-- Dragon Skill - Gear Manager Engine (v1.7.0)
local GearManager = DragonSkill:RegisterModule("GearManager", {})

function GearManager:GetSpecData()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0

    return DragonSkill.Database:GetBiSData(class, specID)
end

function GearManager:CalculateItemScore(itemData, weights)
    if not itemData or not weights then return 0 end
    local score = 0
    if itemData.stats then
        for stat, value in pairs(itemData.stats) do
            score = score + (value * (weights[stat] or 0))
        end
    end
    -- Bonus points for being BiS or Priority
    if itemData.bisScore then score = score + (itemData.bisScore * 10) end
    if itemData.farmPriority then score = score + (itemData.farmPriority * 5) end
    return score
end

function GearManager:GetFarmRoute()
    local specData = self:GetSpecData()
    if not specData then return {} end

    local dungeons = {}
    for itemId, data in pairs(specData.items) do
        if data.source == "dungeon" and data.dungeonName then
            local dName = data.dungeonName
            dungeons[dName] = dungeons[dName] or { name = dName, items = {}, score = 0 }
            table.insert(dungeons[dName].items, data)
            dungeons[dName].score = dungeons[dName].score + (data.farmPriority or 1)
        end
    end

    local list = {}
    for _, d in pairs(dungeons) do table.insert(list, d) end
    table.sort(list, function(a, b) return a.score > b.score end)

    return list
end

function GearManager:GetBestUpgrades()
    local specData = self:GetSpecData()
    if not specData then return {} end

    local upgrades = {}
    for itemId, data in pairs(specData.items) do
        if data.farmPriority and data.farmPriority >= 8 then
            table.insert(upgrades, data)
        end
    end

    table.sort(upgrades, function(a, b) return a.farmPriority > b.farmPriority end)
    return upgrades
end

function GearManager:GetCatalystRecommendation()
    local specData = self:GetSpecData()
    if not specData or not specData.tierSet then return "No data." end

    local recs = {}
    for itemId, data in pairs(specData.items) do
        if data.catalystEligible then
            table.insert(recs, data.name .. " (" .. data.slot .. ")")
        end
    end

    if #recs == 0 then return "No candidates found in inventory/farm list." end
    return "Target: " .. table.concat(recs, ", ")
end
