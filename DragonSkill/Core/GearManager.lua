-- Dragon Skill - Gear Manager Engine (v2.3.7)
-- Unified slot keys (DE/EN), purity filter, realistic upgrade compare.

local GearManager = DragonSkill:RegisterModule("GearManager", {})

local STAT_WEIGHTS_BASE = {
    haste = 100, mastery = 90, versatility = 75, criticalStrike = 60,
    intellect = 150, strength = 150, agility = 150, stamina = 50
}

-- Canonical slot keys used everywhere in scoring
local SLOT_CANON = {
    kopf = "Head", head = "Head",
    hals = "Neck", neck = "Neck",
    schulter = "Shoulder", shoulder = "Shoulder",
    ruecken = "Back", rücken = "Back", back = "Back", umhang = "Back",
    brust = "Chest", chest = "Chest",
    handgelenke = "Wrist", wrist = "Wrist", armschienen = "Wrist",
    haende = "Hands", hände = "Hands", hands = "Hands", handschuhe = "Hands",
    taille = "Waist", waist = "Waist", gurt = "Waist",
    beine = "Legs", legs = "Legs", beinschuetzer = "Legs", gamaschen = "Legs",
    fuesse = "Feet", füße = "Feet", feet = "Feet", stiefel = "Feet",
    ring = "Ring", finger = "Ring",
    schmuck = "Trinket", schmuckstueck = "Trinket", schmuckstück = "Trinket", trinket = "Trinket",
    waffe = "MainHand", mainhand = "MainHand", einhandaxt = "MainHand",
    einhandschwert = "MainHand", einhandstreitkolben = "MainHand",
    zweihandstreitkolben = "MainHand", stab = "MainHand", dolch = "MainHand",
    faustwaffe = "MainHand", bogen = "MainHand", armbrust = "MainHand",
    schusswaffe = "MainHand", stangenwaffe = "MainHand", zauberstab = "MainHand",
    kriegsgleve = "MainHand", warglaive = "MainHand", gleve = "MainHand",
    schild = "OffHand", offhand = "OffHand", secondaryhand = "OffHand",
    nebenhand = "OffHand",
}

local CLASS_WEAPON_CHECK = {
    WARRIOR = { "axt", "streitkolben", "schwert", "stangenwaffe", "stab", "schild", "waffe" },
    PALADIN = { "axt", "streitkolben", "schwert", "stangenwaffe", "schild", "waffe" },
    HUNTER = { "bogen", "armbrust", "schuss", "stangenwaffe", "stab", "axt", "waffe" },
    ROGUE = { "dolch", "schwert", "axt", "streitkolben", "faust", "waffe" },
    PRIEST = { "dolch", "streitkolben", "stab", "zauberstab", "waffe" },
    DEATHKNIGHT = { "axt", "streitkolben", "schwert", "stangenwaffe", "waffe" },
    SHAMAN = { "axt", "streitkolben", "stab", "dolch", "schild", "waffe" },
    MAGE = { "dolch", "schwert", "stab", "zauberstab", "waffe" },
    WARLOCK = { "dolch", "schwert", "stab", "zauberstab", "waffe" },
    MONK = { "faust", "axt", "streitkolben", "schwert", "stangenwaffe", "stab", "waffe" },
    DRUID = { "dolch", "faust", "streitkolben", "stangenwaffe", "stab", "waffe" },
    DEMONHUNTER = { "gleve", "kriegsgleve", "warglaive", "schwert", "axt", "faust", "waffe" },
    EVOKER = { "dolch", "faust", "streitkolben", "schwert", "stab", "waffe" },
}

local WEAPON_KEYWORDS = {
    "waffe", "stab", "dolch", "schild", "bogen", "armbrust", "schuss",
    "gleve", "kolben", "schwert", "axt", "faust", "stangen", "zauberstab"
}

