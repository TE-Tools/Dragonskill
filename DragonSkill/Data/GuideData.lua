-- AUTO-GENERATED - nicht manuell bearbeiten
-- Notfall-Daten Recovery v1.3.5 (Extended Class Support: Paladin, DK, Warrior, DH, Druid, Mage)

DragonSkillData = DragonSkillData or {}

-- ==========================================
-- DEATHKNIGHT
-- ==========================================
DragonSkillData["DEATHKNIGHT"] = DragonSkillData["DEATHKNIGHT"] or {}
DragonSkillData["DEATHKNIGHT"][250] = {
    scrapedAt = "2026-08-16T15:00:00Z",
    statPriority = { wowhead = "Strength > Haste > Mastery / Critical Strike / Versatility", archon = "Strength > Mastery > Crit > Haste > Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "The Coiled Altar", itemId = 268213 }, { slot = "Head", text = "Nek'zali Helm", itemId = 271474 }, { slot = "Neck", text = "Ula'tek's Resolve", itemId = 268265 } } },
    enchants = { wowhead = { { text = "Weapon: Rune of the Sanguine Thirst", itemId = 245001 }, { text = "Chest: Crystallized Vitality", itemId = 245005 } } },
    consumables = { wowhead = { { text = "Phial of the Serpent Goddess", itemId = 246001 }, { text = "Abyssal Potion", itemId = 246002 } } },
    talentBuilds = { { provider = "wowhead", label = "Raid (Deathbringer)", importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWGzMmxMjhZZmZmmZxYmxMmBAAAAmZmZmZmZYGjZAYMzMzAAAMmtBGwSw2wEYYBwMMAAMzAYYA" } },
}

-- ==========================================
-- PALADIN
-- ==========================================
DragonSkillData["PALADIN"] = DragonSkillData["PALADIN"] or {}
-- HOLY
DragonSkillData["PALADIN"][65] = {
    scrapedAt = "2026-08-16T16:15:00Z",
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit > Vers", archon = "Intellect > Haste > Mastery > Crit > Vers" },
    bisGear = { wowhead = { { slot = "Helm", text = "Warhelm of the Consecrated Flame", itemId = 271474 }, { slot = "Weapon", text = "Blade of the Blind Verdict", itemId = 268202 }, { slot = "Shield", text = "Bulwark of Noble Resolve", itemId = 268250 } } },
    enchants = { wowhead = { { text = "Weapon: Ren’dorei Insight", itemId = 245012 }, { text = "Shoulders: Moonglow Mending", itemId = 245013 }, { text = "Chest: Magister’s Mark", itemId = 245014 } } },
    consumables = { wowhead = { { text = "Flask of the Magisters", itemId = 246012 }, { text = "Potion of Focused Clarity (Mana)", itemId = 246013 } } },
    talentBuilds = { { provider = "wowhead", label = "Herald of the Sun (Raid)", importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAAw2MzMjZMzYxYmZYZwMLmpJGzYmZYMbZAYADbgNWmxMLz2Mzs1AAAAsAAbGGzYGmBAwMDzghB" } },
}
-- PROTECTION
DragonSkillData["PALADIN"][66] = {
    scrapedAt = "2026-08-16T16:00:00Z",
    statPriority = { wowhead = "Haste (28%) > Mastery > Versatility > Crit", archon = "Strength > Haste > Mastery > Crit > Vers" },
    bisGear = { wowhead = { { slot = "Helm", text = "Warhelm of the Consecrated Flame", itemId = 271474 }, { slot = "Weapon", text = "Aman'muso, Warlord's Vengeance", itemId = 268213 }, { slot = "Shield", text = "Bulwark of Ula'tek", itemId = 268250 } } },
    enchants = { wowhead = { { text = "Weapon: Authority of Radiant Power", itemId = 245010 }, { text = "Head: Enhanced Blessing of Speed", itemId = 245011 }, { text = "Chest: Mark of the Worldsoul", itemId = 245005 } } },
    consumables = { wowhead = { { text = "Flask of Tepid Versatility", itemId = 246010 }, { text = "Eternal Crystal Rune", itemId = 246011 } } },
    talentBuilds = { { provider = "archon", label = "Recommended Class Tree", importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNjBzyYbMjZmZZZMzwsMLzYAAGAAAAAA00MzyMjZGGegt2AwADYGsBAAAAzMLbLtMzYxMYAMYGGDAmZAwMDYA" } },
}
-- RETRIBUTION
DragonSkillData["PALADIN"][70] = {
    scrapedAt = "2026-08-16T16:15:00Z",
    statPriority = { wowhead = "Strength > Haste > Mastery > Crit > Vers", archon = "Strength > Mastery > Crit > Haste > Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Maze-roa, Warlord's Fury", itemId = 268215 }, { slot = "Helm", text = "Warhelm of the Consecrated Flame", itemId = 271474 }, { slot = "Waist", text = "Girdle of Toxic Regret", itemId = 268259 } } },
    enchants = { wowhead = { { text = "Weapon: Arcane Mastery", itemId = 245015 }, { text = "Weapon Oil: Thalassian Phoenix Oil", itemId = 245016 } } },
    consumables = { wowhead = { { text = "Flask of the Magisters", itemId = 246012 }, { text = "Potion of Recklessness", itemId = 246014 } } },
    talentBuilds = { { provider = "wowhead", label = "Templar (Single Target)", importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAANbbzMzywMDAAAAAAzUGzwMjtxsNMz2MGjZGmxCbDAAgZm2mZ2mBAsBYAwYGmBzYMbYbGMMmxgB" } },
}

-- ==========================================
-- DEMON HUNTER
-- ==========================================
DragonSkillData["DEMONHUNTER"] = DragonSkillData["DEMONHUNTER"] or {}
-- HAVOC
DragonSkillData["DEMONHUNTER"][577] = {
    scrapedAt = "2026-08-16T16:30:00Z",
    statPriority = { wowhead = "Crit > Mastery > Haste > Vers", archon = "Agility > Crit > Mastery > Haste > Vers" },
    bisGear = { wowhead = { { slot = "MainHand", text = "Aman'muso, Warlord's Vengeance", itemId = 268213 }, { slot = "Neck", text = "Aqirbane Reliquary", itemId = 268265 } } },
    enchants = { wowhead = { { text = "Weapon: Acuity of the Ren'dorei", itemId = 245018 }, { text = "Chest: Mark of the Worldsoul", itemId = 245005 } } },
    consumables = { wowhead = { { text = "Flask of the Shattered Sun", itemId = 246015 }, { text = "Potion of Recklessness", itemId = 246014 } } },
    talentBuilds = { { provider = "archon", label = "Recommended Class Tree", importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZ2mxMzMGzkxMDAAAAAAYWMmtZYmBmx2sNzMjxALDsNbmxwsw0YmZMjNAAAgBAAAwMDGAAAAG" } },
}
-- VENGEANCE
DragonSkillData["DEMONHUNTER"][581] = {
    scrapedAt = "2026-08-16T16:30:00Z",
    statPriority = { wowhead = "Haste > Versatility > Mastery > Crit", archon = "Agility > Haste > Crit > Mastery > Vers" },
    bisGear = { wowhead = { { slot = "MainHand", text = "Lightless Lament", itemId = 268211 }, { slot = "OffHand", text = "Mystakria's Harvester", itemId = 268212 } } },
    enchants = { wowhead = { { text = "Weapon: Acuity of the Ren'dorei", itemId = 245018 }, { text = "Boots: Lynx's Speed", itemId = 245019 } } },
    consumables = { wowhead = { { text = "Flask of the Blood Knights", itemId = 246016 }, { text = "Silvermoon Health Potion", itemId = 246002 } } },
    talentBuilds = { { provider = "archon", label = "Recommended Class Tree", importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAWmxMzMGmRmZGMLmxMYmxMjZegZmZMY2mZsZmZbMMAAAAAAAAMzM2AAAAwAzMzMzWbzMzAADAAAgB" } },
}

-- ==========================================
-- DRUID
-- ==========================================
DragonSkillData["DRUID"] = DragonSkillData["DRUID"] or {}
-- BALANCE
DragonSkillData["DRUID"][102] = {
    scrapedAt = "2026-08-16T16:30:00Z",
    statPriority = { wowhead = "Intellect > Mastery > Haste > Crit > Vers", archon = "Intellect > Mastery > Haste > Crit > Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "The Coiled Altar Staff", itemId = 268209 } } },
    enchants = { wowhead = { { text = "Chest: Council's Intellect", itemId = 245020 }, { text = "Ring: Devotion of Mastery", itemId = 245021 } } },
    consumables = { wowhead = { { text = "Flask of Tempered Swiftness", itemId = 246017 }, { text = "Thalassian Phoenix Oil", itemId = 245016 } } },
    talentBuilds = { { provider = "archon", label = "Recommended Class Tree", importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsMzMzMLMYMLzsMziZmxGLzsMmZMWwwAM22mZwY2GATAAAAWYmZmBbGGjBAgZGYA" } },
}
-- RESTORATION
DragonSkillData["DRUID"][105] = {
    scrapedAt = "2026-08-16T16:30:00Z",
    statPriority = { wowhead = "Intellect > Haste > Mastery > Crit > Vers" },
    bisGear = { wowhead = { { slot = "Trinket", text = "Soulcoiler Ritual Vessel", itemId = 270167 } } },
    enchants = { wowhead = { { text = "Weapon: Ren'dorei Insight", itemId = 245012 }, { text = "Legs: Arcane Spellthread", itemId = 245022 } } },
    consumables = { wowhead = { { text = "Flask of Tempered Swiftness", itemId = 246017 }, { text = "Potion of Frozen Focus", itemId = 246018 } } },
    talentBuilds = { { provider = "archon", label = "Recommended Class Tree", importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsNjFbzAAAAAAAAAAgFDNbzw0MAmFzMzMLGGAAAAAMAAzAAAAAgZbmtmtZWsxMzMDmZD0MAAzMAMA" } },
}

-- ==========================================
-- MAGE
-- ==========================================
DragonSkillData["MAGE"] = DragonSkillData["MAGE"] or {}
-- ARCANE
DragonSkillData["MAGE"][62] = {
    scrapedAt = "2026-08-16T16:30:00Z",
    statPriority = { wowhead = "Haste > Crit > Mastery > Vers" },
    bisGear = { wowhead = { { slot = "Head", text = "Warhelm of the Consecrated Flame", itemId = 271474 } } },
    enchants = { wowhead = { { text = "Weapon: Acuity of the Ren'dorei", itemId = 245018 }, { text = "Legs: Arcanoweave Spellthread", itemId = 245023 } } },
    consumables = { wowhead = { { text = "Flask of the Magisters", itemId = 246012 }, { text = "Thalassian Phoenix Oil", itemId = 245016 } } },
    talentBuilds = { { provider = "archon", label = "Recommended Class Tree", importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzQzMGAAAGAAAYmZmllZmYBAgtZMzMmNzyMzMmZMGmZmxCzMz8AzAAMAAAmZBAmZAwwA" } },
}
-- FROST
DragonSkillData["MAGE"][64] = {
    scrapedAt = "2026-08-16T16:30:00Z",
    statPriority = { wowhead = "Mastery > Crit (24%) > Haste > Vers" },
    bisGear = { wowhead = { { slot = "Shoulder", text = "Pauldrons of the Consecrated Flame", itemId = 271472 } } },
    enchants = { wowhead = { { text = "Weapon: Arcane Mastery", itemId = 245015 }, { text = "Chest: Mark of the Worldsoul", itemId = 245005 } } },
    consumables = { wowhead = { { text = "Flask of the Shattered Sun", itemId = 246015 }, { text = "Potion of Recklessness", itemId = 246014 } } },
    talentBuilds = { { provider = "archon", label = "Recommended Class Tree", importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzEzMzYmZmZWMzMMjZAAAgZmZWWmZaDAA2AAAAWAYbZMzMzwsNMmZsBAAwMbAzADYGMA" } },
}

-- ==========================================
-- WARRIOR
-- ==========================================
DragonSkillData["WARRIOR"] = DragonSkillData["WARRIOR"] or {}
-- PROTECTION
DragonSkillData["WARRIOR"][73] = {
    scrapedAt = "2026-08-16T15:00:00Z",
    statPriority = { wowhead = "Strength > Haste > Crit > Mastery > Vers", archon = "Strength > Haste > Crit > Mastery > Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Altar of Fangs Blade", itemId = 268209 }, { slot = "Shield", text = "Crest of Ula'tek", itemId = 268250 } } },
    enchants = { wowhead = { { text = "Weapon: Authority of Radiant Power", itemId = 245010 } } },
    consumables = { wowhead = { { text = "Tempered Flask", itemId = 246010 } } },
    talentBuilds = { { provider = "archon", label = "Recommended Class Tree", importString = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzwMzMzMmNzMLzYMGNmxwyMmZGzwMDAAAAWmZAmxAMwGssY0YGAzCmZDGzMDjtBAzMAAMDYA" } },
}
