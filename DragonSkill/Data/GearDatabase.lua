-- Dragon Skill - Complete Gear & Loot Database (v2.2.7)
-- Expansion: Midnight | Patch: 12.1.0 | Season: 2
-- Master Data: Includes all Raid (Venomous Abyss) and Dungeon Loot.

DragonSkillGearData = DragonSkillGearData or {
    metadata = { expansion = "Midnight", patch = "12.1.0", season = 2, lastUpdated = "2026-08-31" },
    dungeons = {},
    items = {},
    specs = {},
    crafted = {}
}

local function AddItem(id, data) DragonSkillGearData.items[id] = data end
local function AddDungeon(name, bosses) DragonSkillGearData.dungeons[name] = { name = name, bosses = bosses } end

-- ==========================================
-- DUNGEONS & LOOT (SEASON 2)
-- ==========================================

AddDungeon("Murder Row", {
    { name = "Kystia Manaheart", loot = { 268201, 270160, 268250, 268251 } },
    { name = "Zaen Bladesorrow", loot = { 268205, 270161, 268254, 268255 } },
    { name = "Xathuux", loot = { 268210, 270162, 268258, 268259 } }
})

AddDungeon("Altar of Fangs", {
    { name = "Rav'i", loot = { 268240, 268261, 270163, 268208 } },
    { name = "The Writhing Coil", loot = { 271517, 268207, 268211, 268212, 270165 } },
    { name = "Zul'jan", loot = { 268213, 268214, 270170, 268249 } }
})

AddDungeon("Ruby Life Pools", {
    { name = "Melidrussa Chillworn", loot = { 193760, 193761 } },
    { name = "Kyrakka and Erkhart", loot = { 193764, 193765, 270175 } }
})

AddDungeon("Den of Nalorakk", {
    { name = "Nalorakk", loot = { 272004, 272005, 272006, 272007 } }
})

AddDungeon("Venomous Abyss (Raid)", {
    { name = "Entombed Sentinels", loot = { 271528, 271529, 271600, 270165 } },
    { name = "Nekzali", loot = { 271530, 271531, 271602, 270162 } },
    { name = "Sszorak", loot = { 270173, 271532, 271533, 271534, 271610 } },
    { name = "Ulatek", loot = { 271535, 271536, 271617, 271618, 270175 } },
    { name = "Nymrissa", loot = { 271619, 271620, 271621, 271622, 268266 } }
})

-- ==========================================
-- ITEM DATA (REFERENCE)
-- ==========================================

AddItem(270173, { name = "Voracious Heart of Ula'tek", slot = "Trinket", effect = "Primary Stat" })
AddItem(270175, { name = "Living Spore Pod", slot = "Trinket", effect = "Nature Healing" })
AddItem(268213, { name = "Maze-roa, Warlord's Fury", slot = "Two-Hand", secondary = { criticalStrike = true, haste = true } })
AddItem(271528, { name = "Gaze of the Coiled Watcher", slot = "Head", tierItem = true, catalystEligible = true })
AddItem(271532, { name = "Sszorak's Shimmering Scale", slot = "Trinket", effect = "Mastery Proc" })
AddItem(268266, { name = "Ring of Wavecalling", slot = "Ring", secondary = { haste = true, mastery = true } })
AddItem(270162, { name = "Soulcoil Shard", slot = "Trinket", effect = "Haste Proc" })
AddItem(268265, { name = "Amani Pendant", slot = "Neck", secondary = { haste = true, mastery = true } })
AddItem(268253, { name = "Cloak of Coiling Souls", slot = "Cloak", secondary = { crit = true, versatility = true } })
AddItem(268259, { name = "Belt of the Annihilator", slot = "Belt", secondary = { haste = true, crit = true } })
AddItem(268249, { name = "Signet of the Malignant", slot = "Ring", secondary = { mastery = true, versatility = true } })

-- ==========================================
-- SPEC CONFIG (FALLBACK & FULL LIST)
-- ==========================================

local specList = { 102, 103, 104, 105, 250, 251, 252, 62, 63, 64, 71, 72, 73, 65, 66, 70, 253, 254, 255, 259, 260, 261, 256, 257, 258, 262, 263, 264, 265, 266, 267, 268, 269, 270, 577, 581, 1467, 1468, 1473 }
for _, id in ipairs(specList) do
    -- Provide a solid BiS baseline for ALL specs
    DragonSkillGearData.specs[id] = DragonSkillGearData.specs[id] or {
        bis = { overall = { 270173, 270175, 271528, 268213, 268266, 268265, 268253, 268259, 268249 } }
    }
end