function GearManager:NormalizeSlot(slot)
    if not slot or slot == "" then return "Item" end
    local key = tostring(slot):lower()
    key = key:gsub("ü", "ue"):gsub("ö", "oe"):gsub("ä", "ae"):gsub("ß", "ss")
    if SLOT_CANON[key] then return SLOT_CANON[key] end
    for alias, canon in pairs(SLOT_CANON) do
        if key:find(alias, 1, true) then return canon end
    end
    return slot
end

function GearManager:IsItemValidForSpec(itemId, specID)
    local item = DragonSkillGearData and DragonSkillGearData.items and DragonSkillGearData.items[itemId]
    if not item or not item.slot then return true end

    local _, class = UnitClass("player")
    local allowedTypes = CLASS_WEAPON_CHECK[class]
    if not allowedTypes then return true end

    local slotLower = item.slot:lower()
    local isWeaponOrShield = false
    for _, k in ipairs(WEAPON_KEYWORDS) do
        if slotLower:find(k, 1, true) then
            isWeaponOrShield = true
            break
        end
    end

    if not isWeaponOrShield then return true end

    for _, allowed in ipairs(allowedTypes) do
        if slotLower:find(allowed, 1, true) then return true end
    end
    return false
end

function GearManager:GetStatWeights()
    local SP = DragonSkill:GetModule("StatPriority")
    local weights = {}
    for k, v in pairs(STAT_WEIGHTS_BASE) do weights[k] = v end

    local priorityData = SP and SP:GetForCurrentSpec()
    if priorityData and priorityData.wowhead then
        local str = tostring(priorityData.wowhead):lower()
        local parts = { strsplit(">", str) }
        local currentWeight = 110
        for _, p in ipairs(parts) do
            local name = strtrim(p)
            if name:find("haste") or name:find("tempo") then weights.haste = currentWeight
            elseif name:find("mastery") or name:find("meister") then weights.mastery = currentWeight
            elseif name:find("vers") or name:find("vielseit") then weights.versatility = currentWeight
            elseif name:find("crit") or name:find("krit") then weights.criticalStrike = currentWeight end
            currentWeight = currentWeight - 15
        end
    end
    return weights
end

function GearManager:GetItemScore(itemId, itemLevel)
    local data = DragonSkillGearData and DragonSkillGearData.items and DragonSkillGearData.items[itemId]
    local ilvl = tonumber(itemLevel) or (data and data.ilvl) or 639
    -- Primary signal: item level (Midnight Mythic baseline 639)
    local score = ilvl * 20
    -- Known registry items get a small bias so BiS beats unknown same-ilvl junk
    if data then score = score + 50 end
    return score
end

-- Alias used by Character inventory scan
function GearManager:GetUpgradeScore(slot, itemId, itemLevel)
    local details = self:GetUpgradeDetails(slot or "Item", itemId, itemLevel)
    return details and details.score or 0
end

function GearManager:GetEquippedInSlot(canonSlot)
    local Char = DragonSkill:GetModule("Character")
    local currentGear = Char and Char:GetCurrentGear() or {}
    if currentGear[canonSlot] then return currentGear[canonSlot] end
    -- Rings / Trinkets: take the weaker of the two for upgrade math
    if canonSlot == "Ring" then
        local a, b = currentGear.Ring, currentGear.Ring2
        if a and b then
            local sa = self:GetItemScore(a.itemId, a.ilvl)
            local sb = self:GetItemScore(b.itemId, b.ilvl)
            return sa <= sb and a or b
        end
        return a or b
    end
    if canonSlot == "Trinket" then
        local a, b = currentGear.Trinket, currentGear.Trinket2
        if a and b then
            local sa = self:GetItemScore(a.itemId, a.ilvl)
            local sb = self:GetItemScore(b.itemId, b.ilvl)
            return sa <= sb and a or b
        end
        return a or b
    end
    return nil
end

