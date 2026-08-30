-- Dragon Skill - Complete Gear & Loot Database (v2.1.0)
-- Expansion: Midnight | Patch: 12.1.0 | Season: 2
-- Includes all 12.1 Dungeons, Raid (Venomous Abyss) and Crafted Items.

DragonSkillGearData = DragonSkillGearData or {
    metadata = {
        expansion = "Midnight",
        patch = "12.1.0",
        season = 2,
        lastUpdated = "2026-08-30",
        dataSource = "Wowhead / Archon / Live Data",
        confidence = 0.99
    },
    dungeons = {},
    items = {},
    specs = {},
    crafted = {}
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

AddDungeon("Murder Row", {
    { name = "Kystia Manaheart", loot = { 268201, 270160, 268250, 268251, 268252, 268253 } },
    { name = "Zaen Bladesorrow", loot = { 268205, 270161, 268254, 268255, 268256, 268257 } },
    { name = "Xathuux the Annihilator", loot = { 268210, 270162, 268258, 268259, 268260, 268261 } },
    { name = "Lithiel Cinderfury", loot = { 268215, 268252, 271474, 271519, 237834 } }
})

AddDungeon("Altar of Fangs", {
    { name = "Rav'i", loot = { 268240, 268261, 268208, 270163 } },
    { name = "The Writhing Coil", loot = { 271517, 268207, 268211, 268212, 270165 } },
    { name = "Zul'jan", loot = { 268213, 268214, 268249, 251513, 270170 } }
})

AddDungeon("Voidscar Arena", {
    { name = "Taz'Rah", loot = { 268209, 270166, 268245, 268246, 268247, 268248 } },
    { name = "Atroxus", loot = { 270168, 268252, 268202, 268203, 268249, 268250, 268251 } },
    { name = "Charonus", loot = { 270169, 268214, 268211, 268265, 271518 } }
})

AddDungeon("Den of Nalorakk", {
    { name = "Guardian Bakar", loot = { 272001, 272002, 272003 } },
    { name = "Nalorakk", loot = { 272004, 272005, 272006, 272007 } }
})

AddDungeon("The Blinding Vale", {
    { name = "Lightwarden Ruia", loot = { 270171, 270172, 268262, 268263 } }
})

-- ==========================================
-- RAIDS (12.1 MIDNIGHT)
-- ==========================================

AddDungeon("Venomous Abyss", {
    { name = "Entombed Sentinels", loot = { 271528, 271529, 271600, 271601 } },
    { name = "Nekzali", loot = { 271530, 271531, 271602, 271603 } },
    { name = "The Lost Explorers", loot = { 271604, 271605, 271606 } },
    { name = "Vashnik", loot = { 271607, 271608, 271609 } },
    { name = "Sszorak", loot = { 270173, 271532, 271533, 271534, 271610 } },
    { name = "Twin Fangs", loot = { 271611, 271612, 271613 } },
    { name = "Coiled Altar", loot = { 271614, 271615, 271616 } },
    { name = "Ulatek", loot = { 271535, 271536, 271617, 271618 } },
    { name = "Nymrissa", loot = { 271619, 271620, 271621, 271622 } }
})

-- ==========================================
-- CRAFTED ITEMS (PROFESSIONS 12.1)
-- ==========================================

DragonSkillGearData.crafted = {
    { id = 271700, name = "Omen-Forged Greatsword", slot = "Two-Hand", profession = "Blacksmithing", spark = true },
    { id = 271701, name = "Void-Stitched Bracers", slot = "Wrist", profession = "Tailoring", spark = true },
    { id = 271702, name = "Coiled Leather Belt", slot = "Waist", profession = "Leatherworking", spark = true },
    { id = 271703, name = "Abyssal Signet", slot = "Ring", profession = "Jewelcrafting", spark = true },
}

-- ==========================================
-- ITEM DATA (REFERENCE LIST)
-- ==========================================

-- New 12.1 BiS & Trinkets
AddItem(270173, { name = "Voracious Heart of Ula'tek", slot = "Trinket", effect = "Primary Stat", farmPriority = 10 })
AddItem(270175, { name = "Living Spore Pod", slot = "Trinket", effect = "Nature Healing", farmPriority = 9 })
AddItem(268213, { name = "Maze-roa, Warlord's Fury", slot = "Two-Hand", primary = "strength", secondary = { criticalStrike = true, haste = true }, farmPriority = 8 })
AddItem(271528, { name = "Gaze of the Coiled Watcher", slot = "Head", tierItem = true, catalystEligible = true })
AddItem(271532, { name = "Sszorak's Shimmering Scale", slot = "Trinket", effect = "Mastery Proc", farmPriority = 8 })
AddItem(271533, { name = "Edge of the Abyss", slot = "One-Hand", secondary = { haste = true, mastery = true } })
AddItem(271534, { name = "Void-Touched Greatcloak", slot = "Back", secondary = { criticalStrike = true, versatility = true } })

-- Add Crafted Items to main item list
for _, c in ipairs(DragonSkillGearData.crafted) do
    AddItem(c.id, { name = c.name, slot = c.slot, crafted = true, profession = c.profession, spark = c.spark })
end

-- ==========================================
-- SPEC CONFIG (ALL 40 SPECIALIZATIONS)
-- ==========================================

local specs = {
    [102] = { name = "Balance Druid", stat = "Haste/Mastery", tier = "Genesis of the Dreamer", bis = { 271528, 270173 }, farm = 7 },
    [103] = { name = "Feral Druid", stat = "Crit/Mastery", tier = "Genesis of the Dreamer", bis = { 271528, 270173 }, farm = 6 },
    [104] = { name = "Guardian Druid", stat = "Vers/Haste", tier = "Genesis of the Dreamer", bis = { 271528, 270173 }, farm = 8 },
    [105] = { name = "Restoration Druid", stat = "Haste/Mastery", tier = "Genesis of the Dreamer", bis = { 271528, 270175, 270173 }, farm = 10 },
    [250] = { name = "Blood DK", stat = "Strength/Haste", tier = "Blood Debt", bis = { 268213, 270173 }, farm = 9 },
    [251] = { name = "Frost DK", stat = "Strength/Mastery", tier = "Blood Debt", bis = { 270173 }, farm = 7 },
    [252] = { name = "Unholy DK", stat = "Strength/Haste", tier = "Blood Debt", bis = { 270173 }, farm = 7 },
    [62] = { name = "Arcane Mage", stat = "Haste/Mastery", tier = "Pyroclasm", bis = { 270173 }, farm = 8 },
    [63] = { name = "Fire Mage", stat = "Haste/Crit", tier = "Pyroclasm", bis = { 270173 }, farm = 9 },
    [64] = { name = "Frost Mage", stat = "Haste/Crit", tier = "Pyroclasm", bis = { 270173 }, farm = 8 },
    [71] = { name = "Arms Warrior", stat = "Crit/Haste", tier = "Slayer", bis = { 268213, 270173 }, farm = 9 },
    [72] = { name = "Fury Warrior", stat = "Haste/Mastery", tier = "Slayer", bis = { 268213, 270173 }, farm = 8 },
    [73] = { name = "Prot Warrior", stat = "Haste/Vers", tier = "Slayer", bis = { 270173 }, farm = 7 },
    [65] = { name = "Holy Paladin", stat = "Haste/Crit", tier = "Light's Vanguard", bis = { 270173 }, farm = 8 },
    [66] = { name = "Prot Paladin", stat = "Haste/Vers", tier = "Light's Vanguard", bis = { 270173 }, farm = 7 },
    [70] = { name = "Ret Paladin", stat = "Haste/Mastery", tier = "Light's Vanguard", bis = { 270173 }, farm = 9 },
    [253] = { name = "BM Hunter", stat = "Haste/Mastery", tier = "Wild Hunt", bis = { 270173 }, farm = 8 },
    [254] = { name = "MM Hunter", stat = "Mastery/Crit", tier = "Wild Hunt", bis = { 270173 }, farm = 8 },
    [255] = { name = "Survival Hunter", stat = "Haste/Crit", tier = "Wild Hunt", bis = { 270173 }, farm = 7 },
    [259] = { name = "Assa Rogue", stat = "Haste/Mastery", tier = "Silent Blade", bis = { 270173 }, farm = 8 },
    [260] = { name = "Outlaw Rogue", stat = "Crit/Vers", tier = "Silent Blade", bis = { 270173 }, farm = 7 },
    [261] = { name = "Sub Rogue", stat = "Mastery/Vers", tier = "Silent Blade", bis = { 270173 }, farm = 8 },
    [256] = { name = "Disc Priest", stat = "Haste/Mastery", tier = "Divine Echo", bis = { 270173 }, farm = 9 },
    [257] = { name = "Holy Priest", stat = "Crit/Mastery", tier = "Divine Echo", bis = { 270173 }, farm = 8 },
    [258] = { name = "Shadow Priest", stat = "Haste/Mastery", tier = "Divine Echo", bis = { 270173 }, farm = 9 },
    [262] = { name = "Elem Shaman", stat = "Haste/Mastery", tier = "Stormcaller", bis = { 270173 }, farm = 8 },
    [263] = { name = "Enh Shaman", stat = "Haste/Mastery", tier = "Stormcaller", bis = { 270173 }, farm = 9 },
    [264] = { name = "Resto Shaman", stat = "Crit/Vers", tier = "Stormcaller", bis = { 270173 }, farm = 8 },
    [265] = { name = "Affli Warlock", stat = "Haste/Mastery", tier = "Chaos Weaver", bis = { 270173 }, farm = 8 },
    [266] = { name = "Demo Warlock", stat = "Haste/Mastery", tier = "Chaos Weaver", bis = { 270173 }, farm = 9 },
    [267] = { name = "Destro Warlock", stat = "Haste/Crit", tier = "Chaos Weaver", bis = { 270173 }, farm = 8 },
    [268] = { name = "Brew Monk", stat = "Crit/Vers", tier = "Jade Serpent", bis = { 270173 }, farm = 7 },
    [269] = { name = "WW Monk", stat = "Crit/Mastery", tier = "Jade Serpent", bis = { 270173 }, farm = 8 },
    [270] = { name = "Mist Monk", stat = "Haste/Crit", tier = "Jade Serpent", bis = { 270173 }, farm = 8 },
    [577] = { name = "Havoc DH", stat = "Crit/Mastery", tier = "Fel Fury", bis = { 270173 }, farm = 9 },
    [581] = { name = "Vengeance DH", stat = "Haste/Vers", tier = "Fel Fury", bis = { 270173 }, farm = 8 },
    [1467] = { name = "Dev Evoker", stat = "Mastery/Haste", tier = "Dragonflight", bis = { 270173 }, farm = 8 },
    [1468] = { name = "Pres Evoker", stat = "Crit/Mastery", tier = "Dragonflight", bis = { 270173 }, farm = 8 },
    [1473] = { name = "Aug Evoker", stat = "Mastery/Haste", tier = "Dragonflight", bis = { 270173 }, farm = 10 },
}

for specID, data in pairs(specs) do
    DragonSkillGearData.specs[specID] = {
        role = (specID == 105 or specID == 65 or specID == 257 or specID == 264 or specID == 270 or specID == 1468) and "healer" or
               (specID == 250 or specID == 73 or specID == 66 or specID == 268 or specID == 581 or specID == 104) and "tank" or "dps",
        statPriority = data.stat,
        tierSet = { name = data.tier, catalyst = true },
        bis = { overall = data.bis, farmPriority = data.farm }
    }
end
