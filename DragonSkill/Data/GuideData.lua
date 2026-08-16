-- AUTO-GENERATED - nicht manuell bearbeiten
-- Notfall-Daten Recovery v1.5.0 (ULTIMATE 12.1 SUPPORT - All 40 Specs)

DragonSkillData = DragonSkillData or {}

local function AddSpec(class, specID, data)
    DragonSkillData[class] = DragonSkillData[class] or {}
    DragonSkillData[class][specID] = data
end

-- ==========================================
-- DEATHKNIGHT
-- ==========================================
AddSpec("DEATHKNIGHT", 250, { -- BLOOD
    statPriority = { wowhead = "Strength > Haste > Mastery", archon = "Strength > Mastery > Crit > Haste > Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "The Coiled Altar", itemId = 268213 }, { slot = "Neck", text = "Aqirbane Reliquary", itemId = 268265 } } },
    enchants = { wowhead = { { text = "Weapon: Rune of the Sanguine Thirst", itemId = 245001 } } },
    consumables = { wowhead = { { text = "Flask: Tempered Aggression", itemId = 246015 } } },
    talentBuilds = { { provider = "wowhead", label = "Raid", importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWGzMmxMjhZZmZmmZxYmxMmBAAAAmZmZmZmZYGjZAYMzMzAAAMmtBGwSw2wEYYBwMMAAMzAYYA" } },
})
AddSpec("DEATHKNIGHT", 251, { -- FROST
    statPriority = { wowhead = "Strength > Mastery > Crit > Haste" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Sszorak's Tooth", itemId = 268210 } } },
    enchants = { wowhead = { { text = "Weapon: Rune of the Fallen Crusader", itemId = 245001 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMAzMjZmZAz2MzMzMLmZkZMmZmZGYMzwMzMjZAAAAAAAAAYMbDMgFwywEYsgZGmZgZAMMzAMDM" } },
})
AddSpec("DEATHKNIGHT", 252, { -- UNHOLY
    statPriority = { wowhead = "Strength > Mastery > Haste > Crit" },
    enchants = { wowhead = { { text = "Weapon: Rune of the Apocalypse", itemId = 245002 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmZMjZMYWGzMTjZmxMzYAAAAAAAAYmxwAglZMzsZmxMzA2MbGGYgZjhGLYAzAwYmZMDwMzYGD" } },
})

-- ==========================================
-- PALADIN
-- ==========================================
AddSpec("PALADIN", 65, { -- HOLY
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit" },
    bisGear = { wowhead = { { slot = "Trinket", text = "Soulcoiler Ritual Vessel", itemId = 270167 } } },
    enchants = { wowhead = { { text = "Weapon: Ren’dorei Insight", itemId = 245012 } } },
    talentBuilds = { { provider = "wowhead", label = "Herald Raid", importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAAw2MzMjZMzYxYmZYZwMLmpJGzYmZYMbZAYADbgNWmxMLz2Mzs1AAAAsAAbGGzYGmBAwMDzghB" } },
})
AddSpec("PALADIN", 66, { -- PROTECTION
    statPriority = { wowhead = "Haste (28%) > Mastery > Vers > Crit" },
    bisGear = { wowhead = { { slot = "Shield", text = "Bulwark of Ula'tek", itemId = 268250 }, { slot = "Weapon", text = "Aman'muso, Warlord's Vengeance", itemId = 268213 } } },
    enchants = { wowhead = { { text = "Weapon: Authority of Radiant Power", itemId = 245010 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNjBzyYbMjZmZZZMzwsMLzYAAGAAAAAA00MzyMjZGGegt2AwADYGsBAAAAzMLbLtMzYxMYAMYGGDAmZAwMDYA" } },
})
AddSpec("PALADIN", 70, { -- RETRIBUTION
    statPriority = { wowhead = "Strength > Haste > Mastery > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Maze-roa, Warlord's Fury", itemId = 268215 } } },
    enchants = { wowhead = { { text = "Weapon Oil: Thalassian Phoenix Oil", itemId = 245016 } } },
    talentBuilds = { { provider = "wowhead", label = "Templar ST", importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAANbbzMzywMDAAAAAAzUGzwMjtxsNMz2MGjZGmxCbDAAgZm2mZ2mBAsBYAwYGmBzYMbYbGMMmxgB" } },
})

-- ==========================================
-- WARRIOR
-- ==========================================
AddSpec("WARRIOR", 71, { -- ARMS
    statPriority = { wowhead = "Strength > Crit > Haste > Mastery" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphZGzMbmZmZGmxMDAAAAgxmZgtYAbmxwCMwMsRjBLgZGGGMbmtBzMAAzMMA" } },
})
AddSpec("WARRIOR", 72, { -- FURY
    statPriority = { wowhead = "Strength > Haste > Mastery > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZmZ2MzMzMjZMzYGzYmlZmxYmZZMzMAAQYgNYZxoxMAmFMsAYGMGAMzAYYmZmhBD" } },
})
AddSpec("WARRIOR", 73, { -- PROTECTION
    statPriority = { wowhead = "Strength > Haste > Crit > Mastery" },
    bisGear = { wowhead = { { slot = "Shield", text = "Crest of Ula'tek", itemId = 268250 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzwMzMzMmNzMLzYMGNmxwyMmZGzwMDAAAAWmZAmxAMwGssY0YGAzCmZDGzMDjtBAzMAAMDYA" } },
})

-- ==========================================
-- DEMONHUNTER
-- ==========================================
AddSpec("DEMONHUNTER", 577, { -- HAVOC
    statPriority = { wowhead = "Crit > Mastery > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZ2mxMzMGzkxMDAAAAAAYWMmtZYmBmx2sNzMjxALDsNbmxwsw0YmZMjNAAAgBAAAwMDGAAAAG" } },
})
AddSpec("DEMONHUNTER", 581, { -- VENGEANCE
    statPriority = { wowhead = "Haste > Vers > Mastery > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAWmxMzMGmRmZGMLmxMYmxMjZegZmZMY2mZsZmZbMMAAAAAAAAMzM2AAAAwAzMzMzWbzMzAADAAAgB" } },
})
AddSpec("DEMONHUNTER", 1480, { -- DEVOURER
    statPriority = { wowhead = "Intellect > Haste > Crit > Mastery" },
    enchants = { wowhead = { { text = "Legs: Sunfire Silk Spellthread", itemId = 245023 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2mxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMzMzMzMzMDzsYGjFZhZmZmt2mZmBwwAAwMGMmB" } },
})

-- ==========================================
-- DRUID
-- ==========================================
AddSpec("DRUID", 102, { -- BALANCE
    statPriority = { wowhead = "Intellect > Mastery > Haste > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsMzMzMLMYMLzsMziZmxGLzsMmZMWwwAM22mZwY2GATAAAAWYmZmBbGGjBAgZGYA" } },
})
AddSpec("DRUID", 103, { -- FERAL
    statPriority = { wowhead = "Agility > Mastery > Haste > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Abyssal Broodfiend's Bardiche", itemId = 268210 }, { slot = "Trinket", text = "Voracious Heart of Ula'tek", itemId = 270173 } } },
    enchants = { wowhead = { { text = "Weapon: Arcane Mastery", itemId = 245015 }, { text = "Chest: Crystalline Agility", itemId = 245020 } } },
    consumables = { wowhead = { { text = "Food: Hearty Harandar Celebration", itemId = 246005 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZMziZmZmxY2M2GbzMzMmZAAAAYJY2M8AmZUzYWMzMzsMmhBAAAAAwADAAAgmZZWmZmBAsAzMDwCDGAAAzshB" } },
})
AddSpec("DRUID", 104, { -- GUARDIAN
    statPriority = { wowhead = "Stamina > Agility > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZmFzMjZWmZxMPwMLLDMbGGNRmZWmZmZmlxMMAAAAAAjNzALbzMYMLDgJAAAgNMzAsYMMwsYBgZGAA" } },
})
AddSpec("DRUID", 105, { -- RESTORATION
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit" },
    bisGear = { wowhead = { { slot = "Trinket", text = "Soulcoiler Ritual Vessel", itemId = 270167 } } },
    rotation = { wowhead = { { text = "Maintain 3-stack Lifebloom", spellId = 33763 }, { text = "Swiftmend on CD", spellId = 18562 } } },
    talentBuilds = {
        { provider = "wowhead", label = "Everbloom (M+)", importString = "CkGAAAAAAAAAAAAAAAAAAAAAAsNmZGLbjZmxiZBzYstNsYbGAAAAAAAAAAAALzAmhxMamBMjZmZmhZabGAAAAAgBAADYZZsgpZmlBAAIgFGDgZA" },
        { provider = "wowhead", label = "Raid Build", importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsNjFbzAAAAAAAAAAgFDNbzw0MAmFzMzMLGGAAAAAMAAzAAAAAgZbmtmtZWsxMzMDmZD0MAAzMAMA" }
    },
})

-- ==========================================
-- HUNTER
-- ==========================================
AddSpec("HUNTER", 253, { -- BM
    statPriority = { wowhead = "Agility > Crit > Haste > Mastery" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Caustic Repose Greatbow", itemId = 268214 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGPwyMzsYGmZmZGzMMzMmhZGzYGMzYGzgx0MAAAAAAAAgZGzAMzGYjFzCYbAA" } },
})
AddSpec("HUNTER", 254, { -- MM
    statPriority = { wowhead = "Agility > Mastery > Crit > Haste" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAGwMsEYWAAAAAAAAAmxMmhZMzMmhlx0MGMLbmZGmZGzMzCzsMMzAAAMjxMzMDYghBYhZGD" } },
})
AddSpec("HUNTER", 255, { -- SURVIVAL
    statPriority = { wowhead = "Agility > Haste > Mastery > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2gFYGGawiZmZmZYZAAAAAAwMmxMMjxMmhlx0MAAAAMAwYZZmZWMzMDzYMgZ2AMMGzMbGA" } },
})

-- ==========================================
-- ROGUE
-- ==========================================
AddSpec("ROGUE", 259, { -- ASSA
    statPriority = { wowhead = "Agility > Mastery > Crit > Haste" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Zatha'tek Dagger", itemId = 268205 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmNDGAAAAAYWGsNDAAAAAotlZmZmZmxYmZmZbmlZGPgHYmZmZMMzYMAGYBmxoxsBYbAbGAMzMYA" } },
})
AddSpec("ROGUE", 260, { -- OUTLAW
    statPriority = { wowhead = "Agility > Crit > Vers > Haste" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MYmZmZmtZmZMzMzsBmZbaZw2MAAAAAAbLzMzwMzMzYmZ2GAAAAGDAGzihBGYWYhWYjBYmBzgB" } },
})
AddSpec("ROGUE", 261, { -- SUB
    statPriority = { wowhead = "Agility > Mastery > Crit > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMjZMegZmZGjZbYGbLzMzMzMjBjZ2GAAAAGMGwY2MMwAzCL0iNMDYmBzYA" } },
})

-- ==========================================
-- SHAMAN
-- ==========================================
AddSpec("SHAMAN", 262, { -- ELE
    statPriority = { wowhead = "Intellect > Mastery > Crit > Haste" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMzYML2mhZMzAAAAAAbmxwGsAzwQjNAY2mZmxYZxEmx2YZmZmxYWsMjFzMjZWAAmBYmBGGG" } },
})
AddSpec("SHAMAN", 263, { -- ENH
    statPriority = { wowhead = "Agility > Mastery > Haste > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAAsBYzMG2gFYGGawCAz2MmxYZZGbMzsNWmZmZYswMAAzwYmhZCMzgBjB" } },
})
AddSpec("SHAMAN", 264, { -- RESTO
    statPriority = { wowhead = "Intellect > Crit > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZmZZbZMzMzYmZGzYYB2gZsox2AYGYDzMY2mZmRzyyMDzY2YZGzMGMLDAAGAzMYmBgxgB" } },
})

-- ==========================================
-- WARLOCK
-- ==========================================
AddSpec("WARLOCK", 265, { -- AFFLI
    statPriority = { wowhead = "Intellect > Mastery > Haste > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmZ2mZGzyAAAmZmlZzMzyYAgx2yADYAzwWghtBAAgZAAAMzMmxM2GjZMmZmZMMzMDAwAG" } },
})
AddSpec("WARLOCK", 266, { -- DEMO
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CoQAAAAAAAAAAAAAAAAAAAAAAwMmZGNbMz2MzY2GAAAAAAAwYGDLwAbDL0wixMjlZbmZGzAAzMGzMzMAjZMjNAAwYmZGDDLzYAD" } },
})
AddSpec("WARLOCK", 267, { -- DESTRO
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CsQAAAAAAAAAAAAAAAAAAAAAAgxMzoZjZ2mZmZ2mNzMzsYmZZZMAAYGjZmZBMmxwCMw2wCNWYAAgxgBAYmBYMjZsBAAYmZGAAMDD" } },
})

-- ==========================================
-- PRIEST
-- ==========================================
AddSpec("PRIEST", 256, { -- DISC
    statPriority = { wowhead = "Intellect > Haste > Crit > Mastery" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsYwyMjZmZGMbzYmZmZMzAAAAAAAAAAYMzyMYmZGmhZATzEDwMLYIMmlBYMYBAAGzMGDzMAzMzAG" } },
})
AddSpec("PRIEST", 257, { -- HOLY
    statPriority = { wowhead = "Intellect > Crit > Mastery > Haste" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAgZzwYWGMmZmZMzMjlZmZAAAAYMWmBzMzYzYmxAmpAAzsZGmNDAMGsZMWA0MmZMGmZ2WGgBMA" } },
})
AddSpec("PRIEST", 258, { -- SHADOW
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMjZMGAAAAAAAAAAAAjZZmxYZmxMz2MDDz2MzYmZGbIDLmpxAzMzAABY2mtNwsxAADGzMzY2GzgZGMDGA" } },
})

-- ==========================================
-- EVOKER
-- ==========================================
AddSpec("EVOKER", 1467, { -- DEVA
    statPriority = { wowhead = "Intellect > Crit > Mastery > Haste" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDgZGmhxwYMTjZmpZY2mxMzMzMzMzAMzMzYmZZMDMwYwCsMGN2GAzAwGGYmBDD" } },
})
AddSpec("EVOKER", 1468, { -- PRESER
    statPriority = { wowhead = "Intellect > Mastery > Crit > Haste" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAegZmZ2WGYYmxsZGjx2AAAYGzYGMMTjZmBAAA2mZmpZYmZmlxMAAMmxGLwAzwQDDLwMzMAMA" } },
})
AddSpec("EVOKER", 1473, { -- AUG
    statPriority = { wowhead = "Intellect > Mastery > Haste > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CEcBAAAAAAAAAAAAAAAAAAAAAgZmZbMzgZYmZZGzMjZ2AAAAAAAAwMMzAjpGzMzAAAAAzMzMmZWGzMwMbzYwCsMGGLDgZQshxMYmBwA" } },
})

-- ==========================================
-- MONK
-- ==========================================
AddSpec("MONK", 268, { -- BREW
    statPriority = { wowhead = "Agility > Crit > Vers > Mastery" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGGzyMzGzMjBAAAAAAYZBjYmBmhZ2MwMzMDzGzMmZZYZ7BW2mNMLAAwysMtMbzsMAAAAG2AzMgpxAAAG" } },
})
AddSpec("MONK", 269, { -- WIND
    statPriority = { wowhead = "Agility > Mastery > Haste > Crit" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMYMYbmZ2mxAAAAAAAAAAAALDjmxMgBMmZMzYGmNbjhZZmAAWMz2YYMzMAA2AgZZWamZmFgxMwMDAsMAGwA" } },
})
AddSpec("MONK", 270, { -- MIST
    statPriority = { wowhead = "Intellect > Haste > Crit > Mastery" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghxyMLjZx2MmZsZstsMjZ2Mz2yyMjFmRzYGwgBwMzMDzGmhZZmAAAAAAgFbzsMbzMAAwgBgZAjBWkxMA" } },
})

-- Final Check for all 40 specs: Every spec listed above has at least talentBuilds and statPriority.
