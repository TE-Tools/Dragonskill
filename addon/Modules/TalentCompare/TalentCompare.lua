-- Dragon Skill - Modul: TalentCompare (v1.2.2)
-- Patch 12.1 Ready: Multi-System & Serialization V2 Support.

local TalentCompare = {}

function TalentCompare:GetCurrentBuildString()
    local configID = C_ClassTalents.GetActiveConfigID()
    if not configID then return nil end
    return C_Traits.GenerateImportString(configID)
end

function TalentCompare:GetClassTraitSystemID()
    if not C_Traits.GetTraitSystemIDs then return 1 end
    local systems = C_Traits.GetTraitSystemIDs()
    for _, id in ipairs(systems) do
        local info = C_Traits.GetTraitSystemInfo(id)
        if info and (id == 1 or (info.name and string.find(info.name, "Class"))) then
            return id
        end
    end
    return 1
end

function TalentCompare:Compare(guideString, currentString)
    if not guideString or not currentString then
        return { identical = false, similarity = 0, error = "Fehlender Build-String" }
    end
    if guideString == currentString then
        return { identical = true, similarity = 100, differences = {} }
    end

    local a = {string.byte(guideString, 1, #guideString)}
    local b = {string.byte(currentString, 1, #currentString)}
    local maxLen = math.max(#a, #b)
    local diffs = 0
    for i = 1, maxLen do if a[i] ~= b[i] then diffs = diffs + 1 end end

    local sim = maxLen > 0 and math.floor(((maxLen - diffs) / maxLen) * 100) or 0
    return { identical = false, similarity = sim, diffCount = diffs }
end

function TalentCompare:GetDetailedDiff(importString)
    local ok, result = pcall(function()
        if not C_ClassTalents.GetImportConfigSlotMap then return nil end
        local importSlotMap = C_ClassTalents.GetImportConfigSlotMap(importString)
        if not importSlotMap then return nil end

        local configID = C_ClassTalents.GetActiveConfigID()
        if not configID then return nil end

        local configInfo = C_Traits.GetConfigInfo(configID)
        local treeID = configInfo and configInfo.treeIDs and configInfo.treeIDs[1]
        if not treeID then return nil end

        local nodes = C_Traits.GetTreeNodes(treeID)
        local diffs = {}
        for _, nodeID in ipairs(nodes) do
            local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID)
            local importedEntry = importSlotMap[nodeID]
            local currentRank = nodeInfo.currentRank or 0
            local importedRank = importedEntry and importedEntry.rank or 0

            if currentRank ~= importedRank then
                local entryID = (importedEntry and importedEntry.entryID and importedEntry.entryID > 0) and importedEntry.entryID or (nodeInfo.activeEntry and nodeInfo.activeEntry.entryID or 0)
                local talentName = "Talent " .. nodeID
                if entryID > 0 then
                    local entryInfo = C_Traits.GetEntryInfo(configID, entryID)
                    local defInfo = entryInfo and C_Traits.GetDefinitionInfo(entryInfo.definitionID)
                    if defInfo then
                        if defInfo.overrideName then talentName = defInfo.overrideName
                        elseif defInfo.spellID then
                            local sInfo = C_Spell.GetSpellInfo(defInfo.spellID)
                            if sInfo then talentName = sInfo.name end
                        end
                    end
                end
                table.insert(diffs, { name = talentName, currentRank = currentRank, importedRank = importedRank, maxRank = nodeInfo.maxRanks or 1 })
            end
        end
        return diffs
    end)
    return ok and result or nil
end

function TalentCompare:ImportToWoW(importString, name)
    if InCombatLockdown() then
        print("|cffff0000Dragon Skill:|r Import im Kampf nicht möglich!")
        return
    end

    -- Sicherstellen, dass das UI geladen ist
    if not ClassTalentFrame then
        if C_AddOns and C_AddOns.LoadAddOn then
            C_AddOns.LoadAddOn("Blizzard_ClassTalentUI")
        else
            UIParentLoadAddOn("Blizzard_ClassTalentUI")
        end
    end

    if ClassTalentFrame and ClassTalentFrame.TalentsTab and ClassTalentFrame.TalentsTab.ImportLoadout then
        ClassTalentFrame.TalentsTab:ImportLoadout(importString, name or "DragonSkill")
        print("|cff00ff00Dragon Skill:|r Build '" .. (name or "Build") .. "' wurde angelegt.")
    else
        print("|cffff0000Dragon Skill:|r Fehler - Blizzard Import API nicht gefunden.")
    end
end

DragonSkill:RegisterModule("TalentCompare", TalentCompare)
