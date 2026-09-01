-- Dragon Skill - Gear Manager Engine (v2.3.6)
-- Master Engine: Strictly Patch 12.1 Midnight Season 2.
-- Implements Absolute Data Purity and Spec-specific weapon filtering.

local GearManager = DragonSkill:RegisterModule("GearManager", {})

local STAT_WEIGHTS_BASE = {
    haste = 100, mastery = 90, versatility = 75, criticalStrike = 60,
    intellect = 150, strength = 150, agility = 150, stamina = 50
}

-- Spec-to-Weapon Mapping (Strictly Hard-blocked)
local CLASS_WEAPON_CHECK = {
    WARRIOR = { "Axt", "Streitkolben", "Schwert", "Stangenwaffe", "Stab", "Schild" },
    PALADIN = { "Axt", "Streitkolben", "Schwert", "Stangenwaffe", "Schild" },
    HUNTER = { "Bogen", "Armbrust", "Schusswaffe", "Stangenwaffe", "Stab", "Axt" },
    ROGUE = { "Dolch", "Schwert", "Axt", "Streitkolben", "Faustwaffe" },
    PRIEST = { "Dolch", "Streitkolben", "Stab", "Zauberstab" },
    DEATHKNIGHT = { "Axt", "Streitkolben", "Schwert", "Stangenwaffe" },
    SHAMAN = { "Axt", "Streitkolben", "Stab", "Dolch", "Schild" },
    MAGE = { "Dolch", "Schwert", "Stab", "Zauberstab" },
    WARLOCK = { "Dolch", "Schwert", "Stab", "Zauberstab" },
    MONK = { "Faustwaffe", "Axt", "Streitkolben", "Schwert", "Stangenwaffe", "Stab" },
    DRUID = { "Dolch", "Faustwaffe", "Streitkolben", "Stangenwaffe", "Stab" },
    DEMONHUNTER = { "Kriegsgleive", "Schwert", "Axt", "Faustwaffe" },
    EVOKER = { "Dolch", "Faustwaffe", "Streitkolben", "Schwert", "Stab" }
}

function GearManager:IsItemValidForSpec(itemId, specID)
    local item = DragonSkillGearData.items[itemId]
    if not item or not item.slot then return true end

    local _, class = UnitClass("player")
    local allowedTypes = CLASS_WEAPON_CHECK[class]
    if not allowedTypes then return true end

    -- Check if it's a weapon/shield slot and if it's allowed
    local slot = item.slot:lower()
    local isWeaponOrShield = slot:find("axt") or slot:find("streitkolben") or slot:find("schwert") or
                             slot:find("stangenwaffe") or slot:find("stab") or slot:find("schild") or
                             slot:find("bogen") or slot:find("armbrust") or slot:find("schusswaffe") or
                             slot:find("dolch") or slot:find("gleive") or slot:find("faustwaffe") or
                             slot:find("zauberstab")

    if isWeaponOrShield then
        local found = false
        for _, allowed in ipairs(allowedTypes) do
            if slot:find(allowed:lower()) then
                found = true
                break
            end
        end
        return found
    end

    return true
end

function GearManager:GetStatWeights()
    local SP = DragonSkill:GetModule("StatPriority")
    local weights = {}
    for k, v in pairs(STAT_WEIGHTS_BASE) do weights[k] = v end

    local priorityData = SP and SP:GetForCurrentSpec()
    if priorityData and priorityData.wowhead then
        local str = priorityData.wowhead:lower()
        local parts = { strsplit(">", str) }
        local currentWeight = 110
        for _, p in ipairs(parts) do
            local name = strtrim(p)
            if name:find("haste") then weights.haste = currentWeight
            elseif name:find("mastery") then weights.mastery = currentWeight
            elseif name:find("vers") then weights.versatility = currentWeight
            elseif name:find("crit") then weights.criticalStrike = currentWeight end
            currentWeight = currentWeight - 15
        end
    end
    return weights
end

