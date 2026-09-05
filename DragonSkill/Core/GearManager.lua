-- Dragon Skill - Gear Manager Engine (v2.4.2)
-- Absolute Purity Mode: Block Season 1 items and invalid class gear.
-- Designed for Patch 12.1 Midnight.

local GearManager = DragonSkill:RegisterModule("GearManager", {})

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

local CLASS_WEAPON_CHECK = {
    WARRIOR = { "axt", "streitkolben", "schwert", "stangenwaffe", "stab", "schild" },
    PALADIN = { "axt", "streitkolben", "schwert", "stangenwaffe", "schild" },
    HUNTER = { "bogen", "armbrust", "schusswaffe", "stangenwaffe", "stab", "axt" },
    ROGUE = { "dolch", "schwert", "axt", "streitkolben", "faustwaffe" },
    PRIEST = { "dolch", "streitkolben", "stab", "zauberstab" },
    DEATHKNIGHT = { "axt", "streitkolben", "schwert", "stangenwaffe" },
    SHAMAN = { "axt", "streitkolben", "stab", "dolch", "schild" },
    MAGE = { "dolch", "schwert", "stab", "zauberstab" },
    WARLOCK = { "dolch", "schwert", "stab", "zauberstab" },
    MONK = { "faustwaffe", "axt", "streitkolben", "schwert", "stangenwaffe", "stab" },
    DRUID = { "dolch", "faustwaffe", "streitkolben", "stangenwaffe", "stab" },
    DEMONHUNTER = { "gleive", "warglaive", "schwert", "axt", "faustwaffe" },
    EVOKER = { "dolch", "faustwaffe", "streitkolben", "schwert", "stab" }
}

local WEAPON_KEYWORDS = {
    "waffe", "stab", "dolch", "schild", "bogen", "armbrust", "schuss",
    "gleive", "kolben", "schwert", "axt", "faust", "stangen", "zauberstab",
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

function GearManager:IsItemValidForSpec(itemId, specID, nameHint, slotHint)
    itemId = tonumber(itemId)
    if not itemId or itemId < 260000 then return false end -- PURITY: ONLY SEASON 2

    local _, class = UnitClass("player")
    local item = DragonSkillGearData and DragonSkillGearData.items and DragonSkillGearData.items[itemId]
    local name = nameHint or (item and item.name) or ""
    local slot = slotHint or (item and item.slot) or ""

    -- Block Tabards and Shirts
    local nameLower = name:lower()
    local slotLower = slot:lower()
    if nameLower:find("wappenrock") or nameLower:find("hemd") or
       slotLower:find("wappenrock") or slotLower:find("hemd") then
        return false
    end

    -- Universal slots
    local canon = self:NormalizeSlot(slot)
    if canon == "Neck" or canon == "Back" or canon == "Ring" or canon == "Trinket" then
        -- Healer Filter: No Agility/Strength trinkets
        local isHealer = (specID == 105 or specID == 264 or specID == 256 or specID == 257 or specID == 65 or specID == 270 or specID == 1468)
        if isHealer and canon == "Trinket" then
            if nameLower:find("beweglichkeit") or nameLower:find("staerke") or nameLower:find("stärke") then
                return false
            end
        end
        return true
    end

    -- Armor Check
    local allowedArmor = CLASS_ARMOR[class]
    if item and item.armor and item.armor ~= "any" and item.armor ~= "none" then
        if item.armor ~= allowedArmor then return false end
    end

    -- Weapon Check
    local allowedWeapons = CLASS_WEAPON_CHECK[class]
    if allowedWeapons then
        local slotLower = slot:lower()
        local isWeapon = false
        for _, k in ipairs(WEAPON_KEYWORDS) do
            if slotLower:find(k) then isWeapon = true; break end
        end

        if isWeapon then
            local foundMatch = false
            for _, allowed in ipairs(allowedWeapons) do
                if slotLower:find(allowed) then foundMatch = true; break end
            end
            return foundMatch
        end
    end

    return true
end

function GearManager:GetItemScore(itemId, itemLevel)
    local data = DragonSkillGearData and DragonSkillGearData.items and DragonSkillGearData.items[itemId]
    local ilvl = tonumber(itemLevel) or (data and data.ilvl) or 639
    return ilvl * 10
end

function GearManager:GetUpgradeDetails(slot, targetItemId, targetIlvl)
    local Char = DragonSkill:GetModule("Character")
    local currentGear = Char and Char:GetCurrentGear() or {}
    local canon = self:NormalizeSlot(slot)

    local current = currentGear[canon]
    local currentScore = 0
    if current and current.itemId then currentScore = self:GetItemScore(current.itemId, current.ilvl) end

    local targetScore = self:GetItemScore(targetItemId, targetIlvl or 639)
    local diff = targetScore - currentScore
    local percent = (currentScore > 0) and ((diff / currentScore) * 100) or 100

    return { score = diff, percent = math.max(0, math.floor(percent * 10) / 10), targetIlvl = 639 }
end

function GearManager:GetBiSList()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local list, seen = {}, {}

    if DragonSkillData and DragonSkillData[class] and DragonSkillData[class][specID] then
        local bis = DragonSkillData[class][specID].bisGear
        if bis and bis.wowhead then
            for _, entry in ipairs(bis.wowhead) do
                local iid = tonumber(entry.itemId)
                if iid and iid >= 260000 and not seen[iid] and self:IsItemValidForSpec(iid, specID) then
                    table.insert(list, { itemId = iid, name = entry.name, slot = entry.slot, ilvl = 639 })
                    seen[iid] = true
                end
            end
        end
    end

    -- Fallback from Registry
    if #list < 5 and DragonSkillGearData.specs[specID] then
        for _, itemId in ipairs(DragonSkillGearData.specs[specID].bis.overall) do
            if not seen[itemId] and itemId >= 260000 and self:IsItemValidForSpec(itemId, specID) then
                local item = DragonSkillGearData.items[itemId]
                table.insert(list, { itemId = itemId, name = item.name, slot = item.slot or "Item", ilvl = 639 })
                seen[itemId] = true
            end
        end
    end

    return list
end

function GearManager:GetBestUpgrades()
    local upgrades = {}
    local bis = self:GetBiSList()
    for _, item in ipairs(bis) do
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
        for _, boss in ipairs(dData.bosses or {}) do
            for _, itemId in ipairs(boss.loot or {}) do
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
