-- Dragon Skill - Modul: TalentCompare (v1.5.2)
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

-- Importiert den Talent-String in die offizielle Blizzard-UI (kein Auto-Speccen).
-- Returns true bei erfolgreichem API-Aufruf.
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

    -- 1) ClassTalentFrame:ImportLoadout (Retail / 12.x)
    if ClassTalentFrame and type(ClassTalentFrame.ImportLoadout) == "function" then
        local ok, err = pcall(function()
            ClassTalentFrame:ImportLoadout(importString, loadoutName, 1)
        end)
        if ok then
            success = true
        else
            errMsg = tostring(err)
        end
    end

    -- 2) TalentsTab Fallback
    if not success and ClassTalentFrame and ClassTalentFrame.TalentsTab
        and type(ClassTalentFrame.TalentsTab.ImportLoadout) == "function" then
        local ok, err = pcall(function()
            ClassTalentFrame.TalentsTab:ImportLoadout(importString, loadoutName, 1)
        end)
        if ok then
            success = true
        else
            errMsg = tostring(err)
        end
    end

    -- 3) PlayerSpellsFrame (neuere Frame-Namen in manchen Builds)
    if not success and PlayerSpellsFrame and type(PlayerSpellsFrame.ImportLoadout) == "function" then
        local ok, err = pcall(function()
            PlayerSpellsFrame:ImportLoadout(importString, loadoutName, 1)
        end)
        if ok then
            success = true
        else
            errMsg = tostring(err)
        end
    end

    if success then
        print("|cff00ff00Dragon Skill:|r Build '" .. loadoutName .. "' an Blizzard gesendet.")
        if ClassTalentFrame and not ClassTalentFrame:IsShown() then
            pcall(ToggleTalentFrame)
        elseif PlayerSpellsFrame and not PlayerSpellsFrame:IsShown() then
            pcall(function()
                if PlayerSpellsFrame.Show then PlayerSpellsFrame:Show() end
            end)
        else
            pcall(ToggleTalentFrame)
        end
        return true
    end

    print("|cffff0000Dragon Skill:|r Import-API nicht gefunden" .. (errMsg and (" (" .. errMsg .. ")") or "") .. ". Öffne Talent-Fenster (N) und importiere manuell.")
    -- Copy-Popup als Fallback anbieten
    if StaticPopup_Show and StaticPopupDialogs["DRAGONSKILL_COPY"] then
        StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, { importString = importString, label = loadoutName })
    end
    return false
end

DragonSkill:RegisterModule("TalentCompare", TalentCompare)
