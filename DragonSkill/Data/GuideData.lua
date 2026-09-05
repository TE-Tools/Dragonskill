-- Dragon Skill - Guide Data Master (v2.4.2)
-- Patch 12.1 Midnight Season 2 (Venomous Abyss)

DragonSkillData = DragonSkillData or {}

local HEALER_BIS = {
    { itemId = 271619, slot = "Stab", name = "Stab der Wellenflüsterin" },
    { itemId = 272003, slot = "Schmuckstück", name = "Seelenwinder-Ritualgefäß" },
    { itemId = 270175, slot = "Schmuckstück", name = "Lebendige Sporenkapsel" },
    { itemId = 272005, slot = "Kopf", name = "Helm des gewundenen Wächters [T-Set]" },
    { itemId = 272006, slot = "Schulter", name = "Schultern des gewundenen Wächters [T-Set]" },
    { itemId = 272007, slot = "Brust", name = "Brustschutz des gewundenen Wächters [T-Set]" },
    { itemId = 272008, slot = "Hände", name = "Stulpen des gewundenen Wächters [T-Set]" },
    { itemId = 272009, slot = "Beine", name = "Gamaschen des gewundenen Wächters [T-Set]" },
    { itemId = 268266, slot = "Ring", name = "Ring des Wellenrufers" },
    { itemId = 268265, slot = "Hals", name = "Amani-Anhänger" },
    { itemId = 268253, slot = "Rücken", name = "Umhang der gewundenen Seelen" },
}

local TANK_BIS = {
    { itemId = 272001, slot = "Waffe", name = "Maze-roa, Zorn des Kriegsfürsten" },
    { itemId = 272002, slot = "Schmuckstück", name = "Gieriges Herz von Ula'tek" },
    { itemId = 272005, slot = "Kopf", name = "Helm des gewundenen Wächters [T-Set]" },
    { itemId = 272006, slot = "Schulter", name = "Schultern des gewundenen Wächters [T-Set]" },
    { itemId = 272007, slot = "Brust", name = "Brustschutz des gewundenen Wächters [T-Set]" },
    { itemId = 272008, slot = "Hände", name = "Stulpen des gewundenen Wächters [T-Set]" },
    { itemId = 272009, slot = "Beine", name = "Gamaschen des gewundenen Wächters [T-Set]" },
    { itemId = 268262, slot = "Schild", name = "Nymrissas Wellenschutz" },
    { itemId = 268249, slot = "Ring", name = "Siegel des Bösartigen" },
}

local MELEE_BIS = {
    { itemId = 272001, slot = "Waffe", name = "Maze-roa, Zorn des Kriegsfürsten" },
    { itemId = 272002, slot = "Schmuckstück", name = "Gieriges Herz von Ula'tek" },
    { itemId = 272005, slot = "Kopf", name = "Helm des gewundenen Wächters [T-Set]" },
    { itemId = 272006, slot = "Schulter", name = "Schultern des gewundenen Wächters [T-Set]" },
    { itemId = 272007, slot = "Brust", name = "Brustschutz des gewundenen Wächters [T-Set]" },
    { itemId = 272008, slot = "Hände", name = "Stulpen des gewundenen Wächters [T-Set]" },
    { itemId = 272009, slot = "Beine", name = "Gamaschen des gewundenen Wächters [T-Set]" },
    { itemId = 268249, slot = "Ring", name = "Siegel des Bösartigen" },
    { itemId = 271530, slot = "Faustwaffe", name = "Nekzalis Faust" },
}

local CASTER_BIS = {
    { itemId = 272004, slot = "Schmuckstück", name = "Reißzahn der umbralen Bosheit" },
    { itemId = 270160, slot = "Schmuckstück", name = "Kystias Versprechen" },
    { itemId = 272005, slot = "Kopf", name = "Helm des gewundenen Wächters [T-Set]" },
    { itemId = 272006, slot = "Schulter", name = "Schultern des gewundenen Wächters [T-Set]" },
    { itemId = 272007, slot = "Brust", name = "Brustschutz des gewundenen Wächters [T-Set]" },
    { itemId = 272008, slot = "Hände", name = "Stulpen des gewundenen Wächters [T-Set]" },
    { itemId = 272009, slot = "Beine", name = "Gamaschen des gewundenen Wächters [T-Set]" },
    { itemId = 268266, slot = "Ring", name = "Ring des Wellenrufers" },
    { itemId = 271092, slot = "Stab", name = "Ula'teks Stab" },
}

local function GetBisForRole(role)
    local source = (role == "healer" and HEALER_BIS) or (role == "tank" and TANK_BIS) or (role == "caster" and CASTER_BIS) or MELEE_BIS
    return {
        bisGear = {
            wowhead = source,
            raid = source,
            mplus = source
        }
    }
end

-- Update for all classes and specs
DragonSkillData["DRUID"] = { [102] = GetBisForRole("caster"), [103] = GetBisForRole("melee"), [104] = GetBisForRole("tank"), [105] = GetBisForRole("healer") }
DragonSkillData["WARRIOR"] = { [71] = GetBisForRole("melee"), [72] = GetBisForRole("melee"), [73] = GetBisForRole("tank") }
DragonSkillData["PALADIN"] = { [65] = GetBisForRole("healer"), [66] = GetBisForRole("tank"), [70] = GetBisForRole("melee") }
DragonSkillData["HUNTER"] = { [253] = GetBisForRole("melee"), [254] = GetBisForRole("melee"), [255] = GetBisForRole("melee") }
DragonSkillData["ROGUE"] = { [259] = GetBisForRole("melee"), [260] = GetBisForRole("melee"), [261] = GetBisForRole("melee") }
DragonSkillData["PRIEST"] = { [256] = GetBisForRole("healer"), [257] = GetBisForRole("healer"), [258] = GetBisForRole("caster") }
DragonSkillData["DEATHKNIGHT"] = { [250] = GetBisForRole("tank"), [251] = GetBisForRole("melee"), [252] = GetBisForRole("melee") }
DragonSkillData["SHAMAN"] = { [262] = GetBisForRole("caster"), [263] = GetBisForRole("melee"), [264] = GetBisForRole("healer") }
DragonSkillData["MAGE"] = { [62] = GetBisForRole("caster"), [63] = GetBisForRole("caster"), [64] = GetBisForRole("caster") }
DragonSkillData["WARLOCK"] = { [265] = GetBisForRole("caster"), [266] = GetBisForRole("caster"), [267] = GetBisForRole("caster") }
DragonSkillData["MONK"] = { [268] = GetBisForRole("tank"), [269] = GetBisForRole("melee"), [270] = GetBisForRole("healer") }
DragonSkillData["DEMONHUNTER"] = { [577] = GetBisForRole("melee"), [581] = GetBisForRole("tank") }
DragonSkillData["EVOKER"] = { [1467] = GetBisForRole("caster"), [1468] = GetBisForRole("healer"), [1473] = GetBisForRole("caster") }
