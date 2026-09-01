-- Dragon Skill - Complete Gear & Loot Database (v2.3.6)
-- Expansion: Midnight | Patch: 12.1.0 | Season: 2
-- Master Data: Full Mythic Loot Tables and Absolute Purity Registry.

DragonSkillGearData = DragonSkillGearData or {
    metadata = {
        expansion = "Midnight",
        patch = "12.1.0",
        season = 2,
        mythicIlvl = 639,
        lastUpdated = "2026-09-01"
    },
    dungeons = {},
    items = {},
    specs = {},
    crafted = {}
}

local function AddItem(id, data)
    data.ilvl = data.ilvl or 639
    DragonSkillGearData.items[id] = data
end

local function AddDungeon(name, bosses)
    DragonSkillGearData.dungeons[name] = { name = name, bosses = bosses }
end

-- ==========================================
-- DUNGEONS & RAIDS LOOT (12.1)
-- ==========================================

AddDungeon("Murder Row", {
    { name = "Kystia Manaheart", loot = { 268201, 270160, 268250 } },
    { name = "Zaen Bladesorrow", loot = { 268205, 270161, 268254 } },
    { name = "Xathuux", loot = { 268210, 270162, 268258 } }
})

AddDungeon("Altar of Fangs", {
    { name = "Rav'i", loot = { 268240, 268261, 270163 } },
    { name = "Zul'jan", loot = { 268213, 268214, 270170 } }
})

AddDungeon("Venomous Abyss (Raid)", {
    { name = "Entombed Sentinels", loot = { 271528, 271529, 271600, 270165 } },
    { name = "Nekzali", loot = { 271530, 271531, 271602, 270162 } },
    { name = "Sszorak", loot = { 270173, 271532, 271533, 271534 } },
    { name = "Ulatek", loot = { 271535, 271536, 271617, 270175 } },
    { name = "Nymrissa", loot = { 271619, 271620, 268266 } }
})

-- ==========================================
-- ITEM REGISTRY (639+) - PURITY 12.1
-- ==========================================

-- Murder Row
AddItem(268201, { name = "Manaherz-Spalter", slot = "Einhandaxt" })
AddItem(270160, { name = "Kystias Versprechen", slot = "Schmuckstück" })
AddItem(268250, { name = "Umhang der Manadurstigen", slot = "Rücken" })
AddItem(268205, { name = "Klinge der Trauer", slot = "Dolch" })
AddItem(270161, { name = "Zaens Talisman", slot = "Schmuckstück" })
AddItem(268254, { name = "Armschienen des Leids", slot = "Handgelenke" })
AddItem(268210, { name = "Xathuux' Leerenklinge", slot = "Einhandschwert" })
AddItem(268258, { name = "Gurt der Schatten", slot = "Taille" })

-- Altar of Fangs
AddItem(268240, { name = "Rav'is Zerschmetterer", slot = "Einhandstreitkolben" })
AddItem(268261, { name = "Zul'jans Bastion", slot = "Schild" })
AddItem(270163, { name = "Voodoo-Puppe", slot = "Schmuckstück" })
AddItem(268213, { name = "Maze-roa, Zorn des Kriegsfürsten", slot = "Zweihandstreitkolben" })
AddItem(268214, { name = "Großstab der Fangzähne", slot = "Stab" })
AddItem(270170, { name = "Uraltes Gift", slot = "Schmuckstück" })

-- Venomous Abyss
AddItem(271528, { name = "Blick des gewundenen Wächters", slot = "Kopf", tierItem = true })
AddItem(271529, { name = "Schulterplatten des Wächters", slot = "Schulter" })
AddItem(271530, { name = "Nekzalis Faust", slot = "Faustwaffe" })
AddItem(271531, { name = "Brustschutz der Ewigkeit", slot = "Brust" })
AddItem(271600, { name = "Stiefel des Wächters", slot = "Füße" })
AddItem(271602, { name = "Beinschützer des Abgrunds", slot = "Beine" })
AddItem(270165, { name = "Auge des Wächters", slot = "Schmuckstück" })
AddItem(270162, { name = "Seelenwindsplitter", slot = "Schmuckstück" })
AddItem(270173, { name = "Gieriges Herz von Ula'tek", slot = "Schmuckstück" })
AddItem(271532, { name = "Sszoraks Schuppe", slot = "Schmuckstück" })
AddItem(271533, { name = "Bogen des Schlangenfürsten", slot = "Bogen" })
AddItem(271534, { name = "Handschuhe der Giftmischer", slot = "Hände" })
AddItem(271535, { name = "Ulateks Auge", slot = "Schmuckstück" })
AddItem(271536, { name = "Gewand der Sporen", slot = "Brust" })
AddItem(271617, { name = "Gamaschen der Fäulnis", slot = "Beine" })
AddItem(270175, { name = "Lebendige Sporenkapsel", slot = "Schmuckstück" })
AddItem(271619, { name = "Stab der Wellenflüsterin", slot = "Stab" })
AddItem(271620, { name = "Halskette der Gezeiten", slot = "Hals" })
AddItem(268266, { name = "Ring des Wellenrufers", slot = "Ring" })

-- General
AddItem(271092, { name = "Ula'teks Stab", slot = "Stab" })
AddItem(268262, { name = "Nymrissas Wellenschutz", slot = "Schild" })
AddItem(268265, { name = "Amani-Anhänger", slot = "Hals" })
AddItem(268253, { name = "Umhang der gewundenen Seelen", slot = "Rücken" })
AddItem(268259, { name = "Gurt des Vernichters", slot = "Taille" })
AddItem(268249, { name = "Siegel des Bösartigen", slot = "Ring" })

-- ==========================================
-- ROLE-BASED FALLBACK (FOR ALL CLASSES)
-- ==========================================

local roles = {
    healer = { 271092, 270175, 270173, 271528, 268266, 268265, 268253, 268259, 270162 },
    tank = { 268213, 268262, 270173, 271528, 268249, 268265, 268253, 268259, 270165 },
    dps = { 271092, 268213, 270173, 271528, 268249, 268266, 268253, 268259, 270162 }
}

local specList = { 102, 103, 104, 105, 250, 251, 252, 62, 63, 64, 71, 72, 73, 65, 66, 70, 253, 254, 255, 259, 260, 261, 256, 257, 258, 262, 263, 264, 265, 266, 267, 268, 269, 270, 577, 581, 1467, 1468, 1473 }
for _, id in ipairs(specList) do
    local role = (id == 105 or id == 65 or id == 257 or id == 264 or id == 270 or id == 1468) and "healer" or
                 (id == 250 or id == 73 or id == 66 or id == 268 or id == 581 or id == 104) and "tank" or "dps"

    DragonSkillGearData.specs[id] = {
        role = role,
        bis = { overall = roles[role] }
    }
end
