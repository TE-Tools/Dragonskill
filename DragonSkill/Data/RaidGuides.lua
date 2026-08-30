-- Dragon Skill - Raid Guides Database (v2.1.4)
-- Based on the "Midnight S2 - Raids + Dungeons" Spreadsheet.

DragonSkillRaidGuides = {
    ["Nekzali"] = {
        name = "Nek'zali the Soulcoiler",
        dungeon = "Venomous Abyss",
        phases = {
            "Phase 1: Soulcoil Well Management",
            "Intermission (50%): Ritual of Awakening",
            "Phase 2: Uncoiling (Burn Phase)"
        },
        mechanics = {
            { name = "Soulcoil Well", tip = "Kontakt mit der Mitte vermeiden. Adds (Amani) niemals zum Brunnen lassen!" },
            { name = "Seelenwinderzündung", tip = "Boss schwebt; Geister an Sarkophagen am Rand aktivieren." },
            { name = "Adds", tip = "Schilde brechen, dann wegziehen. Tod verursacht Explosion (15m Abstand)." }
        },
        roles = {
            tank = "Boss im Kreis bewegen. Wechsel bei Debuff (100% mehr Schaden).",
            heal = "Raid-Explosionen und Heal-Absorbs gegenheilen.",
            dps = "Adds fokussieren, Schilde brechen, Abstand halten."
        }
    },
    ["Entombed Sentinels"] = {
        name = "Entombed Sentinels (Jawae)",
        dungeon = "Venomous Abyss",
        phases = {
            "Phase 1: Seelenübertragung",
            "Phase 2: Entschlingen (Raid-Damage)",
            "Zwischenphase: Leichen-Management"
        },
        mechanics = {
            { name = "Echo-Add", tip = "Boss immun solange Echo (Jawae) lebt. Schnell töten!" },
            { name = "Soak-Zone", tip = "Gemeinsam abfangen. Spieler außerhalb erhalten Feuer-DoT." },
            { name = "Wutanfall", tip = "Wipe bei 100 Energie (Soft-Enrage)." }
        },
        roles = {
            tank = "Tank-Beschuss erhöht Stapel (weniger Heilung). Wechsel nach 100-Energie-Phase.",
            heal = "Hoher Raid-Schaden in P2 gegenheilen.",
            dps = "Echos priorisieren. Add-Leichen in Soak-Zonen verbrennen."
        }
    },
    ["Vashnik"] = {
        name = "Vashnik",
        dungeon = "Venomous Abyss",
        phases = { "Positionierung zwischen Altaren", "Aktivierung bei 100 Energie" },
        mechanics = {
            { name = "Altare", tip = "Arena hat 3 Bereiche (Lila, Rot, Orange)." },
            { name = "Positionierung", tip = "Boss MUSS zwischen zwei Altaren stehen." }
        },
        roles = {
            tank = "Präzise Positionierung zwischen den Altaren sicherstellen."
        }
    },
    ["Lost Explorers"] = {
        name = "The Lost Explorers (Iku, Nama, Gebbo)",
        dungeon = "Venomous Abyss",
        phases = { "3 Tortollaner gleichzeitig", "Unterbrechen Troll-Buffs" },
        mechanics = {
            { name = "Ermächtigung", tip = "Troll versucht Tortollaner zu stärken (Unterbrechen!)" },
            { name = "Gebbos Kisten", tip = "Durchlaufen zum Öffnen. Fisch an Tortollaner verfüttern (Extra-Button)." }
        },
        roles = {
            dps = "Kisten durch Durchlaufen öffnen.",
            all = "Namas Schildkrötenpanzern ausweichen."
        }
    },
    ["Sszorak"] = {
        name = "Sszorak",
        dungeon = "Venomous Abyss",
        phases = { "Regelmäßiger Wechsel P1/P2", "Wind-Mechanik" },
        mechanics = {
            { name = "Windkanäle", tip = "6 Kanäle können dich von der Plattform stoßen. Mittig stehen!" },
            { name = "Giftwoge", tip = "Hinterlässt schwarze Voids. Konsequent ausweichen." }
        },
        roles = {
            all = "Positionierung ist alles. Nicht runterfallen!"
        }
    },
    ["Twin Fangs"] = {
        name = "Twin Fangs (Vexhul & Ithraz)",
        dungeon = "Venomous Abyss",
        phases = { "Geteilte HP", "Kontrolliertes Soaken" },
        mechanics = {
            { name = "Ewiges Gift", tip = "Stapelbarer Debuff. Bei 11 Stacks: 8 Sek. Betäubung + Tod." },
            { name = "Ätzende Kugeln", tip = "Müssen einzeln aufgesogen werden." }
        },
        roles = {
            tank = "Vexhul-Tank isolieren (4m Gift). Ithraz-Tank fängt 3 Bodenschläge ab.",
            dps = "Kugeln kontrolliert soaken. Beide Bosse gleichzeitig töten."
        }
    },
    ["Coiled Altar"] = {
        name = "Coiled Altar (Zul'jan & Malacrass)",
        dungeon = "Venomous Abyss",
        phases = { "P1: Zul'jan", "P2: Malacrass", "P3: Beide" },
        mechanics = {
            { name = "Guillotine", tip = "Muss mit 5+ Spielern gesoakt werden." },
            { name = "Malacrass Schild", tip = "Absorb-Schild brechen, dann Todeszauber kicken." },
            { name = "Düsterbombe", tip = "Sofort isolieren!" }
        },
        roles = {
            tank = "Wechsel bei 2 Stapeln 'Zorn der Mutter'.",
            heal = "Soak-Gruppen für Guillotine einteilen.",
            dps = "Unterbrechen von Malacrass hat Prio 1."
        }
    },
    ["Ulatek"] = {
        name = "Ula'tek",
        dungeon = "Venomous Abyss",
        phases = { "3 Phasen + Spiraltoxine Intermission" },
        mechanics = {
            { name = "Herz von Ulatek", tip = "Absoluter Fokus! Prio 1." },
            { name = "Spiraltoxine", tip = "Farbkombinationen über Köpfen lösen (Paar finden). Fehlschlag = Wipe." },
            { name = "Blutgift", tip = "Nicht sofort reinigen! Hinterlässt Voids je nach Restdauer." }
        },
        roles = {
            tank = "Atem-Schaden abfangen. Wechsel nach 100-Energie-Phase.",
            heal = "Blutgift-Timer genau beobachten vor dem Dispeln."
        }
    }
}
