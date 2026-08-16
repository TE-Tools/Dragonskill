-- AUTO-GENERATED - nicht manuell bearbeiten
-- Notfall-Daten Recovery v1.3.3

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
            { slot = "Shoulders", text = "Temple Shoulders", itemId = 239037 },
            { slot = "Chest", text = "Cursed Plate", itemId = 268222 },
        },
    },
    enchants = {
        wowhead = {
            { text = "Weapon: Rune of the Sanguine Thirst", itemId = 245001 },
            { text = "Chest: Crystallized Vitality", itemId = 245005 },
            { text = "Legs: Layered Armor Kit", itemId = 245009 },
        },
    },
    consumables = {
        wowhead = {
            { text = "Phial of the Serpent Goddess", itemId = 246001 },
            { text = "Abyssal Potion", itemId = 246002 },
            { text = "Feast of the Dragon Lords", itemId = 246005 },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast Death Strike if healing is needed", spellId = 49998 },
            { text = "Maintain 5+ Bone Shield stacks", spellId = 195181 },
            { text = "Cast Marrowrend if Bone Shield is expiring", spellId = 195182 },
        },
    },
    trinkets = {
        archon = {
            { name = "[S] Coil of Potential", rank = "S", itemId = 270173 },
            { name = "[A] Heart of the Mother", rank = "A", itemId = 270175 },
        },
    },
    talentBuilds = {
        { provider = "wowhead", label = "Raid (Deathbringer)", importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWGzMmxMjhZZmZmmZxYmxMmBAAAAmZmZmZmZYGjZAYMzMzAAAMmtBGwSw2wEYYBwMMAAMzAYYA" },
        { provider = "archon", label = "Recommended Class Tree", importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzMmxMGMLzMz0MLzMjZmBAAAAwgZmZmZMzMjBAzMzMzAAAMmtBGwCYZYCMsAYGDAAmZAYMA" },
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
            { slot = "Head", text = "Vashnik Helm", itemId = 271528 },
        },
    },
    enchants = {
        wowhead = {
            { text = "Weapon: Authority of Radiant Power", itemId = 245010 },
            { text = "Bracers: Devotion of Speed", itemId = 245011 },
        },
    },
    consumables = {
        wowhead = {
            { text = "Tempered Flask", itemId = 246010 },
            { text = "Versatility Rune", itemId = 246011 },
        },
    },
    talentBuilds = {
        { provider = "archon", label = "Recommended Class Tree", importString = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzwMzMzMmNzMLzYMGNmxwyMmZGzwMDAAAAWmZAmxAMwGssY0YGAzCmZDGzMDjtBAzMAAMDYA" },
    },
}
