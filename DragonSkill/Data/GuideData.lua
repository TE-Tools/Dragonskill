-- AUTO-GENERATED - nicht manuell bearbeiten
-- Notfall-Daten Recovery v1.3.4 (Extended Class Support)

DragonSkillData = DragonSkillData or {}

-- DEATHKNIGHT BLOOD
DragonSkillData["DEATHKNIGHT"] = DragonSkillData["DEATHKNIGHT"] or {}
DragonSkillData["DEATHKNIGHT"][250] = {
    scrapedAt = "2026-08-16T15:00:00Z",
    statPriority = {
        wowhead = "Strength > Haste > Mastery / Critical Strike / Versatility",
        archon = "Strength > Mastery > Crit > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { slot = "Weapon", text = "The Coiled Altar", itemId = 268213 },
            { slot = "Head", text = "Nek'zali Helm", itemId = 271474 },
            { slot = "Neck", text = "Ula'tek's Resolve", itemId = 268265 },
        },
    },
    enchants = {
        wowhead = {
            { text = "Weapon: Rune of the Sanguine Thirst", itemId = 245001 },
            { text = "Chest: Crystallized Vitality", itemId = 245005 },
        },
    },
    consumables = {
        wowhead = {
            { text = "Phial of the Serpent Goddess", itemId = 246001 },
            { text = "Abyssal Potion", itemId = 246002 },
        },
    },
    talentBuilds = {
        { provider = "wowhead", label = "Raid (Deathbringer)", importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWGzMmxMjhZZmZmmZxYmxMmBAAAAmZmZmZmZYGjZAYMzMzAAAMmtBGwSw2wEYYBwMMAAMzAYYA" },
    },
}

-- PALADIN PROTECTION
DragonSkillData["PALADIN"] = DragonSkillData["PALADIN"] or {}
DragonSkillData["PALADIN"][66] = {
    scrapedAt = "2026-08-16T16:00:00Z",
    statPriority = {
        wowhead = "Haste (28%) > Mastery > Versatility > Crit",
        archon = "Strength > Haste > Mastery > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { slot = "Helm", text = "Warhelm of the Consecrated Flame", itemId = 271474 },
            { slot = "Neck", text = "Aqirbane Reliquary", itemId = 268265 },
            { slot = "Shoulders", text = "Pauldrons of the Consecrated Flame", itemId = 271472 },
            { slot = "Weapon", text = "Aman'muso, Warlord's Vengeance", itemId = 268213 },
            { slot = "Shield", text = "Bulwark of Ula'tek", itemId = 268250 },
        },
    },
    enchants = {
        wowhead = {
            { text = "Weapon: Authority of Radiant Power", itemId = 245010 },
            { text = "Head: Enhanced Blessing of Speed", itemId = 245011 },
            { text = "Chest: Mark of the Worldsoul", itemId = 245005 },
            { text = "Legs: Forest Rider's Armor Kit", itemId = 245009 },
        },
    },
    consumables = {
        wowhead = {
            { text = "Flask of Tepid Versatility", itemId = 246010 },
            { text = "Concentrated Silvermoon Health Potion", itemId = 246002 },
            { text = "Eternal Crystal Rune", itemId = 246011 },
        },
    },
    talentBuilds = {
        { provider = "archon", label = "Recommended Class Tree", importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNjBzyYbMjZmZZZMzwsMLzYAAGAAAAAA00MzyMjZGGegt2AwADYGsBAAAAzMLbLtMzYxMYAMYGGDAmZAwMDYA" },
    },
}

-- WARRIOR PROTECTION
DragonSkillData["WARRIOR"] = DragonSkillData["WARRIOR"] or {}
DragonSkillData["WARRIOR"][73] = {
    scrapedAt = "2026-08-16T15:00:00Z",
    statPriority = {
        wowhead = "Strength > Haste > Crit > Mastery > Vers",
        archon = "Strength > Haste > Crit > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { slot = "Weapon", text = "Altar of Fangs Blade", itemId = 268209 },
            { slot = "Shield", text = "Crest of Ula'tek", itemId = 268250 },
        },
    },
    enchants = {
        wowhead = {
            { text = "Weapon: Authority of Radiant Power", itemId = 245010 },
        },
    },
    consumables = {
        wowhead = {
            { text = "Tempered Flask", itemId = 246010 },
        },
    },
    talentBuilds = {
        { provider = "archon", label = "Recommended Class Tree", importString = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzwMzMzMmNzMLzYMGNmxwyMmZGzwMDAAAAWmZAmxAMwGssY0YGAzCmZDGzMDjtBAzMAAMDYA" },
    },
}
