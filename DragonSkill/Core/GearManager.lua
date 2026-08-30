-- Dragon Skill - Gear Manager Engine (v1.8.2)
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
    local ilvlScore = (itemLevel or 250) * 12
    local statScore = 0
    local bonusScore = 0

    if data.secondary then
        for stat, active in pairs(data.secondary) do
            if active then statScore = statScore + (weights[stat] or 0) end
        end
    end

    if data.tierItem then bonusScore = bonusScore + 600 end
    if data.catalystEligible then bonusScore = bonusScore + 400 end
    if data.overallScore then bonusScore = bonusScore + (data.overallScore * 8) end

    local total = ilvlScore + statScore + bonusScore
    return total, { ilvl = ilvlScore, stats = statScore, bonus = bonusScore }
end

function GearManager:GetUpgradeDetails(slot, targetItemId, targetIlvl)
    local currentGear = DragonSkill:GetModule("Character"):GetCurrentGear()
    local current = currentGear[slot]

    local currentScore = 0
    local currentIlvl = 0
    if current and current.itemId then
        currentScore = self:GetItemScore(current.itemId, current.ilvl)
        currentIlvl = current.ilvl
    end

    local targetScore, breakdown = self:GetItemScore(targetItemId, targetIlvl or 252)
    local diff = targetScore - currentScore

    local percent = 0
    if currentScore > 0 then
        percent = (diff / currentScore) * 100
    else
        percent = (diff / 1000) * 100 -- Default baseline for empty slots
    end

    return {
        score = diff,
        percent = math.max(0, math.floor(percent * 10) / 10),
        currentIlvl = currentIlvl,
        targetIlvl = targetIlvl or 252,
        breakdown = breakdown
    }
end

function GearManager:GetUpgradeScore(slot, targetItemId, targetIlvl)
    local details = self:GetUpgradeDetails(slot, targetItemId, targetIlvl)
    return details.score
end

function GearManager:GetDungeonScore(dungeonName)
    local dungeon = DragonSkillGearData.dungeons[dungeonName]
    if not dungeon then return 0 end

    local totalUpgrade = 0
    local count = 0

    for _, boss in ipairs(dungeon.bosses) do
        for _, itemId in ipairs(boss.loot) do
            local item = DragonSkillGearData.items[itemId]
            if item then
                local upgrade = self:GetUpgradeScore(item.slot, itemId)
                if upgrade > 0 then
                    totalUpgrade = totalUpgrade + upgrade
                    count = count + 1
                end
            end
        end
    end

    local finalScore = math.min(100, (totalUpgrade / 80) + (count * 12))
    return math.floor(finalScore)
end

function GearManager:GetFarmPlan()
    local plan = {}
    for name, _ in pairs(DragonSkillGearData.dungeons) do
        local score = self:GetDungeonScore(name)
        if score > 5 then
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
            local details = self:GetUpgradeDetails(item.slot, itemId)
            if details.score > 0 then
                table.insert(upgrades, {
                    itemId = itemId,
                    name = item.name,
                    slot = item.slot,
                    score = details.score,
                    percent = details.percent,
                    priority = math.floor(math.min(10, details.percent * 2)) -- Dynamic priority based on %
                })
            end
        end
    end

    table.sort(upgrades, function(a, b) return a.score > b.score end)
    return upgrades
end

function GearManager:GetCatalystRecommendation()
    local Char = DragonSkill:GetModule("Character")
    local tierCount, tierName = Char:GetActiveTierInfo()

    if tierCount >= 4 then
        return "Du hast bereits den 4er Bonus (" .. tierName .. "). Verwende den Catalyst nur noch für Itemlevel-Upgrades auf schwachen Slots."
    end

    local upgrades = self:GetBestUpgrades()
    local candidates = {}
    for _, up in ipairs(upgrades) do
        local item = DragonSkillGearData.items[up.itemId]
        if item and item.catalystEligible then
            table.insert(candidates, up.name)
        end
    end

    if #candidates > 0 then
        return "Empfehlung: Wandle |cffffd100" .. candidates[1] .. "|r um, um deinem " .. (tierCount < 2 and "2er" or "4er") .. " Bonus näher zu kommen."
    end

    return "Momentan keine idealen Catalyst-Kandidaten in deiner Farm-Liste. Suche nach Items für Brust oder Beine."
end

function GearManager:GetVaultRecommendation()
    -- This would normally iterate over C_WeeklyRewards.GetActivities()
    -- For now, we provide expert logic based on BiS
    local upgrades = self:GetBestUpgrades()
    if #upgrades == 0 then return "Nimm die Sockel-Token (Aspekt-Abzeichen), da du bereits BiS-Gear hast." end

    return "Priorisiere in der Vault: |cffffd100" .. upgrades[1].name .. "|r oder Items für den Slot |cff00ff00" .. upgrades[1].slot .. "|r."
end
