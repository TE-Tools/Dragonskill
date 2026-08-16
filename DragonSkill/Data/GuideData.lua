-- AUTO-GENERATED von build-data.js - nicht manuell bearbeiten
-- Quelle: Wowhead / Archon

DragonSkillData = DragonSkillData or {}

DragonSkillData["DEATHKNIGHT"] = DragonSkillData["DEATHKNIGHT"] or {}
DragonSkillData["DEATHKNIGHT"][250] = {
    scrapedAt = "2026-08-16T09:45:11.123Z",
    statPriority = {
        wowhead = "San'layn: Strength > Haste > Mastery / Critical Strike / Versatility | Deathbringer: Strength > Critical Strike > Mastery / Versatility > Haste",
        archon = "Strength > Mastery > Crit > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268213 },
            { slot = "Head", item = "[item=271474 original-item=268229]", source = "[url guide=34244]Nek'zali the Soulcoiler", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271472 original-item=239037]", source = "[url guide=34262]Temple of Sethraliss", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271477 original-item=268222]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Wrist", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 237834 },
            { slot = "Gloves", item = "[item=271475 original-item=159413]", source = "[url guide=34260]King's Rest", itemId = nil },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268259 },
            { slot = "Legs", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271878 },
            { slot = "Boots", item = "[url guide=34264]Altar of Fangs", source = "Unknown", itemId = 273777 },
            { slot = "Ring ()", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 273066 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=33193]Blinding Vale", source = "Unknown", itemId = 251194 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268213 },
            { slot = "Head", item = "[item=271474 original-item=268229]", source = "[url guide=34244]Nek'zali the Soulcoiler", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271472 original-item=239037]", source = "[url guide=34262]Temple of Sethraliss", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271477 original-item=268222]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Wrist", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 237834 },
            { slot = "Gloves", item = "[item=271475 original-item=159413]", source = "[url guide=34260]King's Rest", itemId = nil },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268259 },
            { slot = "Legs", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271878 },
            { slot = "Boots", item = "[url guide=34264]Altar of Fangs", source = "Unknown", itemId = 273777 },
            { slot = "Ring ()", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 273066 },
            { slot = "Ring", item = "[url guide=34260]King's Rest", source = "Unknown", itemId = 159459 },
            { slot = "Ring", item = "[url guide=33183]Voidscar Arena", source = "Unknown", itemId = 252258 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast  if you need the healing or are above 75 Runic Power[toggler id=db_why_75 hidden]Why 75?[/toggler]\n[div id=db_why_75 hidden]This is an arbitrary breakpoint that is a measured amount. It attempts to solve two problems:\n[ul]\n  With it at around this value, you always have two  available to you", spellId = "49998" },
            { text = "You also need 45 RP - two to three full  - to overcap Runic Power", spellId = "206930" },
            { text = "Maintain at least 5 charges of . If  is about to expire, press  [toggler id=bone_shield_generator_db_st hidden]Are there other generators?[/toggler]\n[div id=bone_shield_generator_db_st hidden]As [symbol=wow-hero-talent-deathbringer] [color=#9BE2E2]Deathbringer[/color], every 45 seconds, you will predictably gain two  charges, guaranteeing a  duration refresh and additional charges. On top of this, if you play , you are also guaranteed to come out of  at essentially  cap.\n\nThe problem with this is that, depending on how early you spend those , you may need to add one  generator at the halfway point between .\n\nIf you are already on 8+ bones and do not have a problem in taunting a target,  works as an effective  refresh.\n[/div]", spellId = "195181" },
            { text = "Cast  on cooldown", spellId = "439843" },
            { text = "Cast  on cooldown", spellId = "49028" },
            { text = "Cast  if  is active and your target does not have  on it, or if you are about to cap on its charges", spellId = "50842" },
            { text = "Cast  if you have a  proc", spellId = "50842" },
            { text = "Cast  as a filler. Do not run out of runes, particularly around the 45-second mark when  is about to come off cooldown", spellId = "206930" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "deathbringer",
            label = "Raid",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWGzMmxMjhZZmZmmZxYmxMmBAAAAmZmZmZmZYGjZAYMzMzAAAMmtBGwSw2wEYYBwMMAAMzAYYA",
        },
        {
            provider = "wowhead",
            context = "deathbringer",
            label = "Mythic+",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzMmxMzMMLzMz0MLGjxMGAAAAwMmZmZmZYGDAYmZmZGAAgxsNwAWC2GmADLAmxMAAMzAYYA",
        },
        {
            provider = "wowhead",
            context = "deathbringer",
            label = "Delves",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWmZmxMmZmhZZmZmmZxYmxMGAAAAwMzMzMzMDzYMAYMzMzAAAMmtBGwSwywEYYBghZAAMzAMYA",
        },
        {
            provider = "wowhead",
            context = "sanlayn",
            label = "Raid",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWmZmxMmZmhZZmZmmZxYMmxAAAAAmZmZmZmZYGjZAYMzMzAAAYgBmxiGLLgsMgNAzwAAAmZghB",
        },
        {
            provider = "wowhead",
            context = "sanlayn",
            label = "Mythic+",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWmZmxMmZmhZZmZmmZxYMmxAAAAAmxMzMzMDzYMAYMzMzAAAYgBmxiGLLgsMgNAzYmBAAmZghB",
        },
        {
            provider = "wowhead",
            context = "sanlayn",
            label = "Delves",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWmZmxMmZmhZZmZmmZxYMmxAAAAAmxMzMzMDzYMAYMzMzAAAYgBmxiGLLgsMgNAzYmBAAmZwgB",
        },
        {
            provider = "archon",
            context = "25.8%",
            label = "Recommended Class Tree",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzMmxMGMLzMz0MLzMjZmBAAAAwgZmZmZMzMjBAzMzMzAAAMmtBGwCYZYCMsAYGDAAmZAYMA",
        },
        {
            provider = "archon",
            context = "7.9%",
            label = "Alternative Class Tree #1",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzwMmZmhZZmZmmZxMjZmxAAAAAGMzMzMjZmZMAYmZmZGAAgxsNwAWALDTghFAzYAAwMDAMA",
        },
        {
            provider = "archon",
            context = "7.5%",
            label = "Alternative Class Tree #2",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzwMmxYMLzMz0MLzMjZmBAAAAwgZmZmZMzMjBAzMzMzAAAMmtBGwCYZYCMsAYGDAAmZAYMA",
        },
        {
            provider = "archon",
            context = "5.2%",
            label = "Alternative Class Tree #3",
            importString = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzwMmZmhZbmZmmZxMjZmxAAAAAGMzMzMjZmZMAYmZmZGAAgxsNwAWALDTghFAzYAAwMDAMA",
        },
    },
}

DragonSkillData["DEATHKNIGHT"][251] = {
    scrapedAt = "2026-08-16T09:45:11.610Z",
    statPriority = {
        wowhead = "Deathbringer: Strength > Critical Strike > Mastery > Haste > Versatility | Rider of the Apocalypse: Strength > Critical Strike > Mastery > Haste > Versatility",
        archon = "Strength > Mastery > Crit > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268202 },
            { slot = "Offhand", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268202 },
            { slot = "Head", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271474 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271472 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268222 },
            { slot = "Wrist", item = "[item=237834 bonus=8793:8960:12214:13454:13750:13751:13836:12497]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Gloves", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271475 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268259 },
            { slot = "Legs", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271878 },
            { slot = "Boots", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268260 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=15942]Crafting/Misc", source = "Unknown", itemId = 251513 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "deathbringer",
            label = "Raid",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMAmZMjZAz2MzMzMLzMjMjxYYmxgZmZmZmZmZAAAAAAAAAYMbDMgFwywEyYBzMmZGYAYYmBYmBD",
        },
        {
            provider = "wowhead",
            context = "deathbringer",
            label = "Mythic+",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMAzMMjZAz2MzMzMLzMjMjxYYmxgZmZmZmZmZAAAAAAAAAYMbDMgFwywEyYBzMmZGYAYYmBYmBD",
        },
        {
            provider = "wowhead",
            context = "deathbringer",
            label = "Delves",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMDYmhZmZAzmZmZmZZmZkZMGDzAMzMzMzMzMDAAAAAAAAAjZbgBsAWGmQGLYmZmZGYAYYmBYmBD",
        },
        {
            provider = "wowhead",
            context = "rider",
            label = "Raid",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMDwMjZMDY2mZmZmZZmZkZMGDzMGMjZmZmZmZAAAAAAAAAAsZWMMwAzmGaYDzMmZGYAYAYmZmBD",
        },
        {
            provider = "wowhead",
            context = "rider",
            label = "Mythic+",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAYAmZMzMDY2mZmZmZxMjmZMGmZGGzMwMzMzMDAAAAAAAAAgNzmhBGY20QDbYmZmZGYGADAzMzAD",
        },
        {
            provider = "wowhead",
            context = "rider",
            label = "Delves",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAYAzMMjZMDzmZmZmZxMjmZMGmZGGPwMmZmZmZmZAAAAAAAAAAsZ2MMwAzmGaYDzMzMzAAYAYmZGYA",
        },
        {
            provider = "archon",
            context = "19.5%",
            label = "Alternative Class Tree #1",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMAzMjZmZAz2MzMzMLmZkZMmZmZGYMzwMzMjZAAAAAAAAAYMbDMgFwywEYsgZGmZgZAMMzAMDM",
        },
        {
            provider = "archon",
            context = "6.1%",
            label = "Alternative Class Tree #2",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMAzMMjxYGzyMzMzMbzY0MjxMzMzAjZGmZmZMDAAAAAAAAAjZbgBsAWGmAjFMzwMDMDghZGAGM",
        },
        {
            provider = "archon",
            context = "3.8%",
            label = "Alternative Class Tree #3",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMAzMjZMGDz2MzMzMbzY0MjxMzMzAjZGmZmZMDAAAAAAAAAjZbgBsAWGmAjFMzwMDMDghZGAGM",
        },
        {
            provider = "archon",
            context = "2.4%",
            label = "Recommended Class Tree",
            importString = "CsPAAAAAAAAAAAAAAAAAAAAAAMAzMjZMGDzyMzMzMbzY0MjxMzMzAjZGmZmZMDAAAAAAAAAjZbgBsAWGmAjFMzwMDMDghZGAGM",
        },
    },
}

DragonSkillData["DEATHKNIGHT"][252] = {
    scrapedAt = "2026-08-16T09:45:12.201Z",
    statPriority = {
        wowhead = "San'layn: Strength > Mastery > Crit > Haste > Versatility | Rider of the Apocalypse: Strength > Mastery > Crit > Haste > Versatility",
        archon = "Strength > Mastery > Crit > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268213 },
            { slot = "Head", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271474 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271472 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271477 },
            { slot = "Wrist", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 237834 },
            { slot = "Gloves", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271475 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268259 },
            { slot = "Legs", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271878 },
            { slot = "Boots", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 237828 },
            { slot = "Ring", item = "[url guide=34264]Altar of Fangs", source = "Unknown", itemId = 273792 },
            { slot = "Ring", item = "[url guide=33183]Voidscar Arena]", source = "Unknown", itemId = 252258 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Type", item = "Buff", source = "Unknown", itemId = nil },
            { slot = "Elemental, Abberation, Demon", item = "[spell=1252486]", source = "Unknown", itemId = nil },
            { slot = "Beast, Mechanical", item = "[spell=1252487]", source = "Unknown", itemId = nil },
            { slot = "Humanoid, Dragonkin", item = "[spell=1252488]", source = "Unknown", itemId = nil },
            { slot = "Undead, Giant, Not Specified", item = "[spell=1252489]", source = "Unknown", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "rider",
            label = "Rider ST",
            importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAwMjZMDDz2MzMTzmZmZMjBAAAAAAAgZGmZAwyMmZ2mZGzMDYzsYYIDMbM0YBAzAAzMjZAmZmxYA",
        },
        {
            provider = "wowhead",
            context = "rider",
            label = "Rider M+/Delves",
            importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmhZMDDz2MzMTzmxMzMjBAAAAAAAgZGzYAwyMmZ2MzYMDYzsZYIDMbM0YBDYGAGzMjZAmZmxYA",
        },
        {
            provider = "wowhead",
            context = "rider",
            label = "Open World",
            importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAwMjZMDDz2MzMTzmZmZMjBAAAAAAAgZGzYAw2MmZ2mZGjZAbmNDDZgZhhGLYAzAAzMjZAmZmxYA",
        },
        {
            provider = "wowhead",
            context = "sanlayn",
            label = "San ST",
            importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAwMjZMDDz2MzMTjZmxYGDAAAAAAAAzDMMGAsMDzsZmxMzYgBmxiGLbA2mYDAzAYmZmZMDmZwMzYA",
        },
        {
            provider = "wowhead",
            context = "sanlayn",
            label = "San AoE",
            importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAwMjZMDDz2MzMTzmZmZMjBAAAAAAAg5BGDDAWmhZ2MzYMjBGYGbassAYZiNMgZAMzMzMmBzMYGjB",
        },
        {
            provider = "archon",
            context = "25.5%",
            label = "Recommended Class Tree",
            importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmZMjZMYWGzMTjZmxMzYAAAAAAAAYmxwAglZMzsZmxMzA2MbGGYgZjhGLYAzAwYmZMDwMzYGD",
        },
        {
            provider = "archon",
            context = "6.0%",
            label = "Alternative Class Tree #1",
            importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmhZMmZYWGzMTjZmxMzYAAAAAAAAYmxwAglZMzsZmxMzA2MbGGYgZjhGLYAzAwYmZMDwMzYGD",
        },
        {
            provider = "archon",
            context = "5.2%",
            label = "Alternative Class Tree #2",
            importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmZMjZMY2GzMTjZmxMzYAAAAAAAAYmxwAglZMzsZmxMzA2MbGGYgZjhGLYAzAwYmZMDwMzYGD",
        },
        {
            provider = "archon",
            context = "4.1%",
            label = "Alternative Class Tree #3",
            importString = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmhZMjBzyMzMTjZmxMzYAAAAAAAAYmxwAglZMzsZmxMzA2MbGGYgZjhGLYAzAwYmZMDwMzYGD",
        },
    },
}

DragonSkillData["DEMONHUNTER"] = DragonSkillData["DEMONHUNTER"] or {}
DragonSkillData["DEMONHUNTER"][577] = {
    scrapedAt = "2026-08-16T09:45:13.085Z",
    statPriority = {
        wowhead = "Fel-Scarred: Agility > Critical Strike > Mastery > Haste > Versatility | Aldrachi Reaver: Agility > Critical Strike > Mastery > Haste > Versatility",
        archon = "Agility > Crit > Mastery > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268209 },
            { slot = "Offhand", item = "[url guide=15942]Crafting/Misc", source = "Unknown", itemId = 237840 },
            { slot = "Head", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271875 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271535 original-item=268246]", source = "[url guide=34248]Vashnik the Malignant", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271540 original-item=239048]", source = "[url guide=34260]King's Rest", itemId = nil },
            { slot = "Wrist", item = "[url guide=15942]Crafting/Misc", source = "Unknown", itemId = 244576 },
            { slot = "Gloves", item = "[url guide=34245]Entombed Sentinels", source = "Unknown", itemId = 271538 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268256 },
            { slot = "Legs", item = "[item=271536 original-item=268225]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Boots", item = "[url guide=34262]Temple of Sethraliss", source = "Unknown", itemId = 159327 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=34262]Temple of Sethraliss", source = "Unknown", itemId = 158366 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "fel",
            label = "Raid",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZGzMzmxMzMmZmMmZAAAAAAAzyDMmtZYmBzMWmZMDzMGzyALzmZMMbaaMzMG2AAAAAAAAYmBDAAAAD",
        },
        {
            provider = "wowhead",
            context = "fel",
            label = "Mythic+",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZGzMz2MmZmxYmMmZAAAAAAAzixsNDzMwMWmZmZYmBzyALzmZMMLaaMzMmxGAAAwAAAAYmBDAAAAD",
        },
        {
            provider = "wowhead",
            context = "fel",
            label = "Delves",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZGzMz2MmZmxYmMmZAAAAAAAzixsNDzMwMWmZmZYmBzyALzmZMMLaaMzMmxGAAAwAAAAYmBDAAAAD",
        },
        {
            provider = "wowhead",
            context = "aldrachi",
            label = "Raid",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYgZmZ2MmZmxMzkxMDAAAAAAYWegxsNDzMz2MzYZmxMWmZYmlZ2mBDjlNmkxMjhFAAAAAAAwMDwAAAAwA",
        },
        {
            provider = "wowhead",
            context = "aldrachi",
            label = "Mythic+",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYGMzMz2MmZmxYmMmZAAAAAAAzixsNDzMz2MzYZmxMMzwMLzsNDGGbbMJjZGzYBAAAAAAAMzAMAAAAM",
        },
        {
            provider = "wowhead",
            context = "aldrachi",
            label = "Delves",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYGMzMz2MmZmxYmMmZAAAAAAAzixsNDzMz2MzYZmxMMzwMLzsNDGGbbMJjZGzYBAAAAAAAMzAMAAAAM",
        },
        {
            provider = "archon",
            context = "59.7%",
            label = "Recommended Class Tree",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZ2mxMzMGzkxMDAAAAAAYWMmtZYmBmx2sNzMjxALDsNbmxwsw0YmZMjNAAAgBAAAwMDGAAAAG",
        },
        {
            provider = "archon",
            context = "8.0%",
            label = "Alternative Class Tree #1",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZ2mxMzMGzkxMDAAAAAAY2MmtZYmBmx2sNzMjxALDsNbmxwsw0YmZMjNAAAgBAAAwMDGAAAAG",
        },
        {
            provider = "archon",
            context = "5.1%",
            label = "Alternative Class Tree #2",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZ2mxMzMmZmMmZAAAAAAAzixsNDzMwM2mtZmZMGYZgtZzMGmFmGzMjhNAAAgBAAAwMDGAAAAG",
        },
        {
            provider = "archon",
            context = "2.5%",
            label = "Alternative Class Tree #3",
            importString = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZWmxMzMGzkxMDAAAAAAYWMmtZYmBmx2sNzMjxALDsNbmxwsw0YmZMjNAAAgBAAAwMDGAAAAG",
        },
    },
}

DragonSkillData["DEMONHUNTER"][581] = {
    scrapedAt = "2026-08-16T09:45:13.541Z",
    statPriority = {
        wowhead = "Aldrachi Reaver: Item Level (Agility+Stamina) > Haste > Crit > Versatility > Mastery | Annihilator: Item Level (Agility+Stamina) > Haste > Crit > Versatility > Mastery",
        archon = "Agility > Haste > Crit > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268209 },
            { slot = "Offhand", item = "Crafted", source = "Unknown", itemId = 237840 },
            { slot = "Head", item = "[item=271537 original-item=271875]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271535 original-item=251223]", source = "[url guide=33183]Voidscar Arena", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 271540 },
            { slot = "Wrist", item = "Crafted", source = "Unknown", itemId = 244576 },
            { slot = "Gloves", item = "[item=271538 original-item=251124]", source = "[url guide=33189]Murder Row", itemId = nil },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268256 },
            { slot = "Legs", item = "[item=271536 original-item=268225]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Boots", item = "[url guide=33190]Den of Nalorakk", source = "Unknown", itemId = 251153 },
            { slot = "Ring", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268252 },
            { slot = "Ring", item = "[url guide=34260]King's Rest", source = "Unknown", itemId = 159459 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Trinket (Raw Damage)", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "aldrachi",
            label = "Raid",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjZmZkZmZY2MzMjhZMzYGzYmZYGmx2MzYMAAAAgZbGMMW2YCDzMjFAAAAMYAIAzMADAAAgB",
        },
        {
            provider = "wowhead",
            context = "aldrachi",
            label = "Mythic+",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjhZkZmBWMjZwMjZGz8AzMzYYmZmx2YGjxMAAAAMbzghxyGTYYmZsAAAAgBGABYmBMDAAAgB",
        },
        {
            provider = "wowhead",
            context = "aldrachi",
            label = "Cleave",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjZmZkZmZYYmZGDzYmxMmxMmxMmZsZmxYAAAAAz2MYYssxEGmZGLAAAAYwAQAmZAGAAAAD",
        },
        {
            provider = "wowhead",
            context = "aldrachi",
            label = "Council",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjZmZkZmZYYmZGDzYmxMmxMmxMmZsZmxYAAAAAz2MYYssxEGmZGLAAAAYwAQAmZAGAAAAD",
        },
        {
            provider = "wowhead",
            context = "aldrachi",
            label = "Delves",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjxMjMzMwmZMDmZMzYmHYGzYMzMzM2GzgxMAAAAMbzghxyGTYYmZsAAAAgBzAIAzMADAAAgB",
        },
        {
            provider = "wowhead",
            context = "annihilator",
            label = "Raid",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjZmZkZmZY2MzMjhZMzYGzYmZYGmx2MzYMAAAAAAAQAzMjNAAAAMYMzMzs02MzMAwAAAAYA",
        },
        {
            provider = "wowhead",
            context = "annihilator",
            label = "Mythic+",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjhZkZmBWMjZwMjZGz8AzMzYYmZmx2YGjxMAAAAAAACYmZsBAAAgBmZmZml2mZmBAzAAAAYA",
        },
        {
            provider = "wowhead",
            context = "annihilator",
            label = "Cleave",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjZmZkZmZYWMzMzMMjZGzYGzYYGmx2MzYMAAAAAAAQAzMjNAAAAMYMzMzs02MzMAwAAAAYA",
        },
        {
            provider = "wowhead",
            context = "annihilator",
            label = "Council",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjZmZkZmZYWMzMzMMjZGzYGzYYGmx2MzYMAAAAAAAQAzMjNAAAAMYMzMzs02MzMAwAAAAYA",
        },
        {
            provider = "wowhead",
            context = "annihilator",
            label = "Delves",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAYMzMjxMjMzMwmZMDmZMzYmHYGzYMzMzM2GzgxMAAAAAAACYmZsBAAAgBzMzMzs02MzMAwAAAAYA",
        },
        {
            provider = "archon",
            context = "15.8%",
            label = "Alternative Class Tree #1",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAMjZmZmhZkZmBziZMDmZMzYmHYmZGDmtZGbPwMz2YYAAAAAAAAYmZsBAAAgBmZmZmt2mZmBAAAAAYA",
        },
        {
            provider = "archon",
            context = "12.5%",
            label = "Alternative Class Tree #2",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAMjZmZmhZkZmBziZMDmZMzYmHYmZGDmtZGbzMz2YYAAAAAAAAYmhNAAAAMwMzMzs12MzMAAAAAAD",
        },
        {
            provider = "archon",
            context = "12.0%",
            label = "Recommended Class Tree",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAWmxMzMGmRmZGMLmxMYmxMjZegZmZMY2mZsZmZbMMAAAAAAAAMzM2AAAAwAzMzMzWbzMzAADAAAgB",
        },
        {
            provider = "archon",
            context = "9.7%",
            label = "Alternative Class Tree #3",
            importString = "CUkAAAAAAAAAAAAAAAAAAAAAAAAMjZmZMMjMzMYWMjZwMjZGz8AzMzYwsNzYzMz2YMDAAAAAAAAzMjNAAAAMwMzMzs12MzMAwAAAAYA",
        },
    },
}

DragonSkillData["DEMONHUNTER"][1480] = {
    scrapedAt = "2026-08-16T09:45:14.033Z",
    statPriority = {
        wowhead = "Annihilator: Intellect > Haste > Mastery > Critical Strike > Versatility | Void-Scarred: Intellect > Haste (until 800/18%-20%) > Critical Strike > Mastery > Versatility > Haste (above 800/18%-20%).",
        archon = "Intellect > Mastery > Haste > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268211 },
            { slot = "Head", item = "[item=271537 original-item=271875]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271535 original-item=251223]", source = "[url guide=33183]Voidscar Arena", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271540 original-item=251159]", source = "[url guide=33190]Den of Nalorakk", itemId = nil },
            { slot = "Wrist", item = "crafted with", source = "[url guide=15942]Crafting/Misc", itemId = 244576 },
            { slot = "Gloves", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271538 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268256 },
            { slot = "Legs", item = "[item=271536 original-item=268225]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Boots", item = "crafted with", source = "[url guide=15942]Crafting/Misc", itemId = 244569 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=34262]Temple of Sethraliss", source = "Unknown", itemId = 158366 },
            { slot = "Trinket", item = "[url guide=33189]Murder Row", source = "Unknown", itemId = 250215 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "void",
            label = "Raid ST",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2MmZmZmZmxwMAAAAAAAegxsNYGAAAAAAAAmxMMmZmZMzMzYmtZGjNttAgAGgZMzMbzMTz2MLzMjZMA",
        },
        {
            provider = "wowhead",
            context = "void",
            label = "Raid Cleave",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWMzMzMzMzMwMAAAAAAAegxsNYGAAAAAAAAmxMMPwMzMzMzMzYmtZGjNttAgAGAjZmZbmZa2mZZmZMmBA",
        },
        {
            provider = "wowhead",
            context = "void",
            label = "Mythic+",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWmZmZmZGjxwMAAAAAAALGz2gZAAAAAAAAYGzw8AzMzMzMzMMz2MjxmsAgAGgZMzMbzMTzyMLzMDzMA",
        },
        {
            provider = "wowhead",
            context = "void",
            label = "Delves",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2MzMzMzMjxwMAAAAAAAmxAmBAAAAAAAgZMDzDMzMzMzMzMmZbmxYTbbAIgBwMzMz2Mz0sNz2MzwMDA",
        },
        {
            provider = "wowhead",
            context = "annihilator",
            label = "Raid ST",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2MmZmZmZmxwMAAAAAAAegxsNYGAAAAAAAAmxMMzMzMjZmZmZmFzYsolFmZmZ2abmZGAzYAIgxghB",
        },
        {
            provider = "wowhead",
            context = "annihilator",
            label = "Raid Cleave",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2MmZmZmZmxwMAAAAAAAegxsNYGAAAAAAAAmxMMzMzMzMzMjZmFzYsolFmZmZ2abmZGAzYAIgxghB",
        },
        {
            provider = "wowhead",
            context = "annihilator",
            label = "Mythic+",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2mxMzMzMzMGmBAAAAAAYxY2GMDAAAAAAAAzYwMzMzMzMzMMziZMW0yCzMzMbtNzMDgZMAEwYwYGA",
        },
        {
            provider = "wowhead",
            context = "annihilator",
            label = "Delves",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2MmZmZmZmxwMAAAAAAAmxAmBAAAAAAAgZMDzDMzMzMzMzwMbmxYR2YmZmZrlZmZAMzMAEYGDGzA",
        },
        {
            provider = "archon",
            context = "37.7%",
            label = "Recommended Class Tree",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2mxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMzMzMzMzMDzsYGjFZhZmZmt2mZmBwwAAwMGMmB",
        },
        {
            provider = "archon",
            context = "28.5%",
            label = "Alternative Class Tree #1",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAA2mxMzMzYmxwMAAAAAAAMmthZGAAAAAAAAmxMMzMzMzMzMDzsYGjFZhZmZmt2mZmBwwAAwMGMmB",
        },
        {
            provider = "archon",
            context = "8.7%",
            label = "Alternative Class Tree #2",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWmxMzMzYmxwMAAAAAAAMmthZGAAAAAAAAmxMMzMzMzMzMDzsYGjFZhZmZmt2mZmBwwAAwMGMmB",
        },
        {
            provider = "archon",
            context = "5.8%",
            label = "Alternative Class Tree #3",
            importString = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWmxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMzMzMzMzMDzsYGjFZhZmZmt2mZmBwwAAwMGMmB",
        },
    },
}

