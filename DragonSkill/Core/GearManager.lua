-- Dragon Skill - Gear Manager Engine (v2.3.0)
-- Expansion: Midnight | Patch: 12.1.0 | Season: 2
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
    -- Season 2 Mythic Scaling (639+)
    local ilvlScore = (itemLevel or data.ilvl or 639) * 20
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
    local currentIlvl = 0
    if current and current.itemId then
        currentScore = self:GetItemScore(current.itemId, current.ilvl)
        currentIlvl = current.ilvl
    end

    local targetScore = self:GetItemScore(targetItemId, targetIlvl or 639)
    local diff = targetScore - currentScore

    local percent = (currentScore > 0) and ((diff / currentScore) * 100) or 100

    return {
        score = diff,
        percent = math.max(0, math.floor(percent * 10) / 10),
        currentIlvl = currentIlvl,
        targetIlvl = targetIlvl or 639
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
    local seenItems = {}

    -- 1. Try Scraped Data (Merge Wowhead + Archon)
    if DragonSkillData and DragonSkillData[class] and DragonSkillData[class][specID] then
        local bis = DragonSkillData[class][specID].bisGear
        if bis then
            local sources = { bis.wowhead, bis.archon }
            for _, sourceList in ipairs(sources) do
                if sourceList then
                    for _, entry in ipairs(sourceList) do
                        if entry.itemId and not seenItems[entry.itemId] then
                            -- Only accept items with IDs or known names
                            local name = entry.name or entry.text or ""
                            if name:len() > 30 then name = "Item " .. entry.itemId end -- Filter long descriptions

                            table.insert(list, {
                                itemId = entry.itemId,
                                name = name,
                                slot = entry.slot or "Ausrüstung",
                                ilvl = 639
                            })
                            seenItems[entry.itemId] = true
                        end
                    end
                end
            end
        end
    end

    -- 2. Fallback to Hardcoded 12.1 Master Data (Always shows something)
    if #list < 10 and DragonSkillGearData.specs[specID] then
        local bis = DragonSkillGearData.specs[specID].bis
        if bis and bis.overall then
            for _, itemId in ipairs(bis.overall) do
                if not seenItems[itemId] then
                    local item = DragonSkillGearData.items[itemId]
                    if item then
                        table.insert(list, { itemId = itemId, name = item.name, slot = item.slot or "Item", ilvl = 639 })
                        seenItems[itemId] = true
                    end
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
                itemId = item.itemId,
                name = item.name,
                slot = item.slot or "Item",
                score = details.score,
                percent = details.percent,
                ilvl = 639
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
        local totalUpgrade = 0
        local items = {}
        for _, boss in ipairs(dData.bosses) do
            for _, itemId in ipairs(boss.loot) do
                local score = self:GetUpgradeScore("Item", itemId, 639)
                if score > 0 then
                    local name = DragonSkillGearData.items[itemId] and DragonSkillGearData.items[itemId].name or "Unbekanntes Item"
                    totalUpgrade = totalUpgrade + score
                    table.insert(items, { name = name, boss = boss.name })
                end
            end
        end
        if #items > 0 then
            table.insert(plan, { name = dName, score = math.min(100, #items * 20), items = items })
        end
    end
    table.sort(plan, function(a, b) return a.score > b.score end)
    return plan
end

function GearManager:GetCatalystRecommendation()
    return "Priorisiere Brust oder Beine fuer den 12.1 Set-Bonus."
end

function GearManager:GetVaultRecommendation()
    local ups = self:GetBestUpgrades()
    if #ups == 0 then return "Nimm Aspekt-Abzeichen." end
    return string.format("Wähle |cffffd100%s|r (%s).", ups[1].name, ups[1].slot)
end
