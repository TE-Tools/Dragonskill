-- Dragon Skill - Gear Manager Engine (v2.5.0)
-- Rebuilt for Patch 12.1 Midnight Season 2: BiS data now comes directly from
-- real per-class/spec Wowhead guides (see Data/GuideData.lua, auto-generated
-- by scraper/build-data.js). We trust that source instead of re-guessing
-- armor/weapon type or item-ID ranges in Lua, which previously caused
-- legitimate items (e.g. crafted gear with older IDs) to be blocked and
-- caused every spec sharing a "role" (healer/tank/melee/caster) to see the
-- exact same generic item list regardless of class or weapon type.

local GearManager = DragonSkill:RegisterModule("GearManager", {})

-- Canonical slot names match Character:GetCurrentGear()'s keys
-- (Head, Neck, Shoulder, Back, Chest, Wrist, Hands, Waist, Legs, Feet,
--  Ring, Trinket, MainHand, OffHand).
local SLOT_CANON = {
    -- German
    kopf = "Head", hals = "Neck", schulter = "Shoulder", schultern = "Shoulder",
    ruecken = "Back", umhang = "Back",
    brust = "Chest",
    handgelenke = "Wrist", handgelenk = "Wrist", armschienen = "Wrist", unterarm = "Wrist", unterarme = "Wrist",
    haende = "Hands", handschuhe = "Hands",
    taille = "Waist", gurt = "Waist", guertel = "Waist",
    beine = "Legs", gamaschen = "Legs",
    fuesse = "Feet", stiefel = "Feet",
    ring = "Ring", finger = "Ring",
    schmuck = "Trinket", schmuckstueck = "Trinket",
    waffe = "MainHand", haupthand = "MainHand", einhandwaffe = "MainHand", zweihandwaffe = "MainHand", stab = "MainHand", dolch = "MainHand",
    nebenhand = "OffHand", schild = "OffHand", offhand = "OffHand",
    -- English (some guide pages render slot labels in English even on the DE locale)
    head = "Head", neck = "Neck", shoulder = "Shoulder", shoulders = "Shoulder",
    back = "Back", cloak = "Back",
    chest = "Chest",
    wrist = "Wrist", bracers = "Wrist",
    hands = "Hands", gloves = "Hands",
    waist = "Waist", belt = "Waist",
    legs = "Legs",
    feet = "Feet", boots = "Feet",
    trinket = "Trinket",
    weapon = "MainHand", mainhand = "MainHand",
    -- Blizzard INVTYPE_* equip-slot tokens (used when scanning bags, see
    -- Character:GetInventoryUpgrades), lowercased, e.g. "invtype_head".
    robe = "Chest", hand = "Hands",
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

-- Minimal sanity check only. The per-spec source data (GuideData.lua) is
-- scraped directly from that class+spec's own Wowhead guide, so it is
-- already correct for armor type, weapon type and role — we don't need to
-- (and shouldn't) re-derive that from item names in Lua.
function GearManager:IsItemValidForSpec(itemId)
    itemId = tonumber(itemId)
    return itemId ~= nil and itemId > 0
end

function GearManager:GetItemScore(itemId, itemLevel)
    local data = DragonSkillGearData and DragonSkillGearData.items and DragonSkillGearData.items[itemId]
    local ilvl = tonumber(itemLevel) or (data and data.ilvl) or 639
    return ilvl * 10
end

-- Used by Character:GetInventoryUpgrades when scanning bags for upgrades.
function GearManager:GetUpgradeScore(slot, itemId, ilvl)
    local details = self:GetUpgradeDetails(slot, itemId, ilvl)
    return details and details.score or 0
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

-- Returns this character's real per-spec BiS list, sourced from
-- DragonSkillData[class][specID].bisGear.wowhead (built from the actual
-- Wowhead bis-gear guide for that class+spec). Falls back to the generic
-- role-based registry in GearDatabase.lua only if no per-spec data exists
-- at all (e.g. a brand-new spec not yet covered by the scraper).
function GearManager:GetBiSList()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local list, seen = {}, {}

    -- Self-diagnosing lookup info surfaced by the UI's empty-state messages
    -- (e.g. "Kein BiS-Datenstand geladen") so a missing-data report always
    -- comes with WHY it was missing, instead of a silent blank screen.
    local reason = nil
    if not DragonSkillData then
        reason = "GuideData.lua nicht geladen (DragonSkillData ist nil)"
    elseif not DragonSkillData[class] then
        reason = "Keine Daten für Klasse '" .. tostring(class) .. "'"
    elseif not DragonSkillData[class][specID] then
        reason = "Keine Daten für Spec-ID " .. tostring(specID) .. " (Klasse " .. tostring(class) .. ")"
    end
    self.lastLookup = { class = class, specID = specID, reason = reason }

    if DragonSkillData and DragonSkillData[class] and DragonSkillData[class][specID] then
        local bis = DragonSkillData[class][specID].bisGear
        if bis and bis.wowhead then
            for _, entry in ipairs(bis.wowhead) do
                local iid = tonumber(entry.itemId)
                if iid and not seen[iid] and self:IsItemValidForSpec(iid) then
                    table.insert(list, {
                        itemId = iid,
                        name = entry.name or entry.text,
                        slot = entry.slot,
                        source = entry.source,
                        ilvl = 639,
                    })
                    seen[iid] = true
                end
            end
        end
    end

    -- Fallback from generic role registry (only used if the spec truly has
    -- no real per-spec data loaded yet).
    if #list == 0 and DragonSkillGearData and DragonSkillGearData.specs and DragonSkillGearData.specs[specID] then
        for _, itemId in ipairs(DragonSkillGearData.specs[specID].bis.overall) do
            if not seen[itemId] and self:IsItemValidForSpec(itemId) then
                local item = DragonSkillGearData.items[itemId]
                table.insert(list, { itemId = itemId, name = item and item.name, slot = item and item.slot or "Item", ilvl = 639 })
                seen[itemId] = true
            end
        end
    end

    -- The class/spec key existed but its wowhead list was empty (or every
    -- entry got filtered out) - record that too so the diagnostic doesn't
    -- silently say "no reason" while still returning zero items.
    if #list == 0 and not reason then
        reason = "Eintrag für " .. tostring(class) .. "/" .. tostring(specID) .. " vorhanden, aber bisGear.wowhead ist leer"
        self.lastLookup.reason = reason
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
                itemId = item.itemId, name = item.name, slot = item.slot or "Item", source = item.source,
                score = details.score, percent = details.percent, ilvl = 639
            })
        end
    end
    table.sort(upgrades, function(a, b) return a.score > b.score end)
    return upgrades
end

-- "What do I need to farm?" — group this character's own real per-spec
-- BiS items by where they actually drop/come from (dungeon boss, raid
-- boss, crafting profession, etc.), using the `source` Wowhead already
-- gave us for each item. This replaces the old approach of matching
-- against a small hand-maintained dungeon/boss loot table that could
-- never stay in sync with 40 specs worth of real BiS lists.
function GearManager:GetFarmPlan()
    local bis = self:GetBiSList()
    local groups, order = {}, {}

    for _, item in ipairs(bis) do
        local src = item.source or "Unbekannte Quelle"
        if not groups[src] then
            groups[src] = { name = src, items = {} }
            table.insert(order, src)
        end
        table.insert(groups[src].items, {
            itemId = item.itemId, name = item.name, slot = item.slot, boss = src,
        })
    end

    local plan = {}
    for _, src in ipairs(order) do
        local g = groups[src]
        table.insert(plan, { name = g.name, score = #g.items * 10, items = g.items })
    end
    table.sort(plan, function(a, b) return a.score > b.score end)
    return plan
end