DragonSkillData["DRUID"] = DragonSkillData["DRUID"] or {}
DragonSkillData["DRUID"][102] = {
    scrapedAt = "2026-08-16T09:45:14.570Z",
    statPriority = {
        wowhead = "Keeper of the Grove: Intellect > Mastery > Haste = Critical Strike > Versatility | Elune's Chosen: Intellect > Mastery > Haste > Critical Strike > Versatility",
        archon = "Intellect > Mastery > Haste > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[item=245769 bonus=8791:13771:8960:13751:12497:13836]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Head", item = "[item=271875 bonus=13848:13847:13750]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Neck", item = "[item=268265 bonus=13848:13708]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Shoulders", item = "[item=244572 bonus=8791:13836:13751:13836:9627:8960:12384]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Cloak", item = "[item=268253 bonus=13848:13708]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Chest", item = "[url guide=33190]Den of Nalorakk", source = "Unknown", itemId = 251159 },
            { slot = "Wrist", item = "[item=268240 bonus=13750]", source = "[url guide=34244]Nek'zali the Soulcoiler", itemId = nil },
            { slot = "Gloves", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 268234 },
            { slot = "Belt", item = "[item=268256 bonus=13750:13848:13708]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Legs", item = "[item=268225 bonus=13848:13708]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Boots", item = "[url guide=33190]Den of Nalorakk", source = "Unknown", itemId = 251153 },
            { slot = "Ring", item = "[item=252258 bonus=13750]", source = "[url guide=33183]Voidscar Arena", itemId = nil },
            { slot = "Ring", item = "[item=268249 bonus=13750]", source = "[url guide=34248]Vashnik the Malignant", itemId = nil },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[url guide=34264]Altar of Fangs", source = "Unknown", itemId = 273796 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Spread  while targets are being gathered [span class=tip tooltip=MoonfireAoE][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "8921" },
            { text = "Apply  when all targets are gathered [span class=tip tooltip=MoonfireAoE][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "93402" },
            { text = "Press  if you are not currently in an  and your next cast is either  or", spellId = "205636" },
            { text = "Press  if you just used", spellId = "102560" },
            { text = "Enter  on more than 3 targets with enough [resource=8] to spend at least [color=kyrian]two[/color] stacks of", spellId = "1233272" },
            { text = "Enter  up to and including 3 targets with enough [resource=8] to spend at least [color=kyrian]two[/color] stacks of", spellId = "1233346" },
            { text = "Cast  at the start of  to consume", spellId = "194153" },
            { text = "Cast  to prevent capping on [resource=8] or to consume  at the start of", spellId = "191034" },
            { text = "Cast  outside of  up to and including 4 targets.", spellId = "5176" },
            { text = "Cast  in  and  in", spellId = "194153" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "keeper",
            label = "Raid",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDMmlZmZmBMDWmZbGzYGLsMjZmZMzGGAMALbjFMNzsMCAAAwGzMzMYzAjZAMzAADA",
        },
        {
            provider = "wowhead",
            context = "keeper",
            label = "Mythic+",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNMmZgxsMzMzMLMwDMbzsMWmxMWYZGjxMjFMAYAW2GLYamZZEAAAgNzMPwMD2MmxYGAzMAwA",
        },
        {
            provider = "wowhead",
            context = "keeper",
            label = "Delves",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNMmZgxsMzMzMLMgZZmlx2MmxGLzYmZGmFMAYAW2GLYamZbEAAAgNmZmZwmxMGzAYmBAGA",
        },
        {
            provider = "wowhead",
            context = "elunes",
            label = "Raid",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsMzMzMYYGjZWmhxMWYZmlZGjZ2wAgx2yMDGz2IwEAAAgFzMzMD2MMGzAAYmBLDA",
        },
        {
            provider = "wowhead",
            context = "elunes",
            label = "Mythic+",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNMmZgxsMzMzMLMgxMLzsYmZswyMLjxMjNMAYstNzgxsNCMBAAAYhZmZGsZMjxAAwMDWGA",
        },
        {
            provider = "wowhead",
            context = "elunes",
            label = "Delves",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNMmZgxsMzMzMLMgxMLzsYMzswyMLjxMjNMAYstNzgxsNCMBAAAYhZmZGsZMjxAAwMDWGA",
        },
        {
            provider = "archon",
            context = "46.4%",
            label = "Alternative Class Tree #1",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsYmZmZhBjZZmlZWMzM2YZmlxMjxCGGgx22MDGz2AYCAAAwiZmZmBbGGjBAgZGYA",
        },
        {
            provider = "archon",
            context = "8.9%",
            label = "Alternative Class Tree #2",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsYmZmZhBMLzsMziZmxGLzsMmZMWwwAM22mZwY2GATAAAAWMzMzMYzYGjBAgZGYA",
        },
        {
            provider = "archon",
            context = "6.2%",
            label = "Recommended Class Tree",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsMzMzMLMYMLzsMziZmxGLzsMmZMWwwAM22mZwY2GATAAAAWYmZmBbGGjBAgZGYA",
        },
        {
            provider = "archon",
            context = "3.7%",
            label = "Alternative Class Tree #3",
            importString = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsYmZmZhhZMLzsMziZmxGLzsMmZMWwwAM22mZwY2GATAAAAWYmZmBbGGjBAgZGYA",
        },
    },
}

DragonSkillData["DRUID"][103] = {
    scrapedAt = "2026-08-16T09:45:15.660Z",
    statPriority = {
        wowhead = "Druid of the Claw: Agility > Mastery > Haste > Critical Strike > Versatility | Wildstalker: Agility > Mastery > Critical Strike > Haste > Versatility",
        archon = "Agility > Mastery > Haste > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268215 },
            { slot = "Head", item = "[url guide=33219] Catalyst", source = "Unknown", itemId = 271528 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=33219] Catalyst", source = "Unknown", itemId = 271526 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 271531 },
            { slot = "Wrist", item = "[url guide=15942]Crafting/Misc", source = "Unknown", itemId = 244576 },
            { slot = "Gloves", item = "[url guide=15942]Crafting/Misc", source = "Unknown", itemId = 244575 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268256 },
            { slot = "Legs", item = "[url guide=33219] Catalyst", source = "Unknown", itemId = 271527 },
            { slot = "Boots", item = "[url guide=34250]The Twin Fangs", source = "Unknown", itemId = 268261 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=33183]Voidscar Arena", source = "Unknown", itemId = 252258 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast :[ul]\n        If you have 5 Combo Points,  is missing or in Pandemic, and you have  active.", spellId = "1079" },
            { text = "If you have 5 Combo Points,  is missing or in Pandemic, and  will not be active before the dot expires.", spellId = "1079" },
            { text = "Cast  if:[ul]\n        you have 5 Combo Points and 50 energy,  is active, and  is active.", spellId = "22568" },
            { text = "you have 5 Combo Points and 50 energy,  is active, and  is not active.", spellId = "1079" },
            { text = "and  with , these should be synced", spellId = "106951" },
            { text = "If  is coming off CD within 3 seconds, and you're above 80% energy dump your energy.", spellId = "5217" },
            { text = "Cast  on cooldown", spellId = "5217" },
            { text = "Cast  if:[ul]\n        It is missing on the target or in pandemic", spellId = "1822" },
            { text = "You would increase the snapshot strength.", spellId = nil },
            { text = "has 2 seconds or less of duration and  is not ready.", spellId = "1822" },
            { text = "It is missing on the target or in pandemic", spellId = nil },
            { text = "You would increase the snapshot strength.", spellId = nil },
            { text = "has 2 seconds or less of duration and  is not ready.", spellId = "155625" },
            { text = "to Generate Combo Points", spellId = "5221" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "druid",
            label = "Raid",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAwghxYmZmxsxDsMz2MzMmZGAAAAWCmNYMzomxswMzMGzMDAAAAAAgBAAAQzsMLzMzACsAmZAWMzwAAAYmNMA",
        },
        {
            provider = "wowhead",
            context = "druid",
            label = "Mythic+",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZ2YmZmxY2MPw2YbGzMmZAAAAYLY2MwMzUzYWMzMzsMmxAAAAAAwADAAAgmZZWmZmBEYBmZGgFGMAAAmZDD",
        },
        {
            provider = "wowhead",
            context = "druid",
            label = "Delves",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZ2YmZmxY2MPw2YbGzMmZAAAAYLY2MwMzUzYWMzMzsMmxAAAAAAwADAAAgmZZWmZmBEYBmZGgFGMAAAmZDD",
        },
        {
            provider = "wowhead",
            context = "wildstalker",
            label = "Raid",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAwYMjxYmZMmtFWGbzMzYmZAAAAYJY2gxMjaGzCzMzYMzMAAAAAAAGAAAABAz2MLNLzssBmZAWMzwAAYmBAD",
        },
        {
            provider = "wowhead",
            context = "wildstalker",
            label = "Mythic+",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZ2YmZmxY2MPw2YbGzMmZAAAAYJY2gxMjaGzCzMzsMmZGAAAAAAADAAAgAgZbmlmlZW2AzMALMDDAgZGAMA",
        },
        {
            provider = "wowhead",
            context = "wildstalker",
            label = "Delves",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZ2YmZmxY2MPw2YbGzMmZAAAAYJY2gxMjaGzCzMzsMmZGAAAAAAADAAAgAgZbmlmlZW2AzMALMDDAgZGAMA",
        },
        {
            provider = "archon",
            context = "65.6%",
            label = "Recommended Class Tree",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZMziZmZmxY2M2GbzMzMmZAAAAYJY2M8AmZUzYWMzMzsMmhBAAAAAwADAAAgmZZWmZmBAsAzMDwCDGAAAzshB",
        },
        {
            provider = "archon",
            context = "10.7%",
            label = "Alternative Class Tree #1",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZMziZmZmxY2M2GbzMzMmZAAAAYLY2M8AmZUzYWMzMzsMmhBAAAAAwADAAAgmZZWmZmBAsAzMDwCDGAAAzshB",
        },
        {
            provider = "archon",
            context = "1.5%",
            label = "Alternative Class Tree #2",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZMziZmZmxY2M2GbzMzMmZAAAAYJY2M8AmZUzYWYmZmlxMMAAAAAAGYAAAA0MLzyMzMAgFYmZAWYGGAAAzshB",
        },
        {
            provider = "archon",
            context = "1.4%",
            label = "Alternative Class Tree #3",
            importString = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZMziZmZmxY2M2GbzMzMmZAAAAYJY2M8AmZUzYWGzMzsMmhBAAAAAwADAAAgmZZWmZmBAsAzMDwCDGAAAzshB",
        },
    },
}

DragonSkillData["DRUID"][104] = {
    scrapedAt = "2026-08-16T09:45:16.430Z",
    statPriority = {
        wowhead = "Survivability: Agility > Haste > Versatility > Critical Strike > Mastery | DPS: Agility > Haste > Versatility > Critical Strike > Mastery",
        archon = "Agility > Haste > Mastery > Vers > Crit",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268215 },
            { slot = "Head", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271875 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271526 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271531 },
            { slot = "Wrist", item = "[url guide=34244]Nek'zali the Soulcoiler", source = "Unknown", itemId = 268240 },
            { slot = "Gloves", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271529 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268256 },
            { slot = "Legs", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271527 },
            { slot = "Boots", item = "[url guide=34250]The Twin Fangs", source = "Unknown", itemId = 268261 },
            { slot = "Ring", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268252 },
            { slot = "Ring 2", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket 2", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Maintain  on your primary target.", spellId = "8921" },
            { text = "Maintain 3-5 stacks of .", spellId = "77758" },
            { text = "Cast  on cooldown.", spellId = "1252871" },
            { text = "Cast  on cooldown.", spellId = "33917" },
            { text = "Cast  on cooldown.", spellId = "77758" },
            { text = "Spend Rage on either  (offensively) or (defensively.", spellId = "6807" },
            { text = "Cast  if your health dips low.", spellId = "22842" },
            { text = "Cast  with  procs.", spellId = "8921" },
            { text = "Use your cooldowns / as frequently as possible.", spellId = "22812" },
            { text = "Cast  if you have nothing else to press.", spellId = "213771" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "druid",
            label = "Raid",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmxsMPwYMzmZZGMWGY2gRT0MzsMzMzMGzYGAAAAAwMWmBAAAgamlZZmZGAALYmBYxMYAbW2GAMzGMA",
        },
        {
            provider = "wowhead",
            context = "druid",
            label = "Mythic+",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmxsMmZMziZZGmZZZgZzwoJamZWmZmZmlxMMAAAAAgZsMDAAAA1MLzyMzMAAWwMPAwiZwA2sAAmZDG",
        },
        {
            provider = "wowhead",
            context = "druid",
            label = "Delves",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmxsMmZMziZZGmZZZgZzwoJamZWmZmZmlxMMAAAAAgZsMDAAAA1MLzyMzMAAWwMPAwiZwA2sAAmZDG",
        },
        {
            provider = "wowhead",
            context = "elunes",
            label = "Raid",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmxs4BGjZ2MLzgZZZgZDGNRzMzyMzMzYMjZAAAAAAzYZGwy2MDGz2AYKAAAwGmZAWMDGwmltBYmBwA",
        },
        {
            provider = "wowhead",
            context = "elunes",
            label = "Mythic+",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmxsMPwMjZWMLGmZZZgZzwoJamZWmZmZmlxMAAAAAAMjlZALbzMYMLDgpAAAAbYmBYxMYAbWAYmBwA",
        },
        {
            provider = "wowhead",
            context = "elunes",
            label = "Delves",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMjZWMLGMWGY2MjRT0MzsYmZmxYGGAAAAAwwyMgltZGMmlBwUAAAgNMzDMgFzgBjNLbAmZAMA",
        },
        {
            provider = "archon",
            context = "34.4%",
            label = "Recommended Class Tree",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZmFzMjZWmZxMPwMLLDMbGGNRmZWmZmZmlxMMAAAAAAjNzALbzMYMLDgJAAAgNMzAsYMMwsYBgZGAA",
        },
        {
            provider = "archon",
            context = "6.0%",
            label = "Alternative Class Tree #1",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZmFzMjZWmZxMPwMLLDMbGGNRmZWmZmZmlxMAAAAAAYsZGYZbmBjZZAMBAAAsZMzAsYMMwsYBgZGAA",
        },
        {
            provider = "archon",
            context = "5.4%",
            label = "Alternative Class Tree #2",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZmFzMjZWmZxMPwMLLDMbGGNRmZWmZmZmlxMPAAAAAAAjNzALbzMYMLDgJAAAgNMzAsYMMwsYBgZGAA",
        },
        {
            provider = "archon",
            context = "3.4%",
            label = "Alternative Class Tree #3",
            importString = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZmFzMjZWmZxMPwMLLDMbGGNRmZWmZmZmlxMGAAAAAAjNzALbzMYMLDgJAAAgNMzAsYMMwsYBgZGAA",
        },
    },
}

DragonSkillData["DRUID"][105] = {
    scrapedAt = "2026-08-16T09:45:17.350Z",
    statPriority = {
        wowhead = "Keeper of the Grove: Intellect > Haste > Mastery > Versatility > Critical Strike | Wildstalker: Intellect > Haste > Mastery > Versatility > Critical Strike",
        archon = "Intellect > Haste > Mastery > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Helm", item = "[color=q4][item=271528 original-item=271875][/color]", source = "[icon name=inv_121_raid_achievement_ulatek][/icon][url guide=34252]Ula'tek [i](Raid)[/i] & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Neck", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_twins][/icon][url guide=34250]The Twin Fangs  [i](Raid)[/i]", itemId = 268251 },
            { slot = "Shoulders", item = "[color=q4][/color]", source = "[skill=165]", itemId = 244572 },
            { slot = "Cape", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass][/icon][url guide=34251]The Coiled Alter  [i](Raid)[/i]", itemId = 268253 },
            { slot = "Chest", item = "[color=q4][item=271531 original-item=268235][/color]", source = "[icon name=inv_121_raid_achievement_priestess][/icon][url guide=34244]Nek'zali the Soulcoiler (Raid) & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Bracers", item = "[color=q4][/color]", source = "[skill=165]", itemId = 244576 },
            { slot = "Gloves", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_golems][/icon][url guide=34245]Entomed Sentinels [i](Raid)[/i]", itemId = 271529 },
            { slot = "Belt", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass][/icon][url guide=34251]The Coiled Alter  [i](Raid)[/i]", itemId = 268256 },
            { slot = "Legs", item = "[color=q4][item=271527 original-item=268225][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass][/icon][url guide=34251]The Coiled Alter  [i](Raid)[/i] & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Boots", item = "[color=q4][/color]", source = "[skill=165]", itemId = 244569 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=achievement_boss_elitenagamale][/icon][url guide=34240]Nymrissa Wavebinder [i](Raid)[/i]", itemId = 268266 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_voidscararena][/icon][url guide=33183]Voidscar Arena", itemId = 252258 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=achievement_boss_elitenagamale][/icon][url guide=34240]Nymrissa Wavebinder [i](Raid)[/i]", itemId = 270167 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_priestess][/icon][url guide=34244]Nek'zali the Soulcoiler  [i](Raid)[/i]", itemId = 270162 },
            { slot = "1h Weapon", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_ulatek][/icon][url guide=34252]Ula'tek [i](Raid)[/i]", itemId = 271092 },
            { slot = "Offhand", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_golems][/icon][url guide=34245]Entomed Sentinels  [i](Raid)[/i]", itemId = 268197 },
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Helm", item = "[color=q4][item=271528 original-item=251140][/color]", source = "[icon name=inv_achievement_dungeon_murderrow][/icon][url guide=33189]Murder Row & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Neck", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_murderrow][/icon][url guide=33189]Murder Row", itemId = 251142 },
            { slot = "Shoulders", item = "[color=q4][/color]", source = "[skill=165]", itemId = 244572 },
            { slot = "Cape", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_lightbloom][/icon][url guide=33193]The Blinding Vale", itemId = 251190 },
            { slot = "Chest", item = "[color=q4][item=271531 original-item=251159][/color]", source = "[icon name=inv_achievement_dungeon_proveyourworth][/icon][url guide=33190]Den of Nalorakk & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Bracers", item = "[color=q4][/color]", source = "[skill=165]", itemId = 244576 },
            { slot = "Gloves", item = "[color=q4][item=271529 original-item=159337][/color]", source = "[icon name=achievement_dungeon_templeofsethraliss][/icon][url guide=33272]Temple of Sethraliss & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Belt", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_templeofsethraliss][/icon][url guide=33272]Temple of Sethraliss", itemId = 159317 },
            { slot = "Legs", item = "[color=q4][item=271527 original-item=159313][/color]", source = "[icon name=achievement_dungeon_kingsrest][/icon][url guide=33272]Kings Rest & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Boots", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_proveyourworth][/icon][url guide=33190]Den of Nalorakk", itemId = 251153 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_kingsrest][/icon][url guide=33272]Kings Rest", itemId = 159459 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_voidscararena][/icon][url guide=33183]Voidscar Arena", itemId = 252258 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_lightbloom][/icon][url guide=33193]The Blinding Vale", itemId = 250214 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_murderrow][/icon][url guide=33189]Murder Row", itemId = 250255 },
            { slot = "2h Weapon", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_templeofsethraliss][/icon][url guide=33272]Temple of Sethraliss", itemId = 159636 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "keeper",
            label = "Raid",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMjxMLzMjZmxsNMYmFjNmBAAAAAAAAAAbDa2YMNzY4BMLzMzMDDzAAAAAAAAAbbjFMNzsMAAABswYmZYmBGNDAmZAADA",
        },
        {
            provider = "wowhead",
            context = "keeper",
            label = "Mythic+",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsMjNbzAAAAAAAAAAglBNbGmmZMDmFzMzMLzwYAAAAAAAwA2WGLYamZZAAACYhxMDMzGoZAwMDAYA",
        },
        {
            provider = "wowhead",
            context = "keeper",
            label = "Mythic+",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsNzMgFzsZbGAAAAAAAAAAsNoZzw0MmZMmFzMzMLzwYAAAAAAAwAAQAAAzyMbNLzsYDm5BwMWANDAwMDADA",
        },
        {
            provider = "wowhead",
            context = "wildstalker",
            label = "Raid",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMjxMLzMjZmxsNMYmNjNmBAAAAAAAAAAbDa2YMNzY4BMLzMzMDDzAAAAAAAAAAIAAgZbmlmtZ2sxYmZYmBGNDAwMDADA",
        },
        {
            provider = "wowhead",
            context = "wildstalker",
            label = "Mythic+",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsMjNbzAAAAAAAAAAglBNbGmmZMDmFzMzMLzwDMDAAAAAAAGAACAAY2mZrZbmFbMmZgZWANDAwMDADA",
        },
        {
            provider = "wowhead",
            context = "wildstalker",
            label = "Delves",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsNzMgFzsZbGAAAAAAAAAAsNoZzw0MmZMmFzMzMLzwYAAAAAAAwAAQAAAzyMbNLzsYDm5BwMWANDAwMDADA",
        },
        {
            provider = "archon",
            context = "68.2%",
            label = "Recommended Class Tree",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsNjFbzAAAAAAAAAAgFDNbzw0MAmFzMzMLGGAAAAAMAAzAAAAAgZbmtmtZWsxMzMDmZD0MAAzMAMA",
        },
        {
            provider = "archon",
            context = "3.2%",
            label = "Alternative Class Tree #1",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsNjFbzAAAAAAAAAAgFDNbzw0MAmFmZmZxwMAAAAAMAAzAAAAAgZbmtmtZWsxMzMDmZD0MAAzMAMA",
        },
        {
            provider = "archon",
            context = "3.1%",
            label = "Alternative Class Tree #2",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsNjFbzAAAAAAAAAAgNDNbzw0MAmFzMzMLGGAAAAAMAAzAAAAAgZbmtmtZWsxMzMDmZD0MAAzMAMA",
        },
        {
            provider = "archon",
            context = "1.3%",
            label = "Alternative Class Tree #3",
            importString = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsNjFbzAAAAAAAAAAgFDNbzw0MAmFzMzMLGmBAAAAgBAYGAAAAAMbzs1sNziNGzMDmZD0MAAzMAMA",
        },
    },
}

