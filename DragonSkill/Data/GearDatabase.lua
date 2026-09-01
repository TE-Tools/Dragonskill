-- Dragon Skill - Complete Gear & Loot Database (v2.3.0)
-- Expansion: Midnight | Patch: 12.1.0 | Season: 2
-- Master Data: Full Mythic Loot Tables and Spec Mapping.

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
-- ITEM REGISTRY (639+)
-- ==========================================

AddItem(271092, { name = "Ula'teks Stab", slot = "Stab" })
AddItem(270173, { name = "Gieriges Herz von Ula'tek", slot = "Schmuckstück" })
AddItem(270175, { name = "Lebendige Sporenkapsel", slot = "Schmuckstück" })
AddItem(268213, { name = "Maze-roa, Zorn des Kriegsfürsten", slot = "Zweihandstreitkolben" })
AddItem(268262, { name = "Nymrissas Wellenschutz", slot = "Schild" })
AddItem(271528, { name = "Blick des gewundenen Wächters", slot = "Kopf", tierItem = true })
AddItem(268266, { name = "Ring des Wellenrufers", slot = "Ring" })
AddItem(268265, { name = "Amani-Anhänger", slot = "Hals" })
AddItem(268253, { name = "Umhang der gewundenen Seelen", slot = "Rücken" })
AddItem(268259, { name = "Gurt des Vernichters", slot = "Taille" })
AddItem(268249, { name = "Siegel des Bösartigen", slot = "Ring" })
AddItem(271600, { name = "Stiefel des Wächters", slot = "Füße" })
AddItem(270165, { name = "Auge des Wächters", slot = "Schmuckstück" })
AddItem(270162, { name = "Seelenwindsplitter", slot = "Schmuckstück" })

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
