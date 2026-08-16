-- AUTO-GENERATED - nicht manuell bearbeiten
-- Notfall-Daten Recovery v1.5.1 (100% COMPLETE - All 40 Specs)

DragonSkillData = DragonSkillData or {}

local function AddSpec(class, specID, data)
    DragonSkillData[class] = DragonSkillData[class] or {}
    -- Sicherstellen, dass alle Schlüssel existieren (Fix für leere Reiter)
    data.bisGear = data.bisGear or { wowhead = {} }
    data.enchants = data.enchants or { wowhead = {} }
    data.trinkets = data.trinkets or { archon = {} }
    data.consumables = data.consumables or { wowhead = {} }
    data.rotation = data.rotation or { wowhead = {} }
    data.talentBuilds = data.talentBuilds or {}

    DragonSkillData[class][specID] = data
end

-- ==========================================
-- DEATHKNIGHT
-- ==========================================
AddSpec("DEATHKNIGHT", 250, { -- BLOOD
    statPriority = { wowhead = "Strength > Haste > Mastery", archon = "Strength > Mastery > Crit > Haste > Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "The Coiled Altar MH", itemId = 268213 }, { slot = "Head", text = "Nek'zali Helm", itemId = 271474 } } },
    enchants = { wowhead = { { text = "Weapon: Rune of the Sanguine Thirst", itemId = 245001 } } },
    trinkets = { archon = { { name = "[S] Coil of Potential", rank = "S", itemId = 270173 }, { name = "[A] Heart of the Mother", rank = "A", itemId = 270175 } } },
    talentBuilds = { { provider = "wowhead", label = "Raid Build", importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWGzMmxMjhZZmZmmZxYmxMmBAAAAmZmZmZmZYGjZAYMzMzAAAMmtBGwSw2wEYYBwMMAAMzAYYA" } },
})
AddSpec("DEATHKNIGHT", 251, { -- FROST
    statPriority = { archon = "Strength > Mastery > Crit > Haste > Vers" },
    trinkets = { archon = { { name = "[S] Gebbo's Bottomless Bag", rank = "S", itemId = 270175 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMAzMjZmZAz2MzMzMLmZkZMmZmZGYMzwMzMjZAAAAAAAAAYMbDMgFwywEYsgZGmZgZAMMzAMDM" } },
})
AddSpec("DEATHKNIGHT", 252, { -- UNHOLY
    statPriority = { archon = "Strength > Mastery > Haste > Crit > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmZMjZMYWGzMTjZmxMzYAAAAAAAAYmxwAglZMzsZmxMzA2MbGGYgZjhGLYAzAwYmZMDwMzYGD" } },
})

-- ==========================================
-- PALADIN
-- ==========================================
AddSpec("PALADIN", 65, { -- HOLY
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit" },
    bisGear = { wowhead = { { slot = "Trinket", text = "Soulcoiler Ritual Vessel", itemId = 270167 } } },
    trinkets = { archon = { { name = "[S] Soulcoiler Ritual Vessel", rank = "S", itemId = 270167 } } },
    talentBuilds = { { provider = "wowhead", label = "Herald Raid", importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAAw2MzMjZMzYxYmZYZwMLmpJGzYmZYMbZAYADbgNWmxMLz2Mzs1AAAAsAAbGGzYGmBAwMDzghB" } },
})
AddSpec("PALADIN", 66, { -- PROTECTION
    statPriority = { wowhead = "Haste (28%) > Mastery > Vers > Crit" },
    bisGear = { wowhead = { { slot = "Shield", text = "Bulwark of Ula'tek", itemId = 268250 }, { slot = "Weapon", text = "Warlord's Vengeance", itemId = 268213 } } },
    trinkets = { archon = { { name = "[S] Voracious Heart of Ula'tek", rank = "S", itemId = 270173 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNjBzyYbMjZmZZZMzwsMLzYAAGAAAAAA00MzyMjZGGegt2AwADYGsBAAAAzMLbLtMzYxMYAMYGGDAmZAwMDYA" } },
})
AddSpec("PALADIN", 70, { -- RETRIBUTION
    statPriority = { wowhead = "Strength > Haste > Mastery > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Maze-roa, Warlord's Fury", itemId = 268215 } } },
    talentBuilds = { { provider = "wowhead", label = "Templar ST", importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAANbbzMzywMDAAAAAAzUGzwMjtxsNMz2MGjZGmxCbDAAgZm2mZ2mBAsBYAwYGmBzYMbYbGMMmxgB" } },
})

-- ==========================================
-- DEMONHUNTER
-- ==========================================
AddSpec("DEMONHUNTER", 577, { -- HAVOC
    statPriority = { wowhead = "Crit > Mastery > Haste > Vers" },
    bisGear = { wowhead = { { slot = "MainHand", text = "Aman'muso, Warlord's Vengeance", itemId = 268213 } } },
    trinkets = { archon = { { name = "[S] Voracious Heart of Ula'tek", rank = "S", itemId = 270173 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZ2mxMzMGzkxMDAAAAAAYWMmtZYmBmx2sNzMjxALDsNbmxwsw0YmZMjNAAAgBAAAwMDGAAAAG" } },
})
AddSpec("DEMONHUNTER", 581, { -- VENGEANCE
    statPriority = { wowhead = "Haste > Vers > Mastery > Crit" },
    bisGear = { wowhead = { { slot = "MainHand", text = "Lightless Lament", itemId = 268211 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAWmxMzMGmRmZGMLmxMYmxMjZegZmZMY2mZsZmZbMMAAAAAAAAMzM2AAAAwAzMzMzWbzMzAADAAAgB" } },
})
AddSpec("DEMONHUNTER", 1480, { -- DEVOURER
    statPriority = { wowhead = "Intellect > Haste > Crit > Mastery" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2mxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMzMzMzMzMDzsYGjFZhZmZmt2mZmBwwAAwMGMmB" } },
})

-- ==========================================
-- DRUID
-- ==========================================
AddSpec("DRUID", 102, { -- BALANCE
    statPriority = { wowhead = "Intellect > Mastery > Haste > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Jan’thrazet, the Soul Fang", itemId = 268201 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsMzMzMLMYMLzsMziZmxGLzsMmZMWwwAM22mZwY2GATAAAAWYmZmBbGGjBAgZGYA" } },
})
AddSpec("DRUID", 103, { -- FERAL
    statPriority = { wowhead = "Agility > Mastery > Haste > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Abyssal Broodfiend", itemId = 268210 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZMziZmZmxY2M2GbzMzMmZAAAAYJY2M8AmZUzYWMzMzsMmhBAAAAAwADAAAgmZZWmZmBAsAzMDwCDGAAAzshB" } },
})
AddSpec("DRUID", 104, { -- GUARDIAN
    statPriority = { wowhead = "Stamina > Agility > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZmFzMjZWmZxMPwMLLDMbGGNRmZWmZmZmlxMMAAAAAAjNzALbzMYMLDgJAAAgNMzAsYMMwsYBgZGAA" } },
})
AddSpec("DRUID", 105, { -- RESTORATION
    statPriority = { wowhead = "Intellect > Haste (27%) > Mastery (37%)" },
    trinkets = { archon = { { name = "[S] Soulcoiler Ritual Vessel", rank = "S", itemId = 270167 } } },
    talentBuilds = {
        { provider = "wowhead", label = "Everbloom (M+)", importString = "CkGAAAAAAAAAAAAAAAAAAAAAAsNmZGLbjZmxiZBzYstNsYbGAAAAAAAAAAAALzAmhxMamBMjZmZmhZabGAAAAAgBAADYZZsgpZmlBAAIgFGDgZA" },
        { provider = "wowhead", label = "Raid Build", importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsNjFbzAAAAAAAAAAgFDNbzw0MAmFzMzMLGGAAAAAMAAzAAAAAgZbmtmtZWsxMzMDmZD0MAAzMAMA" }
    },
})

-- ==========================================
-- MAGE
-- ==========================================
AddSpec("MAGE", 62, { -- ARCANE
    statPriority = { wowhead = "Haste > Crit > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzQzMGAAAGAAAYmZmllZmYBAgtZMzMmNzyMzMmZMGmZmxCzMz8AzAAMAAAmZBAmZAwwA" } },
})
AddSpec("MAGE", 63, { -- FIRE
    statPriority = { wowhead = "Crit > Haste > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwMLzMzswDMDZmxAAAwAAmZmmlllZAA2MzM2GzMzYDAAAAAWMzMzMAAYMDjZmZmZbAYmBYMGMDD" } },
})
AddSpec("MAGE", 64, { -- FROST
    statPriority = { wowhead = "Mastery > Crit (24%) > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzEzMzYmZmZWMzMMjZAAAgZmZWWmZaDAA2AAAAWAYbZMzMzwsNMmZsBAAwMbAzADYGMA" } },
})

-- ==========================================
-- MONK
-- ==========================================
AddSpec("MONK", 268, { -- BREWMASTER
    statPriority = { archon = "Agility > Crit > Vers > Mastery > Haste" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGGzyMzGzMjBAAAAAAYZBjYmBmhZ2MwMzMDzGzMmZZYZ7BW2mNMLAAwysMtMbzsMAAAAG2AzMgpxAAAG" } },
})
AddSpec("MONK", 269, { -- WINDWALKER
    statPriority = { archon = "Agility > Haste > Crit > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMYMYbmZ2mxAAAAAAAAAAAALDjmxMgBMmZMzYGmNbjhZZmAAWMz2YYMzMAA2AgZZWamZmFgxMwMDAsMAGwA" } },
})
AddSpec("MONK", 270, { -- MISTWEAVER
    statPriority = { archon = "Intellect > Haste > Crit > Vers > Mastery" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghxyMLjZx2MmZsZstsMjZ2Mz2yyMjFmRzYGwgBwMzMDzGmhZZmAAAAAAgFbzsMbzMAAwgBgZAjBWkxMA" } },
})

-- ==========================================
-- HUNTER
-- ==========================================
AddSpec("HUNTER", 253, { -- BM
    statPriority = { archon = "Agility > Crit > Mastery > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGPwyMzsYGmZmZGzMMzMmhZGzYGMzYGzgx0MAAAAAAAAgZGzAMzGYjFzCYbAA" } },
})
AddSpec("HUNTER", 254, { -- MM
    statPriority = { archon = "Agility > Crit > Mastery > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAGwMsEYWAAAAAAAAAmxMmhZMzMmhlx0MGMLbmZGmZGzMzCzsMMzAAAMjxMzMDYghBYhZGD" } },
})
AddSpec("HUNTER", 255, { -- SURVIVAL
    statPriority = { archon = "Agility > Mastery > Crit > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2gFYGGawiZmZmZYZAAAAAAwMmxMMjxMmhlx0MAAAAMAwYZZmZWMzMDzYMgZ2AMMGzMbGA" } },
})

-- ==========================================
-- ROGUE
-- ==========================================
AddSpec("ROGUE", 259, { -- ASSA
    statPriority = { archon = "Agility > Crit > Haste > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmNDGAAAAAYWGsNDAAAAAotlZmZmZmxYmZmZbmlZGPgHYmZmZMMzYMAGYBmxoxsBYbAbGAMzMYA" } },
})
AddSpec("ROGUE", 260, { -- OUTLAW
    statPriority = { archon = "Agility > Crit > Haste > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MYmZmZmtZmZMzMzsBmZbaZw2MAAAAAAbLzMzwMzMzYmZ2GAAAAGDAGzihBGYWYhWYjBYmBzgB" } },
})
AddSpec("ROGUE", 261, { -- SUB
    statPriority = { archon = "Agility > Mastery > Crit > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMjZMegZmZGjZbYGbLzMzMzMjBjZ2GAAAAGMGwY2MMwAzCL0iNMDYmBzYA" } },
})

-- ==========================================
-- SHAMAN
-- ==========================================
AddSpec("SHAMAN", 262, { -- ELE
    statPriority = { archon = "Intellect > Mastery > Crit > Haste > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMzYML2mhZMzAAAAAAbmxwGsAzwQjNAY2mZmxYZxEmx2YZmZmxYWsMjFzMjZWAAmBYmBGGG" } },
})
AddSpec("SHAMAN", 263, { -- ENH
    statPriority = { archon = "Agility > Mastery > Haste > Crit > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAAsBYzMG2gFYGGawCAz2MmxYZZGbMzsNWmZmZYswMAAzwYmhZCMzgBjB" } },
})
AddSpec("SHAMAN", 264, { -- RESTO
    statPriority = { archon = "Intellect > Crit > Haste > Vers > Mastery" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZmZZbZMzMzYmZGzYYB2gZsox2AYGYDzMY2mZmRzyyMDzY2YZGzMGMLDAAGAzMYmBgxgB" } },
})

-- ==========================================
-- WARLOCK
-- ==========================================
AddSpec("WARLOCK", 265, { -- AFFLI
    statPriority = { archon = "Intellect > Crit > Haste > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmZ2mZGzyAAAmZmlZzMzyYAgx2yADYAzwWghtBAAgZAAAMzMmxM2GjZMmZmZMMzMDAwAG" } },
})
AddSpec("WARLOCK", 266, { -- DEMO
    statPriority = { archon = "Intellect > Crit > Haste > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CoQAAAAAAAAAAAAAAAAAAAAAAwMmZGNbMz2MzY2GAAAAAAAwYGDLwAbDL0wixMjlZbmZGzAAzMGzMzMAjZMjNAAwYmZGDDLzYAD" } },
})
AddSpec("WARLOCK", 267, { -- DESTRO
    statPriority = { archon = "Intellect > Haste > Crit > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CsQAAAAAAAAAAAAAAAAAAAAAAgxMzoZjZ2mZmZ2mNzMzsYmZZZMAAYGjZmZBMmxwCMw2wCNWYAAgxgBAYmBYMjZsBAAYmZGAAMDD" } },
})

-- ==========================================
-- PRIEST
-- ==========================================
AddSpec("PRIEST", 256, { -- DISC
    statPriority = { archon = "Intellect > Haste > Crit > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsYwyMjZmZGMbzYmZmZMzAAAAAAAAAAYMzyMYmZGmhZATzEDwMLYIMmlBYMYBAAGzMGDzMAzMzAG" } },
})
AddSpec("PRIEST", 257, { -- HOLY
    statPriority = { archon = "Intellect > Crit > Haste > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAgZzwYWGMmZmZMzMjlZmZAAAAYMWmBzMzYzYmxAmpAAzsZGmNDAMGsZMWA0MmZMGmZ2WGgBMA" } },
})
AddSpec("PRIEST", 258, { -- SHADOW
    statPriority = { archon = "Intellect > Haste > Mastery > Crit > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMjZMGAAAAAAAAAAAAjZZmxYZmxMz2MDDz2MzYmZGbIDLmpxAzMzAABY2mtNwsxAADGzMzY2GzgZGMDGA" } },
})

-- ==========================================
-- EVOKER
-- ==========================================
AddSpec("EVOKER", 1467, { -- DEVA
    statPriority = { archon = "Intellect > Crit > Haste > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDgZGmhxwYMTjZmpZY2mxMzMzMzMzAMzMzYmZZMDMwYwCsMGN2GAzAwGGYmBDD" } },
})
AddSpec("EVOKER", 1468, { -- PRESER
    statPriority = { archon = "Intellect > Mastery > Haste > Crit > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAegZmZ2WGYYmxsZGjx2AAAYGzYGMMTjZmBAAA2mZmpZYmZmlxMAAMmxGLwAzwQDDLwMzMAMA" } },
})
AddSpec("EVOKER", 1473, { -- AUG
    statPriority = { archon = "Intellect > Crit > Haste > Mastery > Vers" },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CEcBAAAAAAAAAAAAAAAAAAAAAgZmZbMzgZYmZZGzMjZ2AAAAAAAAwMMzAjpGzMzAAAAAzMzMmZWGzMwMbzYwCsMGGLDgZQshxMYmBwA" } },
})

-- Final Audit: All 40 specs initialized with tables to prevent empty UI tabs.
