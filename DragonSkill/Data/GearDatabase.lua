-- Dragon Skill - Gear Database (v2.4.2)
-- Updated for Patch 12.1 Midnight Season 2 (Venomous Abyss)

DragonSkillGearData = DragonSkillGearData or {
    items = {},
    dungeons = {},
    specs = {},
}

local function AddItem(id, data)
    DragonSkillGearData.items[id] = data
end

-- === Patch 12.1: Venomous Abyss Raid Items ===
AddItem(272001, { name = "Maze-roa, Zorn des Kriegsfürsten", slot = "Zweihandstreitkolben" })
AddItem(272002, { name = "Gieriges Herz von Ula'tek", slot = "Schmuckstück" })
AddItem(272003, { name = "Seelenwinder-Ritualgefäß", slot = "Schmuckstück" })
AddItem(272004, { name = "Reißzahn der umbralen Bosheit", slot = "Schmuckstück" })
AddItem(272005, { name = "Helm des gewundenen Wächters [T-Set]", slot = "Kopf", tierItem = true })
AddItem(272006, { name = "Schultern des gewundenen Wächters [T-Set]", slot = "Schulter", tierItem = true })
AddItem(272007, { name = "Brustschutz des gewundenen Wächters [T-Set]", slot = "Brust", tierItem = true })
AddItem(272008, { name = "Stulpen des gewundenen Wächters [T-Set]", slot = "Hände", tierItem = true })
AddItem(272009, { name = "Gamaschen des gewundenen Wächters [T-Set]", slot = "Beine", tierItem = true })

-- === Legacy & Dungeon Items (Season 1 & 2) ===
AddItem(270160, { name = "Kystias Versprechen", slot = "Schmuckstück" })
AddItem(270161, { name = "Zaens Talisman", slot = "Schmuckstück" })
AddItem(270163, { name = "Voodoo-Puppe", slot = "Schmuckstück" })
AddItem(270170, { name = "Uraltes Gift", slot = "Schmuckstück" })
AddItem(270165, { name = "Auge des Wächters", slot = "Schmuckstück" })
AddItem(270162, { name = "Seelenwindsplitter", slot = "Schmuckstück" })
AddItem(270175, { name = "Lebendige Sporenkapsel", slot = "Schmuckstück" })
AddItem(268266, { name = "Ring des Wellenrufers", slot = "Ring" })
AddItem(268249, { name = "Siegel des Bösartigen", slot = "Ring" })
AddItem(268265, { name = "Amani-Anhänger", slot = "Hals" })
AddItem(271620, { name = "Halskette der Gezeiten", slot = "Hals" })
AddItem(268253, { name = "Umhang der gewundenen Seelen", slot = "Rücken" })
AddItem(268250, { name = "Umhang der Manadurstigen", slot = "Rücken" })
AddItem(268201, { name = "Manaherz-Spalter", slot = "Einhandaxt" })
AddItem(268205, { name = "Klinge der Trauer", slot = "Dolch" })
AddItem(268210, { name = "Xathuux' Leerenklinge", slot = "Einhandschwert" })
AddItem(268240, { name = "Rav'is Zerschmetterer", slot = "Einhandstreitkolben" })
AddItem(268214, { name = "Großstab der Fangzähne", slot = "Stab" })
AddItem(271092, { name = "Ula'teks Stab", slot = "Stab" })
AddItem(271619, { name = "Stab der Wellenflüsterin", slot = "Stab" })
AddItem(271530, { name = "Nekzalis Faust", slot = "Faustwaffe" })
AddItem(271533, { name = "Bogen des Schlangenfürsten", slot = "Bogen" })
AddItem(268261, { name = "Zul'jans Bastion", slot = "Schild" })
AddItem(268262, { name = "Nymrissas Wellenschutz", slot = "Schild" })

-- === Dungeons & Raids Loot Tables ===
DragonSkillGearData.dungeons = {
    ["Venomous Abyss (Raid)"] = {
        bosses = {
            { name = "The Coiled Altar", loot = { 272001, 272005 } },
            { name = "The Lost Explorers", loot = { 272006 } },
            { name = "Vashnik the Malignant", loot = { 272004, 272007 } },
            { name = "Entombed Sentinels", loot = { 272008 } },
            { name = "Sszorak", loot = { 272009 } },
            { name = "Ula'tek", loot = { 272002 } },
            { name = "Nek'zali", loot = { 272003 } },
        }
    },
    ["Eco-Dome Al'dani"] = {
        bosses = {
            { name = "Azhiccar", loot = { 268201, 270160, 268250 } },
            { name = "Taah'bat", loot = { 268205, 270161 } },
        }
    },
}

-- BiS Role Logic
local roles = {
    healer = { 271619, 272003, 272005, 272006, 272007, 272008, 272009, 268265, 268253, 268266 },
    tank   = { 272001, 272002, 272005, 272006, 272007, 272008, 272009, 268262, 268249 },
    melee  = { 272001, 272002, 272005, 272006, 272007, 272008, 272009, 268249, 271530 },
    caster = { 272004, 272005, 272006, 272007, 272008, 272009, 268266, 268253, 271092 },
}

local specList = { 102, 103, 104, 105, 250, 251, 252, 62, 63, 64, 71, 72, 73, 65, 66, 70, 253, 254, 255, 259, 260, 261, 256, 257, 258, 262, 263, 264, 265, 266, 267, 268, 269, 270, 577, 581, 1467, 1468, 1473 }
for _, id in ipairs(specList) do
    local role = (id == 105 or id == 65 or id == 257 or id == 264 or id == 270 or id == 1468) and "healer" or
        (id == 104 or id == 66 or id == 73 or id == 250 or id == 268 or id == 581) and "tank" or
        (id == 102 or id == 62 or id == 63 or id == 64 or id == 258 or id == 262 or id == 265 or id == 266 or id == 267 or id == 1467 or id == 1473) and "caster" or "melee"

    DragonSkillGearData.specs[id] = {
        role = role,
        bis = { overall = roles[role] }
    }
end
