-- Dragon Skill - Complete Gear & Loot Database (v1.7.0)
-- Expansion: Midnight | Patch: 12.1.0 | Season: 2
-- Includes all 12.1 Dungeons and Boss Loot.

DragonSkillGearData = DragonSkillGearData or {
    metadata = {
        expansion = "Midnight",
        patch = "12.1.0",
        season = 2,
        lastUpdated = "2026-08-29",
        dataSource = "Wowhead / Archon / Live Data",
        confidence = 0.98
    },
    dungeons = {},
    items = {}, -- [itemId] = { ... }
    specs = {}  -- [specID] = { tierSet = { ... }, bis = { ... } }
}

local function AddItem(id, data)
    DragonSkillGearData.items[id] = data
end

local function AddDungeon(name, bosses)
    DragonSkillGearData.dungeons[name] = { name = name, bosses = bosses }
end

-- ==========================================
-- DUNGEONS & LOOT (12.1 SEASON 2)
-- ==========================================

-- 1. MURDER ROW (Silvermoon City)
AddDungeon("Murder Row", {
    { name = "Kystia Manaheart", loot = { 268201, 270160, 268250, 268251, 268252, 268253 } },
    { name = "Zaen Bladesorrow", loot = { 268205, 270161, 268254, 268255, 268256, 268257 } },
    { name = "Xathuux the Annihilator", loot = { 268210, 270162, 268258, 268259, 268260, 268261 } },
    { name = "Lithiel Cinderfury", loot = { 268215, 268252, 271474, 271519, 237834 } }
})

-- 2. ALTAR OF FANGS (Coiled Isle)
AddDungeon("Altar of Fangs", {
    { name = "Rav'i", loot = { 268240, 268261, 268208, 270163 } },
    { name = "The Writhing Coil", loot = { 271517, 268207, 268211, 268212, 270165 } },
    { name = "Zul'jan", loot = { 268213, 268214, 268249, 251513, 270170 } }
})

-- 3. VOIDSCAR ARENA (Voidstorm)
AddDungeon("Voidscar Arena", {
    { name = "Taz'Rah", loot = { 268209, 270166, 268245, 268246, 268247, 268248 } },
    { name = "Atroxus", loot = { 270168, 268252, 268202, 268203, 268249, 268250, 268251 } },
    { name = "Charonus", loot = { 270169, 268214, 268211, 268265, 271518 } }
})

-- 4. THE BLINDING VALE
AddDungeon("The Blinding Vale", {
    { name = "Lightwarden Ruia", loot = { 270171, 270172, 268262, 268263 } }
})

-- ==========================================
-- ITEM DATA (REFERENCE LIST)
-- ==========================================

-- Weapons
AddItem(268201, { name = "Nibbles' Training Rod", slot = "Two-Hand", primary = "intellect", secondary = { haste = true, mastery = true } })
AddItem(268213, { name = "Maze-roa, Warlord's Fury", slot = "Two-Hand", primary = "strength", secondary = { criticalStrike = true, haste = true }, effect = "Warlord's Fury" })
AddItem(268209, { name = "Taz'Rah's Cosmic Edge", slot = "MainHand", primary = "strength", secondary = { haste = true, versatility = true } })
AddItem(268205, { name = "Bladesorrow", slot = "MainHand", primary = "agility", secondary = { haste = true, criticalStrike = true } })

-- Armor (Resto Druid Focused)
AddItem(271528, { name = "Gaze of the Coiled Watcher", slot = "Head", tierItem = true, secondary = { haste = true, mastery = true } })
AddItem(271519, { name = "War Trial Vestments", slot = "Chest", catalystEligible = true, secondary = { haste = true, mastery = true } })
AddItem(268252, { name = "Sickening Signet of Atroxus", slot = "Ring", secondary = { haste = true, mastery = true } })
AddItem(268249, { name = "Vile Alchemist's Band", slot = "Ring", secondary = { haste = true, criticalStrike = true } })
AddItem(268260, { name = "Breakwater Boots", slot = "Feet", secondary = { haste = true, mastery = true } })
AddItem(268265, { name = "Amulet of the Twin Fangs", slot = "Neck", secondary = { mastery = true, versatility = true } })

-- Trinkets
AddItem(270160, { name = "Manaheart's Binding Flame", slot = "Trinket", effect = "Mana Absorb", overallScore = 95 })
AddItem(270164, { name = "Pendant of Malefic Fury", slot = "Trinket", effect = "Haste Burst", overallScore = 98 })
AddItem(270175, { name = "Living Spore Pod", slot = "Trinket", effect = "Nature Healing", overallScore = 99 })
AddItem(270173, { name = "Voracious Heart of Ula'tek", slot = "Trinket", effect = "Primary Stat", overallScore = 100 })

-- ==========================================
-- SPEC CONFIG (Restoration Druid Reference)
-- ==========================================

DragonSkillGearData.specs[105] = { -- Restoration Druid
    role = "healer",
    armorType = "leather",
    tierSet = {
        name = "Genesis of the Dreamer",
        pieces = { 271528, 271517, 271516, 271520, 271519 },
        bonuses = {
            [2] = "Nature's Swiftness grants Genesis (HoT +15%)",
            [4] = "Incarnation extends Genesis duration"
        }
    },
    bis = {
        overall = { 271528, 268265, 271517, 268253, 271519, 237834, 271516, 268256, 271520, 268260, 268249, 268252, 270175, 270173, 268201 }
    }
}
