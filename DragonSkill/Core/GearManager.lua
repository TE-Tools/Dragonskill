-- Dragon Skill - Gear Manager Engine (v2.2.6)
-- Handles stat weights, upgrade scores, and BiS lists.

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
        percent = (diff / 1000) * 100
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
    return math.floor(math.min(100, (totalUpgrade / 80) + (count * 12)))
end

function GearManager:GetBestUpgrades()
    local upgrades = {}
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0

    -- Dynamically pull BiS from GuideData if available, otherwise from GearDatabase
    local bisList = self:GetBiSList()
    for _, item in ipairs(bisList) do
        local details = self:GetUpgradeDetails(item.slot, item.itemId)
        if details.score > 0 then
            table.insert(upgrades, {
                itemId = item.itemId,
                name = item.name,
                slot = item.slot,
                score = details.score,
                percent = details.percent,
                priority = math.floor(math.min(10, details.percent * 2))
            })
        end
    end
    table.sort(upgrades, function(a, b) return a.score > b.score end)
    return upgrades
end

function GearManager:GetBiSList()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0

    local list = {}

    -- 1. Try Scraped Data (More complete)
    if DragonSkillData and DragonSkillData[class] and DragonSkillData[class][specID] then
        local bis = DragonSkillData[class][specID].bisGear
        local sourceList = (bis and bis.wowhead) or (bis and bis.archon) or {}
        for _, entry in ipairs(sourceList) do
            if entry.itemId then
                local name = entry.name or entry.text or "Item "..entry.itemId
                table.insert(list, { itemId = entry.itemId, name = name, slot = entry.slot or "Item" })
            end
        end
    end

    -- 2. Fallback to Hardcoded GearDatabase
    if #list == 0 and DragonSkillGearData.specs[specID] then
        local bis = DragonSkillGearData.specs[specID].bis
        if bis and bis.overall then
            for _, itemId in ipairs(bis.overall) do
                local item = DragonSkillGearData.items[itemId]
                if item then
                    table.insert(list, { itemId = itemId, name = item.name, slot = item.slot or "Item" })
                end
            end
        end
    end

    return list
end

function GearManager:GetCatalystRecommendation()
    local Char = DragonSkill:GetModule("Character")
    local tierCount, tierName = Char:GetActiveTierInfo()
    if tierCount >= 4 then return "Du hast den 4er Bonus (" .. tierName .. "). Nutze Catalyst fuer Itemlevel-Upgrades." end
    local upgrades = self:GetBestUpgrades()
    for _, up in ipairs(upgrades) do
        local item = DragonSkillGearData.items[up.itemId]
        if item and item.catalystEligible then
            return "Empfehlung: Wandle |cffffd100" .. up.name .. "|r um fuer deinen " .. (tierCount < 2 and "2er" or "4er") .. " Bonus."
        end
    end
    return "Keine idealen Catalyst-Kandidaten gefunden. Brust/Beine priorisieren!"
end

function GearManager:GetVaultRecommendation()
    local upgrades = self:GetBestUpgrades()
    if #upgrades == 0 then return "Nimm die Sockel-Token (Aspekt-Abzeichen)." end
    return "Priorisiere in der Vault: |cffffd100" .. upgrades[1].name .. "|r (" .. upgrades[1].slot .. ")."
end
