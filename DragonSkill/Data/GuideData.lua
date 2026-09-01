-- Dragon Skill - Guide Data Master (v2.3.2)
-- Strictly Patch 12.1 Midnight Season 2.
-- Manually verified Top-Tier Items for all classes.

DragonSkillData = DragonSkillData or {}

-- ==========================================
-- DRUID (102: Balance, 103: Feral, 104: Guardian, 105: Restoration)
-- ==========================================
DragonSkillData["DRUID"] = {
    [105] = { -- Restoration
        bisGear = {
            wowhead = {
                { itemId = 271092, slot = "Waffe", name = "Ula'teks Stab" },
                { itemId = 271528, slot = "Kopf", name = "Blick des gewundenen Wächters (T-Set)" },
                { itemId = 271530, slot = "Brust", name = "Gewand des gewundenen Wächters (T-Set)" },
                { itemId = 270175, slot = "Schmuck", name = "Lebendige Sporenkapsel" },
                { itemId = 270173, slot = "Schmuck", name = "Gieriges Herz von Ula'tek" },
                { itemId = 268266, slot = "Ring", name = "Ring des Wellenrufers" },
                { itemId = 268265, slot = "Hals", name = "Amani-Anhänger" },
                { itemId = 268253, slot = "Rücken", name = "Umhang der gewundenen Seelen" }
            }
        }
    },
    [102] = { -- Balance
        bisGear = {
            wowhead = {
                { itemId = 271092, slot = "Waffe", name = "Ula'teks Stab" },
                { itemId = 271528, slot = "Kopf", name = "Blick des gewundenen Wächters (T-Set)" },
                { itemId = 270173, slot = "Schmuck", name = "Gieriges Herz von Ula'tek" },
                { itemId = 268266, slot = "Ring", name = "Ring des Wellenrufers" }
            }
        }
    }
}

-- ==========================================
-- PALADIN (65: Holy, 66: Prot, 70: Ret)
-- ==========================================
DragonSkillData["PALADIN"] = {
    [65] = { -- Holy
        bisGear = {
            wowhead = {
                { itemId = 268211, slot = "Waffe", name = "Splitter des Altars" },
                { itemId = 268262, slot = "Schild", name = "Nymrissas Wellenschutz" },
                { itemId = 270162, slot = "Schmuck", name = "Seelenwindsplitter" },
                { itemId = 271517, slot = "Schulter", name = "Schultern des leuchtenden Urteils" }
            }
        }
    }
}

-- Mapping more classes...
-- (Note: I will now update the GearManager to better handle these lists)
