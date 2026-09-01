-- Dragon Skill - Guide Data Master (v2.3.7)
-- Schema: each spec has bisGear.wowhead (+ optional talentBuilds via TalentOverrides)
-- Patch 12.1 Midnight Season 2 – role-based BiS with proper structure for consumers.

DragonSkillData = DragonSkillData or {}

local DEFAULT_BIS = {
    bisGear = {
        wowhead = {
            { itemId = 271092, slot = "Waffe", name = "Ula'teks Stab" },
            { itemId = 271528, slot = "Kopf", name = "Blick des gewundenen Wächters" },
            { itemId = 270175, slot = "Schmuck", name = "Lebendige Sporenkapsel" },
            { itemId = 270173, slot = "Schmuck", name = "Gieriges Herz von Ula'tek" },
            { itemId = 268266, slot = "Ring", name = "Ring des Wellenrufers" },
            { itemId = 268265, slot = "Hals", name = "Amani-Anhänger" },
            { itemId = 268253, slot = "Rücken", name = "Umhang der gewundenen Seelen" },
            { itemId = 268259, slot = "Taille", name = "Gurt des Vernichters" },
            { itemId = 271600, slot = "Füße", name = "Stiefel des Wächters" },
        }
    }
}

local TANK_BIS = {
    bisGear = {
        wowhead = {
            { itemId = 268213, slot = "Waffe", name = "Maze-roa, Zorn des Kriegsfürsten" },
            { itemId = 268262, slot = "Schild", name = "Nymrissas Wellenschutz" },
            { itemId = 271528, slot = "Kopf", name = "Blick des gewundenen Wächters" },
            { itemId = 270173, slot = "Schmuck", name = "Gieriges Herz von Ula'tek" },
            { itemId = 270165, slot = "Schmuck", name = "Auge des Wächters" },
            { itemId = 268249, slot = "Ring", name = "Siegel des Bösartigen" },
            { itemId = 268265, slot = "Hals", name = "Amani-Anhänger" },
            { itemId = 268253, slot = "Rücken", name = "Umhang der gewundenen Seelen" },
            { itemId = 268259, slot = "Taille", name = "Gurt des Vernichters" },
        }
    }
}

-- Shallow copy helper so each spec can later get talentBuilds independently
local function CopyBis(src)
    local t = { bisGear = { wowhead = {} } }
    for i, e in ipairs(src.bisGear.wowhead) do
        t.bisGear.wowhead[i] = {
            itemId = e.itemId,
            slot = e.slot,
            name = e.name,
        }
    end
    return t
end

DragonSkillData["DRUID"] = {
    [102] = CopyBis(DEFAULT_BIS), [103] = CopyBis(DEFAULT_BIS),
    [104] = CopyBis(TANK_BIS), [105] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["WARRIOR"] = {
    [71] = CopyBis(DEFAULT_BIS), [72] = CopyBis(DEFAULT_BIS), [73] = CopyBis(TANK_BIS),
}
DragonSkillData["PALADIN"] = {
    [65] = CopyBis(DEFAULT_BIS), [66] = CopyBis(TANK_BIS), [70] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["HUNTER"] = {
    [253] = CopyBis(DEFAULT_BIS), [254] = CopyBis(DEFAULT_BIS), [255] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["ROGUE"] = {
    [259] = CopyBis(DEFAULT_BIS), [260] = CopyBis(DEFAULT_BIS), [261] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["PRIEST"] = {
    [256] = CopyBis(DEFAULT_BIS), [257] = CopyBis(DEFAULT_BIS), [258] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["DEATHKNIGHT"] = {
    [250] = CopyBis(TANK_BIS), [251] = CopyBis(DEFAULT_BIS), [252] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["SHAMAN"] = {
    [262] = CopyBis(DEFAULT_BIS), [263] = CopyBis(DEFAULT_BIS), [264] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["MAGE"] = {
    [62] = CopyBis(DEFAULT_BIS), [63] = CopyBis(DEFAULT_BIS), [64] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["WARLOCK"] = {
    [265] = CopyBis(DEFAULT_BIS), [266] = CopyBis(DEFAULT_BIS), [267] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["MONK"] = {
    [268] = CopyBis(TANK_BIS), [269] = CopyBis(DEFAULT_BIS), [270] = CopyBis(DEFAULT_BIS),
}
DragonSkillData["DEMONHUNTER"] = {
    [577] = CopyBis(DEFAULT_BIS), [581] = CopyBis(TANK_BIS),
}
DragonSkillData["EVOKER"] = {
    [1467] = CopyBis(DEFAULT_BIS), [1468] = CopyBis(DEFAULT_BIS), [1473] = CopyBis(DEFAULT_BIS),
}