DragonSkillData["EVOKER"] = DragonSkillData["EVOKER"] or {}
DragonSkillData["EVOKER"][1467] = {
    scrapedAt = "2026-08-16T09:45:18.210Z",
    statPriority = {
        wowhead = "Flameshaper: Intellect > Critical Strike > Mastery > Haste > Versatility | Scalecommander: Intellect > Critical Strike > Mastery > Haste > Versatility",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[item=245769 bonus=13836:9627:13771:8960:8791]", source = "[url guide=15942]Crafting", itemId = nil },
            { slot = "Head", item = "[item=271501 original-item=268230]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271499 original-item=268231]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271504 original-item=271876]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Wrist", item = "[item=244584 bonus=13667:12497:8960:12384:13836:8791]", source = "[url guide=15942]Crafting", itemId = nil },
            { slot = "Gloves", item = "[item=271502 original-item=193752]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Belt", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268254 },
            { slot = "Legs", item = "[item=271500 original-item=268237]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Boots", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268233 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=34262]Temple of Sethraliss", source = "Unknown", itemId = 158366 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[url guide=34240]Nymrissa Wavecaller", source = "Unknown", itemId = 270167 },
            { slot = "Priority", item = "Location", source = "Item/Notes", itemId = nil },
            { slot = "[large][color=necrolord]1[/color][/large]", item = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c13][/icon] [url guide=34252]Ula'tek (Heroic & Mythic)", source = "[color=q6]Most Pieces[/color] [toggler id=\"voidcore-1\"][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=rogue]2[/color][/large]", item = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c13][/icon] [url guide=34251]Coiled Altar (Mythic)", source = "[color=q6]Most Pieces[/color] [toggler id=\"voidcore-2\" hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=druid]3[/color][/large]", item = "[icon name=8039569 inline=true size=small type=round color=c13][/icon] [url guide=34045] Early Mythic Bosses or Dungeons", source = "Depends [toggler id=\"voidcore-3\" hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = ". - [span class=tip tooltip=manuc][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "357210" },
            { text = "Rank 1.", spellId = "359073" },
            { text = "Rank 1.", spellId = "357208" },
            { text = "with   without  if [resource=19] is not capped.  - [span class=tip tooltip=unbound1][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "1292321" },
            { text = "Spend  / [resource=19] to channel  with . - [span class=tip tooltip=scdis][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "369297" },
            { text = "Spend  / [resource=19] to channel . - [span class=tip tooltip=scdis2][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "369297" },
            { text = ".  - [span class=tip tooltip=unbound2][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "1292321" },
            { text = "as filler.", spellId = "361469" },
            { text = "if needed for movement.", spellId = "362969" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "scalecommander",
            label = "Raid",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAjZgZYGzMgBjZamZmpZM2mxMzMzMzMzAmxMGzMLzMDMwYwGsMGN2GQmBBbYgZGMMA",
        },
        {
            provider = "wowhead",
            context = "scalecommander",
            label = "Mythic+",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAjZAPgZGmBGGjZaMzMNjx2MmZmZmZmZGwMzMGzMbzMDMwYwGsMGN2GQmBBbYGMzghB",
        },
        {
            provider = "wowhead",
            context = "scalecommander",
            label = "Delves",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwMjZgZYmhBGGjZaMzMNjxyMmZmZmZmZGwMzYYmZZmZgBYwGsMGN2GQmBBbYgZGMjB",
        },
        {
            provider = "wowhead",
            context = "flameshaper",
            label = "Raid",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZwMDGMgBjZamZmJjxyMzMzwMzMzAmxMzYmZZmZwMwMmB2ALgZYCsFsMMAmZGG",
        },
        {
            provider = "wowhead",
            context = "flameshaper",
            label = "Mythic+",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAjZwMjZGzMwMGDTDzMZM2mZmZGGzMzAmZmxYmZbmZwMwMmBWAbgZYCsFsMMDwMzwA",
        },
        {
            provider = "wowhead",
            context = "flameshaper",
            label = "Delves",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZMDmZMzYmBmxYYaYmJjx2MzMzwYmZGwMzMGzMmZGMDMjZgFwGYGmAbBLDzAMzMMA",
        },
        {
            provider = "archon",
            context = "27.6%",
            label = "Alternative Class Tree #1",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDgZGmBGGjZaMzMNDz2MmZmZmZmZGwMzMGzMLzMDMwYwCsMGN2GAzAwGmBzMYYA",
        },
        {
            provider = "archon",
            context = "23.6%",
            label = "Alternative Class Tree #2",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDgZGmBGGjZaMzMNDz2MmZmZmZmZGwMzMGzMbzMDMwYwCsMGN2GAzAwGmBzMYYA",
        },
        {
            provider = "archon",
            context = "8.7%",
            label = "Alternative Class Tree #3",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDgZGmhxAjHYamZmpZY2mxMzMzMzMzAMzMzYmZbmZgBGDWglxox2AYGA2wAzMYYA",
        },
        {
            provider = "archon",
            context = "0.1%",
            label = "Recommended Class Tree",
            importString = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDgZGmhxwYMTjZmpZY2mxMzMzMzMzAMzMzYmZZMDMwYwCsMGN2GAzAwGGYmBDD",
        },
    },
}

DragonSkillData["EVOKER"][1468] = {
    scrapedAt = "2026-08-16T09:45:19.371Z",
    statPriority = {
        wowhead = "Raid: Intellect > Mastery > Crit > Haste > Versatility | Mythic+: Intellect > Crit [i][/i] > Haste > Mastery > Versatility",
        archon = "Intellect > Mastery > Haste > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Helm", item = "[color=q4][item=271501 original-item=239035][/color]", source = "[icon name=achievement_dungeon_templeofsethraliss][/icon][url guide=33272]Temple of Sethraliss & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Neck", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_ulatek][/icon][url guide=34252]Ula'tek [i](Raid)[/i]", itemId = 268265 },
            { slot = "Shoulders", item = "[color=q4][item=271499 original-item=268231][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass][/icon][url guide=34251]The Coiled Altar [i](Raid)[/i] & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Cape", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass][/icon][url guide=34251]The Coiled Altar [i](Raid)[/i]", itemId = 268253 },
            { slot = "Chest", item = "[color=q4][item=271504 original-item=271876][/color]", source = "[icon name=inv_121_raid_achievement_ulatek][/icon][url guide=34252]Ula'tek [i](Raid)[/i] & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Bracers", item = "[color=q4][/color]", source = "[icon name=achievement_boss_elitenagamale][/icon][url guide=34240]Nymrissa Wavebinder [i](Raid)[/i]", itemId = 268217 },
            { slot = "Gloves", item = "[color=q4][item=271502 original-item=160213][/color]", source = "[icon name=achievement_dungeon_kingsrest][/icon][url guide=33272]Kings Rest & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Belt", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_alchemist][/icon][url guide=34248]Vashnik the Malignant [i](Raid)[/i]", itemId = 268254 },
            { slot = "Legs", item = "[color=q4][item=271500 original-item=268237][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass][/icon][url guide=34251]The Coiled Altar [i](Raid)[/i] & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Boots", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_templeofsethraliss][/icon][url guide=33272]Temple of Sethraliss", itemId = 159388 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_alchemist][/icon][url guide=34248]Vashnik the Malignant [i](Raid)[/i]", itemId = 268249 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_templeofsethraliss][/icon][url guide=33272]Temple of Sethraliss", itemId = 158366 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_tortollans][/icon][url guide=34247]The Lost Explorers [i](Raid)[/i]", itemId = 270164 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_priestess][/icon][url guide=34244]Nek'zali the Soulcoiler [i](Raid)[/i]", itemId = 270162 },
            { slot = "1h Weapon", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_ulatek][/icon][url guide=34252]Ula'tek [i](Raid)[/i]", itemId = 271092 },
            { slot = "Offhand", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_golems][/icon][url guide=34245]Entomed Sentinels [i](Raid)[/i]", itemId = 268197 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "flameshaper",
            label = "Mythic+",
            importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ2WmZGDjxsZGw2wAAAzYmZmZMMTMmBAAAMzMTGzMzMGzAAjZgFwGYGmQ2YsZYGgZGGA",
        },
        {
            provider = "wowhead",
            context = "flameshaper",
            label = "Delves",
            importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ2MwYmZGMzMDbAAAYYMDzYGZmZAAAALzMz0MGzMjZmBAGzAbgNwMMhsxYzwAYmZmB",
        },
        {
            provider = "wowhead",
            context = "chronowarden",
            label = "Raid",
            importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAYmZ2WmHADzMmNjZmZWmxAAAzYGDmxMyMzAAAAMzMTmxMjZbmZAwAjZsxCMwMaoBsAjZGgxA",
        },
        {
            provider = "wowhead",
            context = "chronowarden",
            label = "Mythic+",
            importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAegZmZ2WGYYmxsZGjx2wAAAzYmZmZMMTMmBAAA2mZmJjZmZGjZAAYMjNWgBmRDNMsAzMzAwA",
        },
        {
            provider = "wowhead",
            context = "chronowarden",
            label = "Delves",
            importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ2MwYmZGMzMDbAAAYYMDzYGZmZAAAALzMz0MGzMjZmBAgxM2YDGYGN0gxCMmZAmZA",
        },
        {
            provider = "archon",
            context = "54.0%",
            label = "Alternative Class Tree #1",
            importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAegZmZ2WGYYmxsZGjx2wAAAzYmZmZMMTMmBAAA2mZmJjZmZGjZAAYMjNWgBmhhGGWgZmZAYA",
        },
        {
            provider = "archon",
            context = "4.7%",
            label = "Alternative Class Tree #2",
            importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAegZmZ2WGYYmxsZGjx2AAAYGzMzghZyMzMAAAw2MzMNDzMzsNmBAgxM2YBGYGGaYYBGzMAMA",
        },
        {
            provider = "archon",
            context = "4.2%",
            label = "Alternative Class Tree #3",
            importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAegZmZ2WGYYmxsZGjx2wAAAzYGzMjhZixMAAAw2MzMNjZmZGjZAAYMjNWgBmhhGGWgZmZAYA",
        },
        {
            provider = "archon",
            context = "0.2%",
            label = "Recommended Class Tree",
            importString = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAegZmZ2WGYYmxsZGjx2AAAYGzYGMMTjZmBAAA2mZmpZYmZmlxMAAMmxGLwAzwQDDLwMzMAMA",
        },
    },
}

DragonSkillData["EVOKER"][1473] = {
    scrapedAt = "2026-08-16T09:45:20.481Z",
    statPriority = {
        wowhead = "Chronowarden: Intellect > Mastery > Critical Strike > Haste > Versatility | Scalecommander: Intellect > Mastery > Critical Strike > Haste > Versatility",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[item=245769 bonus=13836:9627:13771:8960:8791]", source = "[url guide=15942]Crafting", itemId = nil },
            { slot = "Head", item = "[item=271501 original-item=239035]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271499 original-item=268231]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271504 original-item=271876]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Wrist", item = "[item=244584 bonus=13667:12497:8960:12384:13836:8791]", source = "[url guide=15942]Crafting", itemId = nil },
            { slot = "Gloves", item = "[item=271502 original-item=193752]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Belt", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268254 },
            { slot = "Legs", item = "[item=271500 original-item=268237]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Boots", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268233 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=34262]Temple of Sethraliss", source = "Unknown", itemId = 158366 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[url guide=33189]Murder Row", source = "Unknown", itemId = 250215 },
            { slot = "Priority", item = "Location", source = "Item/Notes", itemId = nil },
            { slot = "[large][color=necrolord]1[/color][/large]", item = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c7][/icon] [url guide=34252]Ula'tek (Heroic & Mythic)", source = "[color=q6]Most Pieces[/color] [toggler id=\"voidcore-1\"][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=rogue]2[/color][/large]", item = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c7][/icon] [url guide=34251]Coiled Altar (Mythic)", source = "[color=q6]Most Pieces[/color] [toggler id=\"voidcore-2\" hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=druid]3[/color][/large]", item = "[icon name=8039569 inline=true size=small type=round color=c7][/icon] [url guide=34045] Early Mythic Bosses", source = "Depends [toggler id=\"voidcore-3\" hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "chronowarden",
            label = "Raid",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbzMzgZYmZZGzMjZ2AAAAAAAAYmhxMYM1YmZGAAAAMjZMmZWGzMwMMwYGLsADMDDNiFMGzMAwA",
        },
        {
            provider = "wowhead",
            context = "chronowarden",
            label = "Mythic+",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbzMzgZYmZZGzMjZ2AAAAAAAAwMMzAjpGzMzAAAAgZmZMmZ2GzMwMMwYGLsADMDDNiFMmZmBAG",
        },
        {
            provider = "wowhead",
            context = "chronowarden",
            label = "Delves",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbjZmxyMYmlZMzMmBAAAAAAAAmhZGYM1YmZGAAAAMzMjxMzyYmBmZzAjZswCMwMM0IWwYmZGAYA",
        },
        {
            provider = "wowhead",
            context = "scalecommander",
            label = "Raid",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbzMzgZYmZZGzMjZ2AAAAAAAAYmhxMYM1YmZGAAAAMjZMmZWGzMwMMGsALjhx2AYmI2wYgZGAD",
        },
        {
            provider = "wowhead",
            context = "scalecommander",
            label = "Mythic+",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbjZGMDzMLzYmZMzGAAAAAAAAmhZGYM1YmZGAAAAMzMjxMz2YmBmZzYwCsMGGbDgZiYDjZwMDgB",
        },
        {
            provider = "wowhead",
            context = "scalecommander",
            label = "Delves",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbjZmxyMYmlZMzMmBAAAAAAAAmhZGYM1YmZGAAAAMzMjxMzyYmBmZzYwCsMGGbDgZiYDjZwMDgB",
        },
        {
            provider = "archon",
            context = "3.2%",
            label = "Recommended Class Tree",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAgZmZbMzgZYmZZGzMjZ2AAAAAAAAwMMzAjpGzMzAAAAAzMzMmZWGzMwMbzYwCsMGGLDgZQshxMYmBwA",
        },
        {
            provider = "archon",
            context = "3.0%",
            label = "Alternative Class Tree #1",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAgZmZbMzgZYmZZGzMjZ2AAAAAAAAwM8AzYGjpGzMzAAAAAzMjxMzyYmBmZbGDWglxwYZAMDiNMmBzMAG",
        },
        {
            provider = "archon",
            context = "2.9%",
            label = "Alternative Class Tree #2",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAgZmZbMzgZYmZZGzMjZ2AAAAAAAAwM8AzYGjpGzMzAAAAAzMjxMz2YmBmZbGDWglxwYZAMDiNMmBzMAG",
        },
        {
            provider = "archon",
            context = "2.2%",
            label = "Alternative Class Tree #3",
            importString = "CEcBAAAAAAAAAAAAAAAAAAAAAgZmZbMzgZYmZZGzMjZ2AAAAAAAAwMMmBjpGzMzAAAAAzMzMmZWGzMwMbzYwCsMGGLDgZQshxAzMAG",
        },
    },
}

