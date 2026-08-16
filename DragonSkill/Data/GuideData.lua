-- AUTO-GENERATED von build-data.js - nicht manuell bearbeiten
-- Quelle: Wowhead / Archon

DragonSkillData = DragonSkillData or {}

DragonSkillData["DEATHKNIGHT"] = DragonSkillData["DEATHKNIGHT"] or {}
DragonSkillData["DEATHKNIGHT"][250] = {
    scrapedAt = "2026-08-16T10:00:48.505Z",
    statPriority = {
        wowhead = "San'layn: Strength > Haste > Mastery / Critical Strike / Versatility | Deathbringer: Strength > Critical Strike > Mastery / Versatility > Haste",
        archon = "Strength > Mastery > Crit > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268213, slot = "Weapon" },
            { text = "[item=271474 original-item=268229]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271472 original-item=239037]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271477 original-item=268222]", itemId = nil, slot = "Chest" },
            { text = "[url guide=15942]Crafting", itemId = 237834, slot = "Wrist" },
            { text = "[item=271475 original-item=159413]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268259, slot = "Belt" },
            { text = "[url guide=34252]Ula'tek", itemId = 271878, slot = "Legs" },
            { text = "[url guide=34264]Altar of Fangs", itemId = 273777, slot = "Boots" },
            { text = "[url guide=15942]Crafting", itemId = 273066, slot = "Ring ()" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=33193]Blinding Vale", itemId = 251194, slot = "Ring" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268213, slot = "Weapon" },
            { text = "[item=271474 original-item=268229]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271472 original-item=239037]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271477 original-item=268222]", itemId = nil, slot = "Chest" },
            { text = "[url guide=15942]Crafting", itemId = 237834, slot = "Wrist" },
            { text = "[item=271475 original-item=159413]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268259, slot = "Belt" },
            { text = "[url guide=34252]Ula'tek", itemId = 271878, slot = "Legs" },
            { text = "[url guide=34264]Altar of Fangs", itemId = 273777, slot = "Boots" },
            { text = "[url guide=15942]Crafting", itemId = 273066, slot = "Ring ()" },
            { text = "[url guide=34260]King's Rest", itemId = 159459, slot = "Ring" },
            { text = "[url guide=33183]Voidscar Arena", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
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
                "[item=273066]",
                "[item=240167]",
                "[item=273069] ([symbol=wow-hero-talent-sanlayn] [color=#CE655E]San'layn[/color])",
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
    scrapedAt = "2026-08-16T10:00:48.899Z",
    statPriority = {
        wowhead = "Deathbringer: Strength > Critical Strike > Mastery > Haste > Versatility | Rider of the Apocalypse: Strength > Critical Strike > Mastery > Haste > Versatility",
        archon = "Strength > Mastery > Crit > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 268202, slot = "Weapon" },
            { text = "[url guide=34252]Ula'tek", itemId = 268202, slot = "Offhand" },
            { text = "[url guide=34180]Tier Set", itemId = 271474, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34180]Tier Set", itemId = 271472, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268222, slot = "Chest" },
            { text = "[item=237834 bonus=8793:8960:12214:13454:13750:13751:13836:12497]", itemId = nil, slot = "Wrist" },
            { text = "[url guide=34180]Tier Set", itemId = 271475, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268259, slot = "Belt" },
            { text = "[url guide=34252]Ula'tek", itemId = 271878, slot = "Legs" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268260, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=15942]Crafting/Misc", itemId = 251513, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
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
                "[item=251513]",
                "[item=251490]",
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "if you have 2 charges", spellId = "47568" },
            { text = "if you have 2  stacks, or 1  and  [span class=tip tooltip=two-km][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "49020" },
            { text = "with", spellId = "49184" },
            { text = "to avoid Runic Power waste [span class=tip tooltip=breath-pooling][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "49143" },
            { text = "with  [span class=tip tooltip=rm-pooling][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "49020" },
            { text = "to generate", spellId = "47568" },
            { text = "without  [span class=tip tooltip=naked-oblit][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "49020" },
            { text = "[span class=tip tooltip=naked-hb][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "49184" },
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
    scrapedAt = "2026-08-16T10:00:49.328Z",
    statPriority = {
        wowhead = "San'layn: Strength > Mastery > Crit > Haste > Versatility | Rider of the Apocalypse: Strength > Mastery > Crit > Haste > Versatility",
        archon = "Strength > Mastery > Crit > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268213, slot = "Weapon" },
            { text = "[url guide=34180]Tier Set", itemId = 271474, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34180]Tier Set", itemId = 271472, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34180]Tier Set", itemId = 271477, slot = "Chest" },
            { text = "[url guide=15942]Crafting", itemId = 237834, slot = "Wrist" },
            { text = "[url guide=34180]Tier Set", itemId = 271475, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268259, slot = "Belt" },
            { text = "[url guide=34252]Ula'tek", itemId = 271878, slot = "Legs" },
            { text = "[url guide=15942]Crafting", itemId = 237828, slot = "Boots" },
            { text = "[url guide=34264]Altar of Fangs", itemId = 273792, slot = "Ring" },
            { text = "[url guide=33183]Voidscar Arena]", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "Buff", itemId = nil, slot = "Type" },
            { text = "[spell=1252486]", itemId = nil, slot = "Elemental, Abberation, Demon" },
            { text = "[spell=1252487]", itemId = nil, slot = "Beast, Mechanical" },
            { text = "[spell=1252488]", itemId = nil, slot = "Humanoid, Dragonkin" },
            { text = "[spell=1252489]", itemId = nil, slot = "Undead, Giant, Not Specified" },
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
                "[item=240166]",
                "[item=245876] (Early season only)",
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
    scrapedAt = "2026-08-16T10:00:49.752Z",
    statPriority = {
        wowhead = "Fel-Scarred: Agility > Critical Strike > Mastery > Haste > Versatility | Aldrachi Reaver: Agility > Critical Strike > Mastery > Haste > Versatility",
        archon = "Agility > Crit > Mastery > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268209, slot = "Weapon" },
            { text = "[url guide=15942]Crafting/Misc", itemId = 237840, slot = "Offhand" },
            { text = "[url guide=34252]Ula'tek", itemId = 271875, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271535 original-item=268246]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271540 original-item=239048]", itemId = nil, slot = "Chest" },
            { text = "[url guide=15942]Crafting/Misc", itemId = 244576, slot = "Wrist" },
            { text = "[url guide=34245]Entombed Sentinels", itemId = 271538, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268256, slot = "Belt" },
            { text = "[item=271536 original-item=268225]", itemId = nil, slot = "Legs" },
            { text = "[url guide=34262]Temple of Sethraliss", itemId = 159327, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=34262]Temple of Sethraliss", itemId = 158366, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
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
                "[item=273060]",
                "[item=240167]",
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
    scrapedAt = "2026-08-16T10:00:50.161Z",
    statPriority = {
        wowhead = "Aldrachi Reaver: Item Level (Agility+Stamina) > Haste > Crit > Versatility > Mastery | Annihilator: Item Level (Agility+Stamina) > Haste > Crit > Versatility > Mastery",
        archon = "Agility > Haste > Crit > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268209, slot = "Weapon" },
            { text = "Crafted", itemId = 237840, slot = "Offhand" },
            { text = "[item=271537 original-item=271875]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271535 original-item=251223]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 271540, slot = "Chest" },
            { text = "Crafted", itemId = 244576, slot = "Wrist" },
            { text = "[item=271538 original-item=251124]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268256, slot = "Belt" },
            { text = "[item=271536 original-item=268225]", itemId = nil, slot = "Legs" },
            { text = "[url guide=33190]Den of Nalorakk", itemId = 251153, slot = "Boots" },
            { text = "[url guide=34249]Sszorak", itemId = 268252, slot = "Ring" },
            { text = "[url guide=34260]King's Rest", itemId = 159459, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket (Raw Damage)" },
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
                "[item=245876]",
                "[item=240167]",
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
    scrapedAt = "2026-08-16T10:00:50.575Z",
    statPriority = {
        wowhead = "Annihilator: Intellect > Haste > Mastery > Critical Strike > Versatility | Void-Scarred: Intellect > Haste (until 800/18%-20%) > Critical Strike > Mastery > Versatility > Haste (above 800/18%-20%).",
        archon = "Intellect > Mastery > Haste > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268211, slot = "Offhand" },
            { text = "[item=271537 original-item=271875]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271535 original-item=251223]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271540 original-item=251159]", itemId = nil, slot = "Chest" },
            { text = "crafted with", itemId = 244576, slot = "Wrist" },
            { text = "[url guide=34180]Tier Set", itemId = 271538, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268256, slot = "Belt" },
            { text = "[item=271536 original-item=268225]", itemId = nil, slot = "Legs" },
            { text = "crafted with", itemId = 244569, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=34262]Temple of Sethraliss", itemId = 158366, slot = "Ring" },
            { text = "[url guide=33189]Murder Row", itemId = 250215, slot = "Trinket" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
            { text = "Intellect", itemId = nil },
            { text = "Haste (until 800/18%-20%)", itemId = nil },
            { text = "Critical Strike", itemId = nil },
            { text = "Mastery", itemId = nil },
            { text = "Versatility", itemId = nil },
            { text = "Haste (above 800/18%-20%).", itemId = nil },
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
                "[item=240166]",
                "[item=240166]",
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
    scrapedAt = "2026-08-16T10:00:50.945Z",
    statPriority = {
        wowhead = "Keeper of the Grove: Intellect > Mastery > Haste = Critical Strike > Versatility | Elune's Chosen: Intellect > Mastery > Haste > Critical Strike > Versatility",
        archon = "Intellect > Mastery > Haste > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[item=245769 bonus=8791:13771:8960:13751:12497:13836]", itemId = nil, slot = "Offhand" },
            { text = "[item=271875 bonus=13848:13847:13750]", itemId = nil, slot = "Head" },
            { text = "[item=268265 bonus=13848:13708]", itemId = nil, slot = "Neck" },
            { text = "[item=244572 bonus=8791:13836:13751:13836:9627:8960:12384]", itemId = nil, slot = "Shoulders" },
            { text = "[item=268253 bonus=13848:13708]", itemId = nil, slot = "Cloak" },
            { text = "[url guide=33190]Den of Nalorakk", itemId = 251159, slot = "Chest" },
            { text = "[item=268240 bonus=13750]", itemId = nil, slot = "Wrist" },
            { text = "[url guide=34180]Tier Set", itemId = 268234, slot = "Gloves" },
            { text = "[item=268256 bonus=13750:13848:13708]", itemId = nil, slot = "Belt" },
            { text = "[item=268225 bonus=13848:13708]", itemId = nil, slot = "Legs" },
            { text = "[url guide=33190]Den of Nalorakk", itemId = 251153, slot = "Boots" },
            { text = "[item=252258 bonus=13750]", itemId = nil, slot = "Ring" },
            { text = "[item=268249 bonus=13750]", itemId = nil, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[url guide=34264]Altar of Fangs", itemId = 273796, slot = "Trinket" },
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
                "[item=240167]",
                "[item=273059]",
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
    scrapedAt = "2026-08-16T10:00:51.398Z",
    statPriority = {
        wowhead = "Druid of the Claw: Agility > Mastery > Haste > Critical Strike > Versatility | Wildstalker: Agility > Mastery > Critical Strike > Haste > Versatility",
        archon = "Agility > Mastery > Haste > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 268215, slot = "Weapon" },
            { text = "[url guide=33219] Catalyst", itemId = 271528, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=33219] Catalyst", itemId = 271526, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 271531, slot = "Chest" },
            { text = "[url guide=15942]Crafting/Misc", itemId = 244576, slot = "Wrist" },
            { text = "[url guide=15942]Crafting/Misc", itemId = 244575, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268256, slot = "Belt" },
            { text = "[url guide=33219] Catalyst", itemId = 271527, slot = "Legs" },
            { text = "[url guide=34250]The Twin Fangs", itemId = 268261, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=33183]Voidscar Arena", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
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
                "[item=240166]",
                "[item=240166]",
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
    scrapedAt = "2026-08-16T10:00:51.874Z",
    statPriority = {
        wowhead = "Survivability: Agility > Haste > Versatility > Critical Strike > Mastery | DPS: Agility > Haste > Versatility > Critical Strike > Mastery",
        archon = "Agility > Haste > Mastery > Vers > Crit",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 268215, slot = "Weapon" },
            { text = "[url guide=34252]Ula'tek", itemId = 271875, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34180]Tier Set", itemId = 271526, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34180]Tier Set", itemId = 271531, slot = "Chest" },
            { text = "[url guide=34244]Nek'zali the Soulcoiler", itemId = 268240, slot = "Wrist" },
            { text = "[url guide=34180]Tier Set", itemId = 271529, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268256, slot = "Belt" },
            { text = "[url guide=34180]Tier Set", itemId = 271527, slot = "Legs" },
            { text = "[url guide=34250]The Twin Fangs", itemId = 268261, slot = "Boots" },
            { text = "[url guide=34249]Sszorak", itemId = 268252, slot = "Ring" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring 2" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket 2" },
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
                "[item=245876]",
                "[item=240166]",
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
    scrapedAt = "2026-08-16T10:00:52.333Z",
    statPriority = {
        wowhead = "Keeper of the Grove: Intellect > Haste > Mastery > Versatility > Critical Strike | Wildstalker: Intellect > Haste > Mastery > Versatility > Critical Strike",
        archon = "Intellect > Haste > Mastery > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[color=q4][item=271528 original-item=271875][/color]", itemId = nil, slot = "Helm" },
            { text = "[color=q4][/color]", itemId = 268251, slot = "Neck" },
            { text = "[color=q4][/color]", itemId = 244572, slot = "Shoulders" },
            { text = "[color=q4][/color]", itemId = 268253, slot = "Cape" },
            { text = "[color=q4][item=271531 original-item=268235][/color]", itemId = nil, slot = "Chest" },
            { text = "[color=q4][/color]", itemId = 244576, slot = "Bracers" },
            { text = "[color=q4][/color]", itemId = 271529, slot = "Gloves" },
            { text = "[color=q4][/color]", itemId = 268256, slot = "Belt" },
            { text = "[color=q4][item=271527 original-item=268225][/color]", itemId = nil, slot = "Legs" },
            { text = "[color=q4][/color]", itemId = 244569, slot = "Boots" },
            { text = "[color=q4][/color]", itemId = 268266, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 252258, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 270167, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 270162, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 271092, slot = "1h Weapon" },
            { text = "[color=q4][/color]", itemId = 268197, slot = "Offhand" },
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[color=q4][item=271528 original-item=251140][/color]", itemId = nil, slot = "Helm" },
            { text = "[color=q4][/color]", itemId = 251142, slot = "Neck" },
            { text = "[color=q4][/color]", itemId = 244572, slot = "Shoulders" },
            { text = "[color=q4][/color]", itemId = 251190, slot = "Cape" },
            { text = "[color=q4][item=271531 original-item=251159][/color]", itemId = nil, slot = "Chest" },
            { text = "[color=q4][/color]", itemId = 244576, slot = "Bracers" },
            { text = "[color=q4][item=271529 original-item=159337][/color]", itemId = nil, slot = "Gloves" },
            { text = "[color=q4][/color]", itemId = 159317, slot = "Belt" },
            { text = "[color=q4][item=271527 original-item=159313][/color]", itemId = nil, slot = "Legs" },
            { text = "[color=q4][/color]", itemId = 251153, slot = "Boots" },
            { text = "[color=q4][/color]", itemId = 159459, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 252258, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 250214, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 250255, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 159636, slot = "2h Weapon" },
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
                "[item=240167][i] (Ideal, armor-only)[/i]",
                "[item=245876][i] (Worse, offhands & weapons only)[/i]",
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
    scrapedAt = "2026-08-16T10:00:52.796Z",
    statPriority = {
        wowhead = "Flameshaper: Intellect > Critical Strike > Mastery > Haste > Versatility | Scalecommander: Intellect > Critical Strike > Mastery > Haste > Versatility",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[item=245769 bonus=13836:9627:13771:8960:8791]", itemId = nil, slot = "Offhand" },
            { text = "[item=271501 original-item=268230]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271499 original-item=268231]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271504 original-item=271876]", itemId = nil, slot = "Chest" },
            { text = "[item=244584 bonus=13667:12497:8960:12384:13836:8791]", itemId = nil, slot = "Wrist" },
            { text = "[item=271502 original-item=193752]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268254, slot = "Belt" },
            { text = "[item=271500 original-item=268237]", itemId = nil, slot = "Legs" },
            { text = "[url guide=34249]Sszorak", itemId = 268233, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=34262]Temple of Sethraliss", itemId = 158366, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[url guide=34240]Nymrissa Wavecaller", itemId = 270167, slot = "Trinket" },
            { text = "Location", itemId = nil, slot = "Priority" },
            { text = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c13][/icon] [url guide=34252]Ula'tek (Heroic & Mythic)", itemId = nil, slot = "[large][color=necrolord]1[/color][/large]" },
            { text = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c13][/icon] [url guide=34251]Coiled Altar (Mythic)", itemId = nil, slot = "[large][color=rogue]2[/color][/large]" },
            { text = "[icon name=8039569 inline=true size=small type=round color=c13][/icon] [url guide=34045] Early Mythic Bosses or Dungeons", itemId = nil, slot = "[large][color=druid]3[/color][/large]" },
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
                "[item=273060]",
                "[item=240167]",
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
    scrapedAt = "2026-08-16T10:00:53.224Z",
    statPriority = {
        wowhead = "Raid: Intellect > Mastery > Crit > Haste > Versatility | Mythic+: Intellect > Crit [i][/i] > Haste > Mastery > Versatility",
        archon = "Intellect > Mastery > Haste > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[color=q4][item=271501 original-item=239035][/color]", itemId = nil, slot = "Helm" },
            { text = "[color=q4][/color]", itemId = 268265, slot = "Neck" },
            { text = "[color=q4][item=271499 original-item=268231][/color]", itemId = nil, slot = "Shoulders" },
            { text = "[color=q4][/color]", itemId = 268253, slot = "Cape" },
            { text = "[color=q4][item=271504 original-item=271876][/color]", itemId = nil, slot = "Chest" },
            { text = "[color=q4][/color]", itemId = 268217, slot = "Bracers" },
            { text = "[color=q4][item=271502 original-item=160213][/color]", itemId = nil, slot = "Gloves" },
            { text = "[color=q4][/color]", itemId = 268254, slot = "Belt" },
            { text = "[color=q4][item=271500 original-item=268237][/color]", itemId = nil, slot = "Legs" },
            { text = "[color=q4][/color]", itemId = 159388, slot = "Boots" },
            { text = "[color=q4][/color]", itemId = 268249, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 158366, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 270164, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 270162, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 271092, slot = "1h Weapon" },
            { text = "[color=q4][/color]", itemId = 268197, slot = "Offhand" },
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
                "[item=240167][i] (Ideal, but can only be attached to armor items)[/i]",
                "[item=245876][i] (Worse, but can be put on an early Offhand)[/i]",
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
    scrapedAt = "2026-08-16T10:00:53.638Z",
    statPriority = {
        wowhead = "Chronowarden: Intellect > Mastery > Critical Strike > Haste > Versatility | Scalecommander: Intellect > Mastery > Critical Strike > Haste > Versatility",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[item=245769 bonus=13836:9627:13771:8960:8791]", itemId = nil, slot = "Offhand" },
            { text = "[item=271501 original-item=239035]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271499 original-item=268231]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271504 original-item=271876]", itemId = nil, slot = "Chest" },
            { text = "[item=244584 bonus=13667:12497:8960:12384:13836:8791]", itemId = nil, slot = "Wrist" },
            { text = "[item=271502 original-item=193752]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268254, slot = "Belt" },
            { text = "[item=271500 original-item=268237]", itemId = nil, slot = "Legs" },
            { text = "[url guide=34249]Sszorak", itemId = 268233, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=34262]Temple of Sethraliss", itemId = 158366, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[url guide=33189]Murder Row", itemId = 250215, slot = "Trinket" },
            { text = "Location", itemId = nil, slot = "Priority" },
            { text = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c7][/icon] [url guide=34252]Ula'tek (Heroic & Mythic)", itemId = nil, slot = "[large][color=necrolord]1[/color][/large]" },
            { text = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c7][/icon] [url guide=34251]Coiled Altar (Mythic)", itemId = nil, slot = "[large][color=rogue]2[/color][/large]" },
            { text = "[icon name=8039569 inline=true size=small type=round color=c7][/icon] [url guide=34045] Early Mythic Bosses", itemId = nil, slot = "[large][color=druid]3[/color][/large]" },
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
                "[item=273060]",
                "[item=240167]",
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "Maintain  on allied DPS players. - [span class=tip tooltip=prescience][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "409311" },
            { text = "Cast  if a few seconds or less remain on the active buff duration.", spellId = "395152" },
            { text = "Cast  (see section on cooldown usage for more details).", spellId = "403631" },
            { text = "Cast  (see section on cooldown usage for more details).", spellId = "370553" },
            { text = "Cast  at Rank 1 or Max Rank. - [span class=tip tooltip=firebreath][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "357208" },
            { text = "Cast  at Rank 1, unless increased radius is needed to hit relevant targets. - [span class=tip tooltip=upheaval][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "408092" },
            { text = "Only if talented: Cast  (see section on cooldown usage for more details).", spellId = "404977" },
            { text = "Cast . - [span class=tip tooltip=eruption][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "395160" },
            { text = "Cast  as filler in nearly all situations.", spellId = "361469" },
            { text = "Cast  as backup filler that can be cast while moving, or used to slow enemies.", spellId = "362969" },
            { text = "Maintain  on a Tank. - [span class=tip tooltip=blistering][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "360827" },
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
    scrapedAt = "2026-08-16T10:00:54.067Z",
    statPriority = {
        wowhead = "Pack Leader: Weapon Damage > Agility > Mastery > Critical Strike > Haste > Versatility | Dark Ranger: Weapon Damage > Agility > Critical Strike > Mastery > Haste > Versatility",
        archon = "Agility > Crit > Mastery > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[item=268207 bonus=13848:13708]", itemId = nil, slot = "Weapon" },
            { text = "[item=271492 ]", itemId = nil, slot = "Head" },
            { text = "[item=268265 bonus=13848:13708]", itemId = nil, slot = "Neck" },
            { text = "[item=271490 original-item=268231]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271495 original-item=271876 bonus=13848:13708]", itemId = nil, slot = "Chest" },
            { text = "[item=244584 bonus=13751:12497:13836:12384:8793]", itemId = nil, slot = "Wrist" },
            { text = "[item=271493 original-item=160213]", itemId = nil, slot = "Gloves" },
            { text = "[item=244581 bonus=13751:12497:13836:12384:8793]", itemId = nil, slot = "Belt" },
            { text = "[item=271491 original-item=268237]", itemId = nil, slot = "Legs" },
            { text = "[url guide=34249]Sszorak", itemId = 268233, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
            { text = "[url guide=34245]Entombed Sentinels", itemId = 270165, slot = "Trinket (Raid only)" },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
            { text = "Weapon Damage", itemId = nil },
            { text = "Agility", itemId = nil },
            { text = "Mastery", itemId = nil },
            { text = "Critical Strike", itemId = nil },
            { text = "Haste", itemId = nil },
            { text = "Versatility", itemId = nil },
            { text = "Weapon Damage", itemId = nil },
            { text = "Agility", itemId = nil },
            { text = "Critical Strike", itemId = nil },
            { text = "Mastery", itemId = nil },
            { text = "Haste", itemId = nil },
            { text = "Versatility", itemId = nil },
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
                "[item=240166]",
                "[item=245875]",
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
    scrapedAt = "2026-08-16T10:00:54.481Z",
    statPriority = {
        wowhead = "Sentinel: Agility > Critical Strike > Mastery > Versatility > Haste | Dark Ranger: Agility > Critical Strike > Mastery > Versatility > Haste",
        archon = "Agility > Crit > Mastery > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[item=268207 bonus=12854]", itemId = nil, slot = "Weapon" },
            { text = "[item=271492 original-item=268230 bonus=12854]", itemId = nil, slot = "Head" },
            { text = "[item=268265 bonus=12854]", itemId = nil, slot = "Neck" },
            { text = "[item=271490 original-item=268231 bonus=12854]", itemId = nil, slot = "Shoulders" },
            { text = "[item=268253 bonus=12854]", itemId = nil, slot = "Cloak" },
            { text = "[item=271495 original-item=271876 bonus=12854]", itemId = nil, slot = "Chest" },
            { text = "[item=244584 bonus=12214:8960:12497:12066:13622:13667]", itemId = nil, slot = "Wrist" },
            { text = "[item=271493 original-item=193752 bonus=12854]", itemId = nil, slot = "Gloves" },
            { text = "[item=244581 bonus=12214:8960:12497:12066:13622:13667]", itemId = nil, slot = "Belt" },
            { text = "[item=271491 original-item=268237 bonus=12854]", itemId = nil, slot = "Legs" },
            { text = "[item=268233 bonus=12854]", itemId = nil, slot = "Boots" },
            { text = "[item=251136 bonus=12806]", itemId = nil, slot = "Ring" },
            { text = "[item=268249 bonus=12854]", itemId = nil, slot = "Ring" },
            { text = "[item=270175 bonus=12854]", itemId = nil, slot = "Trinket" },
            { text = "[item=270173 bonus=12854]", itemId = nil, slot = "Trinket" },
            { text = "Location", itemId = nil, slot = "Priority" },
            { text = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c3][/icon] [url guide=34252]Ula'tek", itemId = nil, slot = "[large][color=necrolord]1[/color][/large]" },
            { text = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c3][/icon] [url guide=34251]Coiled Altar", itemId = nil, slot = "[large][color=rogue]2[/color][/large]" },
            { text = "[icon name=8039569 inline=true size=small type=round color=c3][/icon] [url guide=34045]Early Mythic Bosses", itemId = nil, slot = "[large][color=druid]3[/color][/large]" },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
            { text = "Agility", itemId = nil },
            { text = "Critical Strike", itemId = nil },
            { text = "Mastery", itemId = nil },
            { text = "Versatility", itemId = nil },
            { text = "Haste", itemId = nil },
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
                "[item=240167]",
                "[item=240167]",
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
    scrapedAt = "2026-08-16T10:00:54.936Z",
    statPriority = {
        wowhead = "Pack Leader: Agility > Mastery > Critical Strike and Haste > Versatility | Sentinel: Agility > Mastery > Critical Strike > Haste > Versatility",
        archon = "Agility > Mastery > Crit > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 268215, slot = "Weapon" },
            { text = "[item=271492 original-item=251220] (Catalyzed from [color=q4][/color])", itemId = 251220, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271490 original-item=268231] (Catalyzed from )", itemId = 268231, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34252]Ula'tek", itemId = 271876, slot = "Chest" },
            { text = "[item=244584 bonus=13836:13751:9627:13750:8793:8960:12384]", itemId = nil, slot = "Wrist" },
            { text = "[item=271493 original-item=160213] (Catalyzed from [color=q4][/color])", itemId = 160213, slot = "Gloves" },
            { text = "[item=244581 bonus=13836:13751:9627:13750:8793:8960:12384]", itemId = nil, slot = "Belt" },
            { text = "[item=271491 original-item=268237] (Catalysed from )", itemId = 268237, slot = "Legs" },
            { text = "[url guide=34249]Sszorak", itemId = 268233, slot = "Boots" },
            { text = "[color=q4][/color]", itemId = 273792, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
            { text = "Agility", itemId = nil },
            { text = "Mastery", itemId = nil },
            { text = "Critical Strike and Haste", itemId = nil },
            { text = "Versatility", itemId = nil },
            { text = "[spell=1296636] - Mongoose Fury also increases the damage of Wildfire Bomb by 10%", itemId = nil },
            { text = "[spell=1296635] - Each blast of Boomstick extends the duration of Mongoose Fury by 1.0 sec. Mongoose Fury effects are increased by 10%.", itemId = nil },
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
                "[item=273069]",
                "[item=273069]",
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
    scrapedAt = "2026-08-16T10:00:55.428Z",
    statPriority = {
        wowhead = "Spellslinger: Intellect > Haste > Mastery > Critical Strike > Versatility | Sunfury: Intellect > Haste > Versatility > Critical Strike > Mastery",
        archon = "Intellect > Mastery > Haste > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[url guide=15942]Crafting", itemId = 245769, slot = "Offhand" },
            { text = "[item=271564 original-item=271874]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271562 original-item=268241]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271567 original-item=273785]", itemId = nil, slot = "Chest" },
            { text = "[url guide=15942]Crafting", itemId = 239648, slot = "Wrist" },
            { text = "[item=271565 original-item=268243]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=34249]Sszorak", itemId = 268257, slot = "Belt" },
            { text = "[item=271563 original-item=268236]", itemId = nil, slot = "Legs" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268255, slot = "Boots" },
            { text = "[url guide=34240]Nymrissa Wavecaller", itemId = 268266, slot = "Ring" },
            { text = "[url guide=33190]Den of Nalorakk", itemId = 251148, slot = "Ring" },
            { text = "[url guide=33189]Murder Row", itemId = 250215, slot = "Trinket" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
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
                "[item=245769] with [item=273059]",
                "[item=239648] with [item=240167]",
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
    scrapedAt = "2026-08-16T10:00:55.864Z",
    statPriority = {
        wowhead = "Sunfury: Intellect > Haste > Mastery > Versatility > Critical Strike | Frostfire: Intellect > Haste > Mastery > Versatility > Critical Strike",
        archon = "Intellect > Haste > Mastery > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[url guide=15942]Crafting", itemId = 245769, slot = "Offhand" },
            { text = "[item=271564 original-item=271874]", itemId = nil, slot = "Head" },
            { text = "[url guide=33189]Murder Row", itemId = 251142, slot = "Neck" },
            { text = "[item=271562 original-item=268241]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271567 original-item=273785]", itemId = nil, slot = "Chest" },
            { text = "[url guide=15942]Crafting/Misc", itemId = 239648, slot = "Wrist" },
            { text = "[item=271565 original-item=268243]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=34249]Sszorak", itemId = 268257, slot = "Belt" },
            { text = "[item=271563 original-item=268236]", itemId = nil, slot = "Legs" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268255, slot = "Boots" },
            { text = "[url guide=34240]Nymrissa Wavecaller", itemId = 268266, slot = "Ring" },
            { text = "[url guide=34260]King's Rest", itemId = 159459, slot = "Ring" },
            { text = "[url guide=34264]Altar of Fangs", itemId = 273796, slot = "Trinket" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "Location", itemId = nil, slot = "Priority" },
            { text = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c8][/icon] [url guide=34252]Ula'tek (Heroic & Mythic)", itemId = nil, slot = "[large][color=necrolord]1[/color][/large]" },
            { text = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c8][/icon] [url guide=34251]Coiled Altar (Mythic)", itemId = nil, slot = "[large][color=rogue]2[/color][/large]" },
            { text = "[icon name=8039569 inline=true size=small type=round color=c8][/icon] [url guide=34045] Early Mythic Bosses or Dungeons", itemId = nil, slot = "[large][color=druid]3[/color][/large]" },
            { text = "[icon-badge=273796 quality=3 tooltip=\"Bonus_3_Tooltip\"]", itemId = nil, slot = "[center][large]1[/large][/center]" },
            { text = "[icon-badge=270164 quality=4 tooltip=\"Bonus_2_Tooltip\"]", itemId = nil, slot = "[center][large]2[/large][/center]" },
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
                "[item=273060]",
                "[item=240167]",
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "with", spellId = "11366" },
            { text = "The below casts are used to generate :", spellId = "48108" },
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
    scrapedAt = "2026-08-16T10:00:56.259Z",
    statPriority = {
        wowhead = "Frostfire: Intellect > Mastery > Critical Strike > Haste > Versatility | Spellslinger: Intellect > Mastery > Critical Strike > Haste > Versatility",
        archon = "Intellect > Crit > Mastery > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[url guide=34240]Nymrissa Wavecaller", itemId = 268263, slot = "Offhand" },
            { text = "[item=271564 original-item=271874]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271562 original-item=239031]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271567 original-item=273785]", itemId = nil, slot = "Chest" },
            { text = "[item=239648 bonus=8791:8960:12214:12384:13668:13751]", itemId = nil, slot = "Wrist" },
            { text = "[item=271565 original-item=268243]", itemId = nil, slot = "Gloves" },
            { text = "[item=239649 bonus=8791:8960:12214:12384:13668:13751]", itemId = nil, slot = "Belt" },
            { text = "[item=271563 original-item=159234]", itemId = nil, slot = "Legs" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268255, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=34262]Temple of Sethraliss", itemId = 158366, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[url guide=34240]Nymrissa Wavecaller", itemId = 270167, slot = "Trinket" },
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
                "[item=240167] (For Armor)",
                "[item=245876] (For Weapons)",
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
    scrapedAt = "2026-08-16T10:00:56.645Z",
    statPriority = {
        wowhead = "Shado-Pan: Item Level / Agility / Armor / Stamina > Versatility = Critical Strike = Mastery > Haste | Master of Harmony: Item Level / Agility / Armor / Stamina > Versatility = Critical Strike = Mastery > Haste | Shado-Pan: Item Level / Agility > Critical Strike > Versatility = Mastery > Haste | Master of Harmony: Item Level / Agility > Critical Strike > Versatility = Mastery > Haste",
        archon = "Agility > Crit > Vers > Mastery > Haste",
    },
    bisGear = {
        wowhead = {
            { text = "[div style=\"border:1px solid #6ED4CD; padding:10px;\"]\n[center][color=#6ED4CD]Master of Harmony[/color] Defensive Priority[/center]\n[hr]\n[ol]\n[li]Item Level / Agility / Armor / Stamina[/li]\n[li]Versatility = Critical Strike = Mastery[/li]\n[li]Haste[/li]\n[/ol]\n[/div]", itemId = nil, slot = "[div style=\"border:1px solid #FFAD36; padding:10px;\"]\n[center][color=#FFAD36]Shado-Pan[/color] Defensive Priority[/center]\n[hr]\n[ol]\n[li]Item Level / Agility / Armor / Stamina[/li]\n[li]Versatility = Critical Strike = Mastery[/li]\n[li]Haste[/li]\n[/ol]\n[/div]" },
            { text = "[div style=\"border:1px solid #6ED4CD; padding:10px;\"]\n[center][color=#6ED4CD]Master of Harmony[/color] Offensive Priority[/center]\n[hr]\n[ol]\n[li]Item Level / Agility[/li]\n[li]Critical Strike[/li]\n[li]Versatility = Mastery[/li]\n[li]Haste[/li]\n[/ol]\n[/div]", itemId = nil, slot = "[div style=\"border:1px solid #FFAD36; padding:10px;\"]\n[center][color=#FFAD36]Shado-Pan[/color] Offensive Priority[/center]\n[hr]\n[ol]\n[li]Item Level / Agility[/li]\n[li]Critical Strike[/li]\n[li]Versatility = Mastery[/li]\n[li]Haste[/li]\n[/ol]\n[/div]" },
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[item=268215 bonus=13848:13846]", itemId = nil, slot = "Weapon (2h)" },
            { text = "[item=268209 bonus=13848]", itemId = 268206, slot = "Weapons (1h)" },
            { text = "[item=271519 bonus=13848:13847:10835 original-item=271875]", itemId = nil, slot = "Head" },
            { text = "[item=268265 bonus=13848:13708:10835]", itemId = nil, slot = "Neck" },
            { text = "[item=271517 original-item=273774]", itemId = nil, slot = "Shoulders" },
            { text = "[item=268253 bonus=13848]", itemId = nil, slot = "Cloak" },
            { text = "[item=271522 original-item=251226]", itemId = nil, slot = "Chest" },
            { text = "[item=244576 bonus=13751:12497:13836:10835:8795:13454]", itemId = nil, slot = "Wrist" },
            { text = "[item=271520 original-item=193758]", itemId = nil, slot = "Gloves" },
            { text = "[item=268256 bonus=13848]", itemId = nil, slot = "Belt" },
            { text = "[item=271518 bonus=13848 original-item=268225]", itemId = nil, slot = "Legs" },
            { text = "[color=q4][/color]", itemId = 159304, slot = "Boots" },
            { text = "[color=q4][/color]", itemId = 251148, slot = "Ring" },
            { text = "[item=251513 bonus=13751:12497:13836]", itemId = nil, slot = "Ring" },
            { text = "[item=270175 bonus=13848]", itemId = nil, slot = "Trinket (Damage)" },
            { text = "[item=270173 bonus=13848]", itemId = nil, slot = "Trinket (Damage)" },
            { text = "[icon name=inv_121_raid_achievement_tortollans color=c10 inline=true type=round][/icon]The Lost Explorers", itemId = 270160, slot = "Trinket (Defense)" },
            { text = "[color=q4][/color]", itemId = 159617, slot = "Trinket (Defense)" },
            { text = "Instance/Boss", itemId = nil, slot = "Priority" },
            { text = "[icon name=inv_121_raid_achievement_ulatek color=c10 inline=true type=round][/icon]Ula'tek", itemId = 271875, slot = "1" },
            { text = "[icon name=achievement_dungeon_kingsrest inline=true  type=round][/icon][url guide=34260]King's Rest", itemId = 159459, slot = "2" },
            { text = "[icon name=inv_121_raid_achievement_zuljinmalacrass color=c10 inline=true type=round][/icon]The Coiled Altar (Mythic)", itemId = 270173, slot = "1" },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
            { text = "[spell=1252524] - 15-second Agility buff; always available", itemId = nil },
            { text = "[spell=1257183] - 6-second ramping Critical Strike buff, refreshing every second for 10 seconds; [color=venthyr]Garnet[/color] (Critical Strike)", itemId = nil },
            { text = "[spell=1252814] - Physical damage to primary target; [color=purple-gem]Amethyst[/color] (Mastery)", itemId = nil },
            { text = "[spell=1252817] - 8-yard AoE Fire damage, penalized for tanks; [color=kyrian]Lapis[/color] (Versatility)", itemId = nil },
            { text = "[spell=1252818] - 15-second Haste/Speed buff; [color=necrolord]Peridot[/color] (Haste)", itemId = nil },
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
                "[item=251513]",
                "[item=251490]/[item=240167]",
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
    scrapedAt = "2026-08-16T10:00:57.047Z",
    statPriority = {
        wowhead = "Shado-pan: Agility > Haste > Critical Strike > Mastery > Versatility | Conduit of the Celestials: Agility > Haste > Mastery > Critical Strike > Versatility",
        archon = "Agility > Haste > Crit > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 268215, slot = "2H Weapon" },
            { text = "[url guide=34252]Ula'tek", itemId = 271875, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34180]Tier Set", itemId = 271517, slot = "Shoulder" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34244]Nek'zali the Soulcoiler", itemId = 268235, slot = "Chest" },
            { text = "[url guide=15942]Crafting", itemId = 244576, slot = "Wrist" },
            { text = "[url guide=33189]Murder Row", itemId = 251124, slot = "Hands" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268256, slot = "Belt" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268225, slot = "Legs" },
            { text = "[url guide=15942]Crafting", itemId = 244569, slot = "Feet" },
            { text = "[url guide=34262]Temple of Sethraliss", itemId = 158366, slot = "Ring" },
            { text = "[url guide=33183]Voidscar Arena", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket 1" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket 2" },
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
                "[item=240167]",
                "[item=240167]",
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
    scrapedAt = "2026-08-16T10:00:57.429Z",
    statPriority = {
        wowhead = "Raid: Intellect > Haste > Critical Strike > Versatility > Mastery | Mythic+: Intellect > Haste > Mastery > Critical Strike > Versatility",
        archon = "Intellect > Haste > Crit > Vers > Mastery",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[color=q4][item=271519 original-item=271875][/color]", itemId = nil, slot = "Helm" },
            { text = "[color=q4][/color]", itemId = 268265, slot = "Neck" },
            { text = "[color=q4][item=271517 original-item=251146][/color]", itemId = nil, slot = "Shoulders" },
            { text = "[color=q4][/color]", itemId = 193763, slot = "Cape" },
            { text = "[color=q4][item=271522 original-item=251226][/color]", itemId = nil, slot = "Chest" },
            { text = "[color=q4][/color]", itemId = 251135, slot = "Bracers" },
            { text = "[color=q4][item=271520 original-item=251124][/color]", itemId = nil, slot = "Gloves" },
            { text = "[color=q4][/color]", itemId = 251189, slot = "Belt" },
            { text = "[color=q4][item=271518 original-item=159313][/color]", itemId = nil, slot = "Legs" },
            { text = "[color=q4][/color]", itemId = 268247, slot = "Boots" },
            { text = "[color=q4][/color]", itemId = 268266, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 159459, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 270167, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 270162, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 268211, slot = "1h Weapon" },
            { text = "[color=q4][/color]", itemId = 159667, slot = "Offhand" },
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[color=q4][item=271519 original-item=271875][/color]", itemId = nil, slot = "Helm" },
            { text = "[color=q4][/color]", itemId = 268265, slot = "Neck" },
            { text = "[color=q4][/color]", itemId = 271517, slot = "Shoulders" },
            { text = "[color=q4][/color]", itemId = 268253, slot = "Cape" },
            { text = "[color=q4][item=271522 original-item=268235][/color]", itemId = nil, slot = "Chest" },
            { text = "[color=q4][/color]", itemId = 251135, slot = "Bracers" },
            { text = "[color=q4][item=271520 original-item=251124][/color]", itemId = nil, slot = "Gloves" },
            { text = "[color=q4][/color]", itemId = 268256, slot = "Belt" },
            { text = "[color=q4][item=271518 original-item=268225][/color]", itemId = nil, slot = "Legs" },
            { text = "[color=q4][/color]", itemId = 251153, slot = "Boots" },
            { text = "[color=q4][/color]", itemId = 268266, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 252258, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 270167, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 270162, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 268211, slot = "1h Weapon" },
            { text = "[color=q4][/color]", itemId = 268197, slot = "Offhand" },
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
                "[item=240167] (Armor slots only, actual Best in Slot)",
                "[item=245874] (Weapon slots only)",
            },
        },
    },
    rotation = {
        wowhead = {
            { text = "to keep someone alive that would otherwise die without your intervention", spellId = "116670" },
            { text = "if at 3 charges", spellId = "115151" },
            { text = "if at 20 stacks", spellId = "115869" },
            { text = "[span display-options=\"conduit-of-the-celestials\"]If you have 2  stacks, consume at least one to avoid overcapping[/span][span display-options=\"master-of-harmony\"]If you have 2  or 6  stacks, use some stacks to avoid overcapping[/span]", spellId = "1260565" },
            { text = "(empowering ) - [span class=tip tooltip=TFT-Raid-Prio][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "116680" },
            { text = "Any remaining  charges", spellId = "115151" },
            { text = "with high  coverage and an injured raid", spellId = "116670" },
            { text = "Consume  procs with an injured raid", spellId = "1260565" },
            { text = "with a  proc", spellId = "124682" },
            { text = "if you have any stacks", spellId = "115869" },
            { text = ", or  if on cooldown, to fill - [span class=tip tooltip=bok_tooltip][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "100784" },
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
    scrapedAt = "2026-08-16T10:00:57.866Z",
    statPriority = {
        wowhead = "Herald of the Sun: Intellect > Mastery > Haste = Crit > Versatility | Lightsmith: Intellect > Mastery > Haste = Crit > Versatility",
        archon = "Intellect > Haste > Mastery > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268211, slot = "Weapon" },
            { text = "[url guide=34240]Nymrissa Wavecaller", itemId = 268262, slot = "Shield" },
            { text = "[item=271465 original-item=268229]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271463 original-item=251138]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271468 original-item=268222]", itemId = nil, slot = "Chest" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 268239, slot = "Wrist" },
            { text = "[url guide=34245]Entombed Sentinels", itemId = 271466, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268259, slot = "Belt" },
            { text = "[item=271464 original-item=271878]", itemId = nil, slot = "Legs" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268260, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=33183]Voidscar Arena", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34244]Nek'zali the Soulcoiler", itemId = 270162, slot = "Trinket" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek - Until you get to Mythic Ula'tek, your top priority is to get the two cantrip items on Myth track by bonus rolling Heroic.\n\nThere are only two items on our loot table,  and , and we want both of them.", itemId = 268265, slot = "[center][large]1[/large][/center]" },
            { text = "[url guide=34247]The Lost Explorers - These Turtles have an excellent loot table for us, including weapon, shield, and a decent trinket.", itemId = nil, slot = "[center][large]2[/large][/center]" },
            { text = "[url guide=34244]Nek'zali the Soulcoiler - I recommend bonus rolling this boss until you get .", itemId = 270162, slot = "[center][large]3[/large][/center]" },
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
                "[item=245876] is the best embellishment, but can only be put on weapons. Like previous expansions, embellishments are only minor throughput gains, and you will eventually replace your crafted weapon with a Mythic one and instead craft a second item with the second best embellishment.",
                "[item=240167] is our second best embellishment.",
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
    scrapedAt = "2026-08-16T10:00:58.311Z",
    statPriority = {
        wowhead = "Survivability: Strength > Haste > Mastery > Critical Strike > Versatility | DPS: Strength > Haste > Critical Strike > Mastery > Versatility",
        archon = "Strength > Haste > Crit > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268209, slot = "Weapon" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 268196, slot = "Shield" },
            { text = "[url guide=34180]Tier Set", itemId = 271465, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34180]Tier Set", itemId = 271463, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34180]Tier Set", itemId = 271468, slot = "Chest" },
            { text = "[url guide=15942]Crafting Blacksmithing", itemId = 237834, slot = "Wrist" },
            { text = "[url guide=34180]Tier Set", itemId = 271466, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268259, slot = "Belt" },
            { text = "[url guide=34252]Ula'tek", itemId = 271878, slot = "Legs" },
            { text = "[url guide=15942]Crafting Blacksmithing", itemId = 237828, slot = "Boots" },
            { text = "[url guide=34249]Sszorak", itemId = 268252, slot = "Ring" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring 2" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket 2" },
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
                "[item=245876]",
                "[item=240166]",
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
    scrapedAt = "2026-08-16T10:00:58.704Z",
    statPriority = {
        wowhead = "Templar: Strength > Mastery > Haste > Critical Strike > Versatility | Herald of the Sun: Strength > Mastery > Haste > Critical Strike > Versatility",
        archon = "Strength > Mastery > Crit > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[item=268213 bonus=13848]", itemId = nil, slot = "Weapon" },
            { text = "[item=271465 original-item=268229 bonus=12854]", itemId = nil, slot = "Head" },
            { text = "[item=268265 bonus=13848:13708]", itemId = nil, slot = "Neck" },
            { text = "[item=271463 original-item=251138 bonus=12854]", itemId = nil, slot = "Shoulders" },
            { text = "[item=268253 bonus=13848]", itemId = nil, slot = "Cloak" },
            { text = "[item=271468 original-item=268222 bonus=13848]", itemId = nil, slot = "Chest" },
            { text = "[item=237834 bonus=13751:12497:13836:8790:13454]", itemId = nil, slot = "Wrist" },
            { text = "[item=271466 original-item=251214 bonus=12854]", itemId = nil, slot = "Gloves" },
            { text = "[item=268259 bonus=13848]", itemId = nil, slot = "Belt" },
            { text = "[item=271464 original-item=271878 bonus=13848:13846]", itemId = nil, slot = "Legs" },
            { text = "[item=268260 bonus=12854]", itemId = nil, slot = "Boots" },
            { text = "[item=252258 bonus=12854]", itemId = nil, slot = "Ring" },
            { text = "[item=251513 bonus=13751:12497:13836]", itemId = nil, slot = "Ring" },
            { text = "[item=270173 bonus=13848]", itemId = nil, slot = "Trinket" },
            { text = "[item=270175 bonus=13848]", itemId = nil, slot = "Trinket" },
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
                "[item=251513 bonus=13751:12497:13836]",
                "[item=251490]",
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
    scrapedAt = "2026-08-16T10:00:59.124Z",
    statPriority = {
        wowhead = "Oracle: Intellect > Haste > Mastery > Critical Strike > Versatility | Voidweaver: Haste > Intellect > Mastery > Critical Strike > Versatility | Oracle: Intellect > Haste > Mastery > Critical Strike > Versatility | Voidweaver: Intellect > Haste > Mastery > Critical Strike > Versatility",
        archon = "Intellect > Haste > Crit > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[npc=268956]", itemId = 271092, slot = "Weapon" },
            { text = "[zone=9526]", itemId = 159667, slot = "Offhand" },
            { text = "[npc=268956]", itemId = 271874, slot = "Head" },
            { text = "[npc=268956]", itemId = 268265, slot = "Neck" },
            { text = "[item=271553 bonus=13848 original-item=268241]", itemId = nil, slot = "Shoulders" },
            { text = "[npc=24239]", itemId = 268253, slot = "Cloak" },
            { text = "[item=271558 bonus=13848 original-item=251139]", itemId = nil, slot = "Chest" },
            { text = "Crafting", itemId = 239648, slot = "Wrist" },
            { text = "[item=271556 bonus=13848 original-item=268243]", itemId = nil, slot = "Gloves" },
            { text = "Crafting", itemId = 239649, slot = "Belt" },
            { text = "[npc=257347]", itemId = 271554, slot = "Legs" },
            { text = "[npc=24239]", itemId = 268255, slot = "Boots" },
            { text = "[npc=252959]", itemId = 268266, slot = "Ring" },
            { text = "[zone=16425]", itemId = 252258, slot = "Ring" },
            { text = "[npc=252959]", itemId = 270167, slot = "Trinket" },
            { text = "[npc=253563]", itemId = 270162, slot = "Trinket" },
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
                "[item=240166]",
                "[item=273059]",
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
    scrapedAt = "2026-08-16T10:00:59.532Z",
    statPriority = {
        wowhead = "Archon: Intellect > Crit > Versatility = Mastery > Haste | Oracle: Intellect > Crit > Versatility = Mastery > Haste | Archon: Intellect > Versatility > Critical Strike > Haste > Mastery | Oracle: Intellect > Versatility > Critical Strike > Haste > Mastery",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[npc=268956]", itemId = 271092, slot = "Weapon" },
            { text = "[npc=252959]", itemId = 268263, slot = "Offhand" },
            { text = "[npc=268956]", itemId = 271874, slot = "Head" },
            { text = "[npc=268956]", itemId = 268265, slot = "Neck" },
            { text = "[npc=267077]", itemId = 271553, slot = "Shoulders" },
            { text = "[zone=16091]", itemId = 251132, slot = "Cloak" },
            { text = "[item=271558 bonus=13848 original-item=268221]", itemId = nil, slot = "Chest" },
            { text = "Crafting", itemId = 239648, slot = "Wrist" },
            { text = "[npc=258557]", itemId = 271556, slot = "Gloves" },
            { text = "Crafting", itemId = 239649, slot = "Belt" },
            { text = "[item=271554 bonus=13848 original-item=159234]", itemId = nil, slot = "Legs" },
            { text = "[npc=253563]", itemId = 268218, slot = "Boots" },
            { text = "[npc=257347]", itemId = 268252, slot = "Ring" },
            { text = "[zone=16368]", itemId = 251148, slot = "Ring" },
            { text = "[npc=267077]", itemId = 270164, slot = "Trinket" },
            { text = "[npc=253563]", itemId = 270162, slot = "Trinket" },
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
                "[item=240166]",
                "[item=273059]",
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
    scrapedAt = "2026-08-16T10:00:59.885Z",
    statPriority = {
        wowhead = "Archon: Intellect > Haste > Mastery > Critical Strike > Versatility | Voidweaver: Intellect > Haste > Mastery > Critical Strike > Versatility",
        archon = "Intellect > Haste > Mastery > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[item=271092 bonus=13848]", itemId = nil, slot = "Weapon" },
            { text = "[item=245769 bonus=8793:13751:12497:13836:13771:8960]", itemId = nil, slot = "Offhand" },
            { text = "[item=271555 bonus=13848:13846:10835 original-item=271874]", itemId = nil, slot = "Head" },
            { text = "[item=268265 bonus=13708:13750:13848]", itemId = nil, slot = "Neck" },
            { text = "[color=q4][item=239045 bonus=12854 spec=258][/color]", itemId = nil, slot = "Shoulders" },
            { text = "[item=268253 bonus=13848]", itemId = nil, slot = "Cloak" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 271558, slot = "Chest" },
            { text = "[item=239648 bonus=8793:12384:8960:13750:13751:12497:13836 spec=258]", itemId = nil, slot = "Wrist" },
            { text = "[item=271556 bonus=13848 original-item=268243]", itemId = nil, slot = "Gloves" },
            { text = "[item=268257 bonus=10835:12854 ]", itemId = nil, slot = "Belt" },
            { text = "[item=271554 original-item=251160]", itemId = nil, slot = "Legs" },
            { text = "[item=268255 bonus=13848]", itemId = nil, slot = "Boots" },
            { text = "[item=252258 bonus=10835:12854]", itemId = nil, slot = "Ring" },
            { text = "[item=268249 bonus=10835:12854]", itemId = nil, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[color=q4][item=250215 bonus=12854][/color]", itemId = nil, slot = "Trinket" },
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
                "[item=273059]",
                "[item=240166]",
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
    scrapedAt = "2026-08-16T10:01:00.256Z",
    statPriority = {
        wowhead = "Fatebound: Agility > Critical Strike > Haste > Mastery > Versatility | Deathstalker: Agility > Critical Strike > Haste > Mastery > Versatility",
        archon = "Agility > Crit > Haste > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271093, slot = "Weapon" },
            { text = "[item=237837 bonus=12214:13836:13751:9627:13771:8960]", itemId = nil, slot = "Offhand" },
            { text = "[item=271510 original-item=271875]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271508 original-item=251223]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271513 original-item=251159]", itemId = nil, slot = "Chest" },
            { text = "[item=244576 bonus=12214:13836:13751:9627:13750:8790:8960:12384]", itemId = nil, slot = "Wrist" },
            { text = "[url guide=34245]Entombed Sentinels", itemId = 271511, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268256, slot = "Belt" },
            { text = "[item=271509 original-item=268225]", itemId = nil, slot = "Legs" },
            { text = "[url guide=33190]Den of Nalorakk", itemId = 251153, slot = "Boots" },
            { text = "[url guide=34264]Altar of Fangs", itemId = 273792, slot = "Ring" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270168, slot = "Trinket" },
            { text = "Instance", itemId = nil, slot = "Priority" },
            { text = "[url guide=34252]Ula'tek", itemId = 270168, slot = "1" },
            { text = "[url guide=34247]The Lost Explorers", itemId = nil, slot = "2" },
            { text = "[url guide=34224]Any Mythic  Venomous Abyss Boss", itemId = nil, slot = "3" },
            { text = "[url guide=33190]Den of Nalorakk", itemId = nil, slot = "4" },
            { text = "[url guide=34264]Altar of Fangs", itemId = nil, slot = "5" },
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
                "[item=273060]",
                "[item=273069]",
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
    scrapedAt = "2026-08-16T10:01:00.678Z",
    statPriority = {
        wowhead = "Trickster: Agility > Haste > Critical Strike > Versatility > Mastery | Fatebound: Agility > Haste > Critical Strike > Versatility > Mastery",
        archon = "Agility > Crit > Haste > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268209, slot = "Weapon" },
            { text = "[url guide=34264]Altar of Fangs", itemId = 275070, slot = "Offhand" },
            { text = "[url guide=34252]Ula'tek", itemId = 271875, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34180]Tier Set", itemId = 271508, slot = "Shoulders" },
            { text = "[url guide=34244]Nek'zali the Soulcoiler", itemId = 268248, slot = "Cloak" },
            { text = "[url guide=34180]Tier Set", itemId = 271513, slot = "Chest" },
            { text = "[url guide=34244]Nek'zali the Soulcoiler", itemId = 268240, slot = "Wrist" },
            { text = "[item=271511 original-item=251124]", itemId = nil, slot = "Gloves" },
            { text = "[item=244573 bonus=12214:8960:12497:12066:13622:13667:12214:8792:8960:12384]", itemId = nil, slot = "Belt" },
            { text = "[url guide=34180]Tier Set", itemId = 271509, slot = "Legs" },
            { text = "[item=244569 bonus=12214:8960:12497:12066:13622:13667:12214:8792:8960:12384]", itemId = nil, slot = "Boots" },
            { text = "[url guide=34240]Nymrissa Wavecaller", itemId = 268266, slot = "Ring" },
            { text = "[url guide=34249]Sszorak", itemId = 268252, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
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
                "[item=240166]",
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
    scrapedAt = "2026-08-16T10:01:01.112Z",
    statPriority = {
        wowhead = "Deathstalker: Agility > Mastery > Haste (~1100 Haste) > Critical Strike > Versatility | Trickster: Agility > Mastery > Haste (~1100 Haste) > Critical Strike > Versatility | Deathstalker: Agility > Mastery > Haste (~700 Haste) > Critical Strike > Versatility | Trickster: Agility > Mastery > Haste (~700 Haste) > Critical Strike > Versatility",
        archon = "Agility > Mastery > Crit > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271093, slot = "Main-Hand" },
            { text = "[url guide=15942]Crafting/Misc", itemId = 237837, slot = "Off-Hand" },
            { text = "[item=271510 original-item=271875]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271508 original-item=268246]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271513 original-item=268235]", itemId = nil, slot = "Chest" },
            { text = "[url guide=15942]Crafting/Misc", itemId = 244576, slot = "Wrist" },
            { text = "[item=271511 original-item=268234]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268256, slot = "Belt" },
            { text = "[item=271509 original-item=268225]", itemId = nil, slot = "Legs" },
            { text = "[url guide=33219] Catalyst", itemId = 271512, slot = "Boots" },
            { text = "[url guide=33183]Voidscar Arena", itemId = 252258, slot = "Ring" },
            { text = "[url guide=33193]Blinding Vale", itemId = 251194, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
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
                "[item=273060]",
                "[item=240167]",
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
    scrapedAt = "2026-08-16T10:01:01.492Z",
    statPriority = {
        wowhead = "Farseer: Mastery to 1200 rating > Haste/Crit > Versatility > Intellect | Stormbringer: Mastery to 1200 rating > Haste/Crit > Versatility > Intellect",
        archon = "Intellect > Mastery > Crit > Haste > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[url guide=34240]Nymrissa Wavecaller", itemId = 268262, slot = "Offhand" },
            { text = "[url guide=34180]Tier Set", itemId = 271483, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34180]Tier Set", itemId = 271481, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34180]Tier Set", itemId = 271486, slot = "Chest" },
            { text = "[url guide=15942]Crafting", itemId = 244584, slot = "Wrist" },
            { text = "[url guide=34180]Tier Set", itemId = 271484, slot = "Gloves" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268254, slot = "Belt" },
            { text = "[url guide=34180]Tier Set", itemId = 271482, slot = "Legs" },
            { text = "[url guide=15942]Crafting", itemId = 244577, slot = "Boots" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=33183]Voidscar Arena", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[url guide=34264]Altar of Fangs", itemId = 273796, slot = "Trinket" },
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
                "[item=240167]",
                "[item=240167]",
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
    scrapedAt = "2026-08-16T10:01:01.849Z",
    statPriority = {
        wowhead = "Stormbringer: Agility > Mastery = Haste > Critical Strike > Versatility | Totemic: Agility > Mastery = Haste > Critical Strike > Versatility",
        archon = "Agility > Mastery > Haste > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "[icon name=ui_profession_enchanting inline=true size=small tooltip=enchanting][/icon]", itemId = nil, slot = "Slot" },
            { text = "[icon name=inv_12_profession_enchanting_enchantedvellum_purple inline=true][/icon]", itemId = nil, slot = "Main Hand" },
            { text = "[icon name=inv_12_profession_enchanting_enchantedvellum_purple inline=true][/icon]", itemId = nil, slot = "Off Hand" },
            { text = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon][icon name=inv_potiond_4][/icon]", itemId = nil, slot = "Head" },
            { text = "[color=q4][item=268265 bonus=13848:13708:10835][/color]", itemId = nil, slot = "Neck" },
            { text = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", itemId = nil, slot = "Shoulders" },
            { text = "[color=q4][item=268253 bonus=13848][/color]", itemId = nil, slot = "Cloak" },
            { text = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", itemId = nil, slot = "Chest" },
            { text = "[icon name=inv_potiond_4][/icon]", itemId = nil, slot = "Wrist" },
            { text = "[color=q4][item=271484 bonus=12854 original-item=160213][/color] &ndash;", itemId = nil, slot = "Gloves" },
            { text = "[icon name=inv_potiond_4][/icon]", itemId = nil, slot = "Belt" },
            { text = "[icon name=inv_12_profession_leatherworking_amani_armor_kit inline=true][/icon]", itemId = nil, slot = "Legs" },
            { text = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", itemId = nil, slot = "Boots" },
            { text = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", itemId = nil, slot = "Ring 1" },
            { text = "[icon name=inv_12_profession_enchanting_enchantedvellum_blue inline=true][/icon]", itemId = nil, slot = "Ring 2" },
            { text = "[color=q4][item=270175 bonus=13848][/color]", itemId = nil, slot = "Trinket 1" },
            { text = "[color=q4][item=270173 bonus=13848][/color]", itemId = nil, slot = "Trinket 2" },
            { text = "Location", itemId = nil, slot = "Priority" },
            { text = "[icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round color=c7][/icon] [url guide=34252]Ula'tek", itemId = nil, slot = "[large][color=necrolord]1[/color][/large]" },
            { text = "[icon name=inv_121_raid_achievement_zuljinmalacrass inline=true size=small type=round color=c7][/icon] [url guide=34251]Coiled Altar", itemId = nil, slot = "[large][color=rogue]2[/color][/large]" },
            { text = "[icon name=8039569 inline=true size=small type=round color=c7][/icon] [url guide=34045] Early Mythic Bosses", itemId = nil, slot = "[large][color=druid]3[/color][/large]" },
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
                "[color=q4][icon name=inv_12_profession_blacksmithing_weightstone_green]Hunter's Ritual Stone[/icon][/color]",
                "[color=q4][icon name=inv_12_tailoring_rare_cloth_violet_rare-cloth]Arcanoweave Lining[/icon][/color]",
                "[color=q4][icon name=inv_knife_1h_ulatek_d_01]Adorned Fang[/icon][/color]",
                "[item=251513 bonus=13751:12497:13836]",
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
    scrapedAt = "2026-08-16T10:01:02.208Z",
    statPriority = {
        wowhead = "Farseer: Intellect > Critical Strike > Haste > Versatility > Mastery | Totemic: Intellect > Critical Strike > Haste > Versatility > Mastery",
        archon = "Intellect > Crit > Haste > Vers > Mastery",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[color=q4][item=271483 original-item=251220][/color]", itemId = nil, slot = "Helm" },
            { text = "[color=q4][/color]", itemId = 268265, slot = "Neck" },
            { text = "[color=q4][item=271481 original-item=268231][/color]", itemId = nil, slot = "Shoulders" },
            { text = "[color=q4][/color]", itemId = 268253, slot = "Cape" },
            { text = "[color=q4][item=271486 original-item=271876][/color]", itemId = nil, slot = "Chest" },
            { text = "[color=q4][/color]", itemId = 251200, slot = "Bracers" },
            { text = "[color=q4][/color]", itemId = 271484, slot = "Gloves" },
            { text = "[color=q4][/color]", itemId = 159369, slot = "Belt" },
            { text = "[color=q4][item=271482 original-item=268237][/color]", itemId = nil, slot = "Legs" },
            { text = "[color=q4][/color]", itemId = 251145, slot = "Boots" },
            { text = "[color=q4][/color]", itemId = 251148, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 273792, slot = "Ring" },
            { text = "[color=q4][/color]", itemId = 270162, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 250215, slot = "Trinkets" },
            { text = "[color=q4][/color]", itemId = 271092, slot = "1h Weapon" },
            { text = "[color=q4][/color]", itemId = 268196, slot = "Shield" },
            { text = "Boss", itemId = nil, slot = "Priority" },
            { text = "[url guide=34252 style='display: flex; align-items: center; text-align: left;'][icon name=inv_121_raid_achievement_ulatek inline=true size=small type=round][/icon]Heroic Ula'tek", itemId = 268265, slot = "1" },
            { text = "[url guide=34244 style='display: flex; align-items: center; text-align: left;'][icon name=inv_121_raid_achievement_priestess inline=true size=small type=round][/icon]Mythic Nek'zali", itemId = 270162, slot = "2" },
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
            { text = "Use all your  procs [span class=tip tooltip=StormstreamProcs][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "1267068" },
            { text = "Keep  on cooldown [span class=tip tooltip=RiptideTargets][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "61295" },
            { text = "Use  [span class=tip tooltip=SwiftnessCooldown][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "443454" },
            { text = "Cast  [span class=tip tooltip=UnleashPrio][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "73685" },
            { text = "Maintain  [span class=tip tooltip=FarseerRain][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "73920" },
            { text = "Keep  on cooldown [span class=tip tooltip=FarseerHst][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "5394" },
            { text = "Cast  or  [span class=tip tooltip=FillerSelection][symbol=wow-atlas-quest-wrapper-turnin][/span]", spellId = "1064" },
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
    scrapedAt = "2026-08-16T10:01:02.645Z",
    statPriority = {
        wowhead = "Hellcaller: Intellect > Haste > Critical Strike > Versatility > Mastery | Soul Harvester: Intellect > Haste > Critical Strike > Versatility > Mastery",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[url guide=15942]Crafting", itemId = 245769, slot = "Offhand" },
            { text = "[url guide=34252]Ula'tek", itemId = 271874, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 271544, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 271549, slot = "Chest" },
            { text = "[url guide=15942]Crafting", itemId = 239648, slot = "Wrist" },
            { text = "[url guide=34245]Entombed Sentinels", itemId = 271547, slot = "Gloves" },
            { text = "[url guide=15942]Crafting", itemId = 239649, slot = "Belt" },
            { text = "[url guide=34249]Sszorak", itemId = 271545, slot = "Legs" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268255, slot = "Boots" },
            { text = "[url guide=34249]Sszorak", itemId = 268252, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 273792, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[npc=136160]", itemId = 273649, slot = "Trinket" },
            { text = "[item=270164 bonus=13335]", itemId = nil, slot = "[center][large]1[/large][/center]" },
            { text = "[item=271092 bonus=13335]", itemId = nil, slot = "[center][large]2[/large][/center]" },
            { text = "[item=273649 bonus=13335]", itemId = nil, slot = "[center][large]3[/large][/center]" },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
            { text = "Intellect", itemId = nil },
            { text = "Haste", itemId = nil },
            { text = "Critical Strike", itemId = nil },
            { text = "Versatility", itemId = nil },
            { text = "Mastery", itemId = nil },
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
                "[item=273060]",
                "[item=240166]",
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
    scrapedAt = "2026-08-16T10:01:03.062Z",
    statPriority = {
        wowhead = "Diabolist: Intellect > Haste=Critical Strike > Mastery > Versatility | Soul Harvester: Intellect > Haste=Critical Strike > Mastery > Versatility",
        archon = "Intellect > Crit > Haste > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[url guide=34245]Entombed Sentinels", itemId = 268197, slot = "Offhand" },
            { text = "[item=271874 original-item=34252]", itemId = nil, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271544 original-item=34262]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271549 original-item=34264]", itemId = nil, slot = "Chest" },
            { text = "[url guide=15942]Crafting", itemId = 239648, slot = "Wrist" },
            { text = "[item=271547 original-item=34251]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=15942]Crafting", itemId = 239649, slot = "Belt" },
            { text = "[item=271545 original-item=34264]", itemId = nil, slot = "Legs" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268255, slot = "Boots" },
            { text = "[url guide=34249]Sszorak", itemId = 268252, slot = "Ring" },
            { text = "[npc=133389]", itemId = 158366, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[npc=234649]", itemId = 250215, slot = "Trinket" },
            { text = "[item=270164 bonus=13335]", itemId = nil, slot = "[center][large]1[/large][/center]" },
            { text = "[item=271092 bonus=13335]", itemId = nil, slot = "[center][large]2[/large][/center]" },
            { text = "[item=250215 bonus=13335]", itemId = nil, slot = "[center][large]3[/large][/center]" },
        },
    },
    enchants = {
        wowhead = {
        },
    },
    gems = {
        wowhead = {
            { text = "Intellect", itemId = nil },
            { text = "Haste=Critical Strike", itemId = nil },
            { text = "Mastery", itemId = nil },
            { text = "Versatility", itemId = nil },
        },
    },
    consumables = {
        wowhead = {
        },
    },
    crafting = {
        wowhead = {
            embellishments = {
                "[item=240166]",
                "[item=245875]",
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
    scrapedAt = "2026-08-16T10:01:03.436Z",
    statPriority = {
        wowhead = "Diabolist: Intellect > Haste > Mastery>=Critical Strike > Versatility | Hellcaller: Intellect > Haste > Mastery>=Critical Strike > Versatility",
        archon = "Intellect > Haste > Crit > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34252]Ula'tek", itemId = 271092, slot = "Weapon" },
            { text = "[npc=259446]", itemId = 273779, slot = "Offhand" },
            { text = "[url guide=34252]Ula'tek", itemId = 271874, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 271544, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 271549, slot = "Chest" },
            { text = "[url guide=15942]Crafting", itemId = 239648, slot = "Wrist" },
            { text = "[url guide=34245]Entombed Sentinels", itemId = 271547, slot = "Gloves" },
            { text = "[url guide=15942]Crafting", itemId = 239649, slot = "Belt" },
            { text = "[url guide=34249]Sszorak", itemId = 271545, slot = "Legs" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268255, slot = "Boots" },
            { text = "[url guide=34249]Sszorak", itemId = 268252, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 273792, slot = "Ring" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 270164, slot = "Trinket" },
            { text = "[url guide=34240]Nymrissa Wavecaller", itemId = 270167, slot = "Trinket" },
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
                "[item=240166]",
                "[item=245875]",
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
    scrapedAt = "2026-08-16T10:01:03.837Z",
    statPriority = {
        wowhead = "Colossus: Strength > Critical Strike > Haste > Mastery > Versatility | Slayer: Strength > Critical Strike > Haste > Mastery > Versatility",
        archon = "Strength > Crit > Haste > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Name", itemId = nil, slot = "Item Slot" },
            { text = "[url guide=34250]The Twin Fangs", itemId = 271456, slot = "Helm" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271454 original-item=271444]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271459 original-item=268222]", itemId = nil, slot = "Chest" },
            { text = "[item=237834 bonus=12066:13622:9627:8791:8960:13767]", itemId = nil, slot = "Bracers" },
            { text = "[url guide=34245]Entombed Sentinels", itemId = 271457, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268259, slot = "Belt" },
            { text = "[item=271455 original-item=271878]", itemId = nil, slot = "Legs" },
            { text = "[item=237828 bonus=12066:13622:9627:8791:8960:13767]", itemId = nil, slot = "Boots" },
            { text = "[url guide=33183]Voidscar Arena", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34264]Altar of Fangs", itemId = 273792, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268213, slot = "Mainhand" },
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
                "[item=273069] is currently the strongest projected embellishment for dungeon and raid content.",
                "[item=245876] is a competitive embellishment for crafted weapons, but can vary with target type.",
                "[item=240167] is the previous best armor embellishment.",
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
    scrapedAt = "2026-08-16T10:01:04.261Z",
    statPriority = {
        wowhead = "Mountain Thane: Strength > Haste > Mastery > Critical Strike > Versatility | Slayer: Strength > Haste > Mastery > Critical Strike > Versatility",
        archon = "Strength > Haste > Mastery > Crit > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Name", itemId = nil, slot = "Item Slot" },
            { text = "[item=271456 original-item=251126]", itemId = nil, slot = "Helm" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[item=271454 original-item=251138]", itemId = nil, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[item=271459 original-item=268222]", itemId = nil, slot = "Chest" },
            { text = "[item=237834 bonus=12066:13622:9627:8791:8960:13767]", itemId = nil, slot = "Bracers" },
            { text = "[item=271457 original-item=251214]", itemId = nil, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268259, slot = "Belt" },
            { text = "[item=271455 original-item=271878]", itemId = nil, slot = "Legs" },
            { text = "[item=237828 bonus=12066:13622:9627:8791:8960:13767]", itemId = nil, slot = "Boots" },
            { text = "[url guide=33183]Voidscar Arena", itemId = 252258, slot = "Ring" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268213, slot = "Mainhand" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268214, slot = "Offhand" },
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
                "[item=273069] is currently the strongest projected embellishment for dungeon and raid content.",
                "[item=245876] is a competitive embellishment for crafted weapons, but can vary with target type.",
                "[item=240167] is the previous best armor embellishment.",
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
    scrapedAt = "2026-08-16T10:01:04.708Z",
    statPriority = {
        wowhead = "Survivability: Strength > Haste > Critical Strike > Versatility > Mastery | DPS: Strength > Haste > Critical Strike > Versatility > Mastery",
        archon = "Strength > Haste > Crit > Mastery > Vers",
    },
    bisGear = {
        wowhead = {
            { text = "Item", itemId = nil, slot = "Slot" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268209, slot = "Weapon" },
            { text = "[url guide=34247]The Lost Explorers", itemId = 268196, slot = "Shield" },
            { text = "[url guide=34180]Tier Set", itemId = 271456, slot = "Head" },
            { text = "[url guide=34252]Ula'tek", itemId = 268265, slot = "Neck" },
            { text = "[url guide=34180]Tier Set", itemId = 271454, slot = "Shoulders" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268253, slot = "Cloak" },
            { text = "[url guide=34180]Tier Set", itemId = 271459, slot = "Chest" },
            { text = "[url guide=15942]Crafting Blacksmithing", itemId = 237834, slot = "Wrist" },
            { text = "[url guide=34180]Tier Set", itemId = 271457, slot = "Gloves" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 268259, slot = "Belt" },
            { text = "[url guide=34252]Ula'tek", itemId = 271878, slot = "Legs" },
            { text = "[url guide=15942]Crafting Blacksmithing", itemId = 237828, slot = "Boots" },
            { text = "[url guide=34249]Sszorak", itemId = 268252, slot = "Ring" },
            { text = "[url guide=34248]Vashnik the Malignant", itemId = 268249, slot = "Ring 2" },
            { text = "[url guide=34251]The Coiled Altar", itemId = 270173, slot = "Trinket" },
            { text = "[url guide=34252]Ula'tek", itemId = 270175, slot = "Trinket 2" },
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
                "[item=245876]",
                "[item=240166]",
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

