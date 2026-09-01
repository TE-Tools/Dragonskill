-- Dragon Skill - Gear Manager Engine (v2.3.12)
-- Armor/weapon filter by logged-in class via GetItemInfoInstant + name fallback.

local GearManager = DragonSkill:RegisterModule("GearManager", {})

local STAT_WEIGHTS_BASE = {
    haste = 100, mastery = 90, versatility = 75, criticalStrike = 60,
    intellect = 150, strength = 150, agility = 150, stamina = 50
}

local SLOT_CANON = {
    kopf = "Head", head = "Head", hals = "Neck", neck = "Neck",
    schulter = "Shoulder", shoulder = "Shoulder",
    ruecken = "Back", back = "Back", umhang = "Back",
    brust = "Chest", chest = "Chest",
    handgelenke = "Wrist", wrist = "Wrist", armschienen = "Wrist",
    haende = "Hands", hands = "Hands", handschuhe = "Hands",
    taille = "Waist", waist = "Waist", gurt = "Waist",
    beine = "Legs", legs = "Legs", gamaschen = "Legs",
    fuesse = "Feet", feet = "Feet", stiefel = "Feet",
    ring = "Ring", finger = "Ring",
    schmuck = "Trinket", trinket = "Trinket",
    waffe = "MainHand", mainhand = "MainHand", stab = "MainHand", dolch = "MainHand",
    schild = "OffHand", offhand = "OffHand",
}

local CLASS_ARMOR = {
    WARRIOR = "plate", PALADIN = "plate", DEATHKNIGHT = "plate",
    HUNTER = "mail", SHAMAN = "mail", EVOKER = "mail",
    ROGUE = "leather", DRUID = "leather", MONK = "leather", DEMONHUNTER = "leather",
    PRIEST = "cloth", MAGE = "cloth", WARLOCK = "cloth",
}

local ARMOR_SLOTS = {
    Head = true, Shoulder = true, Chest = true, Wrist = true,
    Hands = true, Waist = true, Legs = true, Feet = true,
}

local ARMOR_SUB = {
    [1] = "cloth", [2] = "leather", [3] = "mail", [4] = "plate",
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
    DEMONHUNTER = { "gleve", "warglaive", "schwert", "axt", "faust", "waffe" },
    EVOKER = { "dolch", "faust", "streitkolben", "schwert", "stab", "waffe" },
}

local WEAPON_KEYWORDS = {
    "waffe", "stab", "dolch", "schild", "bogen", "armbrust", "schuss",
    "gleve", "kolben", "schwert", "axt", "faust", "stangen", "zauberstab",
}

-- Explicit armor tags (when client cache not ready)
local ITEM_ARMOR_OVERRIDE = {
    [271529] = "plate",
    [271531] = "plate",
    [271600] = "plate",
    [271602] = "plate",
    [271528] = "plate",
    [268259] = "plate",
    [268254] = "leather",
    [268258] = "leather",
    [271534] = "leather",
    [271536] = "cloth",
    [271617] = "cloth",
}

local function DetectArmorFromName(name)
    if not name then return nil end
    local n = name:lower()
    n = n:gsub("ü", "ue"):gsub("ö", "oe"):gsub("ä", "ae"):gsub("ß", "ss")
    if n:find("platte", 1, true) or n:find("panzer", 1, true)
        or n:find("plate", 1, true) or n:find("schwere", 1, true) then
        return "plate"
    end
    if n:find("kette", 1, true) or n:find("mail", 1, true)
        or n:find("maschen", 1, true) then
        return "mail"
    end
    if n:find("stoff", 1, true) or n:find("gewand", 1, true)
        or n:find("robe", 1, true) or n:find("tuch", 1, true)
        or n:find("seide", 1, true) or n:find("cloth", 1, true) then
        return "cloth"
    end
    if n:find("leder", 1, true) or n:find("haut", 1, true)
        or n:find("fell", 1, true) or n:find("leather", 1, true)
        or n:find("balg", 1, true) then
        return "leather"
    end
    return nil
end