function GearManager:GetItemScore(itemId, itemLevel)
    local data = DragonSkillGearData.items[itemId]
    if not data then return 0 end
    local weights = self:GetStatWeights()
    local ilvlScore = (itemLevel or 639) * 20
    return ilvlScore
end

function GearManager:GetUpgradeDetails(slot, targetItemId, targetIlvl)
    local Char = DragonSkill:GetModule("Character")
    local currentGear = Char and Char:GetCurrentGear() or {}
    local current = currentGear[slot]
    local currentScore = 0
    if current and current.itemId then currentScore = self:GetItemScore(current.itemId, current.ilvl) end

    local targetScore = self:GetItemScore(targetItemId, targetIlvl or 639)
    local diff = targetScore - currentScore
    local percent = (currentScore > 0) and ((diff / currentScore) * 100) or 100

    return {
        score = diff,
        percent = math.max(0, math.floor(percent * 10) / 10),
        targetIlvl = 639
    }
end

function GearManager:GetBiSList()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local list = {}
    local seen = {}

    -- 1. Try Clean 12.1 Manual Data first (With Absolute Purity Check)
    if DragonSkillData and DragonSkillData[class] and DragonSkillData[class][specID] then
        local bis = DragonSkillData[class][specID].bisGear
        if bis and bis.wowhead then
            for _, entry in ipairs(bis.wowhead) do
                local itemId = tonumber(entry.itemId)
                -- PURITY FIX: Ignore ID < 260000 and Hard-block invalid class items
                if itemId and itemId >= 260000 and not seen[itemId] and self:IsItemValidForSpec(itemId, specID) then
                    table.insert(list, { itemId = itemId, name = entry.name, slot = entry.slot, ilvl = 639 })
                    seen[itemId] = true
                end
            end
        end
    end

    -- 2. Fallback to Role Database (Filtering invalid types)
    if #list < 5 and DragonSkillGearData.specs[specID] then
        for _, itemId in ipairs(DragonSkillGearData.specs[specID].bis.overall) do
            if not seen[itemId] and itemId >= 260000 and self:IsItemValidForSpec(itemId, specID) then
                local item = DragonSkillGearData.items[itemId]
                if item then
                    table.insert(list, { itemId = itemId, name = item.name, slot = item.slot or "Item", ilvl = 639 })
                    seen[itemId] = true
                end
            end
        end
    end
    return list
end

function GearManager:GetBestUpgrades()
    local upgrades = {}
    local bisList = self:GetBiSList()
    for _, item in ipairs(bisList) do
        local details = self:GetUpgradeDetails(item.slot or "Item", item.itemId, 639)
        if details.score > 0 then
            table.insert(upgrades, {
                itemId = item.itemId, name = item.name, slot = item.slot or "Item",
                score = details.score, percent = details.percent, ilvl = 639
            })
        end
    end
    table.sort(upgrades, function(a, b) return a.score > b.score end)
    return upgrades
end

function GearManager:GetFarmPlan()
    local plan = {}
    if not DragonSkillGearData or not DragonSkillGearData.dungeons then return plan end
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0

    for dName, dData in pairs(DragonSkillGearData.dungeons) do
        local items = {}
        for _, boss in ipairs(dData.bosses) do
            for _, itemId in ipairs(boss.loot) do
                -- PURITY FIX: Only process valid items for the spec and modern IDs
                if itemId >= 260000 and self:IsItemValidForSpec(itemId, specID) then
                    local details = self:GetUpgradeDetails("Gear", itemId, 639)
                    if details.score > 0 then
                        local name = DragonSkillGearData.items[itemId] and DragonSkillGearData.items[itemId].name or "Unbekanntes Item"
                        table.insert(items, { itemId = itemId, name = name, boss = boss.name, score = details.score })
                    end
                end
            end
        end
        if #items > 0 then table.insert(plan, { name = dName, score = #items * 10, items = items }) end
    end
    table.sort(plan, function(a, b) return a.score > b.score end)
    return plan
end
