-- Dragon Skill - Modul: TalentCompare (v1.5.0)
-- Patch 12.1 Ready: Multi-System & Secure Import Logic.

local TalentCompare = {}

function TalentCompare:GetCurrentBuildString()
    local configID = C_ClassTalents.GetActiveConfigID()
    if not configID then return nil end
    return C_Traits.GenerateImportString(configID)
end

function TalentCompare:Compare(guideString, currentString)
    if not guideString or not currentString then return { similarity = 0 } end
    if guideString == currentString then return { similarity = 100 } end
    local a, b = {string.byte(guideString, 1, #guideString)}, {string.byte(currentString, 1, #currentString)}
    local diffs, maxLen = 0, math.max(#a, #b)
    for i = 1, maxLen do if a[i] ~= b[i] then diffs = diffs + 1 end end
    return { similarity = math.floor(((maxLen - diffs) / maxLen) * 100) }
end

function TalentCompare:GetDetailedDiff(importString)
    local ok, result = pcall(function()
        local map = C_ClassTalents.GetImportConfigSlotMap(importString)
        local configID = C_ClassTalents.GetActiveConfigID()
        if not map or not configID then return {} end
        local treeID = C_Traits.GetConfigInfo(configID).treeIDs[1]
        local diffs = {}
        for _, nodeID in ipairs(C_Traits.GetTreeNodes(treeID)) do
            local nInfo = C_Traits.GetNodeInfo(configID, nodeID)
            local imp = map[nodeID]
            if nInfo.currentRank ~= (imp and imp.rank or 0) then
                table.insert(diffs, { name = "Talent "..nodeID, currentRank = nInfo.currentRank, importedRank = (imp and imp.rank or 0), maxRank = nInfo.maxRanks })
            end
        end
        return diffs
    end)
    return ok and result or {}
end

function TalentCompare:ImportToWoW(importString, name)
    if InCombatLockdown() then
        print("|cffff0000Dragon Skill:|r Import im Kampf nicht möglich!")
        return
    end

    -- Sicherstellen, dass das UI geladen ist
    if not ClassTalentFrame then
        UIParentLoadAddOn("Blizzard_ClassTalentUI")
    end

    -- Blizzard 12.1 API Check
    local success = false
    if ClassTalentFrame then
        -- 12.1 Syntax: ImportLoadout(string, [name], [systemID])
        -- SystemID 1 = Class Talents
        if ClassTalentFrame.ImportLoadout then
            ClassTalentFrame:ImportLoadout(importString, name or "DragonSkill", 1)
            success = true
        elseif ClassTalentFrame.TalentsTab and ClassTalentFrame.TalentsTab.ImportLoadout then
            ClassTalentFrame.TalentsTab:ImportLoadout(importString, name or "DragonSkill", 1)
            success = true
        end
    end

    if success then
        print("|cff00ff00Dragon Skill:|r Build '" .. (name or "Build") .. "' an Blizzard-Interface gesendet.")
        if not ClassTalentFrame:IsShown() then ToggleTalentFrame() end
    else
        print("|cffff0000Dragon Skill:|r Fehler - Blizzard Import API nicht gefunden. Öffne dein Talent-Fenster ('N') händisch.")
    end
end

DragonSkill:RegisterModule("TalentCompare", TalentCompare)
