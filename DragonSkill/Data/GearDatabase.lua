-- Dragon Skill - Gear Database (v2.3.14)
-- Items with armor = plate|leather|mail|cloth for class filtering.

DragonSkillGearData = DragonSkillGearData or {
    items = {},
    dungeons = {},
    specs = {},
}

local function AddItem(id, data)
    DragonSkillGearData.items[id] = data
end

-- === Trinkets / Jewelry / Cloaks ===
AddItem(270160, { name = "Kystias Versprechen", slot = "Schmuckstück" })
AddItem(270161, { name = "Zaens Talisman", slot = "Schmuckstück" })
AddItem(270163, { name = "Voodoo-Puppe", slot = "Schmuckstück" })
AddItem(270170, { name = "Uraltes Gift", slot = "Schmuckstück" })
AddItem(270165, { name = "Auge des Wächters", slot = "Schmuckstück" })
AddItem(270162, { name = "Seelenwindsplitter", slot = "Schmuckstück" })
AddItem(270173, { name = "Gieriges Herz von Ula'tek", slot = "Schmuckstück" })
AddItem(271532, { name = "Sszoraks Schuppe", slot = "Schmuckstück" })
AddItem(271535, { name = "Ulateks Auge", slot = "Schmuckstück" })
AddItem(270175, { name = "Lebendige Sporenkapsel", slot = "Schmuckstück" })
AddItem(268266, { name = "Ring des Wellenrufers", slot = "Ring" })
AddItem(268249, { name = "Siegel des Bösartigen", slot = "Ring" })
AddItem(268265, { name = "Amani-Anhänger", slot = "Hals" })
AddItem(271620, { name = "Halskette der Gezeiten", slot = "Hals" })
AddItem(268253, { name = "Umhang der gewundenen Seelen", slot = "Rücken" })
AddItem(268250, { name = "Umhang der Manadurstigen", slot = "Rücken" })

-- === Weapons ===
AddItem(268201, { name = "Manaherz-Spalter", slot = "Einhandaxt" })
AddItem(268205, { name = "Klinge der Trauer", slot = "Dolch" })
AddItem(268210, { name = "Xathuux' Leerenklinge", slot = "Einhandschwert" })
AddItem(268240, { name = "Rav'is Zerschmetterer", slot = "Einhandstreitkolben" })
AddItem(268213, { name = "Maze-roa, Zorn des Kriegsfürsten", slot = "Zweihandstreitkolben" })
AddItem(268214, { name = "Großstab der Fangzähne", slot = "Stab" })
AddItem(271092, { name = "Ula'teks Stab", slot = "Stab" })
AddItem(271619, { name = "Stab der Wellenflüsterin", slot = "Stab" })
AddItem(271530, { name = "Nekzalis Faust", slot = "Faustwaffe" })
AddItem(271533, { name = "Bogen des Schlangenfürsten", slot = "Bogen" })
AddItem(268261, { name = "Zul'jans Bastion", slot = "Schild" })
AddItem(268262, { name = "Nymrissas Wellenschutz", slot = "Schild" })

-- === Armor (typed) ===
AddItem(268254, { name = "Armschienen des Leids", slot = "Handgelenke", armor = "leather" })
AddItem(268258, { name = "Gurt der Schatten", slot = "Taille", armor = "leather" })
AddItem(271534, { name = "Handschuhe der Giftmischer", slot = "Hände", armor = "leather" })
AddItem(271536, { name = "Gewand der Sporen", slot = "Brust", armor = "cloth" })
AddItem(271617, { name = "Gamaschen der Fäulnis", slot = "Beine", armor = "cloth" })
AddItem(271528, { name = "Blick des gewundenen Wächters", slot = "Kopf", armor = "plate", tierItem = true })
AddItem(271529, { name = "Schulterplatten des Wächters", slot = "Schulter", armor = "plate" })
AddItem(271531, { name = "Brustschutz der Ewigkeit", slot = "Brust", armor = "plate" })
AddItem(271600, { name = "Stiefel des Wächters", slot = "Füße", armor = "plate" })
AddItem(271602, { name = "Beinschützer des Abgrunds", slot = "Beine", armor = "plate" })
AddItem(268259, { name = "Gurt des Vernichters", slot = "Taille", armor = "plate" })

-- === Dungeons (sample loot tables) ===
DragonSkillGearData.dungeons = {
    ["Eco-Dome Al'dani"] = {
        bosses = {
            { name = "Azhiccar", loot = { 268201, 270160, 268250 } },
            { name = "Taah'bat", loot = { 268205, 270161, 268254 } },
            { name = "Soul-Scribe", loot = { 268210, 268258 } },
        }
    },
    ["Ara-Kara, City of Echoes"] = {
        bosses = {
            { name = "Avanoxx", loot = { 268240, 268261, 270163 } },
            { name = "Anub'zekt", loot = { 268213, 268214, 270170 } },
        }
    },
    ["Halls of Atonement"] = {
        bosses = {
            { name = "Halkias", loot = { 271528, 271529, 271530 } },
            { name = "Echelon", loot = { 271531, 271600, 271602 } },
            { name = "High Adjudicator Aleez", loot = { 270165, 270162 } },
            { name = "Lord Chamberlain", loot = { 270173, 271532 } },
        }
    },
    ["The Dawnbreaker"] = {
        bosses = {
            { name = "Speaker Shadowcrown", loot = { 271533, 271534 } },
            { name = "Anub'ikkaj", loot = { 271535, 271536, 271617 } },
            { name = "Rasha'nan", loot = { 270175, 271619, 271620 } },
        }
    },
    ["Priory of the Sacred Flame"] = {
        bosses = {
            { name = "Captain Dailcry", loot = { 271092, 268262, 268265 } },
            { name = "Baron Braunpyke", loot = { 268253, 268259, 268249 } },
        }
    },
}

-- Role BiS packs (filtered further by class armor in GearManager)
local roles = {
    healer = { 271092, 270175, 270173, 271528, 268266, 268265, 268253, 268259, 270162 },
    tank   = { 268213, 268262, 271528, 270173, 270165, 268249, 268265, 268253, 268259 },
    dps    = { 268210, 270160, 270161, 271528, 268266, 268265, 268253, 268259, 270170 },
}

local specList = { 102, 103, 104, 105, 250, 251, 252, 62, 63, 64, 71, 72, 73, 65, 66, 70, 253, 254, 255, 259, 260, 261, 256, 257, 258, 262, 263, 264, 265, 266, 267, 268, 269, 270, 577, 581, 1467, 1468, 1473 }
for _, id in ipairs(specList) do
    local role = (id == 105 or id == 65 or id == 257 or id == 264 or id == 270 or id == 1468) and "healer" or
        (id == 104 or id == 66 or id == 73 or id == 250 or id == 268 or id == 581) and "tank" or "dps"
    DragonSkillGearData.specs[id] = {
        role = role,
        bis = { overall = roles[role] }
    }
end