local function ResolveArmorType(itemId, name, registryArmor)
    if ITEM_ARMOR_OVERRIDE[itemId] then return ITEM_ARMOR_OVERRIDE[itemId] end
    if registryArmor then return registryArmor end
    if itemId and itemId > 0 then
        local classID, subClassID
        if C_Item and C_Item.GetItemInfoInstant then
            local _i, _t, _st, _loc, _icon, c, sc = C_Item.GetItemInfoInstant(itemId)
            classID, subClassID = c, sc
        elseif GetItemInfoInstant then
            local _i, _t, _st, _loc, _icon, c, sc = GetItemInfoInstant(itemId)
            classID, subClassID = c, sc
        end
        if classID == 4 and subClassID and ARMOR_SUB[subClassID] then
            return ARMOR_SUB[subClassID]
        end
        if classID and classID ~= 4 then return nil end
    end
    return DetectArmorFromName(name)
end

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

function GearManager:GetPlayerClass()
    local _, class = UnitClass("player")
    return class
end

function GearManager:IsWeaponSlot(slot)
    if not slot then return false end
    local sl = slot:lower()
    for _, k in ipairs(WEAPON_KEYWORDS) do
        if sl:find(k, 1, true) then return true end
    end
    return false
end

function GearManager:IsItemValidForSpec(itemId, specID)
    itemId = tonumber(itemId)
    if not itemId or itemId <= 0 then return false end

    local class = self:GetPlayerClass()
    local item = DragonSkillGearData and DragonSkillGearData.items and DragonSkillGearData.items[itemId]
    local name = (item and item.name) or ""
    local slot = (item and item.slot) or ""
    local canon = self:NormalizeSlot(slot)

    -- Jewelry / cloak: always ok
    if canon == "Neck" or canon == "Back" or canon == "Ring" or canon == "Trinket" then
        return true
    end

    -- Armor slots: must match logged-in class
    local isArmorSlot = ARMOR_SLOTS[canon]
    if not isArmorSlot and slot ~= "" then
        local sl = slot:lower()
        if sl:find("kopf", 1, true) or sl:find("schulter", 1, true) or sl:find("brust", 1, true)
            or sl:find("hand", 1, true) or sl:find("taille", 1, true) or sl:find("bein", 1, true)
            or sl:find("fuss", 1, true) or sl:find("arm", 1, true) then
            isArmorSlot = true
        end
    end

    if isArmorSlot then
        local allowed = CLASS_ARMOR[class]
        local detected = ResolveArmorType(itemId, name, item and item.armor)
        if allowed and detected then
            return detected == allowed
        end
        -- Unknown armor type on armor slot → hide (safer than wrong type)
        if allowed and not detected then
            return false
        end
    end

    -- Weapon filter
    if self:IsWeaponSlot(slot) then
        local allowedTypes = CLASS_WEAPON_CHECK[class]
        if not allowedTypes then return true end
        local slotLower = slot:lower()
        local nl = name:lower()
        for _, allowed in ipairs(allowedTypes) do
            if slotLower:find(allowed, 1, true) or nl:find(allowed, 1, true) then
                return true
            end
        end
        return false
    end

    return true
end

function GearManager:GetStatWeights()
    local weights = {}
    for k, v in pairs(STAT_WEIGHTS_BASE) do weights[k] = v end
    return weights
end

function GearManager:GetItemScore(itemId, itemLevel)
    local data = DragonSkillGearData and DragonSkillGearData.items and DragonSkillGearData.items[itemId]
    local ilvl = tonumber(itemLevel) or (data and data.ilvl) or 639
    local score = ilvl * 20
    if data then score = score + 50 end
    return score
end

function GearManager:GetUpgradeScore(slot, itemId, itemLevel)
    local details = self:GetUpgradeDetails(slot or "Item", itemId, itemLevel)
    return details and details.score or 0
end

