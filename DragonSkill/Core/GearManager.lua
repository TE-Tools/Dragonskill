-- Dragon Skill - Gear Manager Engine (v2.3.1)
-- Handles stat weights, upgrade scores, and merged BiS lists.

local GearManager = DragonSkill:RegisterModule("GearManager", {})

local STAT_WEIGHTS_BASE = {
    haste = 100, mastery = 90, versatility = 75, criticalStrike = 60,
    intellect = 150, strength = 150, agility = 150, stamina = 50
}

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
    if not data then return 0, {} end
    local weights = self:GetStatWeights()
    local ilvlScore = (itemLevel or 639) * 15
    local statScore = 0
    if data.secondary then
        for stat, active in pairs(data.secondary) do
            if active then statScore = statScore + (weights[stat] or 0) end
        end
    end
    return ilvlScore + statScore, { ilvl = ilvlScore, stats = statScore }
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

function GearManager:GetUpgradeScore(slot, targetItemId, targetIlvl)
    local details = self:GetUpgradeDetails(slot, targetItemId, targetIlvl)
    return details.score
end

function GearManager:GetBiSList()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local list = {}
    local seen = {}

    -- 1. Try GuideData (Wowhead/Archon) - ONLY 12.1 ITEMS
    if DragonSkillData and DragonSkillData[class] and DragonSkillData[class][specID] then
        local bis = DragonSkillData[class][specID].bisGear
        local sources = { bis.wowhead, bis.archon }
        for _, s in ipairs(sources) do
            if s then for _, entry in ipairs(s) do
                -- Filter for Season 2 Item IDs (approx > 230000 or specific list)
                if entry.itemId and entry.itemId > 100000 and not seen[entry.itemId] then
                    table.insert(list, { itemId = entry.itemId, name = entry.name or entry.text, slot = entry.slot or "Gear", ilvl = 639 })
                    seen[entry.itemId] = true
                end
            end end
        end
    end

    -- 2. Fallback to Master Database (Role-based, Guaranteed 12.1)
    if #list < 10 and DragonSkillGearData.specs[specID] then
        for _, itemId in ipairs(DragonSkillGearData.specs[specID].bis.overall) do
            if not seen[itemId] then
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
    for dName, dData in pairs(DragonSkillGearData.dungeons) do
        local items = {}
        for _, boss in ipairs(dData.bosses) do
            for _, itemId in ipairs(boss.loot) do
                local details = self:GetUpgradeDetails("Gear", itemId, 639)
                if details.score > 0 then
                    local name = DragonSkillGearData.items[itemId] and DragonSkillGearData.items[itemId].name or "Unbekanntes Item"
                    table.insert(items, { itemId = itemId, name = name, boss = boss.name, score = details.score })
                end
            end
        end
        if #items > 0 then table.insert(plan, { name = dName, score = #items * 10, items = items }) end
    end
    table.sort(plan, function(a, b) return a.score > b.score end)
    return plan
end

function GearManager:GetCatalystRecommendation() return "Priorisiere Brust/Beine fuer Set-Bonus." end
function GearManager:GetVaultRecommendation() return "Priorisiere BiS Schmuckstuecke." end
