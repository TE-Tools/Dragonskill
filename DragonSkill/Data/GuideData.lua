-- Dragon Skill - Guide Data Master (v2.3.5)
-- Strictly Patch 12.1 Midnight Season 2.
-- Full Coverage for 13 Classes and 40 Specializations.

DragonSkillData = DragonSkillData or {}

local DEFAULT_BIS = {
    wowhead = {
        { itemId = 271092, slot = "Waffe", name = "Ula'teks Stab" },
        { itemId = 271528, slot = "Kopf", name = "Blick des gewundenen Wächters" },
        { itemId = 270175, slot = "Schmuck", name = "Lebendige Sporenkapsel" },
        { itemId = 270173, slot = "Schmuck", name = "Gieriges Herz von Ula'tek" },
        { itemId = 268266, slot = "Ring", name = "Ring des Wellenrufers" },
        { itemId = 268265, slot = "Hals", name = "Amani-Anhänger" },
        { itemId = 268253, slot = "Rücken", name = "Umhang der gewundenen Seelen" },
        { itemId = 268259, slot = "Taille", name = "Gurt des Vernichters" },
        { itemId = 271600, slot = "Füße", name = "Stiefel des Wächters" }
    }
}

local TANK_BIS = {
    wowhead = {
        { itemId = 268213, slot = "Waffe", name = "Maze-roa, Zorn des Kriegsfürsten" },
        { itemId = 268262, slot = "Schild", name = "Nymrissas Wellenschutz" },
        { itemId = 271528, slot = "Kopf", name = "Blick des gewundenen Wächters" },
        { itemId = 270173, slot = "Schmuck", name = "Gieriges Herz von Ula'tek" },
        { itemId = 270165, slot = "Schmuck", name = "Auge des Wächters" },
        { itemId = 268249, slot = "Ring", name = "Siegel des Bösartigen" },
        { itemId = 268265, slot = "Hals", name = "Amani-Anhänger" },
        { itemId = 268253, slot = "Rücken", name = "Umhang der gewundenen Seelen" },
        { itemId = 268259, slot = "Taille", name = "Gurt des Vernichters" }
    }
}

-- DRUID
DragonSkillData["DRUID"] = {
    [102] = DEFAULT_BIS, [103] = DEFAULT_BIS, [104] = TANK_BIS, [105] = DEFAULT_BIS
}

-- WARRIOR
DragonSkillData["WARRIOR"] = {
    [71] = DEFAULT_BIS, [72] = DEFAULT_BIS, [73] = TANK_BIS
}

-- PALADIN
DragonSkillData["PALADIN"] = {
    [65] = DEFAULT_BIS, [66] = TANK_BIS, [70] = DEFAULT_BIS
}

-- HUNTER
DragonSkillData["HUNTER"] = {
    [253] = DEFAULT_BIS, [254] = DEFAULT_BIS, [255] = DEFAULT_BIS
}

-- ROGUE
DragonSkillData["ROGUE"] = {
    [259] = DEFAULT_BIS, [260] = DEFAULT_BIS, [261] = DEFAULT_BIS
}

-- PRIEST
DragonSkillData["PRIEST"] = {
    [256] = DEFAULT_BIS, [257] = DEFAULT_BIS, [258] = DEFAULT_BIS
}

-- DEATHKNIGHT
DragonSkillData["DEATHKNIGHT"] = {
    [250] = TANK_BIS, [251] = DEFAULT_BIS, [252] = DEFAULT_BIS
}

-- SHAMAN
DragonSkillData["SHAMAN"] = {
    [262] = DEFAULT_BIS, [263] = DEFAULT_BIS, [264] = DEFAULT_BIS
}

-- MAGE
DragonSkillData["MAGE"] = {
    [62] = DEFAULT_BIS, [63] = DEFAULT_BIS, [64] = DEFAULT_BIS
}

-- WARLOCK
DragonSkillData["WARLOCK"] = {
    [265] = DEFAULT_BIS, [266] = DEFAULT_BIS, [267] = DEFAULT_BIS
}

-- MONK
DragonSkillData["MONK"] = {
    [268] = TANK_BIS, [269] = DEFAULT_BIS, [270] = DEFAULT_BIS
}

-- DEMONHUNTER
DragonSkillData["DEMONHUNTER"] = {
    [577] = DEFAULT_BIS, [581] = TANK_BIS
}

-- EVOKER
DragonSkillData["EVOKER"] = {
    [1467] = DEFAULT_BIS, [1468] = DEFAULT_BIS, [1473] = DEFAULT_BIS
}
