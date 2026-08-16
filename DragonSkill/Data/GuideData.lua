-- AUTO-GENERATED - nicht manuell bearbeiten
-- Notfall-Daten Recovery v1.3.5 (Full Class Support: DK, Paladin, Warrior, DH, Druid, Mage, Hunter, Rogue, Shaman, Warlock, Priest, Evoker)

DragonSkillData = DragonSkillData or {}

-- Helper: Merge function to keep existing talent strings
local function AddSpec(class, specID, data)
    DragonSkillData[class] = DragonSkillData[class] or {}
    local existing = DragonSkillData[class][specID] or {}
    data.talentBuilds = data.talentBuilds or existing.talentBuilds or {}
    DragonSkillData[class][specID] = data
end

-- ==========================================
-- DEATHKNIGHT
-- ==========================================
AddSpec("DEATHKNIGHT", 250, {
    scrapedAt = "2026-08-16T15:00:00Z",
    statPriority = { wowhead = "Strength > Haste > Mastery / Critical Strike / Versatility", archon = "Strength > Mastery > Crit > Haste > Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "The Coiled Altar", itemId = 268213 }, { slot = "Head", text = "Nek'zali Helm", itemId = 271474 }, { slot = "Neck", text = "Ula'tek's Resolve", itemId = 268265 } } },
    enchants = { wowhead = { { text = "Weapon: Rune of the Sanguine Thirst", itemId = 245001 }, { text = "Chest: Crystallized Vitality", itemId = 245005 } } },
    consumables = { wowhead = { { text = "Phial of the Serpent Goddess", itemId = 246001 }, { text = "Abyssal Potion", itemId = 246002 } } },
    talentBuilds = { { provider = "wowhead", label = "Raid (Deathbringer)", importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWGzMmxMjhZZmZmmZxYmxMmBAAAAmZmZmZmZYGjZAYMzMzAAAMmtBGwSw2wEYYBwMMAAMzAYYA" } },
})

-- ==========================================
-- PALADIN
-- ==========================================
-- HOLY
AddSpec("PALADIN", 65, {
    scrapedAt = "2026-08-16T16:15:00Z",
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit > Vers" },
    bisGear = { wowhead = { { slot = "Helm", text = "Warhelm of the Consecrated Flame", itemId = 271474 }, { slot = "Weapon", text = "Blade of the Blind Verdict", itemId = 268202 } } },
    enchants = { wowhead = { { text = "Weapon: Ren’dorei Insight", itemId = 245012 }, { text = "Chest: Magister’s Mark", itemId = 245014 } } },
    consumables = { wowhead = { { text = "Flask of the Magisters", itemId = 246012 }, { text = "Potion of Focused Clarity", itemId = 246013 } } },
})
-- PROTECTION
AddSpec("PALADIN", 66, {
    scrapedAt = "2026-08-16T16:00:00Z",
    statPriority = { wowhead = "Haste (28%) > Mastery > Versatility > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Aman'muso, Warlord's Vengeance", itemId = 268213 }, { slot = "Shield", text = "Bulwark of Ula'tek", itemId = 268250 } } },
    enchants = { wowhead = { { text = "Weapon: Authority of Radiant Power", itemId = 245010 }, { text = "Head: Enhanced Blessing of Speed", itemId = 245011 } } },
    consumables = { wowhead = { { text = "Flask of Tepid Versatility", itemId = 246010 } } },
})
-- RETRIBUTION
AddSpec("PALADIN", 70, {
    scrapedAt = "2026-08-16T16:15:00Z",
    statPriority = { wowhead = "Strength > Haste > Mastery > Crit > Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Maze-roa, Warlord's Fury", itemId = 268215 } } },
    enchants = { wowhead = { { text = "Weapon: Arcane Mastery", itemId = 245015 }, { text = "Weapon Oil: Thalassian Phoenix Oil", itemId = 245016 } } },
})

