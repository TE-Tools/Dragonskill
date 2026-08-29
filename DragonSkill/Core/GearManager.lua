-- Dragon Skill - Gear Manager Engine (v1.7.0)
-- Handles stat weights, upgrade scores, and farm planning.

local GearManager = DragonSkill:RegisterModule("GearManager", {})

local STAT_WEIGHTS_BASE = {
    haste = 100,
    mastery = 90,
    versatility = 75,
    criticalStrike = 60,
    intellect = 150,
    strength = 150,
    agility = 150,
    stamina = 50
}

function GearManager:GetStatWeights()
    local SP = DragonSkill:GetModule("StatPriority")
    local weights = {}
    for k, v in pairs(STAT_WEIGHTS_BASE) do weights[k] = v end

    local priorityData = SP and SP:GetForCurrentSpec()
    if priorityData and priorityData.wowhead then
        -- Parse "Haste > Mastery > Versatility > Critical Strike"
        local str = priorityData.wowhead:lower()
        local parts = { strsplit(">", str) }
        local currentWeight = 100
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
    local score = (itemLevel or 250) * 10 -- Base ilvl score

    if data.secondary then
        for stat, active in pairs(data.secondary) do
            if active then score = score + (weights[stat] or 0) end
        end
    end

    if data.tierItem then score = score + 500 end -- Huge bonus for tier
    if data.catalystEligible then score = score + 300 end
    if data.overallScore then score = score + (data.overallScore * 5) end

    return score
end

function GearManager:GetUpgradeScore(slot, targetItemId, targetIlvl)
    local currentGear = DragonSkill:GetModule("Character"):GetCurrentGear()
    local current = currentGear[slot]

    local currentScore = 0
    if current and current.itemId then
        currentScore = self:GetItemScore(current.itemId, current.ilvl)
    end

    local targetScore = self:GetItemScore(targetItemId, targetIlvl or 252)
    local diff = targetScore - currentScore

    if diff <= 0 then return 0 end
    return diff
end

function GearManager:GetDungeonScore(dungeonName)
    local dungeon = DragonSkillGearData.dungeons[dungeonName]
    if not dungeon then return 0 end

    local totalUpgrade = 0
    local relevantItems = 0

    for _, boss in ipairs(dungeon.bosses) do
        for _, itemId in ipairs(boss.loot) do
            local item = DragonSkillGearData.items[itemId]
            if item then
                local upgrade = self:GetUpgradeScore(item.slot, itemId)
                if upgrade > 0 then
                    totalUpgrade = totalUpgrade + upgrade
                    relevantItems = relevantItems + 1
                end
            end
        end
    end

    -- Normalize score to 0-100
    local finalScore = math.min(100, (totalUpgrade / 100) + (relevantItems * 10))
    return math.floor(finalScore)
end

function GearManager:GetFarmPlan()
    local plan = {}
    for name, _ in pairs(DragonSkillGearData.dungeons) do
        local score = self:GetDungeonScore(name)
        if score > 10 then
            table.insert(plan, { name = name, score = score })
        end
    end
    table.sort(plan, function(a, b) return a.score > b.score end)
    return plan
end

function GearManager:GetBestUpgrades()
    local upgrades = {}
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local specData = DragonSkillGearData.specs[specID]

    if not specData or not specData.bis then return {} end

    for _, itemId in ipairs(specData.bis.overall) do
        local item = DragonSkillGearData.items[itemId]
        if item then
            local score = self:GetUpgradeScore(item.slot, itemId)
            if score > 0 then
                table.insert(upgrades, {
                    itemId = itemId,
                    name = item.name,
                    slot = item.slot,
                    score = score,
                    priority = math.floor(math.min(10, score / 100))
                })
            end
        end
    end

    table.sort(upgrades, function(a, b) return a.score > b.score end)
    return upgrades
end
