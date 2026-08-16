-- Dragon Skill - Modul: TalentCompare (v1.5.6)
-- Node-Match-% + Node-Diff mit Talentnamen

local TalentCompare = {}

function TalentCompare:GetCurrentBuildString()
    local configID = C_ClassTalents.GetActiveConfigID()
    if not configID then return nil end
    return C_Traits.GenerateImportString(configID)
end

-- Byte-Vergleich (Fallback)
function TalentCompare:Compare(guideString, currentString)
    if not guideString or not currentString then return { similarity = 0, mode = "none" } end
    if guideString == currentString then return { similarity = 100, mode = "exact" } end
    local a = { string.byte(guideString, 1, #guideString) }
    local b = { string.byte(currentString, 1, #currentString) }
    local diffs, maxLen = 0, math.max(#a, #b)
    if maxLen == 0 then return { similarity = 0, mode = "bytes" } end
    for i = 1, maxLen do
        if a[i] ~= b[i] then diffs = diffs + 1 end
    end
    return {
        similarity = math.floor(((maxLen - diffs) / maxLen) * 100),
        mode = "bytes",
    }
end

-- Primärer Vergleich: Node-Ränge wenn API verfügbar, sonst Bytes
function TalentCompare:CompareBuild(importString)
    if not importString or importString == "" then
        return { similarity = 0, mode = "none" }
    end
    local current = self:GetCurrentBuildString()
    if current and current == importString then
        return { similarity = 100, mode = "exact" }
    end

    local detail = self:GetDetailedDiff(importString)
    if detail and detail.total and detail.total > 0 then
        local matched = detail.total - (detail.count or 0)
        if matched < 0 then matched = 0 end
        return {
            similarity = math.floor((matched / detail.total) * 100),
            mode = "nodes",
            diffCount = detail.count or 0,
            total = detail.total,
        }
    end

    return self:Compare(importString, current)
end

local function SpellNameFromID(spellID)
    if not spellID then return nil end
    if C_Spell and C_Spell.GetSpellInfo then
        local info = C_Spell.GetSpellInfo(spellID)
        if type(info) == "table" and info.name then return info.name end
        if type(info) == "string" then return info end
    end
    if GetSpellInfo then
        local n = GetSpellInfo(spellID)
        if n then return n end
    end
    return nil
end

local function NameFromEntry(configID, entryID)
    if not entryID or not C_Traits.GetEntryInfo then return nil end
    local eInfo = C_Traits.GetEntryInfo(configID, entryID)
    if not eInfo then return nil end

    if eInfo.definitionID and C_Traits.GetDefinitionInfo then
        local def = C_Traits.GetDefinitionInfo(eInfo.definitionID)
        if def then
            local n = def.overrideName or def.name
            if n and n ~= "" then return n end
            if def.spellID then
                local sn = SpellNameFromID(def.spellID)
                if sn then return sn end
            end
        end
    end

    if eInfo.subTreeID and C_Traits.GetSubTreeInfo then
        local st = C_Traits.GetSubTreeInfo(configID, eInfo.subTreeID)
        if st and st.name then return st.name end
    end

    return nil
end

local function ResolveNodeName(configID, nodeID, nInfo, preferredRank)
    if nInfo.activeEntry and nInfo.activeEntry.entryID then
        local n = NameFromEntry(configID, nInfo.activeEntry.entryID)
        if n then return n end
    end

    local entryIDs = nInfo.entryIDs
    if entryIDs and #entryIDs > 0 then
        local idx = preferredRank and math.max(1, math.min(#entryIDs, preferredRank)) or 1
        local n = NameFromEntry(configID, entryIDs[idx])
        if n then return n end
        for _, eid in ipairs(entryIDs) do
            n = NameFromEntry(configID, eid)
            if n then return n end
        end
    end

    if nInfo.visibleEntryIDs then
        for _, eid in ipairs(nInfo.visibleEntryIDs) do
            local n = NameFromEntry(configID, eid)
            if n then return n end
        end
    end

    return "Node " .. tostring(nodeID)
end

function TalentCompare:GetDetailedDiff(importString)
    local empty = { diffs = {}, count = 0, total = 0 }
    if not importString or importString == "" then return empty end

    local ok, result = pcall(function()
        if not C_ClassTalents.GetImportConfigSlotMap then return empty end
        local map = C_ClassTalents.GetImportConfigSlotMap(importString)
        local configID = C_ClassTalents.GetActiveConfigID()
        if not map or not configID then return empty end

        local configInfo = C_Traits.GetConfigInfo(configID)
        local treeID = configInfo and configInfo.treeIDs and configInfo.treeIDs[1]
        if not treeID then return empty end

        local diffs = {}
        local total = 0
        for _, nodeID in ipairs(C_Traits.GetTreeNodes(treeID)) do
            local nInfo = C_Traits.GetNodeInfo(configID, nodeID)
            if nInfo and not nInfo.isInvisible then
                -- Nur Nodes die spielbar / rankbar sind
                local maxRanks = nInfo.maxRanks or 0
                if maxRanks > 0 or (nInfo.entryIDs and #nInfo.entryIDs > 0) then
                    total = total + 1
                    local imp = map[nodeID]
                    local importedRank = (imp and (imp.rank or imp.ranksGranted or 0)) or 0
                    local currentRank = nInfo.currentRank or 0
                    if currentRank ~= importedRank then
                        local nameRank = importedRank > 0 and importedRank or currentRank
                        table.insert(diffs, {
                            nodeID = nodeID,
                            name = ResolveNodeName(configID, nodeID, nInfo, nameRank),
                            currentRank = currentRank,
                            importedRank = importedRank,
                            maxRank = maxRanks,
                        })
                    end
                end
            end
        end

        table.sort(diffs, function(a, b)
            return tostring(a.name) < tostring(b.name)
        end)

        return { diffs = diffs, count = #diffs, total = total }
    end)

    if ok and result then return result end
    return empty
end

function TalentCompare:FormatDiffSummary(importString, maxLines)
    maxLines = maxLines or 12
    local detail = self:GetDetailedDiff(importString)
    if not detail or detail.count == 0 then
        if detail and detail.total and detail.total > 0 then
            return "|cff00ff00Keine Node-Abweichungen – Build stimmt überein.|r"
        end
        return "Keine Node-Abweichungen gefunden (oder API nicht verfügbar)."
    end

    local lines = {
        string.format(
            "|cffffd100%d / %d Abweichung(en):|r",
            detail.count,
            detail.total or detail.count
        ),
    }
    local shown = 0
    for _, d in ipairs(detail.diffs) do
        if shown >= maxLines then break end
        local arrow
        if d.currentRank < d.importedRank then
            arrow = string.format("|cff66ff66%s|r  %d → %d (Guide)", d.name, d.currentRank, d.importedRank)
        else
            arrow = string.format("|cffff6666%s|r  %d → %d (Guide)", d.name, d.currentRank, d.importedRank)
        end
        table.insert(lines, arrow)
        shown = shown + 1
    end
    if detail.count > shown then
        table.insert(lines, string.format("|cff888888… +%d weitere|r", detail.count - shown))
    end
    return table.concat(lines, "\n")
end

local function EnsureTalentUI()
    if ClassTalentFrame then return true end
    if C_AddOns and C_AddOns.LoadAddOn then
        pcall(C_AddOns.LoadAddOn, "Blizzard_ClassTalentUI")
    elseif LoadAddOn then
        pcall(LoadAddOn, "Blizzard_ClassTalentUI")
    end
    return ClassTalentFrame ~= nil
end

function TalentCompare:ImportToWoW(importString, name)
    if not importString or importString == "" then
        print("|cffff0000Dragon Skill:|r Kein Import-String vorhanden.")
        return false
    end
    if InCombatLockdown() then
        print("|cffff0000Dragon Skill:|r Import im Kampf nicht möglich!")
        return false
    end

    EnsureTalentUI()

    local loadoutName = name or "DragonSkill"
    local success = false
    local errMsg = nil

    if ClassTalentFrame and type(ClassTalentFrame.ImportLoadout) == "function" then
        local ok, err = pcall(function()
            ClassTalentFrame:ImportLoadout(importString, loadoutName, 1)
        end)
        if ok then success = true else errMsg = tostring(err) end
    end

    if not success and ClassTalentFrame and ClassTalentFrame.TalentsTab
        and type(ClassTalentFrame.TalentsTab.ImportLoadout) == "function" then
        local ok, err = pcall(function()
            ClassTalentFrame.TalentsTab:ImportLoadout(importString, loadoutName, 1)
        end)
        if ok then success = true else errMsg = tostring(err) end
    end

    if not success and PlayerSpellsFrame and type(PlayerSpellsFrame.ImportLoadout) == "function" then
        local ok, err = pcall(function()
            PlayerSpellsFrame:ImportLoadout(importString, loadoutName, 1)
        end)
        if ok then success = true else errMsg = tostring(err) end
    end

    if success then
        print("|cff00ff00Dragon Skill:|r Build '" .. loadoutName .. "' an Blizzard gesendet.")
        if ClassTalentFrame and not ClassTalentFrame:IsShown() then
            pcall(ToggleTalentFrame)
        elseif PlayerSpellsFrame and PlayerSpellsFrame.Show and not PlayerSpellsFrame:IsShown() then
            pcall(function() PlayerSpellsFrame:Show() end)
        else
            pcall(ToggleTalentFrame)
        end
        return true
    end

    print("|cffff0000Dragon Skill:|r Import-API nicht gefunden" .. (errMsg and (" (" .. errMsg .. ")") or "") .. ". Öffne Talent-Fenster (N) und importiere manuell.")
    if StaticPopup_Show and StaticPopupDialogs["DRAGONSKILL_COPY"] then
        StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, { importString = importString, label = loadoutName })
    end
    return false
end

DragonSkill:RegisterModule("TalentCompare", TalentCompare)