-- ==========================================
-- DEMON HUNTER
-- ==========================================
-- HAVOC
AddSpec("DEMONHUNTER", 577, {
    scrapedAt = "2026-08-16T16:30:00Z",
    statPriority = { wowhead = "Crit > Mastery > Haste > Vers" },
    bisGear = { wowhead = { { slot = "MainHand", text = "Aman'muso, Warlord's Vengeance", itemId = 268213 } } },
    enchants = { wowhead = { { text = "Weapon: Acuity of the Ren'dorei", itemId = 245018 }, { text = "Legs: Forest Hunter’s Armor Kit", itemId = 245009 } } },
})
-- VENGEANCE
AddSpec("DEMONHUNTER", 581, {
    scrapedAt = "2026-08-16T16:30:00Z",
    statPriority = { wowhead = "Haste > Versatility > Mastery > Crit" },
    bisGear = { wowhead = { { slot = "MainHand", text = "Lightless Lament", itemId = 268211 } } },
    enchants = { wowhead = { { text = "Weapon: Acuity of the Ren'dorei", itemId = 245018 }, { text = "Boots: Lynx's Speed", itemId = 245019 } } },
})

-- ==========================================
-- DRUID
-- ==========================================
-- BALANCE
AddSpec("DRUID", 102, {
    statPriority = { wowhead = "Intellect > Mastery > Haste > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Coiled Altar Staff", itemId = 268209 } } },
    enchants = { wowhead = { { text = "Ring: Devotion of Mastery", itemId = 245021 } } },
})
-- GUARDIAN
AddSpec("DRUID", 104, {
    statPriority = { wowhead = "Stamina > Agility > Haste > Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Warlord's Vengeance", itemId = 268213 } } },
    enchants = { wowhead = { { text = "Legs: Storm-Touched Armor Kit", itemId = 245009 } } },
})

-- ==========================================
-- HUNTER
-- ==========================================
-- BEAST MASTERY
AddSpec("HUNTER", 253, {
    statPriority = { wowhead = "Agility > Crit > Haste > Mastery" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Caustic Repose Greatbow", itemId = 268214 } } },
    enchants = { wowhead = { { text = "Weapon: Arcane Mastery", itemId = 245015 }, { text = "Legs: Forest Hunter's Armor Kit", itemId = 245009 } } },
    consumables = { wowhead = { { text = "Flask of the Blood Knights", itemId = 246016 }, { text = "Thalassian Phoenix Oil", itemId = 245016 } } },
})

-- ==========================================
-- ROGUE
-- ==========================================
AddSpec("ROGUE", 259, {
    statPriority = { wowhead = "Agility > Crit > Haste > Mastery" },
    bisGear = { wowhead = { { slot = "MainHand", text = "Zatha'tek, Breath of Corruption", itemId = 268205 } } },
    enchants = { wowhead = { { text = "Weapon: Arcane Mastery", itemId = 245015 }, { text = "Rings: Eyes of the Eagle", itemId = 245017 } } },
})

-- ==========================================
-- SHAMAN
-- ==========================================
-- ENHANCEMENT
AddSpec("SHAMAN", 263, {
    statPriority = { wowhead = "Agility > Mastery > Haste > Crit" },
    bisGear = { wowhead = { { slot = "MainHand", text = "Aman’muso, Warlord’s Vengeance", itemId = 268213 } } },
    enchants = { wowhead = { { text = "Weapon: Berserker's Rage", itemId = 245024 } } },
})

-- ==========================================
-- WARLOCK
-- ==========================================
AddSpec("WARLOCK", 267, {
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Jan’thrazet, the Soul Fang", itemId = 268201 } } },
    enchants = { wowhead = { { text = "Chest: Mark of the Magister", itemId = 245014 }, { text = "Legs: Arcanoweave Spellthread", itemId = 245023 } } },
})

-- ==========================================
-- PRIEST
-- ==========================================
AddSpec("PRIEST", 258, {
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Jan’thrazet, the Soul Fang", itemId = 268201 } } },
    enchants = { wowhead = { { text = "Rings: Silvermoon’s Alacrity", itemId = 245025 } } },
})

-- ==========================================
-- EVOKER
-- ==========================================
AddSpec("EVOKER", 1473, {
    statPriority = { wowhead = "Intellect > Mastery > Crit > Haste" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Jan’thrazet, the Soul Fang", itemId = 268201 } } },
    enchants = { wowhead = { { text = "Rings: Zul’jin’s Mastery", itemId = 245021 } } },
})
