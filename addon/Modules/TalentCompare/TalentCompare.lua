-- Dragon Skill - Modul: TalentCompare
-- Vergleicht einen importierten Talent-Build (aus Guide-Daten oder manuell eingefügtem String)
-- mit dem aktuell auf dem Charakter gespeckten Build. Nutzt ausschließlich offizielle
-- C_Traits / C_ClassTalents APIs - kein Auto-Speccen, nur Anzeige + Diff.

local TalentCompare = {}

--- Liefert den aktuell aktiven Talent-String des Charakters (offizielle Blizzard API)
function TalentCompare:GetCurrentBuildString()
    local configID = C_ClassTalents.GetActiveConfigID()
    if not configID then return nil end
    local exportString = C_Traits.GenerateImportString(configID)
    return exportString
end

-- Blizzard Talent-Import-Strings sind Custom-Base64 (Alphabet inkl. + / = -) über einem
-- Bitstream aus: Header (Spec, Version) + pro Trait-Node ein "selected"-Bit + ggf. Rang/Choice-Bits.
-- Ein vollständiger Bit-Decoder (inkl. Node-ID-Reihenfolge exakt wie der Client sie erwartet)
-- ist nicht offiziell dokumentiert und ändert sich mit Patches. v0.2 nutzt daher einen
-- Byte-Level-Diff: identische Talentwahl ergibt identische Bytes an derselben Position,
-- weshalb Abweichungen zuverlässig als "Position X unterschiedlich" markiert werden -
-- auch ohne zu wissen, welches konkrete Talent an Position X kodiert ist.
local BASE64_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="

local function decodeToBytes(str)
    -- Reduziert den String auf reine Zeichen-Codes (kein echtes Base64-Bit-Unpacking,
    -- reicht aber für einen stabilen Positions-Diff zwischen zwei Strings derselben Spec).
    local bytes = {}
    for i = 1, #str do
        bytes[i] = str:byte(i)
    end
    return bytes
end

--- Vergleicht zwei Talent-Strings. Liefert Übereinstimmung + Liste abweichender Positionen
--- (grober Diff, siehe Kommentar oben - kein Klartext-Talentname, aber zeigt "wie viele
--- und wo" Unterschiede bestehen, inkl. Ähnlichkeits-Prozentzahl).
function TalentCompare:Compare(guideString, currentString)
    local ok, result = pcall(function()
        if not guideString or not currentString then
            return { identical = false, error = "Fehlender Build-String" }
        end

        if guideString == currentString then
            return { identical = true, similarity = 100, differences = {} }
        end

        local a = decodeToBytes(guideString)
        local b = decodeToBytes(currentString)
        local maxLen = math.max(#a, #b)
        local diffPositions = {}

        for i = 1, maxLen do
            if a[i] ~= b[i] then
                table.insert(diffPositions, i)
            end
        end

        local similarity = maxLen > 0 and math.floor(((maxLen - #diffPositions) / maxLen) * 100) or 0

        return {
            identical = false,
            similarity = similarity,
            diffCount = #diffPositions,
            differences = diffPositions,
            guideString = guideString,
            currentString = currentString
        }
    end)

    if not ok then
        print("|cffff0000Dragon Skill:|r Fehler beim Byte-Vergleich: " .. tostring(result))
        return { identical = false, error = "Interner Fehler" }
    end
    return result
end

--- Öffentliche API: Vergleicht Guide-Build (aus DragonSkillData) mit aktuellem Char-Build
function TalentCompare:CompareWithGuide(class, spec, buildLabel)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)
    if not guideData or not guideData.talentBuilds then
        return nil, "Keine Guide-Daten für " .. tostring(class) .. "/" .. tostring(spec)
    end

    local targetBuild
    for _, build in ipairs(guideData.talentBuilds) do
        if not buildLabel or build.label == buildLabel then
            targetBuild = build
            break
        end
    end

    if not targetBuild then
        return nil, "Build nicht gefunden: " .. tostring(buildLabel)
    end

    local currentString = self:GetCurrentBuildString()
    local result = self:Compare(targetBuild.importString, currentString)
    result.buildLabel = targetBuild.label
    result.context = targetBuild.context
    return result
end

--- Nutzt die Blizzard-API um detaillierte Unterschiede zu finden.
function TalentCompare:GetDetailedDiff(importString)
    local ok, result = pcall(function()
        if not C_ClassTalents.GetImportConfigSlotMap then return nil end
        local importSlotMap = C_ClassTalents.GetImportConfigSlotMap(importString)
        if not importSlotMap then return nil end

        local configID = C_ClassTalents.GetActiveConfigID()
        if not configID then return nil end

        local configInfo = C_Traits.GetConfigInfo(configID)
        local treeID = configInfo.treeIDs[1]
        local nodes = C_Traits.GetTreeNodes(treeID)

        local diffs = {}
        for _, nodeID in ipairs(nodes) do
            local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID)
            local importedEntry = importSlotMap[nodeID]

            local currentRank = nodeInfo.currentRank or 0
            local currentEntryID = nodeInfo.activeEntry and nodeInfo.activeEntry.entryID or 0

            local importedRank = importedEntry and importedEntry.rank or 0
            local importedEntryID = importedEntry and importedEntry.entryID or 0

            if currentEntryID ~= importedEntryID or currentRank ~= importedRank then
                local entryID = (importedEntryID > 0) and importedEntryID or currentEntryID
                local entryInfo = C_Traits.GetEntryInfo(configID, entryID)
                local definitionInfo = entryInfo and C_Traits.GetDefinitionInfo(entryInfo.definitionID)

                local talentName = "Unbekanntes Talent"
                if definitionInfo then
                    if definitionInfo.overrideName then
                        talentName = definitionInfo.overrideName
                    elseif definitionInfo.spellID then
                        local spellInfo = C_Spell.GetSpellInfo(definitionInfo.spellID)
                        talentName = spellInfo and spellInfo.name or "Spell " .. definitionInfo.spellID
                    end
                end

                table.insert(diffs, {
                    name = talentName,
                    currentRank = currentRank,
                    importedRank = importedRank,
                    maxRank = nodeInfo.maxRanks
                })
            end
        end
        return diffs
    end)

    if not ok then
        print("|cffff0000Dragon Skill:|r Fehler beim detaillierten Diff: " .. tostring(result))
        return nil
    end
    return result
end

DragonSkill:RegisterModule("TalentCompare", TalentCompare)
