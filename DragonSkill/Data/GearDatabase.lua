-- Dragon Skill - Gear & Farm Database (v1.7.0)
-- Expansion: Midnight | Patch: 12.1 | Season: 2
-- This file contains structured data for BiS, Farm, and Upgrades.

DragonSkillGearData = DragonSkillGearData or {
    metadata = {
        expansion = "Midnight",
        patch = "12.1.0",
        season = 2,
        lastUpdated = "2026-08-29",
        dataSource = "DragonSkill Scraper / Wowhead / Archon",
        confidence = 0.95
    },
    specs = {}
}

local function AddSpecGear(class, specID, data)
    DragonSkillGearData.specs[class] = DragonSkillGearData.specs[class] or {}
    DragonSkillGearData.specs[class][specID] = data
end

-- ==========================================
-- DRUID: RESTORATION (105) - REFERENCE SPEC
-- ==========================================
AddSpecGear("DRUID", 105, {
    statWeights = { intellect = 10, haste = 9, mastery = 8.5, versatility = 7, criticalStrike = 6 },
    preferredStats = { "haste", "mastery" },
    tierSet = {
        name = "Garb of the Coiled Watcher",
        pieces = { 271528, 271517, 271519, 271516, 271520 }, -- Head, Shoulder, Chest, Hands, Legs
        bonuses = {
            [2] = "Rejuvenation chance / Nature's Swiftness grant Genesis (+25% HoT heal)",
            [4] = "Tranquility / Convoke grant Genesis, duration +4s"
        }
    },
    bisProfiles = {
        overall = {
            head = 271528,   -- Gaze of the Coiled Watcher (Ula'tek)
            neck = 268265,   -- Amulet of the Twin Fangs
            shoulder = 244572, -- Silvermoon Agent's Mantle (Crafted)
            back = 268253,   -- Silken Voodoo Drape
            chest = 271519,  -- War Trial Vestments (Catalyst/Raid)
            wrist = 244576,  -- Silvermoon Agent's Deflectors (Crafted)
            hands = 271516,  -- Enigmatic Dreamwatcher's Gauntlets
            waist = 268256,  -- Sash of the Forlorn Vessel
            legs = 271520,   -- Coiled Hex Legguards
            feet = 268260,   -- Breakwater Boots (M+)
            ring1 = 268249,  -- Vile Alchemist's Band (M+)
            ring2 = 268252,  -- Sickening Signet of Atroxus (M+)
            trinket1 = 270167, -- Seal of the Venom-Lord
            trinket2 = 270175, -- Living Spore Pod
            mainhand = 268201 -- Staff of the Serpent Scion
        }
    },
    items = {
        [271528] = { name = "Gaze of the Coiled Watcher", slot = "Head", source = "raid", sourceName = "The Venomous Abyss", bossName = "Ula'tek", tierItem = true, farmPriority = 10 },
        [271519] = { name = "War Trial Vestments", slot = "Chest", source = "dungeon", dungeonName = "Den of Nalorakk", catalystEligible = true, farmPriority = 10 },
        [268252] = { name = "Sickening Signet of Atroxus", slot = "Ring", source = "dungeon", dungeonName = "Voidscar Arena", stats = { haste = 120, mastery = 110 }, farmPriority = 10 },
        [268249] = { name = "Vile Alchemist's Band", slot = "Ring", source = "dungeon", dungeonName = "Vashnik the Malignant", farmPriority = 9 },
        [268260] = { name = "Breakwater Boots", slot = "Feet", source = "dungeon", dungeonName = "Nymrissa Wavecaller", farmPriority = 8 }
    }
})

-- ==========================================
-- DEATHKNIGHT: BLOOD (250)
-- ==========================================
AddSpecGear("DEATHKNIGHT", 250, {
    statWeights = { strength = 10, haste = 9, mastery = 8, versatility = 7, criticalStrike = 5 },
    preferredStats = { "haste", "mastery" },
    bisProfiles = {
        overall = {
            mainhand = 268213, -- Maze-roa, Warlord's Fury
            trinket1 = 270173, -- Voracious Heart of Ula'tek
            trinket2 = 270162  -- Idol of the War Loa
        }
    },
    items = {
        [268213] = { name = "Maze-roa, Warlord's Fury", slot = "MainHand", source = "raid", sourceName = "The Venomous Abyss", bossName = "The Coiled Altar", farmPriority = 10 },
        [270173] = { name = "Voracious Heart of Ula'tek", slot = "Trinket", source = "raid", sourceName = "The Venomous Abyss", bossName = "Ula'tek", farmPriority = 10 }
    }
})

-- ==========================================
-- MAGE: FIRE (63)
-- ==========================================
AddSpecGear("MAGE", 63, {
    statWeights = { intellect = 10, haste = 11, criticalStrike = 8, mastery = 7, versatility = 6 },
    preferredStats = { "haste", "criticalStrike" },
    bisProfiles = {
        overall = {
            head = 271474, -- Venomkeeper's Horrific Cowl
            mainhand = 268201, -- Jan'thrazet, the Soul Fang
            trinket1 = 270160, -- Vile Vial of Volatile Venom
            trinket2 = 270175 -- Gebbo's Bottomless Bag
        }
    },
    items = {
        [271474] = { name = "Venomkeeper's Horrific Cowl", slot = "Head", source = "raid", sourceName = "The Venomous Abyss", bossName = "Ula'tek", farmPriority = 10 },
        [268201] = { name = "Jan'thrazet, the Soul Fang", slot = "MainHand", source = "raid", sourceName = "The Venomous Abyss", bossName = "Ula'tek", farmPriority = 10 }
    }
})

-- ==========================================
-- WARRIOR: ARMS (71)
-- ==========================================
AddSpecGear("WARRIOR", 71, {
    statWeights = { strength = 10, criticalStrike = 9, haste = 8, mastery = 7, versatility = 6 },
    preferredStats = { "criticalStrike", "haste" },
    bisProfiles = {
        overall = {
            mainhand = 268213, -- Maze-roa, Warlord's Fury
            trinket1 = 270170, -- Zul'jin's Guillotine Technique
            trinket2 = 270173 -- Voracious Heart of Ula'tek
        }
    },
    items = {
        [268213] = { name = "Maze-roa, Warlord's Fury", slot = "MainHand", source = "raid", sourceName = "The Venomous Abyss", bossName = "The Coiled Altar", farmPriority = 10 }
    }
})

-- ==========================================
-- PALADIN: HOLY (65)
-- ==========================================
AddSpecGear("PALADIN", 65, {
    statWeights = { intellect = 10, mastery = 9, haste = 8, criticalStrike = 8, versatility = 6 },
    preferredStats = { "mastery", "haste" },
    bisProfiles = {
        overall = {
            mainhand = 268201, -- Jan'thrazet, the Soul Fang
            trinket1 = 270167, -- Nymrissa's Wavecaller
            trinket2 = 270175 -- Gebbo's Bottomless Bag
        }
    },
    items = {
        [270167] = { name = "Nymrissa's Wavecaller", slot = "Trinket", source = "raid", sourceName = "The Venomous Abyss", bossName = "Entombed Sentinels", farmPriority = 10 }
    }
})

-- Placeholder for other 38 specs...
-- In a real scenario, this would be auto-filled by the build-data script.