function GearManager:GetUpgradeDetails(slot, targetItemId, targetIlvl)
    local canon = self:NormalizeSlot(slot)
    local current = self:GetEquippedInSlot(canon)
    local currentScore = 0
    if current and current.itemId then
        currentScore = self:GetItemScore(current.itemId, current.ilvl)
    end

    local tIlvl = tonumber(targetIlvl) or 639
    local targetScore = self:GetItemScore(targetItemId, tIlvl)
    local diff = targetScore - currentScore
    local percent = 0
    if currentScore > 0 then
        percent = (diff / currentScore) * 100
    elseif targetScore > 0 then
        percent = 100
    end

    return {
        score = diff,
        percent = math.floor(percent * 10 + 0.5) / 10,
        targetIlvl = tIlvl,
        slot = canon,
    }
end

function GearManager:GetBiSList()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local list = {}
    local seen = {}

    local function pushEntry(entry)
        local itemId = tonumber(entry.itemId)
        if not itemId or itemId < 260000 or seen[itemId] then return end
        if not self:IsItemValidForSpec(itemId, specID) then return end
        local name = entry.name
        local slot = entry.slot or "Item"
        if (not name or name == "") and DragonSkillGearData and DragonSkillGearData.items[itemId] then
            name = DragonSkillGearData.items[itemId].name
            slot = slot ~= "Item" and slot or (DragonSkillGearData.items[itemId].slot or "Item")
        end
        table.insert(list, {
            itemId = itemId,
            name = name or ("Item " .. itemId),
            slot = slot,
            ilvl = entry.ilvl or 639,
        })
        seen[itemId] = true
    end

    -- 1. GuideData (supports bisGear.wowhead AND legacy wowhead root)
    if DragonSkillData and DragonSkillData[class] and DragonSkillData[class][specID] then
        local specData = DragonSkillData[class][specID]
        local wowhead = (specData.bisGear and specData.bisGear.wowhead) or specData.wowhead
        if wowhead then
            for _, entry in ipairs(wowhead) do pushEntry(entry) end
        end
    end

    -- 2. Role fallback from GearDatabase
    if #list < 8 and DragonSkillGearData and DragonSkillGearData.specs and DragonSkillGearData.specs[specID] then
        local overall = DragonSkillGearData.specs[specID].bis and DragonSkillGearData.specs[specID].bis.overall
        if overall then
            for _, itemId in ipairs(overall) do
                local item = DragonSkillGearData.items[itemId]
                pushEntry({
                    itemId = itemId,
                    name = item and item.name,
                    slot = item and item.slot or "Item",
                    ilvl = 639,
                })
            end
        end
    end
    return list
end

function GearManager:GetBestUpgrades()
    local upgrades = {}
    local bisList = self:GetBiSList()
    for _, item in ipairs(bisList) do
        local details = self:GetUpgradeDetails(item.slot or "Item", item.itemId, item.ilvl or 639)
        if details.score > 0 then
            table.insert(upgrades, {
                itemId = item.itemId,
                name = item.name,
                slot = item.slot or "Item",
                score = details.score,
                percent = details.percent,
                ilvl = item.ilvl or 639,
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
        for _, boss in ipairs(dData.bosses or {}) do
            for _, itemId in ipairs(boss.loot or {}) do
                if itemId >= 260000 and self:IsItemValidForSpec(itemId, specID) then
                    local reg = DragonSkillGearData.items[itemId]
                    local slot = reg and reg.slot or "Item"
                    local details = self:GetUpgradeDetails(slot, itemId, 639)
                    if details.score > 0 then
                        table.insert(items, {
                            itemId = itemId,
                            name = reg and reg.name or "Unbekanntes Item",
                            boss = boss.name,
                            slot = slot,
                            score = details.score,
                        })
                    end
                end
            end
        end
        if #items > 0 then
            table.insert(plan, { name = dName, score = #items * 10, items = items })
        end
    end
    table.sort(plan, function(a, b) return a.score > b.score end)
    return plan
end