DragonSkillData["HUNTER"] = DragonSkillData["HUNTER"] or {}
DragonSkillData["HUNTER"][253] = {
    scrapedAt = "2026-08-16T09:45:21.285Z",
    statPriority = {
        wowhead = "Pack Leader: Weapon Damage > Agility > Mastery > Critical Strike > Haste > Versatility | Dark Ranger: Weapon Damage > Agility > Critical Strike > Mastery > Haste > Versatility",
        archon = "Agility > Crit > Mastery > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[item=268207 bonus=13848:13708]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Head", item = "[item=271492 ]", source = "[url guide=34250]The Twin Fangs", itemId = nil },
            { slot = "Neck", item = "[item=268265 bonus=13848:13708]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Shoulders", item = "[item=271490 original-item=268231]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271495 original-item=271876 bonus=13848:13708]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Wrist", item = "[item=244584 bonus=13751:12497:13836:12384:8793]", source = "[skill=165]", itemId = nil },
            { slot = "Gloves", item = "[item=271493 original-item=160213]", source = "[url guide=34260]King's Rest", itemId = nil },
            { slot = "Belt", item = "[item=244581 bonus=13751:12497:13836:12384:8793]", source = "[skill=165]", itemId = nil },
            { slot = "Legs", item = "[item=271491 original-item=268237]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Boots", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268233 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[url guide=33183]Voidscar Arena", itemId = 252258 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Trinket (Raid only)", item = "[url guide=34245]Entombed Sentinels", source = "Unknown", itemId = 270165 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast  if  is available in the next 3 seconds or about to reach 2 charges.", spellId = "217200" },
            { text = "Cast .", spellId = "19574" },
            { text = "Cast  if you have a  buff or  active. [span class=tip tooltip=KCsave][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "34026" },
            { text = "Cast  if you have  active.", spellId = "193455" },
            { text = "Cast .", spellId = "217200" },
            { text = "Cast .", spellId = "193455" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "pack",
            label = "Raid",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGGzsMzwMmZMDzMGzMMzYGzwMzYGzghmBAAAAMDAAAzMzMAzsRYYWAbDAD",
        },
        {
            provider = "wowhead",
            context = "pack",
            label = "Mythic+",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsBzwQDbAAYGPwMzsMzwMzMjZGMzYmhZGzMzYbmZYMDLDNDAAAAAAAAmHYMzAmZjAmFw2AwA",
        },
        {
            provider = "wowhead",
            context = "pack",
            label = "Delves",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGPwMzsMzwMzMjZGMzYmhZmZGzwMzwYmhx0MAAAAAAAAYMmBYmNCWmZBsNAM",
        },
        {
            provider = "wowhead",
            context = "dark",
            label = "Raid",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAYzsNwAGwMsBZsAAgZMjZWMDzYmxMMzYYGzMjZMDzMjZMDGaGAAAAwMAAAMzMzgZGQYYWAbDAD",
        },
        {
            provider = "wowhead",
            context = "dark",
            label = "Mythic+",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAYzsNwAGwMsBZsAAgZGzMziZYGmxMjZmZYGzMjZmZsNzMMmhlhmBAAAAMDAAAzDMmZYmBEwsA2GAA",
        },
        {
            provider = "wowhead",
            context = "dark",
            label = "Delves",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAYzsNwAGwMsBZsAAgZGzMziZYGmxMjZmZYGzMzMjZYmZYMzwYaGAAAAwMAAAMGzgZGQwyMLgtBA",
        },
        {
            provider = "archon",
            context = "6.5%",
            label = "Alternative Class Tree #1",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGPwyMzsYGmZmZGzMMzMmhZGzMzYbmZMjZwYaGAAAAAAAAgZMGwMbAwsA2GA",
        },
        {
            provider = "archon",
            context = "6.5%",
            label = "Alternative Class Tree #2",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGPwyMzsYGmZmZGzMMzMmhZGzMzgZGzYGMmmBAAAAAAAAMzYMgZ2AYxsA2GA",
        },
        {
            provider = "archon",
            context = "3.8%",
            label = "Alternative Class Tree #3",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGPwyMzsYGmZmZGzMMzMmhZGzMzYzMjZMDGTzAAAAAAAAAmZMGwMbAwsA2GA",
        },
        {
            provider = "archon",
            context = "1.7%",
            label = "Recommended Class Tree",
            importString = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGPwyMzsYGmZmZGzMMzMmhZGzYGMzYGzgx0MAAAAAAAAgZGzAMzGYjFzCYbAA",
        },
    },
}

DragonSkillData["HUNTER"][254] = {
    scrapedAt = "2026-08-16T09:45:22.366Z",
    statPriority = {
        wowhead = "Sentinel: Agility > Critical Strike > Mastery > Versatility > Haste | Dark Ranger: Agility > Critical Strike > Mastery > Versatility > Haste",
        archon = "Agility > Crit > Mastery > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[item=268207 bonus=12854]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Head", item = "[item=271492 original-item=268230 bonus=12854]", source = "Catalyst the [url guide=34244]Nek'zali the Soulcoiler Head", itemId = nil },
            { slot = "Neck", item = "[item=268265 bonus=12854]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Shoulders", item = "[item=271490 original-item=268231 bonus=12854]", source = "Catalyst the [url guide=34251]The Coiled Altar Shoulders", itemId = nil },
            { slot = "Cloak", item = "[item=268253 bonus=12854]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Chest", item = "[item=271495 original-item=271876 bonus=12854]", source = "Catalyst the [url guide=34252]Ula'tek Chest", itemId = nil },
            { slot = "Wrist", item = "[item=244584 bonus=12214:8960:12497:12066:13622:13667]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Gloves", item = "[item=271493 original-item=193752 bonus=12854]", source = "Catalyst the [url guide=34263]Ruby Life Pools Gloves", itemId = nil },
            { slot = "Belt", item = "[item=244581 bonus=12214:8960:12497:12066:13622:13667]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Legs", item = "[item=271491 original-item=268237 bonus=12854]", source = "Catalyst the [url guide=34251]The Coiled Altar Legs", itemId = nil },
            { slot = "Boots", item = "[item=268233 bonus=12854]", source = "[url guide=34249]Sszorak", itemId = nil },
            { slot = "Ring", item = "[item=251136 bonus=12806]", source = "[url guide=33189]Murder Row", itemId = nil },
            { slot = "Ring", item = "[item=268249 bonus=12854]", source = "[url guide=34248]Vashnik the Malignant", itemId = nil },
            { slot = "Trinket", item = "[item=270175 bonus=12854]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Trinket", item = "[item=270173 bonus=12854]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Priority", item = "Location", source = "Item/Notes", itemId = nil },
            { slot = "[large][color=necrolord]1[/color][/large]", item = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c3][/icon] [url guide=34252]Ula'tek", source = "[color=q6]Most Pieces[/color] [toggler id=VOIDCORE_1][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=rogue]2[/color][/large]", item = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c3][/icon] [url guide=34251]Coiled Altar", source = "[color=q6]Trinket[/color] [toggler id=VOIDCORE_2 hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=druid]3[/color][/large]", item = "[icon name=8039569 inline=true size=small type=round color=c3][/icon] [url guide=34045]Early Mythic Bosses", source = "Depends [toggler id=VOIDCORE_3 hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Trinket Usage. Use on-use trinkets inside . Stat trinkets gain the most from the window, so they take priority when you have to pick one.", spellId = "288613" },
            { text = "Cast  if you have .", spellId = "466932" },
            { text = "Cast  on cooldown. Thanks to , you can cast it twice in a row and should do so.", spellId = "212431" },
            { text = "Cast  on cooldown.", spellId = "260243" },
            { text = "Inside , cast  without a  proc when  is available, or when  is close to capping at 2 charges.", spellId = "288613" },
            { text = "Cast  on cooldown, saving your final use of the fight until  reaches 30 stacks.", spellId = "288613" },
            { text = "Cast  on cooldown, and clip its last tick with . [span class=tip tooltip=RFClipDRST][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "257044" },
            { text = "Cast  on cooldown.", spellId = "392060" },
            { text = "Cast  to spend .", spellId = "185358" },
            { text = "Cast  on cooldown.", spellId = "19434" },
            { text = "Cast .", spellId = "466932" },
            { text = "Cast .", spellId = "56641" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "sentinel",
            label = "Single Target",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAwCMwMGzYZAMD2AAAAAAAAAzYGzssNjZmxM4BMNjBjtlZmZmZmZmZhZWGMDAAYMzMGAz0GDDwGzsNjB",
        },
        {
            provider = "wowhead",
            context = "sentinel",
            label = "Raid AoE/Cleave",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAwCMwMGzYZAMD2AAAAAAAAAzYGzssNjZmxM4BMNjBz2mZmZmZmZmZhZWGmBAAYMzMGAz0GDDwGzsNjB",
        },
        {
            provider = "wowhead",
            context = "sentinel",
            label = "Mythic+",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAwGMwMGzYZAMD2AAAAAAAAAzYmZGbzYmZMDLjpZMYW2WmZmZmZmZmFmZZYGAAAPwYMAMTbgBYjZ2mxA",
        },
        {
            provider = "wowhead",
            context = "sentinel",
            label = "Delves",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAwGMwMGzYZAMD2AAAAAAAAAzYmZGMmZGzMMmGGMLbLzMzMzMzMzCmthZAAAmZMGAmpNsMDwGzsNjB",
        },
        {
            provider = "wowhead",
            context = "dark",
            label = "Single Target",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAmgZYbAzCAAAAAAAAYGzYmltZMzMmBPgpZMYstMzMzMzMzMLMzygBAAYMzMmZmBEGGgNmZbGD",
        },
        {
            provider = "wowhead",
            context = "dark",
            label = "Mythic+",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAmgZYbAzCAAAAAAAAYGzMzYbGzMjZYZMNjBzymZMzMzMzMLMzywMAAAegxYmZmBEwAsxMbzYA",
        },
        {
            provider = "wowhead",
            context = "dark",
            label = "Delves",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAmgZYbAzCAAAAAAAAYGzMzgxMzYmhx0wgZZzMmZmZmZmFMbDzAAAMzYMzMzACWmBYjZ2mxA",
        },
        {
            provider = "archon",
            context = "48.7%",
            label = "Alternative Class Tree #1",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAGwMsEYWAAAAAAAAAmxMzM2MmZGzwyYaGDmlNzMDzMjZmZhZWGmZAAAmxYmZmBMAGgNmZM",
        },
        {
            provider = "archon",
            context = "9.0%",
            label = "Recommended Class Tree",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAGwMsEYWAAAAAAAAAmxMmhZMzMmhlx0MGMLbmZGmZGzMzCzsMMzAAAMjxMzMDYghBYhZGD",
        },
        {
            provider = "archon",
            context = "4.0%",
            label = "Alternative Class Tree #2",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAGwMsEYWAAAAAAAAAmxMzMMjZMmhlx0MGMLbmZGmZGzMzCzsMMzAAAMjxMzMDYghBYhZGD",
        },
        {
            provider = "archon",
            context = "2.4%",
            label = "Alternative Class Tree #3",
            importString = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAGwMsEYWAAAAAAAAAmxMzM2MmZGzgx0MGMLbmZGmZGzMzCzsMMzAAAMjxMzMDYghBYjZGD",
        },
    },
}

DragonSkillData["HUNTER"][255] = {
    scrapedAt = "2026-08-16T09:45:23.909Z",
    statPriority = {
        wowhead = "Pack Leader: Agility > Mastery > Critical Strike and Haste > Versatility | Sentinel: Agility > Mastery > Critical Strike > Haste > Versatility",
        archon = "Agility > Mastery > Crit > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268215 },
            { slot = "Head", item = "[item=271492 original-item=251220] (Catalyzed from [color=q4][/color])", source = "[url guide=34180]Tier Set|[url guide=33183]Voidscar Arena", itemId = 251220 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271490 original-item=268231] (Catalyzed from )", source = "[url guide=34180]Tier Set|[url guide=34251]The Coiled Altar", itemId = 268231 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271876 },
            { slot = "Wrist", item = "[item=244584 bonus=13836:13751:9627:13750:8793:8960:12384]", source = "[url guide=15942]Crafting", itemId = nil },
            { slot = "Gloves", item = "[item=271493 original-item=160213] (Catalyzed from [color=q4][/color])", source = "[url guide=34180]Tier Set|[url guide=34260]King's Rest", itemId = 160213 },
            { slot = "Belt", item = "[item=244581 bonus=13836:13751:9627:13750:8793:8960:12384]", source = "[url guide=15942]Crafting", itemId = nil },
            { slot = "Legs", item = "[item=271491 original-item=268237] (Catalysed from )", source = "[url guide=34180]Tier Set|[url guide=34251]The Coiled Altar", itemId = 268237 },
            { slot = "Boots", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268233 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[url guide=34251]The Coiled Altar", itemId = 273792 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[url guide=33183]Voidscar Arena", itemId = 252258 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast  if it is not yet active. [span class=tip tooltip=Huntersmark][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "257284" },
            { text = "Cast  whenever any of the  beasts are available to summon, without wasting any  stacks. [span class=tip tooltip=Howl][symbol=wow-atlas-quest-wrapper-turnin][/span].", spellId = "259489" },
            { text = "Cast  if you have a  stack to spend.", spellId = "259495" },
            { text = "Cast   if you have a  stack to spend.", spellId = "1261193" },
            { text = "Cast  if you have a  stack to spend.", spellId = "1259003" },
            { text = "Cast  with or without a  to spend.", spellId = "186270" },
            { text = "Cast .", spellId = "259489" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "pack",
            label = "Pre-tier set",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMGWIbwMM0gFjZmxMWGAAAAAAmZmZmhZMmxMYMNDAAAwAgZssMzMLMzMzYmxAmZDAjxMWMAA",
        },
        {
            provider = "wowhead",
            context = "pack",
            label = "Raid",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMGWIbwMM0gFjZmxMWGAAAAAAmZmZmhZMmxMYMNDAAAwAgZssMzMLMzMzYmxAmZDAjxMWMAA",
        },
        {
            provider = "wowhead",
            context = "pack",
            label = "Mythic+",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2ILwMM0gFzMzMzMWGAAAAAAmZmZmhZMmxMYMNDAAAwAgHYssMzYhZmZGzMGwMbAYMmZWMAA",
        },
        {
            provider = "wowhead",
            context = "pack",
            label = "Delves",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2ILwMM0gFzMzMzMWGAAAAAAmZmZmhZMMmZYMNDAAAwAgHYssMzYhZmZGjxAmZDgZMmZWMAA",
        },
        {
            provider = "wowhead",
            context = "sentinel",
            label = "Raid",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMWgBmxoxyAYmgNjZmxMWGAAAAAAmZmZmhZMmxMYMNDAAAwAgZssNzMLMzMzYmxAwM2AjxMWMAA",
        },
        {
            provider = "wowhead",
            context = "sentinel",
            label = "Raid",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMWgBmxoxyAYmgtZMzMGzyAAAAAAwMzMmhZMmxMYMNDAAAwAgZmllZmZBzMzYmxAwMWwixwYxAA",
        },
        {
            provider = "wowhead",
            context = "sentinel",
            label = "Mythic+",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMWgBmxoxyAYmgtZmZmxMz2MAAAAAAmxMzMMjxMmBjpZAAAAGAgltZGLzYmxYMzAwM2wixwMLGAA",
        },
        {
            provider = "wowhead",
            context = "sentinel",
            label = "Mythic+",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMWgBmxoxyAYmgtZmZmxMz2MAAAAAAmxMzMMjxMmBjpZAAAAGAgltZGbzYmxYMzAwM2wixwMLGAA",
        },
        {
            provider = "wowhead",
            context = "sentinel",
            label = "Delves",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMWgBmxoxyAYmgtZmZmZmZ2mBAAAAAwMzMzMMjhxMDjpZAAAAGAgltZGLDzMGjxAwM2gZMMziBA",
        },
        {
            provider = "archon",
            context = "14.7%",
            label = "Alternative Class Tree #1",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2gFYGGawiZmZmZYZAAAAAAwMmZmx2MGzYGMmmBAAAgBAGLLzMziZmZYGjBMzGAMGzMbGA",
        },
        {
            provider = "archon",
            context = "7.6%",
            label = "Alternative Class Tree #2",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2gFYGGawiZmZmZYZAAAAAAwMmZmxyMGzYGMmmBAAAgBAGLLzMziZmZMGzMgZ2AgxYmZzAA",
        },
        {
            provider = "archon",
            context = "5.4%",
            label = "Recommended Class Tree",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2gFYGGawiZmZmZYZAAAAAAwMmxMMjxMmhlx0MAAAAMAwYZZmZWMzMDzYMgZ2AMMGzMbGA",
        },
        {
            provider = "archon",
            context = "4.6%",
            label = "Alternative Class Tree #3",
            importString = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2gFYGGawiZmZmZYZAAAAAAwMmZmx2MGzYGWGTzAAAAwAAjllZmZxMzMYMGwMbAGGjZmNDA",
        },
    },
}

DragonSkillData["MAGE"] = DragonSkillData["MAGE"] or {}
DragonSkillData["MAGE"][62] = {
    scrapedAt = "2026-08-16T09:45:24.388Z",
    statPriority = {
        wowhead = "Spellslinger: Intellect > Haste > Mastery > Critical Strike > Versatility | Sunfury: Intellect > Haste > Versatility > Critical Strike > Mastery",
        archon = "Intellect > Mastery > Haste > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 245769 },
            { slot = "Head", item = "[item=271564 original-item=271874]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271562 original-item=268241]", source = "[url guide=34250]The Twin Fangs", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271567 original-item=273785]", source = "[url guide=34264]Altar of Fangs", itemId = nil },
            { slot = "Wrist", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 239648 },
            { slot = "Gloves", item = "[item=271565 original-item=268243]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Belt", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268257 },
            { slot = "Legs", item = "[item=271563 original-item=268236]", source = "[url guide=34244]Nek'zali the Soulcoiler", itemId = nil },
            { slot = "Boots", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268255 },
            { slot = "Ring", item = "[url guide=34240]Nymrissa Wavecaller", source = "Unknown", itemId = 268266 },
            { slot = "Ring", item = "[url guide=33190]Den of Nalorakk", source = "Unknown", itemId = 251148 },
            { slot = "Trinket", item = "[url guide=33189]Murder Row", source = "Unknown", itemId = 250215 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "spellslinger",
            label = "Raid",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAYGGLzMzswMDamZGAAAGAAEwMzMLLzMxCAAwMzMjNLzMzsMjxYmZwCzYmZGAgBAAYmZBAMDAGmZG",
        },
        {
            provider = "wowhead",
            context = "spellslinger",
            label = "Mythic+",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzQzMGAAAGAAEwMzMLLzMxCAAbDmZG2sMjZMjxMzMzwCzMzMzAAMAAAzMbAADAGmZG",
        },
        {
            provider = "wowhead",
            context = "spellslinger",
            label = "Delves",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzQzMGAAAGAAEwMzMLLzMxCAAbDmZG2sMjZMjxMzMzwCzMzMzAAMAAAzMbAADAGmZG",
        },
        {
            provider = "wowhead",
            context = "sunfury",
            label = "Raid",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAYGGLzMzswMDamZGAAAGAwMz0sssMDAEbAAAmZG2sMjZWmxYmZmZYhZMzMDAwAAAMAzMgZAwwMzA",
        },
        {
            provider = "wowhead",
            context = "sunfury",
            label = "Mythic+",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzQzMGAAAGAwMz0sssMDAEbAAsBzMDbWmxMLzYMzMzMswMzMzMAADAAwAMzAMAYYmZA",
        },
        {
            provider = "wowhead",
            context = "sunfury",
            label = "Delves",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzQzMGAAAGAwMz0sssMDAEbAAsBzMDbWmxMLzYMzMzMswMzMzMAADAAwAMzAMAYYmZA",
        },
        {
            provider = "archon",
            context = "15.2%",
            label = "Alternative Class Tree #1",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFmZGamxAAAwAAAAzMzssMzELAAsNjZmxsZWmZmxMjxwMzMWYmZGzAAMAAAmZBAMDAGG",
        },
        {
            provider = "archon",
            context = "10.7%",
            label = "Alternative Class Tree #2",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzQzMzAAAwAAAAzMzssMzELAAsNjZmxsZWmZmxMjxwMzMWYmZmHYGAgBAAwMLAgZAwwA",
        },
        {
            provider = "archon",
            context = "10.5%",
            label = "Alternative Class Tree #3",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwMLzMzsgZGamxAAAwAAAAzMzssMzELAAsNjZmxsZWmZmxMjxwMzMWYmZmHYGAgBAAwMLAgZAwwA",
        },
        {
            provider = "archon",
            context = "0.9%",
            label = "Recommended Class Tree",
            importString = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzQzMGAAAGAAAYmZmllZmYBAgtZMzMmNzyMzMmZMGmZmxCzMz8AzAAMAAAmZBAmZAwwA",
        },
    },
}

DragonSkillData["MAGE"][63] = {
    scrapedAt = "2026-08-16T09:45:25.830Z",
    statPriority = {
        wowhead = "Sunfury: Intellect > Haste > Mastery > Versatility > Critical Strike | Frostfire: Intellect > Haste > Mastery > Versatility > Critical Strike",
        archon = "Intellect > Haste > Mastery > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 245769 },
            { slot = "Head", item = "[item=271564 original-item=271874]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Neck", item = "[url guide=33189]Murder Row", source = "Unknown", itemId = 251142 },
            { slot = "Shoulders", item = "[item=271562 original-item=268241]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271567 original-item=273785]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Wrist", item = "[url guide=15942]Crafting/Misc", source = "Unknown", itemId = 239648 },
            { slot = "Gloves", item = "[item=271565 original-item=268243]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Belt", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268257 },
            { slot = "Legs", item = "[item=271563 original-item=268236]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Boots", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268255 },
            { slot = "Ring", item = "[url guide=34240]Nymrissa Wavecaller", source = "Unknown", itemId = 268266 },
            { slot = "Ring", item = "[url guide=34260]King's Rest", source = "Unknown", itemId = 159459 },
            { slot = "Trinket", item = "[url guide=34264]Altar of Fangs", source = "Unknown", itemId = 273796 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Priority", item = "Location", source = "Item/Notes", itemId = nil },
            { slot = "[large][color=necrolord]1[/color][/large]", item = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c8][/icon] [url guide=34252]Ula'tek (Heroic & Mythic)", source = "[color=q6]High Risk, High Reward[/color] [toggler id=\"voidcore-1\"][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=rogue]2[/color][/large]", item = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c8][/icon] [url guide=34251]Coiled Altar (Mythic)", source = "[color=q6]Mostly Useful[/color] [toggler id=\"voidcore-2\" hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=druid]3[/color][/large]", item = "[icon name=8039569 inline=true size=small type=round color=c8][/icon] [url guide=34045] Early Mythic Bosses or Dungeons", source = "Safest, but least Impactful [toggler id=\"voidcore-3\" hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[center][large]1[/large][/center]", item = "[icon-badge=273796 quality=3 tooltip=\"Bonus_3_Tooltip\"]", source = "Unknown", itemId = nil },
            { slot = "[center][large]2[/large][/center]", item = "[icon-badge=270164 quality=4 tooltip=\"Bonus_2_Tooltip\"]", source = "Unknown", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "sunfury",
            label = "Raid",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAYGGLzMzswMzIzMzAAAwAAmZmmlttZAA2MzM2mZmZGLAAAAAYxMjZAAgZMmZmZMzsMAMzQGjBMDjB",
        },
        {
            provider = "wowhead",
            context = "sunfury",
            label = "Mythic+",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzIzMzMAAAGAwMz0sstNDAwmZmx2MzMzYDAAAAALmZmZAAgZMmZmZMzsMAMzQYMgZYMA",
        },
        {
            provider = "wowhead",
            context = "sunfury",
            label = "Delves",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwMLzMzsgZGZmxAAAwAAmZmmlltZAA2MzM2GzMzYBAAAAA2MzMzMAAYMDjZmZmZbAYmhwYMYGG",
        },
        {
            provider = "wowhead",
            context = "frostfire",
            label = "Raid",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAYGGLzMzswMzIzMzAAAwMLzYmZZWgAAAWMzw2MzMzYBAAAAALmZMDAAMzwMzMzMzsAMzAyYMGMYMA",
        },
        {
            provider = "wowhead",
            context = "frostfire",
            label = "Mythic+",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzIzMzMAAAmZZGzMLzCEAAwiZG2mZmZGbAAAAAYxMzMDAAMzwMzMzMzsAMzACjxgBjB",
        },
        {
            provider = "wowhead",
            context = "frostfire",
            label = "Delves",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzIzMzAAAwMLzYmZZWgAAAWMzM2mZmZmZDAAAAALmZmZAAgZMmZmZMzsAMzAyYMgBjB",
        },
        {
            provider = "archon",
            context = "20.4%",
            label = "Alternative Class Tree #1",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFegZGZmxAAAwAAmZmmlllZAA2MzM2GzMzYDAAAAAWMzMzMAAYMDjZmZmZbAYmBYMGMDD",
        },
        {
            provider = "archon",
            context = "11.6%",
            label = "Alternative Class Tree #2",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwMLzMzsgZGZmZGAAAGAwMz0sssMDAwmZmx2YmZGbAAAAAwiZmZGAAYMDjZmZmZbAYmBGjxgZYA",
        },
        {
            provider = "archon",
            context = "9.9%",
            label = "Alternative Class Tree #3",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwMLzMzsgZGZmZmBAAwAAmZmmlllZAA2MzM2GzMzYDAAAAA2MzYGAAYMDjZmZmZbAYmBGjxgZYA",
        },
        {
            provider = "archon",
            context = "3.9%",
            label = "Recommended Class Tree",
            importString = "C8DAAAAAAAAAAAAAAAAAAAAAAMzwMLzMzswDMDZmxAAAwAAmZmmlllZAA2MzM2GzMzYDAAAAAWMzMzMAAYMDjZmZmZbAYmBYMGMDD",
        },
    },
}

DragonSkillData["MAGE"][64] = {
    scrapedAt = "2026-08-16T09:45:26.328Z",
    statPriority = {
        wowhead = "Frostfire: Intellect > Mastery > Critical Strike > Haste > Versatility | Spellslinger: Intellect > Mastery > Critical Strike > Haste > Versatility",
        archon = "Intellect > Crit > Mastery > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[url guide=34240]Nymrissa Wavecaller", source = "Unknown", itemId = 268263 },
            { slot = "Head", item = "[item=271564 original-item=271874]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271562 original-item=239031]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271567 original-item=273785]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Wrist", item = "[item=239648 bonus=8791:8960:12214:12384:13668:13751]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Gloves", item = "[item=271565 original-item=268243]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Belt", item = "[item=239649 bonus=8791:8960:12214:12384:13668:13751]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Legs", item = "[item=271563 original-item=159234]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Boots", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268255 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=34262]Temple of Sethraliss", source = "Unknown", itemId = 158366 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[url guide=34240]Nymrissa Wavecaller", source = "Unknown", itemId = 270167 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "if  is active and  is not active - [span class=tip tooltip=THERMAL_VOID_TIP][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "44614" },
            { text = "if  at 2 stacks - [span class=tip tooltip=FOF_CLEAVE_TIP][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "30455" },
            { text = "if  active", spellId = "30455" },
            { text = "if  at 6 or more stacks", spellId = "30455" },
            { text = "if at 3 or fewer", spellId = "205021" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "spellslinger",
            label = "Raid",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAYGGLzMzsMmZmYmZGzMzMziZmZMjZAAAgZmZWWmZaDAAAAAA2AYbZMzMDmthxMsAAAwMbAzEGwMYYA",
        },
        {
            provider = "wowhead",
            context = "spellslinger",
            label = "Mythic+",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzEzMmZmZmZWMzMjZMDAAAMzMzyyMTbAAwCAAAYBgtlxMzMY2GGzwCAAAzsBMTGDYGMMA",
        },
        {
            provider = "wowhead",
            context = "spellslinger",
            label = "Delves",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzEzMmZmZmZWMzMjZMDAAAMzMzyyMTbAAwCAAAYBgtlxMzMY2GGzwCAAAzsBMTGDYGMMA",
        },
        {
            provider = "wowhead",
            context = "frostfire",
            label = "Raid",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAYGGLzMzsMmZmYmxYmZmZWMzMzMzMzsMTzMbzCAAAaBAAAAAAAw2yYmZGMbzYmZstAAAAmZwMZMgBwA",
        },
        {
            provider = "wowhead",
            context = "frostfire",
            label = "Mythic+",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzEzMmZmZmZWMzMzMzMzsMTzMbzCAAAaBAAWAAAAAYbZMzMDmtZMzM2WAAAAzMYmMGwAYA",
        },
        {
            provider = "wowhead",
            context = "frostfire",
            label = "Delves",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzEzMmZmZmZWMzMzMzMzsMTzMbzCAAAaBAAWAAAAAYbZMzMDmtZMzM2WAAAAzMYmMGwAYA",
        },
        {
            provider = "archon",
            context = "22.9%",
            label = "Alternative Class Tree #1",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFmZmYGmZmZmZWMzMMjZAAAgZmZWWmZaDAAWAAAAWAYbbMzMDmthxMjNAAAmZDYGGDYGMA",
        },
        {
            provider = "archon",
            context = "9.0%",
            label = "Alternative Class Tree #2",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmlhZmYmZmZmZmZWMzMMjZAAAgZmZWWmZaDAA2AAAAWAYbZMzMDmthxMjNAAAmZDYGYAzgB",
        },
        {
            provider = "archon",
            context = "6.1%",
            label = "Alternative Class Tree #3",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFmZmYGmZmZmZWMzMMjZAAAgZmZWWmZaDAA2AAAAWAYbbMzMDmthxMjNAAAmZDYGGDYGMA",
        },
        {
            provider = "archon",
            context = "0.9%",
            label = "Recommended Class Tree",
            importString = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzEzMzYmZmZWMzMMjZAAAgZmZWWmZaDAA2AAAAWAYbZMzMzwsNMmZsBAAwMbAzADYGMA",
        },
    },
}

DragonSkillData["MONK"] = DragonSkillData["MONK"] or {}
DragonSkillData["MONK"][268] = {
    scrapedAt = "2026-08-16T09:45:27.707Z",
    statPriority = {
        wowhead = "Shado-Pan: Item Level / Agility / Armor / Stamina > Versatility = Critical Strike = Mastery > Haste | Master of Harmony: Item Level / Agility / Armor / Stamina > Versatility = Critical Strike = Mastery > Haste | Shado-Pan: Item Level / Agility > Critical Strike > Versatility = Mastery > Haste | Master of Harmony: Item Level / Agility > Critical Strike > Versatility = Mastery > Haste",
        archon = "Agility > Crit > Vers > Mastery > Haste",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon (2h)", item = "[item=268215 bonus=13848:13846]", source = "[icon name=inv_121_raid_achievement_ulatek color=c10 inline=true type=round][/icon]Ula'tek", itemId = nil },
            { slot = "Weapons (1h)", item = "[item=268209 bonus=13848]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass color=c10 inline=true type=round][/icon]The Coiled Altar\n    [icon name=inv_121_raid_achievement_brute color=c10 inline=true type=round][/icon]Sszorak", itemId = 268206 },
            { slot = "Head", item = "[item=271519 bonus=13848:13847:10835 original-item=271875]", source = "[url guide=33219]Catalyst|[icon name=inv_121_raid_achievement_ulatek color=c10 inline=true type=round][/icon][url guide=34252]Raid|Vault", itemId = nil },
            { slot = "Neck", item = "[item=268265 bonus=13848:13708:10835]", source = "[icon name=inv_121_raid_achievement_ulatek color=c10 inline=true type=round][/icon]Ula'tek", itemId = nil },
            { slot = "Shoulders", item = "[item=271517 original-item=273774]", source = "[url guide=33219]Catalyst|[icon name=inv_achievement_dungeon_altaroffangs color=c10 inline=true type=round][/icon][url guide=34264]Mythic+|Vault", itemId = nil },
            { slot = "Cloak", item = "[item=268253 bonus=13848]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass color=c10 inline=true type=round][/icon]The Coiled Altar", itemId = nil },
            { slot = "Chest", item = "[item=271522 original-item=251226]", source = "[url guide=33219]Catalyst|[icon name=inv_achievement_dungeon_voidscararena color=c10 inline=true type=round][/icon][url guide=33183]Mythic+|Vault", itemId = nil },
            { slot = "Wrist", item = "[item=244576 bonus=13751:12497:13836:10835:8795:13454]", source = "[icon name=ui_profession_leatherworking color=c10 inline=true type=round][/icon][url guide=33200]Leatherworking", itemId = nil },
            { slot = "Gloves", item = "[item=271520 original-item=193758]", source = "[url guide=33219]Catalyst|[icon name=achievement_dungeon_lifepools color=c10 inline=true type=round][/icon][url guide=17811]Mythic+|Vault", itemId = nil },
            { slot = "Belt", item = "[item=268256 bonus=13848]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass color=c10 inline=true type=round][/icon]The Coiled Altar", itemId = nil },
            { slot = "Legs", item = "[item=271518 bonus=13848 original-item=268225]", source = "[url guide=33219]Catalyst|[icon name=inv_121_raid_achievement_zuljinmalacrass color=c10 inline=true type=round][/icon][url guide=34251]Raid|Vault", itemId = nil },
            { slot = "Boots", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_kingsrest color=c10 inline=true type=round][/icon]Kings' Rest", itemId = 159304 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_proveyourworth color=c10 inline=true type=round][/icon]Den of Nalorakk", itemId = 251148 },
            { slot = "Ring", item = "[item=251513 bonus=13751:12497:13836]", source = "[icon name=ui_profession_jewelcrafting color=c10 inline=true type=round][/icon][url guide=33205]Jewelcrafting", itemId = nil },
            { slot = "Trinket (Damage)", item = "[item=270175 bonus=13848]", source = "[icon name=inv_121_raid_achievement_ulatek color=c10 inline=true type=round][/icon]Ula'tek", itemId = nil },
            { slot = "Trinket (Damage)", item = "[item=270173 bonus=13848]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass color=c10 inline=true type=round][/icon]The Coiled Altar", itemId = nil },
            { slot = "Trinket (Defense)", item = "[icon name=inv_121_raid_achievement_tortollans color=c10 inline=true type=round][/icon]The Lost Explorers", source = "Unknown", itemId = 270160 },
            { slot = "Trinket (Defense)", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_kingsrest color=c10 inline=true type=round][/icon]Kings' Rest", itemId = 159617 },
            { slot = "Priority", item = "Instance/Boss", source = "Item/Notes", itemId = nil },
            { slot = "1", item = "[icon name=inv_121_raid_achievement_ulatek color=c10 inline=true type=round][/icon]Ula'tek", source = "Realistically, every item on Ula'tek's loot table is useful for Brewmasters. This especially includes the weapon and necklace. Although the  is also best-in-slot when received at its elevated item level, a basic Myth-track version will not match the strength of other Myth-track helms featuring more ideal secondary stats.", itemId = 271875 },
            { slot = "2", item = "[icon name=achievement_dungeon_kingsrest inline=true  type=round][/icon][url guide=34260]King's Rest", source = "Of the 12 possible items that can be rolled here, only one () fails to at least be good, if not strong or outright BiS. This includes three tier slots that can be catalyzed, both damage and defensive trinkets, and even one- and two-handed weapons! Consider this your most reliable source of gear if not actively raiding The Venomous Abyss on at least Heroic.", itemId = 159459 },
            { slot = "1", item = "[icon name=inv_121_raid_achievement_zuljinmalacrass color=c10 inline=true type=round][/icon]The Coiled Altar (Mythic)", source = "Most of the items here are only exceptional if you are able to obtain their elevated item level versions from Mythic difficulty. The one exception to this is ; even the very rare  is outclassed by a crafted 2h weapon, by comparison.", itemId = 270173 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Execute an enemy with , when allowed - [span class=tip tooltip=TouchofDeath][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "322109" },
            { text = "Use  to trigger  - [span class=tip tooltip=BlackoutKick][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "100784" },
            { text = "Only if taking minimal damage, activate / - [span class=tip tooltip=BringMeAnother3][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "322507" },
            { text = "Activate  - [span class=tip tooltip=SPMDave][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "132578" },
            { text = "Consume your  buff with  - [span class=tip tooltip=BoCTigerPalm][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "196736" },
            { text = "Use [span display-options=\"rjw\"], ideally with  active beforehand[/span] - [span class=tip tooltip=ExplodingKeg][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "325153" },
            { text = "Use your second charge of", spellId = "121253" },
            { text = "Use  when there are no other abilities to press - [span class=tip tooltip=TigerPalm][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "100780" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "shado",
            label = "Standard Raid",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGPwYWM2mxMDAAAAAAALLYEmBmhxmZMmZmZMzywMmZZYZzy2sNMLAAwGCAAwsNLNzMziZYDgZGmGDAAYA",
        },
        {
            provider = "wowhead",
            context = "shado",
            label = "Mythic+",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAwMLbGDzwyM2MmZMAAAAAAALLgYmBmhBzgZmZGzsNMjZWGW2stNbzYWAAgNEAAgZbWamZmNG2AYmhpxAGAwA",
        },
        {
            provider = "wowhead",
            context = "shado",
            label = "Delves",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZZzYGzwyM2MmZMAAAAAAALLgYmBmhBzgZmZGzsNMjZWGW2ssNbzYWAAgNEAAgZbWamZmFG2AYmhpxAGAwA",
        },
        {
            provider = "wowhead",
            context = "master",
            label = "Standard Raid",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGPwYWM2mxMDAAAAAAALLYEmBmhxmZMmZmZMzywMmZZYZzy2sNMLAAwysMtMbzsMAAQAmhNwMDYaMAAgB",
        },
        {
            provider = "wowhead",
            context = "master",
            label = "Mythic+",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZZzYGzwyM2MmZMAAAAAAALLgYmBmhBzgZmZGzsNMjZWGW2stNbzYWAAglZZaZ2mZZAAgAYYDMzAmGDYAAD",
        },
        {
            provider = "wowhead",
            context = "master",
            label = "Delves",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZZzYGzwyM2MmZMAAAAAAALLgYmBmhBzgZmZGzsNMjZWGW2ssNbzYWAAglZZaZ2mZZAAgAYYDMzAmGDYAAD",
        },
        {
            provider = "archon",
            context = "10.6%",
            label = "Recommended Class Tree",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGGzyMzGzMjBAAAAAAYZBjYmBmhZ2MwMzMDzGzMmZZYZ7BW2mNMLAAwysMtMbzsMAAAAG2AzMgpxAAAG",
        },
        {
            provider = "archon",
            context = "10.1%",
            label = "Alternative Class Tree #1",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGGzyMzGzMjBAAAAAAYZBmYmBmhZ2MwMzMDzGzMmZZYZ7BW2mNMLAAwysMtMbzsMAAAAG2AzMgpxAAAG",
        },
        {
            provider = "archon",
            context = "4.1%",
            label = "Alternative Class Tree #2",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGGzyMzGzMjBAAAAAAYZBjYmBmhxmBmZmZMzGzMmZZYZ7BW2mNMLAAwysMtMbzsMAAAAG2AzMgpxAAAG",
        },
        {
            provider = "archon",
            context = "3.8%",
            label = "Alternative Class Tree #3",
            importString = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGGzyMzGzMjBAAAAAAYZBzEzMwMM2MwMzMDzmtZGjlhltHYZb2wsAAALzy0ysNzyAAAAYYDMzAmGDAAYA",
        },
    },
}

DragonSkillData["MONK"][269] = {
    scrapedAt = "2026-08-16T09:45:28.194Z",
    statPriority = {
        wowhead = "Shado-pan: Agility > Haste > Critical Strike > Mastery > Versatility | Conduit of the Celestials: Agility > Haste > Mastery > Critical Strike > Versatility",
        archon = "Agility > Haste > Crit > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "2H Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268215 },
            { slot = "Head", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271875 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulder", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271517 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34244]Nek'zali the Soulcoiler", source = "Unknown", itemId = 268235 },
            { slot = "Wrist", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 244576 },
            { slot = "Hands", item = "[url guide=33189]Murder Row", source = "Unknown", itemId = 251124 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268256 },
            { slot = "Legs", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268225 },
            { slot = "Feet", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 244569 },
            { slot = "Ring", item = "[url guide=34262]Temple of Sethraliss", source = "Unknown", itemId = 158366 },
            { slot = "Ring", item = "[url guide=33183]Voidscar Arena", source = "Unknown", itemId = 252258 },
            { slot = "Trinket 1", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Trinket 2", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "shado",
            label = "Raid - Single Target",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYM2GmhlZGbzAAAAAAAAAAAAsMMaGzAGwMGmZmZY2GmhZZmAAWMz2MjZmZmBAwGAMLzSzMzsAgBmZAYsMQMgLA",
        },
        {
            provider = "wowhead",
            context = "shado",
            label = "Raid - Cleave",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMYMYbmZ2mxAAAAAAAAAAAALDjwMMMgZMMzMzwsNMDzyMBAsYmtxwYmZAAsBAzys0MzMLADDMzAwYZMEDYA",
        },
        {
            provider = "wowhead",
            context = "shado",
            label = "Mythic+",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYAMGbzMz2MAAAAAAAAAAAALDzEmhhBMjhZmZGmNMDzyMBAsYmtZmxMzMDAgNAYWmlmZmZBgZgZGAYZMEDYA",
        },
        {
            provider = "wowhead",
            context = "shado",
            label = "Delves",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYAMGbzMz2MAAAAAAAAAAAALDzEmhhBMjhZmZGmNMDzyMBAsYmtZmxMzMDAgNAYWmlmZmZBgZgZGAYZMEDYA",
        },
        {
            provider = "wowhead",
            context = "conduit",
            label = "Raid - Single Target",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYM2GmhlZmZbGAAAAAAAAAAAglhRzYGwAmxwMzMDz2wMMLzEAwiZ2mZMjZmBAwiZWmlxEEAAGAzAMWGImZmFXA",
        },
        {
            provider = "wowhead",
            context = "conduit",
            label = "Raid - Cleave",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMgxYZmx2MDAAAAAAAAAAAYZY0MmBMgZMMzMzwsNMDzyMBAsYmtxMGzMDAgFzsMLjJIAghBwMAjlBiZmZzA",
        },
        {
            provider = "wowhead",
            context = "conduit",
            label = "Mythic+",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMgxYZmZ2mBAAAAAAAAAAAYZYEmhhBMjhZmZGmNMDzyMBAswsxMmZmZAAsYmlZZMBBAMzMAmBYsMGiZmZzA",
        },
        {
            provider = "wowhead",
            context = "conduit",
            label = "Delves",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMgxYZmZ2mBAAAAAAAAAAAYZYEmhhBMjhZmZGmNMDzyMBAswsxMmZmZAAsYmlZZMBBAMzMAmBYsMGiZmZzA",
        },
        {
            provider = "archon",
            context = "36.8%",
            label = "Alternative Class Tree #1",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMYMYbmZ2mxAAAAAAAAAAAALDzEmhhBMjhZmZGmthZYWmJAgFzsNGGzMDAgNAYWmlmZmZBYYgZGAYZMgBM",
        },
        {
            provider = "archon",
            context = "6.5%",
            label = "Alternative Class Tree #2",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMYMYbmZ2mxAAAAAAAAAAAALDjmxMMMGMMMzMzwshZYWmJAgFzsNGGzMDAgNAYWmlmZmZBYMDMzAwwAYAD",
        },
        {
            provider = "archon",
            context = "6.4%",
            label = "Alternative Class Tree #3",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMYMYbmZ2mxAAAAAAAAAAAALDzEmhhBMMjZmZGmNMDzyMBAsYmtxwYmZAAsBAzys0MzMLAjZgZGAGLDgBM",
        },
        {
            provider = "archon",
            context = "1.7%",
            label = "Recommended Class Tree",
            importString = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMYMYbmZ2mxAAAAAAAAAAAALDjmxMgBMmZMzYGmNbjhZZmAAWMz2YYMzMAA2AgZZWamZmFgxMwMDAsMAGwA",
        },
    },
}

DragonSkillData["MONK"][270] = {
    scrapedAt = "2026-08-16T09:45:29.322Z",
    statPriority = {
        wowhead = "Raid: Intellect > Haste > Critical Strike > Versatility > Mastery | Mythic+: Intellect > Haste > Mastery > Critical Strike > Versatility",
        archon = "Intellect > Haste > Crit > Vers > Mastery",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Helm", item = "[color=q4][item=271519 original-item=271875][/color]", source = "[icon name=inv_121_raid_achievement_ulatek size=small type=round inline=true color=q4][/icon] [url guide=34252]Ula'tek & [url guide=33219] Catalyst", itemId = nil },
            { slot = "Neck", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_ulatek size=small type=round inline=true color=q4][/icon] [url guide=34252]Ula'tek", itemId = 268265 },
            { slot = "Shoulders", item = "[color=q4][item=271517 original-item=251146][/color]", source = "[icon name=inv_achievement_dungeon_proveyourworth size=small type=round inline=true color=q3][/icon] [url guide=33190]Den of Nalorakk & [url guide=33219] Catalyst", itemId = nil },
            { slot = "Cape", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_lifepools size=small type=round inline=true color=q3][/icon] [url guide=34263]Ruby Life Pools", itemId = 193763 },
            { slot = "Chest", item = "[color=q4][item=271522 original-item=251226][/color]", source = "[icon name=inv_achievement_dungeon_voidscararena size=small type=round inline=true color=q3][/icon] [url guide=33183]Voidscar Arena & [url guide=33219] Catalyst", itemId = nil },
            { slot = "Bracers", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_murderrow size=small type=round inline=true color=q3][/icon] [url guide=33189]Murder Row", itemId = 251135 },
            { slot = "Gloves", item = "[color=q4][item=271520 original-item=251124][/color]", source = "[icon name=inv_achievement_dungeon_murderrow size=small type=round inline=true color=q3][/icon] [url guide=33189]Murder Row & [url guide=33219] Catalyst", itemId = nil },
            { slot = "Belt", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_lightbloom size=small type=round inline=true color=q3][/icon] [url guide=33193]The Blinding Vale", itemId = 251189 },
            { slot = "Legs", item = "[color=q4][item=271518 original-item=159313][/color]", source = "[icon name=achievement_dungeon_kingsrest size=small type=round inline=true color=q3][/icon] [url guide=34260]Kings' Rest & [url guide=33219] Catalyst", itemId = nil },
            { slot = "Boots", item = "[color=q4][/color]", source = "[icon name=achievement_boss_elitenagamale size=small type=round inline=true color=q4][/icon] [url guide=34240]Nymrissa Wavebinder", itemId = 268247 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=achievement_boss_elitenagamale size=small type=round inline=true color=q4][/icon] [url guide=34240]Nymrissa Wavebinder", itemId = 268266 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_kingsrest size=small type=round inline=true color=q3][/icon] [url guide=34260]Kings' Rest", itemId = 159459 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=achievement_boss_elitenagamale size=small type=round inline=true color=q4][/icon] [url guide=34240]Nymrissa Wavebinder", itemId = 270167 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_priestess size=small type=round inline=true color=q4][/icon] [url guide=34244]Nek'zali the Soulcoiler", itemId = 270162 },
            { slot = "1h Weapon", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass size=small type=round inline=true color=q4][/icon] [url guide=34251]The Coiled Altar", itemId = 268211 },
            { slot = "Offhand", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_kingsrest size=small type=round inline=true color=q3][/icon] [url guide=34260]Kings' Rest", itemId = 159667 },
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Helm", item = "[color=q4][item=271519 original-item=271875][/color]", source = "[icon name=inv_121_raid_achievement_ulatek size=small type=round inline=true color=q4][/icon] [url guide=34252]Ula'tek & [url guide=33219] Catalyst", itemId = nil },
            { slot = "Neck", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_ulatek size=small type=round inline=true color=q4][/icon] [url guide=34252]Ula'tek", itemId = 268265 },
            { slot = "Shoulders", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_tortollans size=small type=round inline=true color=q4][/icon] [url guide=34247]The Lost Explorers", itemId = 271517 },
            { slot = "Cape", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass size=small type=round inline=true color=q4][/icon] [url guide=34251]The Coiled Altar", itemId = 268253 },
            { slot = "Chest", item = "[color=q4][item=271522 original-item=268235][/color]", source = "[icon name=inv_121_raid_achievement_priestess size=small type=round inline=true color=q4][/icon] [url guide=34244]Nek'zali the Soulcoiler & [url guide=33219] Catalyst", itemId = nil },
            { slot = "Bracers", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_murderrow size=small type=round inline=true color=q3][/icon] [url guide=33189]Murder Row", itemId = 251135 },
            { slot = "Gloves", item = "[color=q4][item=271520 original-item=251124][/color]", source = "[icon name=inv_achievement_dungeon_murderrow size=small type=round inline=true color=q3][/icon] [url guide=33189]Murder Row & [url guide=33219] Catalyst", itemId = nil },
            { slot = "Belt", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass size=small type=round inline=true color=q4][/icon] [url guide=34251]The Coiled Altar", itemId = 268256 },
            { slot = "Legs", item = "[color=q4][item=271518 original-item=268225][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass size=small type=round inline=true color=q4][/icon] [url guide=34251]The Coiled Altar & [url guide=33219] Catalyst", itemId = nil },
            { slot = "Boots", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_proveyourworth size=small type=round inline=true color=q3][/icon] [url guide=33190]Den of Nalorakk", itemId = 251153 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=achievement_boss_elitenagamale size=small type=round inline=true color=q4][/icon] [url guide=34240]Nymrissa Wavebinder", itemId = 268266 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_voidscararena size=small type=round inline=true color=q3][/icon] [url guide=33183]Voidscar Arena", itemId = 252258 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=achievement_boss_elitenagamale size=small type=round inline=true color=q4][/icon] [url guide=34240]Nymrissa Wavebinder", itemId = 270167 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_priestess size=small type=round inline=true color=q4][/icon] [url guide=34244]Nek'zali the Soulcoiler", itemId = 270162 },
            { slot = "1h Weapon", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass size=small type=round inline=true color=q4][/icon] [url guide=34251]The Coiled Altar", itemId = 268211 },
            { slot = "Offhand", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_golems size=small type=round inline=true color=q4][/icon] [url guide=34245]Entomed Sentinels", itemId = 268197 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "conduit",
            label = "Raid",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghx2YZYzixMzyyM2wYGmZZZbmxCzoZMDYwgxYmZmhZbMGsYCAAAAgAsYZmlZbmBAAGwAMDYMMWkxMA",
        },
        {
            provider = "wowhead",
            context = "conduit",
            label = "Mythic+",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghxyMLjZx2MmZsZsZZGzs9AzstsMzYhhmxMgBDYWmZmZY2wMMLzEAAAAABYx2Mbz2MDAAMAAzAGDsIjZA",
        },
        {
            provider = "wowhead",
            context = "conduit",
            label = "Delves",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMWmZZML2mxMjNDYMzmZ222mZswQzYGLYwAGzMzMMbDzwsMTAAAAAEgFbzsNbzMAAAwAMDYMMDZMDA",
        },
        {
            provider = "wowhead",
            context = "master",
            label = "Raid",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghx2YZYzixMzyyM2wYGmZZZbmxCzoZMDYwgxYmZmhZbMGsYCAAAAMLTLz2MLzGAAAADYmZAgxwYRGA",
        },
        {
            provider = "wowhead",
            context = "master",
            label = "Mythic+",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghxyMLjZx2MmZsZsZZGzs9AzstsMzYhhmxMgBDYWmZmZY2wMMLzEAAAAYWm2mtZWmNAAAAGgZGAYMwiMAA",
        },
        {
            provider = "wowhead",
            context = "master",
            label = "Delves",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMWmZZML2mxMjNDYMzmZ222mZswQzYGLYwAGzMzMMbDzwsMTAAAAgZZab2mZZ2AAAAAYmZAgxwMkBA",
        },
        {
            provider = "archon",
            context = "13.6%",
            label = "Alternative Class Tree #1",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghxyMLjZx2MmZsZstsMjZ2Mz2yyMjFmRzYGwYMAmZmZY2wMMLzEAAAAAAsYbmlZbmBAAGAgZAjBWkxMA",
        },
        {
            provider = "archon",
            context = "6.9%",
            label = "Alternative Class Tree #2",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMWmZZML2mxMjNjtllZMzmZ2WWmZswQzYGwgBjZZmZmhZDzwsMTAAAAAAwitZWmtZGAAYAAmBMGYRGzA",
        },
        {
            provider = "archon",
            context = "3.8%",
            label = "Recommended Class Tree",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghxyMLjZx2MmZsZstsMjZ2Mz2yyMjFmRzYGwgBwMzMDzGmhZZmAAAAAAgFbzsMbzMAAwgBgZAjBWkxMA",
        },
        {
            provider = "archon",
            context = "3.2%",
            label = "Alternative Class Tree #3",
            importString = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghxyMLjZx2MmZsZstsMjZ2Mz2yyMjFmRzYGwYMAmZmZY2ghZZmAAAAAAgFbzsMbzMAAwgBgZAjBWkxMA",
        },
    },
}

DragonSkillData["PALADIN"] = DragonSkillData["PALADIN"] or {}
DragonSkillData["PALADIN"][65] = {
    scrapedAt = "2026-08-16T09:45:30.082Z",
    statPriority = {
        wowhead = "Herald of the Sun: Intellect > Mastery > Haste = Crit > Versatility | Lightsmith: Intellect > Mastery > Haste = Crit > Versatility",
        archon = "Intellect > Haste > Mastery > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268211 },
            { slot = "Shield", item = "[url guide=34240]Nymrissa Wavecaller", source = "Unknown", itemId = 268262 },
            { slot = "Head", item = "[item=271465 original-item=268229]", source = "[url guide=34244]Nek'zali the Soulcoiler", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271463 original-item=251138]", source = "[url guide=33189]Murder Row", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271468 original-item=268222]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Wrist", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 268239 },
            { slot = "Gloves", item = "[url guide=34245]Entombed Sentinels", source = "Unknown", itemId = 271466 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268259 },
            { slot = "Legs", item = "[item=271464 original-item=271878]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Boots", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268260 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=33183]Voidscar Arena", source = "Unknown", itemId = 252258 },
            { slot = "Trinket", item = "[url guide=34244]Nek'zali the Soulcoiler", source = "Unknown", itemId = 270162 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "[center][large]1[/large][/center]", item = "[url guide=34252]Ula'tek - Until you get to Mythic Ula'tek, your top priority is to get the two cantrip items on Myth track by bonus rolling Heroic.\n\nThere are only two items on our loot table,  and , and we want both of them.", source = "Unknown", itemId = 268265 },
            { slot = "[center][large]2[/large][/center]", item = "[url guide=34247]The Lost Explorers - These Turtles have an excellent loot table for us, including weapon, shield, and a decent trinket.", source = "Unknown", itemId = nil },
            { slot = "[center][large]3[/large][/center]", item = "[url guide=34244]Nek'zali the Soulcoiler - I recommend bonus rolling this boss until you get .", source = "Unknown", itemId = 270162 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "herald",
            label = "Raid",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAAw2MzMjZMzYxYmZYZwMLmpJGGzMDjZLDADYYDsxyMmZZ2mZmtGAAAgFAYzwYGzwMAAmZYGjRDA",
        },
        {
            provider = "wowhead",
            context = "herald",
            label = "Raid",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAAwyMzMjZ2mZmNYMsM2MziZaihxMzwY2yAwAG2AbsMjZWmtZmZrBAAAYBA2MMmxMMDAgZGmxY0A",
        },
        {
            provider = "wowhead",
            context = "herald",
            label = "Mythic+",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAAD2GzMzMjZmZBmZYZsZmFjmYYMzMMmtMAMAsB2YZmZmlZbmZ2aAAAAWAmhNDMjZYGAAzMMjxoB",
        },
        {
            provider = "wowhead",
            context = "herald",
            label = "Mythic+",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAADWGzMzMjZmZBGDLzsZmFjmYYMzMMmtMAMAsB2YZmZmlZbmZ2aAAAAWAmhNDMjZwAAYmhZMGNA",
        },
        {
            provider = "wowhead",
            context = "herald",
            label = "Delves",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAADMmZmZGzMzixMmxyYzMLGNxYGjZYMbZAYAYDsxyMzMLz2Mzs1AAAAsAMDbGYGzwAAwMDzYMaA",
        },
        {
            provider = "wowhead",
            context = "lightsmith",
            label = "Raid",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAbAwMAAw2MzMjZMzYxYmZYZwMLmpJGGzMDjZLDADYYDsxyMGAEAwMzyyitZG2AgNDjZMDzAYmBgZMGNA",
        },
        {
            provider = "wowhead",
            context = "lightsmith",
            label = "Raid",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAAwyMzMjZMzMbGzYYZsZmFz0EDjZmhxslBgBMsB2YZGDACAYmZZZx2MDbAwmhxMmhBgZGAmxY0A",
        },
        {
            provider = "wowhead",
            context = "lightsmith",
            label = "Mythic+",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAbAwMAAD2GzMzMjZmZBmZYZsZmFjmYYMzMMmtMAMAsB2YZmZAQAAzMLLL2mZYDYG2MwMmhZAMzAwMGjGA",
        },
        {
            provider = "wowhead",
            context = "lightsmith",
            label = "Mythic+",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAADWGzMzMjZmZZwYYZsZmFz0EDjZmhxslBgBgNwGLzMDACAYmZZZx2MDbAzwmBmxMMAMzAwMGjGA",
        },
        {
            provider = "wowhead",
            context = "lightsmith",
            label = "Delves",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAALAwMAADMmZmZGzMzixMmxyYzMLGNxwYMDjZLDADAbgNWmZGAEAwMz22ilZG2AzMsZgZYYAYmBgZMGNA",
        },
        {
            provider = "archon",
            context = "35.7%",
            label = "Alternative Class Tree #1",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYBAMDAwglxMzMzYmZWgxwyYbmZxMNxwYmZYY2yAwAwGYjlZmZWmtZmZrBAAAYhNMYzAzYGAAwMDzYMMA",
        },
        {
            provider = "archon",
            context = "19.8%",
            label = "Alternative Class Tree #2",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYBAMDAwglxMzMzYmZWgxwyYbmZxMNxwYmZYY2yAwAwGYjtZmZWmtZmZrBAAAYhNMYzAzYGAAwMDzYMMA",
        },
        {
            provider = "archon",
            context = "6.1%",
            label = "Alternative Class Tree #3",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAMLAgZAAglxMzMzYmZWgxwyYbmZxMNxsMjZmhhZLDADAbgNWmZmZZ2mZmtGAAAgF2YGsBMMAAAzMMjxwA",
        },
        {
            provider = "archon",
            context = "1.3%",
            label = "Recommended Class Tree",
            importString = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYBAMDAAsMmZmZGzMzCMGWGbzMLmpJmlZMzMMMbZAYAYDsx2MzMLz2Mzs1AAAAswGPAsZgZYAAAzMMjxwA",
        },
    },
}

DragonSkillData["PALADIN"][66] = {
    scrapedAt = "2026-08-16T09:45:30.649Z",
    statPriority = {
        wowhead = "Survivability: Strength > Haste > Mastery > Critical Strike > Versatility | DPS: Strength > Haste > Critical Strike > Mastery > Versatility",
        archon = "Strength > Haste > Crit > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268209 },
            { slot = "Shield", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 268196 },
            { slot = "Head", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271465 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271463 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271468 },
            { slot = "Wrist", item = "[url guide=15942]Crafting Blacksmithing", source = "Unknown", itemId = 237834 },
            { slot = "Gloves", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271466 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268259 },
            { slot = "Legs", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271878 },
            { slot = "Boots", item = "[url guide=15942]Crafting Blacksmithing", source = "Unknown", itemId = 237828 },
            { slot = "Ring", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268252 },
            { slot = "Ring 2", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket 2", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast  on cooldown.", spellId = "31884" },
            { text = "Cast  on cooldown.", spellId = "275779" },
            { text = "Cast  when you have 3-5 Holy Power or if it's free. Try not to cap Holy Power.", spellId = "53600" },
            { text = "Cast  on cooldown.", spellId = "31935" },
            { text = "if you have 0 Holy Power. Try to use this on cooldown as much as possible.", spellId = "375576" },
            { text = "/ on cooldown.", spellId = "204019" },
            { text = "if your health drops below 50% or to top yourself off if you are in danger of a big hit.", spellId = "85673" },
            { text = "as a filler.", spellId = "26573" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "templar",
            label = "Raid",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNzYWmZYGzM2WGDLzithBAYAAAAAAQamZxMmZGjZrNAMgBMYbAAgZm2mZWmBAYzyGzYAMmhxAAsNDwMDyYD",
        },
        {
            provider = "wowhead",
            context = "templar",
            label = "Mythic+",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsZeAzyYGzYmZWWGjZZWmlZMAADAAAAAAaamhZMzwY2aDADMgZw2AAAzMtNzsMDAwmlFMAgZYMAALzAmZGkxC",
        },
        {
            provider = "wowhead",
            context = "templar",
            label = "Delves",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsZeAzyYGzYmZWWGjZZWmlZMAADAAAAAAaamhZMzwY2aDADMgZw2AAAzMtNzsMDAwmlFMAgZYMAALzAmZGkxC",
        },
        {
            provider = "wowhead",
            context = "lightsmith",
            label = "Raid",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNzYWmZYGzM2WGDLzithBAYAAAAAAQamZxMmZGjZrNAMgBMYbAAAEgZmttlWmZsYZjZMAGzwYAwMDAmZQGb",
        },
        {
            provider = "wowhead",
            context = "lightsmith",
            label = "Mythic+",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsZeAzyYGzYmZWWGjZZWmlZMAADAAAAAAaamhZMzwY2aDADMgZw2AAAIAzMbbLtMzYxyCGAwMMGAMzAwMzgMWA",
        },
        {
            provider = "wowhead",
            context = "lightsmith",
            label = "Delves",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsZeAzyYGzYmZWWGjZZWmlZMAADAAAAAAaamhZMzwY2aDADMgZw2AAAIAzMbbLtMzYxyCGAwMMGAMzAwMzgMWA",
        },
        {
            provider = "archon",
            context = "26.9%",
            label = "Recommended Class Tree",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNjBzyYbMjZmZZZMzwsMLzYAAGAAAAAA00MzyMjZGGegt2AwADYGsBAAAAzMLbLtMzYxMYAMYGGDAmZAwMDYA",
        },
        {
            provider = "archon",
            context = "9.6%",
            label = "Alternative Class Tree #1",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNjBzyYbMjZmZZZMzwsMLDDAwAAAAAAgmmZWmZMDGmt2AwADYGsBAAAAzMLbLtMzYxMYAMGzwYAwMDAmZAD",
        },
        {
            provider = "archon",
            context = "9.4%",
            label = "Alternative Class Tree #2",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNjBzyYbMjZmZZZMzwsMLzYAAGAAAAAA00MzyMjZwws1GAGYAzgNAAAAYmZZbplZGLmBDgBzwYAwMDAmZAD",
        },
        {
            provider = "archon",
            context = "5.3%",
            label = "Alternative Class Tree #3",
            importString = "CIEAAAAAAAAAAAAAAAAAAAAAAsNjBzyYbMjZmZZZMzwsMLzYAAGAAAAAA00MzyMjZGGmt2AwADYGsBAAAAzMLbLtMzYxMYAAzwYAwMDAmZAD",
        },
    },
}

DragonSkillData["PALADIN"][70] = {
    scrapedAt = "2026-08-16T09:45:31.564Z",
    statPriority = {
        wowhead = "Templar: Strength > Mastery > Haste > Critical Strike > Versatility | Herald of the Sun: Strength > Mastery > Haste > Critical Strike > Versatility",
        archon = "Strength > Mastery > Crit > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[item=268213 bonus=13848]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Head", item = "[item=271465 original-item=268229 bonus=12854]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Neck", item = "[item=268265 bonus=13848:13708]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Shoulders", item = "[item=271463 original-item=251138 bonus=12854]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Cloak", item = "[item=268253 bonus=13848]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Chest", item = "[item=271468 original-item=268222 bonus=13848]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Wrist", item = "[item=237834 bonus=13751:12497:13836:8790:13454]", source = "[url guide=15942]Blacksmithing", itemId = nil },
            { slot = "Gloves", item = "[item=271466 original-item=251214 bonus=12854]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Belt", item = "[item=268259 bonus=13848]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Legs", item = "[item=271464 original-item=271878 bonus=13848:13846]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Boots", item = "[item=268260 bonus=12854]", source = "[url guide=34248]Vashnik the Malignant", itemId = nil },
            { slot = "Ring", item = "[item=252258 bonus=12854]", source = "[url guide=33183]Voidscar Arena", itemId = nil },
            { slot = "Ring", item = "[item=251513 bonus=13751:12497:13836]", source = "[url guide=15942]Jewelcrafting", itemId = nil },
            { slot = "Trinket", item = "[item=270173 bonus=13848]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Trinket", item = "[item=270175 bonus=13848]", source = "[url guide=34252]Ula'tek", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast", spellId = "31884" },
            { text = "Cast", spellId = "343527" },
            { text = "Cast  if it's castable after using", spellId = "427453" },
            { text = "Cast  with a  proc in any one of the following situations:\n			[ul] or  is up, but will end within a few seconds", spellId = "427453" },
            { text = "You don't have the Haste buff from  up, and  won't come off cooldown for at least 5 seconds", spellId = "432626" },
            { text = "The proc will expire soon, or your target will die soon", spellId = nil },
            { text = "Cast  with 5 Holy Power", spellId = "383328" },
            { text = "Cast", spellId = "255937" },
            { text = "Cast", spellId = "375576" },
            { text = "Cast  with 2 stacks of", spellId = "184575" },
            { text = "Cast", spellId = "383328" },
            { text = "Cast", spellId = "184575" },
            { text = "Cast", spellId = "24275" },
            { text = "Cast", spellId = "20271" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "templar",
            label = "Raid",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAANbbzMzywMDAAAAAAzUGzwMjtxsNMz2MGjZGmxCbDAAIzMtNzsNDAYDwAgxMMDmxY2w2MYYMjBD",
        },
        {
            provider = "wowhead",
            context = "templar",
            label = "Mythic+",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAwoZbbmZWGzMzAAAAAAYmyYGmZsNmthZ2mxYMGmxGbAAAZmptZmtZAAbAGAMmhBmxMzGWmBDjZMYA",
        },
        {
            provider = "wowhead",
            context = "templar",
            label = "Delves",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAwoZbbmZWGjZmBAAAAAYmyYGMjtZmthZ2mxYMzwM2YDAAIzMtNzsNDAYDwAAmhBmxM2wyMYMjZMYA",
        },
        {
            provider = "wowhead",
            context = "herald",
            label = "Raid",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAANbbzMzywMDAAAAAAzUGzwMjtxsNMz2MGjxwMWYbAYWmtZmZrBBAAsAYAwYGmBzYmZDYmZYMjBD",
        },
        {
            provider = "wowhead",
            context = "herald",
            label = "Mythic+",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAwoZbbmZWGzMzAAAAAAYmyYGmZsNmthZ2mxYMGmxCbAYWmtZmZrBBAAsAYAwYGGYGzMbAzMDjZMYA",
        },
        {
            provider = "wowhead",
            context = "herald",
            label = "Delves",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAwoZbbmZWGjZmBAAAAAYmyYGMjtZmthZ2mxYMzwMWYDAzysNzMbNIAAgFADAYGGYGzYDYmZMjZMYA",
        },
        {
            provider = "archon",
            context = "23.0%",
            label = "Recommended Class Tree",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAAMa22mZmlxYmBAAAAAwMlZZGmZsNMbDzsNjxYMMjN2AAAYmptZmtZAAbAGAMmhBmZmZ2wyMYYMMYA",
        },
        {
            provider = "archon",
            context = "7.6%",
            label = "Alternative Class Tree #1",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAAMa22mZmlxYmBAAAAAwMlxMMzYbY2GmZbGjxYYGbsBAAwMTbzMbzAA2AMAYMDDMzMzshlZwwYGDG",
        },
        {
            provider = "archon",
            context = "7.1%",
            label = "Alternative Class Tree #2",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQz22MzsMGzMAAAAAAmpMLzwMjthZbYmtZMGjhZsxGAAAzMtNzsNDAYDwAgxMMwMzMzGWmBDjZMYA",
        },
        {
            provider = "archon",
            context = "3.7%",
            label = "Alternative Class Tree #3",
            importString = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAAMa22mZmlxwMAAAAAAmpMLzwMjthZbYmtZMGjhZsxGAAAzMtNzsNDAYDwAgxMMwMzMzGWmBDjZMYA",
        },
    },
}

DragonSkillData["PRIEST"] = DragonSkillData["PRIEST"] or {}
DragonSkillData["PRIEST"][256] = {
    scrapedAt = "2026-08-16T09:45:32.127Z",
    statPriority = {
        wowhead = "Oracle: Intellect > Haste > Mastery > Critical Strike > Versatility | Voidweaver: Haste > Intellect > Mastery > Critical Strike > Versatility | Oracle: Intellect > Haste > Mastery > Critical Strike > Versatility | Voidweaver: Intellect > Haste > Mastery > Critical Strike > Versatility",
        archon = "Intellect > Haste > Crit > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[npc=268956]", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[zone=9526]", source = "Unknown", itemId = 159667 },
            { slot = "Head", item = "[npc=268956]", source = "Unknown", itemId = 271874 },
            { slot = "Neck", item = "[npc=268956]", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271553 bonus=13848 original-item=268241]", source = "[npc=257361]", itemId = nil },
            { slot = "Cloak", item = "[npc=24239]", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271558 bonus=13848 original-item=251139]", source = "[zone=16091]", itemId = nil },
            { slot = "Wrist", item = "Crafting", source = "Unknown", itemId = 239648 },
            { slot = "Gloves", item = "[item=271556 bonus=13848 original-item=268243]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Belt", item = "Crafting", source = "Unknown", itemId = 239649 },
            { slot = "Legs", item = "[npc=257347]", source = "Unknown", itemId = 271554 },
            { slot = "Boots", item = "[npc=24239]", source = "Unknown", itemId = 268255 },
            { slot = "Ring", item = "[npc=252959]", source = "Unknown", itemId = 268266 },
            { slot = "Ring", item = "[zone=16425]", source = "Unknown", itemId = 252258 },
            { slot = "Trinket", item = "[npc=252959]", source = "Unknown", itemId = 270167 },
            { slot = "Trinket", item = "[npc=253563]", source = "Unknown", itemId = 270162 },
            { slot = "[icon-badge=271092 quality=4 tooltip=\"BiS Weapon\"]", item = "[icon-badge=271874 quality=4 tooltip=\"BiS Helm with bonus stats\"]", source = "[icon-badge=268265 quality=4 tooltip=\"BiS Neck with bonus socket\"]", itemId = nil },
            { slot = "[icon-badge=159667 quality=3 tooltip=\"BiS Off-Hand\"]", item = "[icon-badge=252258 quality=3 tooltip=\"BiS Ring\"]", source = "[icon-badge=251139 quality=3 tooltip=\"BiS Chest\"]", itemId = nil },
            { slot = "[center][large]1[/large][/center]", item = "[icon-badge=271092 quality=4 tooltip=\"BiS Weapon\"]", source = "Unknown", itemId = nil },
            { slot = "[center][large]2[/large][/center]", item = "[icon-badge=271874 quality=4 tooltip=\"BiS Helm with bonus stats\"]", source = "Unknown", itemId = nil },
            { slot = "[center][large]3[/large][/center]", item = "[icon-badge=268265 quality=4 tooltip=\"BiS Neck with bonus socket\"]", source = "Unknown", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "oracle",
            label = "Raid",
            importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMGWmZmBDmZbmtZmZmxMDAAAAAAAAAgZYZGMzMDmxMgpZamBYmNMEGzyAMGsAAAjxMjBzAMzMTwA",
        },
        {
            provider = "wowhead",
            context = "oracle",
            label = "Mythic+",
            importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMDWmZMmBmZbmtZmZmxMDAAAAAAAAAgxYZGMzMjNjZGsZamYAmZDDhxsMAjBLAAwYmZGDmBYmZEMD",
        },
        {
            provider = "wowhead",
            context = "voidweaver",
            label = "Raid",
            importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMmxyYmBzgZbmtZmZmZmBAAAAAAAAAgZYZGMzMDzwMgpZamBzMAIAmtZbBM2MAAMGzMGmZwMDGBD",
        },
        {
            provider = "wowhead",
            context = "voidweaver",
            label = "Mythic+",
            importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMzMWYMGzgZzsNzMzMzMDAAAAAAAAAgxYZGMzMjNjZGsZamYwMDACgZb2WAjNDAAjZmZMYGMzgRwM",
        },
        {
            provider = "wowhead",
            context = "voidweaver",
            label = "Delves",
            importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMzMWYMGzgZzsNzMzMzMDAAAAAAAAAgxYZGMzMjNjZGsZamYwMDACgZb2WAjNDAAjZmZMYGMzgRwM",
        },
        {
            provider = "archon",
            context = "18.7%",
            label = "Alternative Class Tree #1",
            importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsYwyMjZmZGMbzYmZmZMzAAAAAAAAAAYYWmBzMzwMmZATzEDwMLYIMmlBYMYBAAGzMzYwMAzMzAG",
        },
        {
            provider = "archon",
            context = "10.5%",
            label = "Alternative Class Tree #2",
            importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsYwyMjZmZGMbzYmZmZMzAAAAAAAAAAYGWmBzMzMMmZwmpZiBYmFMEGzyAMGsAAAjZmZMYGgZmBYA",
        },
        {
            provider = "archon",
            context = "8.0%",
            label = "Recommended Class Tree",
            importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsYwyMjZmZGMbzYmZmZMzAAAAAAAAAAYMzyMYmZGmhZATzEDwMLYIMmlBYMYBAAGzMGDzMAzMzAG",
        },
        {
            provider = "archon",
            context = "4.2%",
            label = "Alternative Class Tree #3",
            importString = "CAQAAAAAAAAAAAAAAAAAAAAAAADsYwyMjZmZGMbzYmZmZMzAAAAAAAAAAYMzyMYmZGmxMDYamYAmZBDhxsMAjBLAAwYmxYwMAzMzAG",
        },
    },
}

DragonSkillData["PRIEST"][257] = {
    scrapedAt = "2026-08-16T09:45:33.044Z",
    statPriority = {
        wowhead = "Archon: Intellect > Crit > Versatility = Mastery > Haste | Oracle: Intellect > Crit > Versatility = Mastery > Haste | Archon: Intellect > Versatility > Critical Strike > Haste > Mastery | Oracle: Intellect > Versatility > Critical Strike > Haste > Mastery",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[npc=268956]", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[npc=252959]", source = "Unknown", itemId = 268263 },
            { slot = "Head", item = "[npc=268956]", source = "Unknown", itemId = 271874 },
            { slot = "Neck", item = "[npc=268956]", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[npc=267077]", source = "Unknown", itemId = 271553 },
            { slot = "Cloak", item = "[zone=16091]", source = "Unknown", itemId = 251132 },
            { slot = "Chest", item = "[item=271558 bonus=13848 original-item=268221]", source = "[npc=252959]", itemId = nil },
            { slot = "Wrist", item = "Crafting", source = "Unknown", itemId = 239648 },
            { slot = "Gloves", item = "[npc=258557]", source = "Unknown", itemId = 271556 },
            { slot = "Belt", item = "Crafting", source = "Unknown", itemId = 239649 },
            { slot = "Legs", item = "[item=271554 bonus=13848 original-item=159234]", source = "[zone=9526]", itemId = nil },
            { slot = "Boots", item = "[npc=253563]", source = "Unknown", itemId = 268218 },
            { slot = "Ring", item = "[npc=257347]", source = "Unknown", itemId = 268252 },
            { slot = "Ring", item = "[zone=16368]", source = "Unknown", itemId = 251148 },
            { slot = "Trinket", item = "[npc=267077]", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[npc=253563]", source = "Unknown", itemId = 270162 },
            { slot = "[icon-badge=271092 quality=4 tooltip=\"BiS Weapon\"]", item = "[icon-badge=271874 quality=4 tooltip=\"BiS Helm with bonus stats\"]", source = "[icon-badge=268265 quality=4 tooltip=\"BiS Neck with bonus socket\"]", itemId = nil },
            { slot = "[icon-badge=251148 quality=3 tooltip=\"BiS Ring\"]", item = "[icon-badge=159234 quality=3 tooltip=\"BiS Legs\"]", source = "[icon-badge=251132 quality=3 tooltip=\"BiS Cloak\"]", itemId = nil },
            { slot = "[center][large]1[/large][/center]", item = "[icon-badge=271092 quality=4 tooltip=\"BiS Weapon\"]", source = "Unknown", itemId = nil },
            { slot = "[center][large]2[/large][/center]", item = "[icon-badge=271874 quality=4 tooltip=\"BiS Helm with bonus stats\"]", source = "Unknown", itemId = nil },
            { slot = "[center][large]3[/large][/center]", item = "[icon-badge=268265 quality=4 tooltip=\"BiS Neck with bonus socket\"]", source = "Unknown", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "archon",
            label = "Raid",
            importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAgZmlxMjZmZYmZYZGmBAAAwwsMDzMzMYGzAYmaAgZWMTmFDAMGsZmZ2A0MMjxwMz2yAMDMA",
        },
        {
            provider = "wowhead",
            context = "archon",
            label = "Mythic+",
            importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAMmxsMYMzMDzMDLzMzMAAAAGzsMDmZmBjZGDYmCAMzmZysZAgxgNzM2A0MmZMGmZ2WGgBMA",
        },
        {
            provider = "wowhead",
            context = "archon",
            label = "Delves",
            importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAMmxsMmxMzYYmBLzMzMAAAAGmlZGzMzM2MmZMbLYmCAMziZysZAgxgNzM2A0wMMGMz2yAMgB",
        },
        {
            provider = "wowhead",
            context = "oracle",
            label = "Raid",
            importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAGjZmlZmZMzYYmxYZmxMAAAAGmlZGzMzMMzYGAzUDgZWwQYMbDwYgFGzCgMMPgxwMDwMzMwA",
        },
        {
            provider = "wowhead",
            context = "oracle",
            label = "Mythic+",
            importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAbGzYWGzMmZMMDsMzMzAAAAYMzyMMzMzYbGzMAmpAYmFMEGz2AMGYxMzAQzYmHwYwMAzMDYA",
        },
        {
            provider = "archon",
            context = "51.1%",
            label = "Recommended Class Tree",
            importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAgZzwYWGMmZmZMzMjlZmZAAAAYMWmBzMzYzYmxAmpAAzsZGmNDAMGsZMWA0MmZMGmZ2WGgBMA",
        },
        {
            provider = "archon",
            context = "10.1%",
            label = "Alternative Class Tree #1",
            importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAgZzwYWGMmZmZMzMjlZmZAAAAYMzyMYmZGmxMjxGmpAAzsZGmNDAMGsZMWA0MMjxgZ2WGgBMA",
        },
        {
            provider = "archon",
            context = "4.3%",
            label = "Alternative Class Tree #2",
            importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAgZzwYWGMmZmZMzMjlZmZAAAAYMWmZMzMzYzYmxAmpAAzsZGmNDAMGsZMWA0MmhxwMz2yAMgB",
        },
        {
            provider = "archon",
            context = "3.4%",
            label = "Alternative Class Tree #3",
            importString = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAgZzwYWGMmZmZMzMjlZmZAAAAYMzyMYmZGmxMjBMTBAmZzMMbGAYMYzYsAoZYGjhZmtlBYAD",
        },
    },
}

DragonSkillData["PRIEST"][258] = {
    scrapedAt = "2026-08-16T09:45:33.819Z",
    statPriority = {
        wowhead = "Archon: Intellect > Haste > Mastery > Critical Strike > Versatility | Voidweaver: Intellect > Haste > Mastery > Critical Strike > Versatility",
        archon = "Intellect > Haste > Mastery > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[item=271092 bonus=13848]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Offhand", item = "[item=245769 bonus=8793:13751:12497:13836:13771:8960]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Head", item = "[item=271555 bonus=13848:13846:10835 original-item=271874]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Neck", item = "[item=268265 bonus=13708:13750:13848]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Shoulders", item = "[color=q4][item=239045 bonus=12854 spec=258][/color]", source = "[url guide=34260]King's Rest", itemId = nil },
            { slot = "Cloak", item = "[item=268253 bonus=13848]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Chest", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 271558 },
            { slot = "Wrist", item = "[item=239648 bonus=8793:12384:8960:13750:13751:12497:13836 spec=258]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Gloves", item = "[item=271556 bonus=13848 original-item=268243]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Belt", item = "[item=268257 bonus=10835:12854 ]", source = "[url guide=34249]Sszorak", itemId = nil },
            { slot = "Legs", item = "[item=271554 original-item=251160]", source = "[url guide=33190]Den of Nalorakk", itemId = nil },
            { slot = "Boots", item = "[item=268255 bonus=13848]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Ring", item = "[item=252258 bonus=10835:12854]", source = "[url guide=33183]Voidscar Arena", itemId = nil },
            { slot = "Ring", item = "[item=268249 bonus=10835:12854]", source = "[url guide=34248]Vashnik the Malignant", itemId = nil },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[color=q4][item=250215 bonus=12854][/color]", source = "[url guide=33189]Murder Row", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "archon",
            label = "Single Target",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDzAAAAAAAAAAAAwMLmxMbzMGz2MGzw2MzYmZGbIzYxMNAzAMzmZY2MAkxYBAzMIjZmZMbMz2yAMTMA",
        },
        {
            provider = "wowhead",
            context = "archon",
            label = "Raid Cleave",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDDAAAAAAAAAAAAmZxMmZbmxMz2MGzw2MzYmZGbIzYxMNAzAMzmZY2MAkxYBAzMIjZmZMbMz2yAMTMA",
        },
        {
            provider = "wowhead",
            context = "archon",
            label = "Mythic+",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDDAAAAAAAAAAAAmZxMmZbmxMzyMGzw2MzYmZGbIzYxMNAzAMzmZY2MAkxYBAzMIjZmZMbMz2yAMTMA",
        },
        {
            provider = "wowhead",
            context = "archon",
            label = "Delves",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDDAAAAAAAAAAAAmZxMmZbmxMzyMGzw2MzYmZGbIzYxMNAzAMzmZY2MAkxYBAzMIjZmZMbMz2yAMTMA",
        },
        {
            provider = "wowhead",
            context = "voidweaver",
            label = "Single Target",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMMjZGAAAAAAAAAAAAegZxMmZbmBz2MzYG2mZGzMzYDZGLmpBYmZGAIAz2stAmNGAYkxMzMmtxMYmBzEDA",
        },
        {
            provider = "wowhead",
            context = "voidweaver",
            label = "Raid Cleave",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMMjZGAAAAAAAAAAAAMLmxMbzMMz2MzYG2mZGzMzYDZGLmpBYmZGAIAz2stAmNGAYkxMzMmtxMYmBzEDA",
        },
        {
            provider = "wowhead",
            context = "voidweaver",
            label = "Mythic+",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDDAAAAAAAAAAAAmZxMmZbmxMzyMzYG2mZGzMzYDZGLmpBYmZGAIAz2stAmNGAYkxMzMmNmBzMYmYA",
        },
        {
            provider = "wowhead",
            context = "voidweaver",
            label = "Delves",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDDAAAAAAAAAAAAmZxMmZbmxMzyMzYG2mZGzMzYDZGLmpBYmZGAIAz2stAmNGAYkxMzMmNmBzMYmYA",
        },
        {
            provider = "archon",
            context = "15.0%",
            label = "Recommended Class Tree",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMjZMGAAAAAAAAAAAAjZZmxYZmxMz2MDDz2MzYmZGbIDLmpxAzMzAABY2mtNwsxAADGzMzY2GzgZGMDGA",
        },
        {
            provider = "archon",
            context = "6.9%",
            label = "Alternative Class Tree #1",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMjZMGAAAAAAAAAAAAjZZmxYZmxMz2MDjx2MzYmZGbIDLmpxAzMzAABY2mtNwsxAADGzMzY2GzgZGMDGA",
        },
        {
            provider = "archon",
            context = "6.9%",
            label = "Alternative Class Tree #2",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMjZMGAAAAAAAAAAAAjZZmxYZmxMz2MDjx2MzYmZGbIzYxMNAzMzAABY2mtNwsxAADGzMzY2GzgZGMDGA",
        },
        {
            provider = "archon",
            context = "4.7%",
            label = "Alternative Class Tree #3",
            importString = "CIQAAAAAAAAAAAAAAAAAAAAAAMjZMGAAAAAAAAAAAAjZZmxYZmxMz2MDDz2MzYmZGbIzYxMNAzMzAABY2mtNwsxAADGzMzY2GzgZGMDGA",
        },
    },
}

DragonSkillData["ROGUE"] = DragonSkillData["ROGUE"] or {}
DragonSkillData["ROGUE"][259] = {
    scrapedAt = "2026-08-16T09:45:34.348Z",
    statPriority = {
        wowhead = "Fatebound: Agility > Critical Strike > Haste > Mastery > Versatility | Deathstalker: Agility > Critical Strike > Haste > Mastery > Versatility",
        archon = "Agility > Crit > Haste > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271093 },
            { slot = "Offhand", item = "[item=237837 bonus=12214:13836:13751:9627:13771:8960]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Head", item = "[item=271510 original-item=271875]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271508 original-item=251223]", source = "[url guide=33183]Voidscar Arena", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271513 original-item=251159]", source = "[url guide=33190]Den of Nalorakk", itemId = nil },
            { slot = "Wrist", item = "[item=244576 bonus=12214:13836:13751:9627:13750:8790:8960:12384]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Gloves", item = "[url guide=34245]Entombed Sentinels", source = "Unknown", itemId = 271511 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268256 },
            { slot = "Legs", item = "[item=271509 original-item=268225]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Boots", item = "[url guide=33190]Den of Nalorakk", source = "Unknown", itemId = 251153 },
            { slot = "Ring", item = "[url guide=34264]Altar of Fangs", source = "Unknown", itemId = 273792 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270168 },
            { slot = "Priority", item = "Instance", source = "Item/Notes", itemId = nil },
            { slot = "1", item = "[url guide=34252]Ula'tek", source = "Ula'tek is simply the strongest single source of power in Season 2. Out of the five items that can be bonus rolled, four are best in slot, and the  is best in a lot of aoe/cleave situations. If heroic Ula'tek can be killed weekly, it is highly recommended to bonus roll Ula'tek until every item is obtained.", itemId = 270168 },
            { slot = "2", item = "[url guide=34247]The Lost Explorers", source = "The Lost Explorers are an earlier boss in the raid, and offer a good passive/all-around trinket, usable belt, as well as a tier item. If bonus rolling on Mythic, it will save a good amount of crests. This isn't a super high-value bonus roll, and you should feel free to bonus roll or take vault options as you want at this point.", itemId = nil },
            { slot = "3", item = "[url guide=34224]Any Mythic  Venomous Abyss Boss", source = "Bonus rolling at this point has lost a lot of its value, but you can still get crest savings and value out of bonus rolling mythic raid bosses. Depending on the rest of your gear, you will want to determine what bosses have the highest chance of giving crest savings.", itemId = nil },
            { slot = "4", item = "[url guide=33190]Den of Nalorakk", source = "Den of Nalorakk has both our best in slot Chest piece to catalyze, as well as our best in slot feet. The three other items on the drop table are not good.", itemId = nil },
            { slot = "5", item = "[url guide=34264]Altar of Fangs", source = "Altar of Fangs has a great ring, as well as a dagger with a bonus effect. The dagger is not very good in cleave/aoe, but provides some bonus damage in pure single target if desired. Altar of Fangs should be considered the last place you would want to use bonus rolls, as using them on any mythic raid boss for crest savings is going to be preferred.", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Maintain", spellId = "703" },
            { text = "Cast  until having 5 or more combo points", spellId = "1329" },
            { text = "Cast  at maximum combo points when  is active [span class=tip tooltip=darkest-shiv][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "32645" },
            { text = "Maintain  by casting at 5 or more combo points", spellId = "1943" },
            { text = "Cast  followed by  to apply . This should be lined up with  in most situations [span class=tip tooltip=vanish-gar][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "1856" },
            { text = "Cast  on cooldown", spellId = "360194" },
            { text = "Cast  on cooldown, immediately after  when applicable", spellId = "385627" },
            { text = "Cast  at 5 or more combo points[span class=tip tooltip=pooling][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "32645" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "deathstalker",
            label = "Raid Single Target",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlxsNDGAAAAAYWGsNDAAAAAIbzMzMzMjxyMzMbzsMzMzYGzYMmZMMAbmlBGwSwywEYYxgZGgxYA",
        },
        {
            provider = "wowhead",
            context = "deathstalker",
            label = "Raid",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmFDGAAAAAYWGsNDAAAAAIbzMzMzMjxyMzMbzsMzMPgZMzYMMzYMAbmlBGwSwywEYYxgZGgxYA",
        },
        {
            provider = "wowhead",
            context = "deathstalker",
            label = "Mythic+",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmFDGAAAAAYWGsNDAAAAAIbzMzMzMjxyMzMbzsMzMPgZMzYMMzYMAbmlBGwSwywEYYxgZGgxYA",
        },
        {
            provider = "wowhead",
            context = "deathstalker",
            label = "Delves",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmFDGAAAAAYWGsNDAAAAAIbzMzMzMjxyMzMbzsMzMPgZMzYMMzYMAbmlBGwSwywEYYxgZGgxYA",
        },
        {
            provider = "wowhead",
            context = "fatebound",
            label = "Raid Single Target",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlxsNDGAAAAAYWGsNDAAAAAIbzMzMzMjxyMzMbzsMzMzYGzYMmZMMAGYBmxoxsBy2A2MAYmZMGA",
        },
        {
            provider = "wowhead",
            context = "fatebound",
            label = "Raid",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmFDGAAAAAYWGsNDAAAAAIbzMzMzMjxyMzMbzsMzMPgZMzYMMzYMAGYBmxoxsBy2A2MAYmZMGA",
        },
        {
            provider = "wowhead",
            context = "fatebound",
            label = "Mythic+",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmFDGAAAAAYWGsNDAAAAAIbzMzMzMjxyMzMbzsMzMPgZMzYMMzYMAGYBmxoxsBy2A2MAYmZMGA",
        },
        {
            provider = "wowhead",
            context = "fatebound",
            label = "Delves",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmFDGAAAAAYWGsNDAAAAAIbzMzMzMjxyMzMbzsMzMPgZMzYMMzYMAGYBmxoxsBy2A2MAYmZMGA",
        },
        {
            provider = "archon",
            context = "55.2%",
            label = "Recommended Class Tree",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmNDGAAAAAYWGsNDAAAAAotlZmZmZmxYmZmZbmlZGPgHYmZmZMMzYMAGYBmxoxsBYbAbGAMzMYA",
        },
        {
            provider = "archon",
            context = "8.5%",
            label = "Alternative Class Tree #1",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmNDGAAAAAYWGsNDAAAAAottZmZmZmxYmZmZbmlZGPgHYmZmZMMzYMAGYBmxoxsBYbAbGAMzMYA",
        },
        {
            provider = "archon",
            context = "4.1%",
            label = "Alternative Class Tree #2",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmNDGAAAAAYWGsNDAAAAAotlZmZmZmxYmZmZbmlZGPgHYmZmZMMzYMDwALwMGNmNAbDYDAMzMYA",
        },
        {
            provider = "archon",
            context = "3.7%",
            label = "Alternative Class Tree #3",
            importString = "CMQAAAAAAAAAAAAAAAAAAAAAAYmlZmNDGAAAAAYWGsNDAAAAAotlZmZmZmxYmZmZbmlZGPgHYmZmZMMzYMAGYBmxoxsBYbAbAgZmZYA",
        },
    },
}

DragonSkillData["ROGUE"][260] = {
    scrapedAt = "2026-08-16T09:45:35.151Z",
    statPriority = {
        wowhead = "Trickster: Agility > Haste > Critical Strike > Versatility > Mastery | Fatebound: Agility > Haste > Critical Strike > Versatility > Mastery",
        archon = "Agility > Crit > Haste > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268209 },
            { slot = "Offhand", item = "[url guide=34264]Altar of Fangs", source = "Unknown", itemId = 275070 },
            { slot = "Head", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271875 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271508 },
            { slot = "Cloak", item = "[url guide=34244]Nek'zali the Soulcoiler", source = "Unknown", itemId = 268248 },
            { slot = "Chest", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271513 },
            { slot = "Wrist", item = "[url guide=34244]Nek'zali the Soulcoiler", source = "Unknown", itemId = 268240 },
            { slot = "Gloves", item = "[item=271511 original-item=251124]", source = "[url guide=34180]Tier Set", itemId = nil },
            { slot = "Belt", item = "[item=244573 bonus=12214:8960:12497:12066:13622:13667:12214:8792:8960:12384]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Legs", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271509 },
            { slot = "Boots", item = "[item=244569 bonus=12214:8960:12497:12066:13622:13667:12214:8792:8960:12384]", source = "[url guide=15942]Crafting/Misc", itemId = nil },
            { slot = "Ring", item = "[url guide=34240]Nymrissa Wavecaller", source = "Unknown", itemId = 268266 },
            { slot = "Ring", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268252 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast  on cooldown if at stage 1 or less. - [span class=tip tooltip=rtb][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "315508" },
            { text = "Cast  if you have a stage 3 or higher  active.", spellId = "381989" },
            { text = "Cast  whenever , , , and  are on cooldown.", spellId = "1277933" },
            { text = "Cast  on cooldown at 2 or fewer combo points, followed by .", spellId = "13750" },
            { text = "Cast  with the 4-set bonus active.", spellId = "2098" },
            { text = "Cast  on cooldown.", spellId = "271877" },
            { text = "Cast  at 6 or more combo points.", spellId = "315341" },
            { text = "Cast  at 6 or more combo points.", spellId = "2098" },
            { text = "Cast  if;[ul]\n	 has 6 stacks.", spellId = "185763" },
            { text = "has 3 stacks, and you are at 1-3 combo points.", spellId = "279876" },
            { text = "Cast  at 5 or fewer combo points.", spellId = "193315" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "trickster",
            label = "Raid",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMmZmtZmZmZMmF4BmZbaZw2MAAAAAAbbzMzwMzMziZmZbAAAAYmBAjZxwQGYWYhWYjBYmBDMA",
        },
        {
            provider = "wowhead",
            context = "trickster",
            label = "Mythic+",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMjZmtZmZMzMzsAmZbaZw2MAAAAAAbbzMzwMzMziZmZbAAAAYmBAjZxwQGYWYhWYjBYmBDMA",
        },
        {
            provider = "wowhead",
            context = "trickster",
            label = "Delves",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMjZmtZmZMzMzsAmZbaZw2MAAAAAA2mZmhZmZmFzMz2AAAAwYAwYWMMkBmFWoF2YAmZwMYG",
        },
        {
            provider = "wowhead",
            context = "fatebound",
            label = "Raid",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMmZmtZmZmZMmF4BmZbaZw2MAAAAAAbbzMzwMzMziZmZbAAAAYmBMwGMjRjZDw2EWYAwMzAD",
        },
        {
            provider = "wowhead",
            context = "fatebound",
            label = "Mythic+",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMjZmtZmZMzMzsAmZbaZw2MAAAAAAbbzMzwMzMziZmZbAAAAYmBMwGMjRjZDw2EWYAgZGYA",
        },
        {
            provider = "wowhead",
            context = "fatebound",
            label = "Delves",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMjZmtZmZMzMzsAmZbaZw2MAAAAAA2mZmhZmZmFzMz2AAAAwYADsBzY0Y2AsNhFGAMzMDmB",
        },
        {
            provider = "archon",
            context = "33.5%",
            label = "Recommended Class Tree",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MYmZmZmtZmZMzMzsBmZbaZw2MAAAAAAbLzMzwMzMzYmZ2GAAAAGDAGzihBGYWYhWYjBYmBzgB",
        },
        {
            provider = "archon",
            context = "17.5%",
            label = "Alternative Class Tree #1",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MYmZmZmtZmZMzMzsBmZbaZw2MAAAAAgZbbmZGmZmZGzMz2AAAAwYAwYWMMwAzCL0CbMAzMYgB",
        },
        {
            provider = "archon",
            context = "9.4%",
            label = "Alternative Class Tree #2",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MYmZmZmtZmZMzMzsBmZbaZw2MAAAAAgZbZmZGmZmZGzMz2AAAAwYAwYWMMwAzCL0CbMAzMYgB",
        },
        {
            provider = "archon",
            context = "7.2%",
            label = "Alternative Class Tree #3",
            importString = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MYmZmZmtZmZMzMzsBmZbaZw2MAAAAAAbbzMzwMzMzYmZ2GAAAAGDAGzihBGYWYhWYjBYmBzgB",
        },
    },
}

DragonSkillData["ROGUE"][261] = {
    scrapedAt = "2026-08-16T09:45:35.664Z",
    statPriority = {
        wowhead = "Deathstalker: Agility > Mastery > Haste (~1100 Haste) > Critical Strike > Versatility | Trickster: Agility > Mastery > Haste (~1100 Haste) > Critical Strike > Versatility | Deathstalker: Agility > Mastery > Haste (~700 Haste) > Critical Strike > Versatility | Trickster: Agility > Mastery > Haste (~700 Haste) > Critical Strike > Versatility",
        archon = "Agility > Mastery > Crit > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Main-Hand", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271093 },
            { slot = "Off-Hand", item = "[url guide=15942]Crafting/Misc", source = "Unknown", itemId = 237837 },
            { slot = "Head", item = "[item=271510 original-item=271875]", source = "[url guide=34180]Tier Set - [url guide=34252]Ula'tek", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271508 original-item=268246]", source = "[url guide=34180]Tier Set - [url guide=34248]Vashnik the Malignant", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271513 original-item=268235]", source = "[url guide=34180]Tier Set - [url guide=34244]Nek'zali the Soulcoiler", itemId = nil },
            { slot = "Wrist", item = "[url guide=15942]Crafting/Misc", source = "Unknown", itemId = 244576 },
            { slot = "Gloves", item = "[item=271511 original-item=268234]", source = "[url guide=34180]Tier Set - [url guide=34249]Sszorak", itemId = nil },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268256 },
            { slot = "Legs", item = "[item=271509 original-item=268225]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Boots", item = "[url guide=33219] Catalyst", source = "Unknown", itemId = 271512 },
            { slot = "Ring", item = "[url guide=33183]Voidscar Arena", source = "Unknown", itemId = 252258 },
            { slot = "Ring", item = "[url guide=33193]Blinding Vale", source = "Unknown", itemId = 251194 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "deathstalker",
            label = "Raid",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMDDzMzMzw8AbzYGbbzMzMzMjBjZ2GAAAAGMmFzyADYBsMMhMLYGmZAmxA",
        },
        {
            provider = "wowhead",
            context = "deathstalker",
            label = "Mythic+",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMDjZmZmZGGbzYGbbzMzMzMjBjZ2GAAAAGMmFzyADYBsMMhMLYGmZAmxA",
        },
        {
            provider = "wowhead",
            context = "deathstalker",
            label = "Delves",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMDjZmZmZGGbzYGbbzMzMzMjBjZ2GAAAAGMmFzyADYBsMMhMLYGmZAmxA",
        },
        {
            provider = "wowhead",
            context = "trickster",
            label = "Raid",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMDDzMzMzw8AbzYGbbzMzMzMjBjZ2GAAAAGMGwY2MMwAziWoFbYGwMDmxA",
        },
        {
            provider = "wowhead",
            context = "trickster",
            label = "Mythic+",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbLjxMDDzMzMzw8AbzYGbbzMzMzMjBjZ2GAAAAGMGwY2MMwAziWoFbYGwMDmxA",
        },
        {
            provider = "wowhead",
            context = "trickster",
            label = "Delves",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbLjxMDDzMzMzw8AbzYGbbzMzMzMjBjZ2GAAAAGMGwY2MMwAziWoFbYGwMDmxA",
        },
        {
            provider = "archon",
            context = "31.2%",
            label = "Recommended Class Tree",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMjZMegZmZGjZbYGbLzMzMzMjBjZ2GAAAAGMGwY2MMwAzCL0iNMDYmBzYA",
        },
        {
            provider = "archon",
            context = "20.9%",
            label = "Alternative Class Tree #1",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMjZMegZmZGjZbYGbbzMzMzMjBjZWGAAAAGMGwY2MMwAzCL0iNMDYmBzYA",
        },
        {
            provider = "archon",
            context = "18.4%",
            label = "Alternative Class Tree #2",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMjZMegZmZGjZbYGbbzMzMzMjBjZ2GAAAAGMGwY2MMwAzCL0iNMDYmBzYA",
        },
        {
            provider = "archon",
            context = "8.1%",
            label = "Alternative Class Tree #3",
            importString = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMjZMegZmZGjZbYGbLzMzMzMjBjZWGAAAAGMGwY2MMwAzCL0iNMDYmBzYA",
        },
    },
}

DragonSkillData["SHAMAN"] = DragonSkillData["SHAMAN"] or {}
DragonSkillData["SHAMAN"][262] = {
    scrapedAt = "2026-08-16T09:45:36.122Z",
    statPriority = {
        wowhead = "Farseer: Mastery to 1200 rating > Haste/Crit > Versatility > Intellect | Stormbringer: Mastery to 1200 rating > Haste/Crit > Versatility > Intellect",
        archon = "Intellect > Mastery > Crit > Haste > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[url guide=34240]Nymrissa Wavecaller", source = "Unknown", itemId = 268262 },
            { slot = "Head", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271483 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271481 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271486 },
            { slot = "Wrist", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 244584 },
            { slot = "Gloves", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271484 },
            { slot = "Belt", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268254 },
            { slot = "Legs", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271482 },
            { slot = "Boots", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 244577 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Ring", item = "[url guide=33183]Voidscar Arena", source = "Unknown", itemId = 252258 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[url guide=34264]Altar of Fangs", source = "Unknown", itemId = 273796 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Remember to use  and  for movement events.", spellId = "79206" },
            { text = "Cast  on cooldown.", spellId = "191634" },
            { text = "Cast  on cooldown.", spellId = "443454" },
            { text = "Cast  roughly on cooldown, but always after", spellId = "114050" },
            { text = "Cast  as your filler.", spellId = "188196" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "farseer",
            label = "Raid",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMmZmZZbZMMjBAAAAsYmNYADY2YCZWAgZZmZGjtFTYmZZsMzMzYYZWmxiZGmZZAADAMzYYYA",
        },
        {
            provider = "wowhead",
            context = "farseer",
            label = "Mythic+",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMGjZZZZMmhBAAAAsYmNYADY2YCZWAgZZmZGjtFTbMzYsMzMzYYZWMWmZGzMLAAzAgZGDDD",
        },
        {
            provider = "wowhead",
            context = "farseer",
            label = "Delves",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMLLzMmZmZbZZMmxMDAAAAsZmNYADY2YCZWAgZZmZGjtFTYmxYZmZmZmxiFjFMmZWAAGAYmxwwA",
        },
        {
            provider = "wowhead",
            context = "stormbringer",
            label = "Raid",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMmZmZZbZMMjBAAAAsYmNYADY2YCZWAgZZmZGjtFTYmZZsMzMzYYZWmxiZGmZZAADAMzYYYA",
        },
        {
            provider = "wowhead",
            context = "stormbringer",
            label = "Mythic+",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMGjZZZZMmhBAAAAsYmNYADY2YCZWAgZZmZGjtFTbMzYsMzMzYYZWMWmZGzMLAAzAgZGDDD",
        },
        {
            provider = "wowhead",
            context = "stormbringer",
            label = "Delves",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMLLzMzMzMbbLDmxMDAAAAA2MjhNYBmRDN2AgZZmZGjtFTYmxYZmZmZmxiFjFjhZWAAGAzMwwwA",
        },
        {
            provider = "archon",
            context = "7.3%",
            label = "Alternative Class Tree #1",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMzYML2mhZMzAAAAAAbmxwGsAzwQjNAY2mZmxYbxEmx2YZmZm5BmxilZsYmZMzCAwAYmBGGG",
        },
        {
            provider = "archon",
            context = "6.4%",
            label = "Alternative Class Tree #2",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMzYML2mhZMzAAAAAAbmxwGsAzwQjNAY2mZmxMbLzEmBWmZmZMDzyMWMzMmZBAYGgZGYYYA",
        },
        {
            provider = "archon",
            context = "4.9%",
            label = "Alternative Class Tree #3",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMzYML2mhZMzAAAAAAbmxwGsAzwQjNAY2mZmxMLLzEzM2GLz8AzMGYZGLmZGzsAAMDwMDMMMA",
        },
        {
            provider = "archon",
            context = "0.8%",
            label = "Recommended Class Tree",
            importString = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAzMbLzMzYML2mhZMzAAAAAAbmxwGsAzwQjNAY2mZmxYZxEmx2YZmZmxYWsMjFzMjZWAAmBYmBGGG",
        },
    },
}

DragonSkillData["SHAMAN"][263] = {
    scrapedAt = "2026-08-16T09:45:37.582Z",
    statPriority = {
        wowhead = "Stormbringer: Agility > Mastery = Haste > Critical Strike > Versatility | Totemic: Agility > Mastery = Haste > Critical Strike > Versatility",
        archon = "Agility > Mastery > Haste > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "[icon name=ui_profession_enchanting inline=true size=small tooltip=enchanting][/icon]", source = "Item", itemId = nil },
            { slot = "Main Hand", item = "[icon name=inv_12_profession_enchanting_enchantedvellum_purple inline=true][/icon]", source = "[color=q4][item=268209 bonus=13848][/color]", itemId = nil },
            { slot = "Off Hand", item = "[icon name=inv_12_profession_enchanting_enchantedvellum_purple inline=true][/icon]", source = "[color=q4][item=237850 bonus=13751:12497:13836:13771:8793][/color]", itemId = nil },
            { slot = "Head", item = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon][icon name=inv_potiond_4][/icon]", source = "[color=q4][item=271483 bonus=12854 original-item=251220][/color] &ndash;", itemId = nil },
            { slot = "Neck", item = "[color=q4][item=268265 bonus=13848:13708:10835][/color]", source = "[url guide=34252][icon name=inv_121_raid_achievement_ulatek]Ula'tek[/icon]", itemId = nil },
            { slot = "Shoulders", item = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", source = "[color=q4][item=271481 bonus=13848 original-item=268231][/color] &ndash;", itemId = nil },
            { slot = "Cloak", item = "[color=q4][item=268253 bonus=13848][/color]", source = "[url guide=34251][icon name=inv_121_raid_achievement_zuljinmalacrass]The Coiled Altar[/icon]", itemId = nil },
            { slot = "Chest", item = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", source = "[color=q4][item=271486 bonus=13848:13708 original-item=271876][/color] &ndash;", itemId = nil },
            { slot = "Wrist", item = "[icon name=inv_potiond_4][/icon]", source = "[color=q4][item=244584 bonus=13751:12497:13836:12384:8793][/color]", itemId = nil },
            { slot = "Gloves", item = "[color=q4][item=271484 bonus=12854 original-item=160213][/color] &ndash;", source = "[url guide=33219] Catalyst &ndash; [url guide=34260][icon name=achievement_dungeon_kingsrest]King's Rest[/icon]", itemId = nil },
            { slot = "Belt", item = "[icon name=inv_potiond_4][/icon]", source = "[color=q4][item=268254 bonus=12854][/color]", itemId = nil },
            { slot = "Legs", item = "[icon name=inv_12_profession_leatherworking_amani_armor_kit inline=true][/icon]", source = "[color=q4][item=271482 bonus=13848 original-item=268237][/color] &ndash;", itemId = nil },
            { slot = "Boots", item = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", source = "[color=q4][item=268233 bonus=12854][/color]", itemId = nil },
            { slot = "Ring 1", item = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", source = "[color=q4][item=268249 bonus=12854:10835][/color]", itemId = nil },
            { slot = "Ring 2", item = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", source = "[color=q4][item=252258 bonus=12854:10835][/color]", itemId = nil },
            { slot = "Trinket 1", item = "[color=q4][item=270175 bonus=13848][/color]", source = "[url guide=34252][icon name=inv_121_raid_achievement_ulatek]Ula'tek[/icon]", itemId = nil },
            { slot = "Trinket 2", item = "[color=q4][item=270173 bonus=13848][/color]", source = "[url guide=34251][icon name=inv_121_raid_achievement_zuljinmalacrass]The Coiled Altar[/icon]", itemId = nil },
            { slot = "Priority", item = "Location", source = "Item/Notes", itemId = nil },
            { slot = "[large][color=necrolord]1[/color][/large]", item = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c7][/icon] [url guide=34252]Ula'tek", source = "[color=q6]Most Pieces[/color] [toggler id=\"voidcore-1\"][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=rogue]2[/color][/large]", item = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c7][/icon] [url guide=34251]Coiled Altar", source = "[color=q6]Weapon & Trinket[/color] [toggler id=\"voidcore-2\" hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
            { slot = "[large][color=druid]3[/color][/large]", item = "[icon name=8039569 inline=true size=small type=round color=c7][/icon] [url guide=34045] Early Mythic Bosses", source = "Depends [toggler id=\"voidcore-3\" hidden][i]Click for Notes[/i][/toggler]", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "stormbringer",
            label = "Raid",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAA2AsZGDLkFYGGawCAzyMmZGLLzAzMbsMzMzwwYGAgZYMzYmJwMDGMGA",
        },
        {
            provider = "wowhead",
            context = "stormbringer",
            label = "Mythic+",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAA2AsZGDbkFYGGawCAzyMmxYZxYjZmtxyMzMzgFmBAYGGzMMTgZGMYMA",
        },
        {
            provider = "wowhead",
            context = "stormbringer",
            label = "Delves",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAA2AsZGDbkNYGGawCAzyMmxYZZGYmxYxMzMjxCzAAMDjZGzMBmZwgxA",
        },
        {
            provider = "wowhead",
            context = "totemic",
            label = "Raid",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzMzMzMzMzMzMzYGAAAAAAAAAsAbwMW0YbAMTwGAzyMmZGLLzAzMbsMzMzwwYGAADwYmJmZAgxA",
        },
        {
            provider = "wowhead",
            context = "totemic",
            label = "Mythic+",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzMjZmZmZmZmZGzAAAAAAAAAgFYDmxiGbDgZC2AYWmxMGLLGbMzsNWm5BmZGsMmBAAYMmRMzAMYMA",
        },
        {
            provider = "wowhead",
            context = "totemic",
            label = "Delves",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMjZmZmZmZmZmZGzAAAAAAAAAgFYDmxiGbDgZC2AYWmxMGLLzAzMGLmZmZMWYGAAgxYmJmZAGMGA",
        },
        {
            provider = "archon",
            context = "11.7%",
            label = "Alternative Class Tree #1",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAAsBYzMG2gFYGGawCAz2MmxYZZGYmZbsMzMzwYZMDAwMMmZYmAzMYwYA",
        },
        {
            provider = "archon",
            context = "6.4%",
            label = "Alternative Class Tree #2",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAAsBYzMG2gFYGGawCAz2MmxYZZGbMzsNWmZmZYsMmBAYGGzMMCMzgBjB",
        },
        {
            provider = "archon",
            context = "4.7%",
            label = "Alternative Class Tree #3",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAAsBYzMG2gFYGGawCAz2MmxYZZGLMzsNWmZmZYsMmBAYGGzMMCMzgBjB",
        },
        {
            provider = "archon",
            context = "3.7%",
            label = "Recommended Class Tree",
            importString = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAAsBYzMG2gFYGGawCAz2MmxYZZGbMzsNWmZmZYswMAAzwYmhZCMzgBjB",
        },
    },
}

DragonSkillData["SHAMAN"][264] = {
    scrapedAt = "2026-08-16T09:45:38.689Z",
    statPriority = {
        wowhead = "Farseer: Intellect > Critical Strike > Haste > Versatility > Mastery | Totemic: Intellect > Critical Strike > Haste > Versatility > Mastery",
        archon = "Intellect > Crit > Haste > Vers > Mastery",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Helm", item = "[color=q4][item=271483 original-item=251220][/color]", source = "[icon name=inv_achievement_dungeon_voidscararena][/icon][url guide=33183]Voidscar Arena & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Neck", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_ulatek][/icon][url guide=34252]Ula'tek [i](Raid)[/i]", itemId = 268265 },
            { slot = "Shoulders", item = "[color=q4][item=271481 original-item=268231][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass][/icon][url guide=34251]The Coiled Alter [i](Raid)[/i] & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Cape", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass][/icon][url guide=34251]The Coiled Alter [i](Raid)[/i]", itemId = 268253 },
            { slot = "Chest", item = "[color=q4][item=271486 original-item=271876][/color]", source = "[icon name=inv_121_raid_achievement_ulatek][/icon][url guide=34252]Ula'tek [i](Raid)[/i] & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Bracers", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_lightbloom][/icon][url guide=33193]The Blinding Vale", itemId = 251200 },
            { slot = "Gloves", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_ulatek][/icon][url guide=33180]Raid | [icon name=ability_racial_packhobgoblin][/icon][url guide=17592]Vault", itemId = 271484 },
            { slot = "Belt", item = "[color=q4][/color]", source = "[icon name=achievement_dungeon_kingsrest][/icon][url guide=33272]Kings Rest", itemId = 159369 },
            { slot = "Legs", item = "[color=q4][item=271482 original-item=268237][/color]", source = "[icon name=inv_121_raid_achievement_zuljinmalacrass][/icon][url guide=34251]The Coiled Alter [i](Raid)[/i] & [icon name=inv_radientazeritematrix][/icon][url guide=33219] Catalyst", itemId = nil },
            { slot = "Boots", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_proveyourworth][/icon][url guide=33190]Den of Nalorakk", itemId = 251145 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_proveyourworth][/icon][url guide=33190]Den of Nalorakk", itemId = 251148 },
            { slot = "Ring", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_altaroffangs][/icon][url guide=33272]Alter of Fangs", itemId = 273792 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_priestess][/icon][url guide=34244]Nek'zali the Soulcoiler [i](Raid)[/i]", itemId = 270162 },
            { slot = "Trinkets", item = "[color=q4][/color]", source = "[icon name=inv_achievement_dungeon_murderrow][/icon][url guide=33189]Murder Row", itemId = 250215 },
            { slot = "1h Weapon", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_ulatek][/icon][url guide=34252]Ula'tek [i](Raid)[/i]", itemId = 271092 },
            { slot = "Shield", item = "[color=q4][/color]", source = "[icon name=inv_121_raid_achievement_tortollans][/icon][url guide=34247]The Lost Explorers [i](Raid)[/i]", itemId = 268196 },
            { slot = "[icon-badge=268265 quality=4 tooltip=\"Raid_Cantrip_Tooltip\"]", item = "[icon-badge=271092 quality=4 tooltip=\"Raid_Cantrip_Tooltip\"]", source = "[icon-badge=271876 quality=4 tooltip=\"Raid_Cantrip_Tooltip\"]", itemId = nil },
            { slot = "[icon-badge=250215 quality=3 tooltip=\"Bis_Trinket_Tooltip\"]", item = "[icon-badge=273792 quality=3 tooltip=\"Jewelry_Tooltip\"]", source = "[icon-badge=251148 quality=3 tooltip=\"Jewelry_Tooltip\"]", itemId = nil },
            { slot = "Priority", item = "Boss", source = "Item/Notes", itemId = nil },
            { slot = "1", item = "[url guide=34252 style='display: flex; align-items: center; text-align: left;'][icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round][/icon]Heroic Ula'tek", source = "Ula'tek contains incredibly strong loot for Restoration Shamans. , , and  are all very strong pieces and you want to get all of them as soon as possible. Bonus rolls will allow you to get them at myth-track even on the heroic difficulty boss.", itemId = 268265 },
            { slot = "2", item = "[url guide=34244 style='display: flex; align-items: center; text-align: left;'][icon name=inv_121_raid_achievement_priestess inline=true size=small type=round][/icon]Mythic Nek'zali", source = "Having the best trinket of the season in  Mythic Nek'zali is the next best place to use your bonus rolls after Heroic Ula'tek, as you can make good use of four out of the five items in its loot table. Being the very first boss of the raid means it is very accesible, and all the loot is very well itemized for us.", itemId = 270162 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "farseer",
            label = "Raid",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAzMzsssNjZGjZGzMMWMzGMgJY2YCMWMDzgtxYmmtlZmNzYWYxMzMmhZZAAAgZmBAzMwgZA",
        },
        {
            provider = "wowhead",
            context = "farseer",
            label = "Mythic+",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAzMzsssNzMzMjZGjZMWMzCMgJYWYCMWwMDmtZGjmtlZmNzYWYxYmxwysMAAAwMzAgZGYwM",
        },
        {
            provider = "wowhead",
            context = "farseer",
            label = "Delves",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAzMzsssNzMzMjZGjZMWMzCMgJYWYCMWwMDmtZGjmtlZmNzYWYxYmxwysMAAAwMzAgZGYwM",
        },
        {
            provider = "wowhead",
            context = "totemic",
            label = "Raid",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAzMzsssNjZGjZGzMDjFYDmxiGbDIzAbmhZw2YMTz2yMzmZMLsYegZGzwsMAAAwMzgZGAYwM",
        },
        {
            provider = "wowhead",
            context = "totemic",
            label = "Mythic+",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAzMzsstMzMzMjZGjZgFYDmxiGbDIzAbMzMY2mZMa2WmZ2MjZhFjZGDLzyAAAAzMDmZAgBzA",
        },
        {
            provider = "wowhead",
            context = "totemic",
            label = "Delves",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAzMzsstMzMzMjZGjZgFYDmxiGbDIzAbMzMY2mZMa2WmZ2MjZhFjZGDLzyAAAAzMDmZAgBzA",
        },
        {
            provider = "archon",
            context = "8.5%",
            label = "Alternative Class Tree #1",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZmZZbZMzMzYmZGzYYB2gZsox2AYGYDzMY2mZMaWWmZYGzGLGzMGWmlZAAYAMzgZGAGDG",
        },
        {
            provider = "archon",
            context = "7.9%",
            label = "Alternative Class Tree #2",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZmZZbZMzMzYmZGzYYB2gZsox2AYGYDzMY2mZMTzyyMDzY2YxYmxwysMAAYAMzgZGAGDG",
        },
        {
            provider = "archon",
            context = "3.3%",
            label = "Recommended Class Tree",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZmZZbZMzMzYmZGzYYB2gZsox2AYGYDzMY2mZmRzyyMDzY2YZGzMGMLDAAGAzMYmBgxgB",
        },
        {
            provider = "archon",
            context = "2.8%",
            label = "Alternative Class Tree #3",
            importString = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAjZmZZbZMzMzYmZGDDLwGMjFN2GAzAbYmBz2MjZaWWmZYGzGLmHYmxwysMAAYAMzgZGAGDG",
        },
    },
}

DragonSkillData["WARLOCK"] = DragonSkillData["WARLOCK"] or {}
DragonSkillData["WARLOCK"][265] = {
    scrapedAt = "2026-08-16T09:45:39.834Z",
    statPriority = {
        wowhead = "Hellcaller: Intellect > Haste > Critical Strike > Versatility > Mastery | Soul Harvester: Intellect > Haste > Critical Strike > Versatility > Mastery",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[npc=259446]", source = "Unknown", itemId = 273779 },
            { slot = "Head", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271874 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 271544 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 271549 },
            { slot = "Wrist", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 239648 },
            { slot = "Gloves", item = "[url guide=34245]Entombed Sentinels", source = "Unknown", itemId = 271547 },
            { slot = "Belt", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 239649 },
            { slot = "Legs", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 271545 },
            { slot = "Boots", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268255 },
            { slot = "Ring", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268252 },
            { slot = "Ring", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 273792 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[npc=136160]", source = "Unknown", itemId = 273649 },
            { slot = "[center][large]1[/large][/center]", item = "[item=270164 bonus=13335]", source = "Unknown", itemId = nil },
            { slot = "[center][large]2[/large][/center]", item = "[item=271092 bonus=13335]", source = "Unknown", itemId = nil },
            { slot = "[center][large]3[/large][/center]", item = "[item=273649 bonus=13335]", source = "Unknown", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast .", spellId = "48181" },
            { text = "Cast .", spellId = "980" },
            { text = "Cast .", spellId = "445465" },
            { text = "Cast .", spellId = "1257052" },
            { text = "Cast .", spellId = "205180" },
            { text = "Cast .", spellId = "442726" },
            { text = "Cast as many  as possible.", spellId = "316099" },
            { text = "Cast .", spellId = "1261149" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "hellcaller",
            label = "Raid",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZhhZmZmlBAAYmZZWmZmlxAAWgBmFjGzAysAWGAAAmBAAmZAzMjhZGmZMzMGMzMzAAmBG",
        },
        {
            provider = "wowhead",
            context = "hellcaller",
            label = "Raid Cleave",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMmZGNbM2mZGzyAAAmZmlZxMzyYAALwAziRjZAZ2ALDAAAzAAAzMYMjZmtxwYmZmZYYmZGAgZgB",
        },
        {
            provider = "wowhead",
            context = "hellcaller",
            label = "Mythic+",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMegZGNbzM2mZGz2AAAmZmlZxMzyYAALwAziRjZAZ2ALDAAAzAAAzMYMjxsNGzYmZmZYYmZGAgBMA",
        },
        {
            provider = "wowhead",
            context = "hellcaller",
            label = "Delves",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMegZGNbzM2mZGz2AAAmZmlZxMzyYAALwAziRjZAZ2ALDAAAzAAAzMYMjxsNGzYmZmZYYmZGAgBMA",
        },
        {
            provider = "wowhead",
            context = "soul",
            label = "Raid",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZhhZmZmlBAAYmZZ2mZmlxAAjllBGwEMDbBG2GAAAmBAAwMDzMjBzwMzMzMGMzMzAAmBG",
        },
        {
            provider = "wowhead",
            context = "soul",
            label = "Raid Cleave",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMmZGNbM2mZGzyAAAmZmlZxMzyYAgx2yADYCmhtADbDAAAzAAAYmZMjZmtxwYmZmZYYmZGAgZgB",
        },
        {
            provider = "wowhead",
            context = "soul",
            label = "Mythic+",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmx2MzYWGAAwMzsMLmZ2GDAM2WGYATwMsFYYbAAAYGAAAzMjZMzsNGzYMzMzYYmZGAgBMA",
        },
        {
            provider = "wowhead",
            context = "soul",
            label = "Delves",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmx2MzYWGAAwMzsMLmZ2GDAM2WGYATwMsFYYbAAAYGAAAzMjZMzsNGzYMzMzYYmZGAgBMA",
        },
        {
            provider = "archon",
            context = "32.6%",
            label = "Alternative Class Tree #1",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmZ2mZGzyAAAmZmlZzMzyYAgx2yADYAzwWghtBAAgZAAAMzMmxM2GjZMmZmZMMzMDAwAG",
        },
        {
            provider = "archon",
            context = "25.6%",
            label = "Recommended Class Tree",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMMzoZzMz2MzMzyAAAmZmlZzMzyYAgx2yADYAzwWghtBAAgZAAAMzMmxM2GjZMmZmZMMzMDAwAG",
        },
        {
            provider = "archon",
            context = "4.2%",
            label = "Alternative Class Tree #2",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMegZGNbmZ2mZGzyAAAmZmlZzMzyYAgx2yADYAzwWghtBAAgZAAAMzMmxM2GjZMmZmZMMzMDAwAG",
        },
        {
            provider = "archon",
            context = "1.9%",
            label = "Alternative Class Tree #3",
            importString = "CkQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmx2MzYWGAAwMzsMbmZWGDAM2WGYADYG2CMsNAAAMDAAgZmxMmZ2GjZMmZmZMMzMDAwAG",
        },
    },
}

DragonSkillData["WARLOCK"][266] = {
    scrapedAt = "2026-08-16T09:45:41.213Z",
    statPriority = {
        wowhead = "Diabolist: Intellect > Haste=Critical Strike > Mastery > Versatility | Soul Harvester: Intellect > Haste=Critical Strike > Mastery > Versatility",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[url guide=34245]Entombed Sentinels", source = "Unknown", itemId = 268197 },
            { slot = "Head", item = "[item=271874 original-item=34252]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271544 original-item=34262]", source = "[url guide=34247]The Lost Explorers", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271549 original-item=34264]", source = "[url guide=34248]Vashnik the Malignant", itemId = nil },
            { slot = "Wrist", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 239648 },
            { slot = "Gloves", item = "[item=271547 original-item=34251]", source = "[url guide=34245]Entombed Sentinels", itemId = nil },
            { slot = "Belt", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 239649 },
            { slot = "Legs", item = "[item=271545 original-item=34264]", source = "[url guide=34249]Sszorak", itemId = nil },
            { slot = "Boots", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268255 },
            { slot = "Ring", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268252 },
            { slot = "Ring", item = "[npc=133389]", source = "Unknown", itemId = 158366 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[npc=234649]", source = "Unknown", itemId = 250215 },
            { slot = "[center][large]1[/large][/center]", item = "[item=270164 bonus=13335]", source = "Unknown", itemId = nil },
            { slot = "[center][large]2[/large][/center]", item = "[item=271092 bonus=13335]", source = "Unknown", itemId = nil },
            { slot = "[center][large]3[/large][/center]", item = "[item=250215 bonus=13335]", source = "Unknown", itemId = nil },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Cast /.", spellId = "264130" },
            { text = "Cast .", spellId = "104316" },
            { text = "Cast /.", spellId = "105174" },
            { text = "Cast /.", spellId = "1276452" },
            { text = "Cast .", spellId = "265187" },
            { text = "Cast .", spellId = "1276672" },
            { text = "Cast  with .", spellId = "264178" },
            { text = "Cast /.[span class=tip tooltip=InfernalBolt][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "686" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "diabolist",
            label = "Raid",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAYmZMzoZjhZmxsMAAAAAAAgxMGWgB2GtQDLGjxysMzMjZAgZGzMzMzAMzMmZAAAGzMzMDDLzYAD",
        },
        {
            provider = "wowhead",
            context = "diabolist",
            label = "Raid Cleave",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAYmhZGNbmx2MzYWGAAAAAAAwYGDLwAbj2ohFjZGLz2MzMmBAmZMmZmZAmZGmZDAAMmZmxwwyMGwA",
        },
        {
            provider = "wowhead",
            context = "diabolist",
            label = "Mythic+",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAYmhZGNbmx2MzYWGAAAAAAAwYGDLwAbj2ohFjZGLz2MzMmBAmZMmZmZAmZGmZDAAMmZmxwwyMGwA",
        },
        {
            provider = "wowhead",
            context = "diabolist",
            label = "Delves",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAYmhZGNbmx2MzYWGAAAAAAAwYGDLwAbj2ohFjZGLz2MzMmBAmZMmZmZAmZGmZDAAMmZmxwwyMGwA",
        },
        {
            provider = "wowhead",
            context = "soul",
            label = "Raid",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAYmZMzoZjhZmxsMAAAAAAAjllBGwAmhlQGbmhZ2mlZmZMDAYMzMzAMzMzMmZAAAmZmZmZMDLDAD",
        },
        {
            provider = "wowhead",
            context = "soul",
            label = "Raid Cleave",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAYmhZGNbmx2MzYWGAAAAAAgxyyADYAzwSIjNDGLz2MzMmBAmxMzMDwMzMzwMbAAgZmZmxMD2mBwA",
        },
        {
            provider = "wowhead",
            context = "soul",
            label = "Mythic+",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAYmhZGNbmx2MzYWGAAAAAAgxyyADYAzwSIjNDGLjZmZmZAgZMzYGgZmZmhZ2AAAzMzMjZGsNzAMA",
        },
        {
            provider = "wowhead",
            context = "soul",
            label = "Delves",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAYmhZGNbmx2MzYWGAAAAAAgxyyADYAzwSIjNDGLz2MzMmBAmxMzMDwMzMzwMbAAgZmZmxMD2mBwA",
        },
        {
            provider = "archon",
            context = "19.3%",
            label = "Alternative Class Tree #1",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAwMmZGNbMz2MzYWGAAAAAAAwYGDLwAbDL0wixMjlZbmZGzAAzMGzMzMAjZMjNAAwYmZGDDLzYAD",
        },
        {
            provider = "archon",
            context = "11.8%",
            label = "Recommended Class Tree",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAwMmZGNbMz2MzY2GAAAAAAAwYGDLwAbDL0wixMjlZbmZGzAAzMGzMzMAjZMjNAAwYmZGDDLzYAD",
        },
        {
            provider = "archon",
            context = "4.9%",
            label = "Alternative Class Tree #2",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAwMMzoZzMz2MzMzyAAAAAAAAGzYYBGYbYhGWMmZsMbzMzYGAYmxYmZmBYMjZsBAAGzMzYYYZGDYA",
        },
        {
            provider = "archon",
            context = "3.8%",
            label = "Alternative Class Tree #3",
            importString = "CoQAAAAAAAAAAAAAAAAAAAAAAwMmZGNbMz2MzMz2AAAAAAAAGzYYBGYbYhGWMmZsMbzMzYGAYmxYmZmBYMDjNAAwYmZGDDLzYAD",
        },
    },
}

DragonSkillData["WARLOCK"][267] = {
    scrapedAt = "2026-08-16T09:45:41.685Z",
    statPriority = {
        wowhead = "Diabolist: Intellect > Haste > Mastery>=Critical Strike > Versatility | Hellcaller: Intellect > Haste > Mastery>=Critical Strike > Versatility",
        archon = "Intellect > Haste > Crit > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271092 },
            { slot = "Offhand", item = "[npc=259446]", source = "Unknown", itemId = 273779 },
            { slot = "Head", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271874 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 271544 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 271549 },
            { slot = "Wrist", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 239648 },
            { slot = "Gloves", item = "[url guide=34245]Entombed Sentinels", source = "Unknown", itemId = 271547 },
            { slot = "Belt", item = "[url guide=15942]Crafting", source = "Unknown", itemId = 239649 },
            { slot = "Legs", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 271545 },
            { slot = "Boots", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268255 },
            { slot = "Ring", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268252 },
            { slot = "Ring", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 273792 },
            { slot = "Trinket", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 270164 },
            { slot = "Trinket", item = "[url guide=34240]Nymrissa Wavecaller", source = "Unknown", itemId = 270167 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Maintain", spellId = "445468" },
            { text = "Cast  when available, and if you are about to cap on soul shards", spellId = "17877" },
            { text = "Cast  to avoid capping soul shards", spellId = "116858" },
            { text = "when available, and you have less than 4 soul shards", spellId = "6353" },
            { text = "Cast  to keep this below 2 stacks or when moving", spellId = "17962" },
            { text = "Cast  to generate soul shards and generate  stacks. Try to use these on  as much as possible.", spellId = "17962" },
            { text = "Cast  to generate soul shards", spellId = "29722" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "diabolist",
            label = "Raid",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjhZmZmlZzMzMLGjFzAAgZmxMzsAGzYYhMw2wGNWYAAgxAjNAMzAYmxYAAAYmZmBAwYYA",
        },
        {
            provider = "wowhead",
            context = "diabolist",
            label = "Mythic+",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmZ2mZGzysZmZmFzMLLzDMAAYGjZmZBMmxwCZgthFaswAAAjZYAAmZAGzYMbAAAmZmBAAGG",
        },
        {
            provider = "wowhead",
            context = "diabolist",
            label = "Cleave",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjhZmxsMLzMzMLGz2iZAAwMGzMzCYMjhFyAbDb0YhBAAGDwCAmZAmZGjZDAAwMzMAAMGG",
        },
        {
            provider = "wowhead",
            context = "diabolist",
            label = "Council",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMjZGNbmZ2mZGzysZmZmFzMLLzDMAAYGjZmZBMmxwCZgthFaswAAAjZYAAmZAGzYMbAAAmZmBAAGG",
        },
        {
            provider = "wowhead",
            context = "diabolist",
            label = "Delves",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjhZmxsMLzMzMLGz2iZAAwMGzMzCYMjhFyAbDb0YhBAAGDwCAmZAmZGjZDAAwMzMAAMGG",
        },
        {
            provider = "wowhead",
            context = "hellcaller",
            label = "Raid",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMmZGNLMzmZmZWmFzMzsYMWMDAAmZGzMziNYgZxoxMAmtYjBAAGDM2AAmZwYGzYDAAwMzMAAMGG",
        },
        {
            provider = "wowhead",
            context = "hellcaller",
            label = "Mythic+",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMjZGNLmxiZGzysNzMjFzYZZmBAAzgZmZxCMwsY0YGAzWsxAAAjZYAAwMDGzMmZDAAwMzMDAAzwA",
        },
        {
            provider = "wowhead",
            context = "hellcaller",
            label = "Cleave",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMmZGNLMzmZmZWmlZmZmFjZbxDMAAYGjZmZxGMwsY0YGAzWsxAAAjBGbAAzMYMjZsBAAYmZGAAGDD",
        },
        {
            provider = "wowhead",
            context = "hellcaller",
            label = "Council",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMjZGNLmxiZGzysNzMjFzYZZmBAAzgZmZxCMwsY0YGAzWsxAAAjZYAAwMDGzMmZDAAwMzMDAAzwA",
        },
        {
            provider = "wowhead",
            context = "hellcaller",
            label = "Delves",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMjZGNLmxiZGzysNzMjFzYZZmBAAzgZmZxCMwsY0YGAzWsxAAAjZYAAwMDGzMmZDAAwMzMDAAzwA",
        },
        {
            provider = "archon",
            context = "23.5%",
            label = "Alternative Class Tree #1",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMjZGNLMz2MzMzysZmZmFzMLLjBAAzYMzMLgxMGWgB2GWoxCDAAMGMAAzMAjZMDAAAmZmZAAYGG",
        },
        {
            provider = "archon",
            context = "9.7%",
            label = "Alternative Class Tree #2",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMMzoZZmZ2mZGzysZmZmFzMLLjBAAzYMzMLgxMGWgB2GWoxCDAAMGMAAzMAzMDjNAAAzMzAAgZYA",
        },
        {
            provider = "archon",
            context = "7.4%",
            label = "Alternative Class Tree #3",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAwMmZGNbjx2MzYWmNzMzsYmZZZMAAYGjZmZBMmxwCMw2wCNWYAAgxgBAYmBYMjZGAAAmZmBAAzwA",
        },
        {
            provider = "archon",
            context = "1.9%",
            label = "Recommended Class Tree",
            importString = "CsQAAAAAAAAAAAAAAAAAAAAAAgxMzoZjZ2mZmZ2mNzMzsYmZZZMAAYGjZmZBMmxwCMw2wCNWYAAgxgBAYmBYMjZsBAAYmZGAAMDD",
        },
    },
}

DragonSkillData["WARRIOR"] = DragonSkillData["WARRIOR"] or {}
DragonSkillData["WARRIOR"][71] = {
    scrapedAt = "2026-08-16T09:45:42.169Z",
    statPriority = {
        wowhead = "Colossus: Strength > Critical Strike > Haste > Mastery > Versatility | Slayer: Strength > Critical Strike > Haste > Mastery > Versatility",
        archon = "Strength > Crit > Haste > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Item Slot", item = "Name", source = "Source", itemId = nil },
            { slot = "Helm", item = "[url guide=34250]The Twin Fangs", source = "Unknown", itemId = 271456 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271454 original-item=271444]", source = "[url guide=34224]BoE Trash Drop", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271459 original-item=268222]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Bracers", item = "[item=237834 bonus=12066:13622:9627:8791:8960:13767]", source = "[url guide=15942]Crafted", itemId = nil },
            { slot = "Gloves", item = "[url guide=34245]Entombed Sentinels", source = "Unknown", itemId = 271457 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268259 },
            { slot = "Legs", item = "[item=271455 original-item=271878]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Boots", item = "[item=237828 bonus=12066:13622:9627:8791:8960:13767]", source = "[url guide=15942]Crafted", itemId = nil },
            { slot = "Ring", item = "[url guide=33183]Voidscar Arena", source = "Unknown", itemId = 252258 },
            { slot = "Ring", item = "[url guide=34264]Altar of Fangs", source = "Unknown", itemId = 273792 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Mainhand", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268213 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "slayer",
            label = "Raid ST",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMzMmZGAAAghphxYmxyMzMzgxMDAAAAgZWmZAhxyyAbgBMDTIzgNwMjtx2ALzsMAzMAYGGA",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Raid MT",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMzYmZGAAAghphxYmxyMzMzgxMDAAAAgxyMDMhxy2AbgBMDTIzgNwMjtx2gZZmtBYmBAzwA",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Mythic+",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmZmFzYmZGAAAghphxYmZzMzMzYmxMDAAAAgxyMDMhxy2AbgBMDTIzgNwMDDDmlZ2GgZGAMDDA",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Delving",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmZmFzYmZGAAAghphxYmZzMzMzYmxMDAAAAgxyMDMhxy2AbgBMDTIzgNwMDDDmlZ2GgZGAMDDA",
        },
        {
            provider = "wowhead",
            context = "colossus",
            label = "ST Raid",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMzwMDAAAghphxYmxyMzMzgxMDAAAAgZ2mZABwmZMsBDMj2oxgFwMjtx2MzmlZWGMzAAMDDA",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "MT Raid",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphxYmxyMzMzgxMDAAAAgxmZgJLAbmxwCMwMajGDWAzM2GbjxsZ2GMzAAMDDA",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Mythic+",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphxYmZzMzMzYmxMDAAAAgxmZgJLAbmxwCMwMajGDWAzMMMGzmZbwMDAwMMA",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Delving",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphxYmZzMzMzYmxMDAAAAgxmZgJLAbmxwCMwMajGDWAzMMMGzmZbwMDAwMMA",
        },
        {
            provider = "archon",
            context = "17.0%",
            label = "Alternative Class Tree #1",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphZGmZbZmZmZYGzMAAAAAGbmB2iBsZGDLwAzwGNGsAmZYYwsZ2GMzAAMzwA",
        },
        {
            provider = "archon",
            context = "16.7%",
            label = "Recommended Class Tree",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphZGzMbmZmZGmxMDAAAAgxmZgtYAbmxwCMwMsRjBLgZGGGMbmtBzMAAzMMA",
        },
        {
            provider = "archon",
            context = "12.4%",
            label = "Alternative Class Tree #2",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphxwMbLzMzMjZGzMAAAAAGbmB2iBsZGDLwAzwGNGsAMDGDmNz2gZGAwMzwA",
        },
        {
            provider = "archon",
            context = "7.2%",
            label = "Alternative Class Tree #3",
            importString = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphZGmZzMzMzYmxMDAAAAgxmZgtYAbmxwCMwMsRjBLgZGGGMbmtBzMAAzMMA",
        },
    },
}

DragonSkillData["WARRIOR"][72] = {
    scrapedAt = "2026-08-16T09:45:42.674Z",
    statPriority = {
        wowhead = "Mountain Thane: Strength > Haste > Mastery > Critical Strike > Versatility | Slayer: Strength > Haste > Mastery > Critical Strike > Versatility",
        archon = "Strength > Haste > Mastery > Crit > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Item Slot", item = "Name", source = "Source", itemId = nil },
            { slot = "Helm", item = "[item=271456 original-item=251126]", source = "[url guide=33189]Murder Row", itemId = nil },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[item=271454 original-item=251138]", source = "[url guide=33189]Murder Row", itemId = nil },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[item=271459 original-item=268222]", source = "[url guide=34251]The Coiled Altar", itemId = nil },
            { slot = "Bracers", item = "[item=237834 bonus=12066:13622:9627:8791:8960:13767]", source = "[url guide=15942]Crafted", itemId = nil },
            { slot = "Gloves", item = "[item=271457 original-item=251214]", source = "[url guide=33190]Den of Nalorakk", itemId = nil },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268259 },
            { slot = "Legs", item = "[item=271455 original-item=271878]", source = "[url guide=34252]Ula'tek", itemId = nil },
            { slot = "Boots", item = "[item=237828 bonus=12066:13622:9627:8791:8960:13767]", source = "[url guide=15942]Crafted", itemId = nil },
            { slot = "Ring", item = "[url guide=33183]Voidscar Arena", source = "Unknown", itemId = 252258 },
            { slot = "Ring", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
            { slot = "Mainhand", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268213 },
            { slot = "Offhand", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268214 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "slayer",
            label = "Raid ST",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDzMmZ2MzMzMDjZmZGzMzsMzMmZmZzYmBAAixy2ALgJYGmAzwGwMDjNAAYmhxYYMYM",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Raid MT",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjxMzmZmZmZYMzMzMzYmlZMmZMbmZmBAAixy2ALgJYGmAzwGwMzmxGAAMzwYWGGDGD",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Mythic+",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjxMzmZmZmZmZMzMzMzYmlZMmZMbmZmBAAixy2ALgJYGmAzwGwMzmBAAYmhxsMwgxA",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Delving",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjxMzmZmZmZmZMzMzMzYmlZMmZMbmZmBAAixy2ALgJYGmAzwGwMzmBAAYmhxsMwgxA",
        },
        {
            provider = "wowhead",
            context = "mountain",
            label = "ST Raid",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZmZ2MzMzMDjZmZGzMzsMzMzMjZ5BGzMAAQYgNYZxoxMgMLYYBwMMzGAMzAMGYMgxA",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "MT Raid",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZmZ2WmZmZMMmZmZmZMzyMzMzMmFzMzAAAhB2glFjGzAysgZsAYmNGAwMDADLmBYM",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Mythic+",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZMz2yMzMjZmxMzMzMjZWmZmZmxsYmZGAAIMwGssY0YGQmFMjFAzgBAMzAwwiZAGD",
        },
        {
            provider = "wowhead",
            context = nil,
            label = "Delving",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZMz2yMzMjZmxMzMzMjZWmZmZmxsYmZGAAIMwGssY0YGQmFMjFAzgBAMzAwwiZAGD",
        },
        {
            provider = "archon",
            context = "40.6%",
            label = "Alternative Class Tree #1",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZMz2yMzMjZmxMjZMjZWmZGjZmlxMzAAAhB2glFjGzAYWwMWAMDGDAmZAMMzMDGM",
        },
        {
            provider = "archon",
            context = "13.1%",
            label = "Alternative Class Tree #2",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZMjlZmZGzMjZGzYGzsMzMGzMLjZmBAACDsBLLGNmBwsgZsAYGMbDAmZAMMzMDGM",
        },
        {
            provider = "archon",
            context = "4.1%",
            label = "Alternative Class Tree #3",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZMz2yMzMjxMmZMjZMzyMzYMzsMmZGAAIMwGssY0YGAzCmxCgZwYAwMDghZmZGGM",
        },
        {
            provider = "archon",
            context = "0.4%",
            label = "Recommended Class Tree",
            importString = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDjZmZ2MzMzMjZMzYGzYmlZmxYmZZMzMAAQYgNYZxoxMAmFMsAYGMGAMzAYYmZmhBD",
        },
    },
}

DragonSkillData["WARRIOR"][73] = {
    scrapedAt = "2026-08-16T09:45:43.505Z",
    statPriority = {
        wowhead = "Survivability: Strength > Haste > Critical Strike > Versatility > Mastery | DPS: Strength > Haste > Critical Strike > Versatility > Mastery",
        archon = "Strength > Haste > Crit > Mastery > Vers",
    },
    statAverages = {
        archon = {
        },
    },
    bisGear = {
        wowhead = {
            { slot = "Slot", item = "Item", source = "Source", itemId = nil },
            { slot = "Weapon", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268209 },
            { slot = "Shield", item = "[url guide=34247]The Lost Explorers", source = "Unknown", itemId = 268196 },
            { slot = "Head", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271456 },
            { slot = "Neck", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 268265 },
            { slot = "Shoulders", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271454 },
            { slot = "Cloak", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268253 },
            { slot = "Chest", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271459 },
            { slot = "Wrist", item = "[url guide=15942]Crafting Blacksmithing", source = "Unknown", itemId = 237834 },
            { slot = "Gloves", item = "[url guide=34180]Tier Set", source = "Unknown", itemId = 271457 },
            { slot = "Belt", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 268259 },
            { slot = "Legs", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 271878 },
            { slot = "Boots", item = "[url guide=15942]Crafting Blacksmithing", source = "Unknown", itemId = 237828 },
            { slot = "Ring", item = "[url guide=34249]Sszorak", source = "Unknown", itemId = 268252 },
            { slot = "Ring 2", item = "[url guide=34248]Vashnik the Malignant", source = "Unknown", itemId = 268249 },
            { slot = "Trinket", item = "[url guide=34251]The Coiled Altar", source = "Unknown", itemId = 270173 },
            { slot = "Trinket 2", item = "[url guide=34252]Ula'tek", source = "Unknown", itemId = 270175 },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Always  into combat.", spellId = "100" },
            { text = "on cooldown.", spellId = "436358" },
            { text = "on cooldown.", spellId = "23922" },
            { text = "on cooldown and to apply .", spellId = "6343" },
            { text = "Spend excess Rage on .", spellId = "190456" },
            { text = "targets at or below 20%(35% if you have the talent) health.", spellId = "163201" },
            { text = "Use  if you have low HP!", spellId = "202168" },
        },
    },
    trinkets = {
        archon = {
        },
    },
    talentBuilds = {
        {
            provider = "wowhead",
            context = "colossus",
            label = "Raid",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAzMDzMzMzMzmxsMjxYmGmZGLjZmZYGzMAAAAYZAYGDAsZGDbkBmhFaMzCMDzgZDAwMDAYAjB",
        },
        {
            provider = "wowhead",
            context = "colossus",
            label = "Mythic+",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAjZYmZmZGzmZmlZMGz0YGzYZMzMDzYmBAAAALDAzYAgNzYYjMwMsQjZWgZGzgZDAwMDAYAjB",
        },
        {
            provider = "wowhead",
            context = "colossus",
            label = "Delves",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAjZYmZmZGzmZmlZMGz0YGzYZMzMDzYmBAAAALDAzYAgNzYYjMwMsQjZWgZGzgZDAwMDAYAjB",
        },
        {
            provider = "wowhead",
            context = "mountain",
            label = "Raid",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAzMzYmZGzY2MzsMjxYmGmZYZMzMDzYmBAAAAbDAzYAGYD2WMaMDgZLmZDmxMDmNAYmBAgBMG",
        },
        {
            provider = "wowhead",
            context = "mountain",
            label = "Mythic+",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAjZGzMzYGzmZmlZMGjGzYGLzMzMDzYmBAAAALDAzYAGYD2WMaMDgZJmZDmZMDmFAYmBAgBMG",
        },
        {
            provider = "wowhead",
            context = "mountain",
            label = "Delves",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAjZGzMzYGzmZmlZMGjGzYGLzMzMDzYmBAAAALDAzYAGYD2WMaMDgZJmZDmZMDmFAYmBAgBMG",
        },
        {
            provider = "archon",
            context = "29.2%",
            label = "Recommended Class Tree",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzwMzMzMmNzMLzYMGNmxwyMmZGzwMDAAAAWmZAmxAMwGssY0YGAzCmZDGzMDjtBAzMAAMDYA",
        },
        {
            provider = "archon",
            context = "17.6%",
            label = "Alternative Class Tree #1",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzwMzMzMmNzMLzYMGNmxwiZmZGzwMDAAAAWmZAmxAMwGssY0YGAzCmZDGzMDmtBAzMAAMDYA",
        },
        {
            provider = "archon",
            context = "7.3%",
            label = "Alternative Class Tree #2",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzwMzMzMmNzMLzYMGNmxYbxMzMjZYmBAAAALzMAzYAGYDWWMaMDgZBzsBjZmBjBAzMAAMDYA",
        },
        {
            provider = "archon",
            context = "6.9%",
            label = "Alternative Class Tree #3",
            importString = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAGzwMzMzMmNzMLzYMGNmxwyMmZGmxMDAAAAWmZAmxAMwGssY0YGAzCmZDGzMDmtBAzMAAMDYA",
        },
    },
}

