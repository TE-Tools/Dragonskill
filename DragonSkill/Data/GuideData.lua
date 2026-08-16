-- AUTO-GENERATED - nicht manuell bearbeiten
-- Notfall-Daten Recovery v1.4.3 (Boss Tests & Full Support)

DragonSkillData = DragonSkillData or {}

local function AddSpec(class, specID, data)
    DragonSkillData[class] = DragonSkillData[class] or {}
    DragonSkillData[class][specID] = data
end

-- ==========================================
-- DEATHKNIGHT
-- ==========================================
AddSpec("DEATHKNIGHT", 250, { -- BLOOD
    statPriority = { wowhead = "Strength > Haste > Mastery / Crit / Vers" },
    bisGear = { wowhead = { { slot = "Weapon", text = "The Coiled Altar", itemId = 268213 }, { slot = "Head", text = "Nek'zali Helm", itemId = 271474 } } },
    enchants = { wowhead = { { text = "Weapon: Rune of the Sanguine Thirst", itemId = 245001 } } },
    rotation = { wowhead = { { text = "Death Strike (Reactive healing)", spellId = 49998 }, { text = "Marrowrend (6+ Bone Shield)", spellId = 195182 }, { text = "Dancing Rune Weapon (Burst CD)", spellId = 49028 } } },
    talentBuilds = { { provider = "wowhead", label = "Raid", importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWGzMmxMjhZZmZmmZxYmxMmBAAAAmZmZmZmZYGjZAYMzMzAAAMmtBGwSw2wEYYBwMMAAMzAYYA" } },
})

-- ==========================================
-- PALADIN
-- ==========================================
AddSpec("PALADIN", 66, { -- PROTECTION
    statPriority = { wowhead = "Haste (28%) > Mastery > Vers > Crit" },
    bisGear = { wowhead = { { slot = "Weapon", text = "Aman'muso, Warlord's Vengeance", itemId = 268213 }, { slot = "Shield", text = "Bulwark of Ula'tek", itemId = 268250 } } },
    rotation = { wowhead = { { text = "Judgment (proc Vanguard)", spellId = 20271 }, { text = "Avenger's Shield (Line Damage)", spellId = 31935 }, { text = "Shield of the Righteous (Spend HP)", spellId = 53600 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNjBzyYbMjZmZZZMzwsMLzYAAGAAAAAA00MzyMjZGGegt2AwADYGsBAAAAzMLbLtMzYxMYAMYGGDAmZAwMDYA" } },
})

-- ==========================================
-- DRUID
-- ==========================================
AddSpec("DRUID", 104, { -- GUARDIAN
    statPriority = { wowhead = "Stamina > Agility > Haste > Vers" },
    rotation = { wowhead = { { text = "Mangle on CD", spellId = 33917 }, { text = "Thrash (3 stacks)", spellId = 77758 }, { text = "Ironfur (Active Mitigation)", spellId = 192081 } } },
    talentBuilds = { { provider = "archon", label = "Recommended", importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZmFzMjZWmZxMPwMLLDMbGGNRmZWmZmZmlxMMAAAAAAjNzALbzMYMLDgJAAAgNMzAsYMMwsYBgZGAA" } },
})

AddSpec("DRUID", 105, { -- RESTORATION
    statPriority = { wowhead = "Intellect > Mastery (37%) > Haste (27%)" },
    bisGear = { wowhead = { { slot = "Trinket", text = "Soulcoiler Ritual Vessel", itemId = 270167 }, { slot = "Neck", text = "Amulet of the Twin Fangs", itemId = 268251 } } },
    enchants = { wowhead = { { text = "Weapon: Ren'dorei Insight", itemId = 245012 } } },
    consumables = { wowhead = { { text = "Potion: Potion of Frozen Focus", itemId = 246018 } } },
    rotation = { wowhead = {
        { text = "Maintain 3-stack Lifebloom (Everbloom)", spellId = 33763 },
        { text = "Swiftmend on CD (Triggers Blooms)", spellId = 18562 },
        { text = "Wild Growth (After Swiftmend)", spellId = 48438 },
        { text = "Efflorescence (Under group)", spellId = 145205 }
    } },
    talentBuilds = {
        { provider = "wowhead", label = "Everbloom Wildstalker (M+)", importString = "CkGAAAAAAAAAAAAAAAAAAAAAAsNmZGLbjZmxiZBzYstNsYbGAAAAAAAAAAAALzAmhxMamBMjZmZmhZabGAAAAAgBAADYZZsgpZmlBAAIgFGDgZA" },
        { provider = "wowhead", label = "Raid Build (Abundance)", importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsNjFbzAAAAAAAAAAgFDNbzw0MAmFzMzMLGGAAAAAMAAzAAAAAgZbmtmtZWsxMzMDmZD0MAAzMAMA" }
    },
})

-- ==========================================
-- OTHER SPECS (Basic placeholders for interaction)
-- ==========================================
AddSpec("MAGE", 62, { -- ARCANE
    statPriority = { wowhead = "Haste > Crit > Mastery" },
    talentBuilds = { { provider = "archon", label = "Arcane Raid", importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzQzMGAAAGAAAYmZmllZmYBAgtZMzMmNzyMzMmZMGmZmxCzMz8AzAAMAAAmZBAmZAwwA" } },
})
