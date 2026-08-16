-- Dragon Skill - Modul: TalentCompare (v1.5.2)
-- Patch 12.1: robusterer Import + Diff

local TalentCompare = {}

function TalentCompare:GetCurrentBuildString()
    local configID = C_ClassTalents and C_ClassTalents.GetActiveConfigID and C_ClassTalents.GetActiveConfigID()
    if not configID then return nil end
    if C_Traits and C_Traits.GenerateImportString then
        return C_Traits.GenerateImportString(configID)
    end
    return nil
end

function TalentCompare:Compare(guideString, currentString)
    if not guideString or not currentString then return { similarity = 0 } end
    if guideString == currentString then return { similarity = 100 } end
    local a, b = { string.byte(guideString, 1, #guideString) }, { string.byte(currentString, 1, #currentString) }
    local diffs, maxLen = 0, math.max(#a, #b)
    for i = 1, maxLen do
        if a[i] ~= b[i] then diffs = diffs + 1 end
    end
    return { similarity = math.floor(((maxLen - diffs) / maxLen) * 100) }
end

function TalentCompare:GetDetailedDiff(importString)
    local ok, result = pcall(function()
        if not C_ClassTalents or not C_ClassTalents.GetImportConfigSlotMap then return {} end
        local map = C_ClassTalents.GetImportConfigSlotMap(importString)
        local configID = C_ClassTalents.GetActiveConfigID()
        if not map or not configID then return {} end
        local configInfo = C_Traits.GetConfigInfo(configID)
        local treeID = configInfo and configInfo.treeIDs and configInfo.treeIDs[1]
        if not treeID then return {} end

        local diffs = {}
        for _, nodeID in ipairs(C_Traits.GetTreeNodes(treeID)) do
            local nInfo = C_Traits.GetNodeInfo(configID, nodeID)
            local imp = map[nodeID]
            if nInfo and nInfo.currentRank ~= (imp and imp.rank or 0) then
                table.insert(diffs, {
                    name = "Talent " .. nodeID,
                    currentRank = nInfo.currentRank,
                    importedRank = (imp and imp.rank or 0),
                    maxRank = nInfo.maxRanks,
                })
            end
        end
        return diffs
    end)
    return ok and result or {}
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

-- Importiert den String in die offizielle Blizzard-Talent-UI (kein Secure-Bypass).
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
    local errMsg

    -- 1) Moderne Frame-Methoden (12.x)
    if ClassTalentFrame then
        local ok, err = pcall(function()
            if ClassTalentFrame.ImportLoadout then
                ClassTalentFrame:ImportLoadout(importString, loadoutName, 1)
                success = true
            elseif ClassTalentFrame.TalentsTab and ClassTalentFrame.TalentsTab.ImportLoadout then
                ClassTalentFrame.TalentsTab:ImportLoadout(importString, loadoutName, 1)
                success = true
            elseif PlayerSpellsFrame and PlayerSpellsFrame.TalentsFrame and PlayerSpellsFrame.TalentsFrame.ImportLoadout then
                -- Fallback: neuer PlayerSpells-Frame (je nach Build)
                PlayerSpellsFrame.TalentsFrame:ImportLoadout(importString, loadoutName, 1)
                success = true
            end
        end)
        if not ok then
            errMsg = tostring(err)
            success = false
        end
    end

    -- 2) C_ClassTalents Fallback falls vorhanden
    if not success and C_ClassTalents then
        local ok, err = pcall(function()
            if C_ClassTalents.ImportLoadout then
                C_ClassTalents.ImportLoadout(importString, loadoutName)
                success = true
            elseif C_ClassTalents.ImportTalentLoadout then
                C_ClassTalents.ImportTalentLoadout(importString, loadoutName)
                success = true
            end
        end)
        if not ok then
            errMsg = tostring(err)
        end
    end

    if success then
        print("|cff00ff00Dragon Skill:|r Build '" .. loadoutName .. "' an Blizzard gesendet.")
        if ClassTalentFrame and not ClassTalentFrame:IsShown() and ToggleTalentFrame then
            ToggleTalentFrame()
        elseif PlayerSpellsFrame and not PlayerSpellsFrame:IsShown() and TogglePlayerSpellsFrame then
            pcall(TogglePlayerSpellsFrame)
        elseif ToggleTalentFrame then
            ToggleTalentFrame()
        end
        return true
    end

    print("|cffff0000Dragon Skill:|r Import-API nicht gefunden" .. (errMsg and (" (" .. errMsg .. ")") or "") .. ". Öffne Talente (N) und nutze 'Kopieren'.")
    return false
end

DragonSkill:RegisterModule("TalentCompare", TalentCompare)