function GearManager:GetEquippedInSlot(canonSlot)
    local Char = DragonSkill:GetModule("Character")
    local currentGear = Char and Char:GetCurrentGear() or {}
    if currentGear[canonSlot] then return currentGear[canonSlot] end
    if canonSlot == "Ring" then
        local a, b = currentGear.Ring, currentGear.Ring2
        if a and b then
            return self:GetItemScore(a.itemId, a.ilvl) <= self:GetItemScore(b.itemId, b.ilvl) and a or b
        end
        return a or b
    end
    if canonSlot == "Trinket" then
        local a, b = currentGear.Trinket, currentGear.Trinket2
        if a and b then
            return self:GetItemScore(a.itemId, a.ilvl) <= self:GetItemScore(b.itemId, b.ilvl) and a or b
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
    if currentScore > 0 then percent = (diff / currentScore) * 100
    elseif targetScore > 0 then percent = 100 end
    return { score = diff, percent = math.floor(percent * 10 + 0.5) / 10, targetIlvl = tIlvl, slot = canon }
end

function GearManager:GetBiSList()
    local class = self:GetPlayerClass()
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local list, seen = {}, {}

    local function pushEntry(entry)
        if not entry then return end
        local itemId = tonumber(entry.itemId)
        if not itemId or itemId <= 0 or seen[itemId] then return end
        if not self:IsItemValidForSpec(itemId, specID) then return end
        local name = entry.name
        local slot = entry.slot or "Item"
        if DragonSkillGearData and DragonSkillGearData.items and DragonSkillGearData.items[itemId] then
            local reg = DragonSkillGearData.items[itemId]
            if not name or name == "" then name = reg.name end
            if not slot or slot == "Item" then slot = reg.slot or "Item" end
        end
        table.insert(list, {
            itemId = itemId,
            name = name or ("Item " .. itemId),
            slot = slot,
            ilvl = entry.ilvl or 639,
        })
        seen[itemId] = true
    end

    if DragonSkillData and class and DragonSkillData[class] then
        local specData = DragonSkillData[class][specID]
        if specData then
            local src = (specData.bisGear and specData.bisGear.wowhead)
                or (specData.bisGear and specData.bisGear.archon)
                or specData.wowhead
            if type(src) == "table" then
                for _, entry in ipairs(src) do pushEntry(entry) end
            end
        end
    end

    if DragonSkillGearData and DragonSkillGearData.specs and DragonSkillGearData.specs[specID] then
        local overall = DragonSkillGearData.specs[specID].bis and DragonSkillGearData.specs[specID].bis.overall
        if overall then
            for _, itemId in ipairs(overall) do
                local item = DragonSkillGearData.items and DragonSkillGearData.items[itemId]
                pushEntry({
                    itemId = itemId,
                    name = item and item.name,
                    slot = item and item.slot or "Item",
                    ilvl = 639,
                })
            end
        end
    end

    if #list < 3 and DragonSkillGearData and DragonSkillGearData.items then
        local fallbackIds = {
            270175, 270173, 270162, 270165, 270160, 270161, 270163, 270170, 271532, 271535,
            268266, 268249, 268265, 271620, 268253, 268250,
            271092, 268214, 271619, 268213, 268240, 268201, 268210, 268261, 268262,
        }
        for _, itemId in ipairs(fallbackIds) do
            local item = DragonSkillGearData.items[itemId]
            pushEntry({
                itemId = itemId,
                name = item and item.name,
                slot = item and item.slot or "Item",
                ilvl = 639,
            })
        end
    end

    return list
end

function GearManager:GetBestUpgrades()
    local upgrades = {}
    for _, item in ipairs(self:GetBiSList()) do
        local details = self:GetUpgradeDetails(item.slot or "Item", item.itemId, item.ilvl or 639)
        if details.score > 0 then
            table.insert(upgrades, {
                itemId = item.itemId, name = item.name, slot = item.slot or "Item",
                score = details.score, percent = details.percent, ilvl = item.ilvl or 639,
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
                if itemId and itemId > 0 and self:IsItemValidForSpec(itemId, specID) then
                    local reg = DragonSkillGearData.items and DragonSkillGearData.items[itemId]
                    local slot = reg and reg.slot or "Item"
                    local details = self:GetUpgradeDetails(slot, itemId, 639)
                    local score = details and details.score or 0
                    if score < 1 then score = 1 end
                    table.insert(items, {
                        itemId = itemId,
                        name = reg and reg.name or ("Item " .. tostring(itemId)),
                        boss = boss.name, slot = slot, score = score,
                    })
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
