-- Dragon Skill - Raid Guides Master Database (v2.2.0)
-- Full data extracted from video "Aufzeichnung 2026-08-30 164121.mp4"

DragonSkillRaidGuides = {
    {
        id = 3011,
        name = "Nek'zali the Soulcoiler",
        summary = "P1 bis 50% HP. Adds vom Well fernhalten. 100 Energie = Wipe.",
        phases = {
            {
                name = "Phase 1: Soulcoil Well (bis 50%)",
                desc = "Boss steht in der Mitte eines Giftbrunnens. Niemals den Brunnen berühren (Hoher Schaden!).",
                mechanics = {
                    { name = "Seelenwinderzündung", tip = "Boss schwebt; Geister an Sarkophagen am Rand aktivieren." },
                    { name = "Restless Amani (Adds)", tip = "Kleine Adds laufen zum Brunnen. Sie haben Absorb-Schilde. Schilde brechen, dann wegziehen. Tod verursacht Explosion (15m)." },
                    { name = "100 Energie", tip = "Altar-Aktivierung verursacht massive Raid-Explosionen und stärkt Boss/Adds permanent." }
                }
            },
            {
                name = "Intermission (50%): Ritual of Awakening",
                desc = "Boss immun. Fokus auf Echoes of Jawae.",
                mechanics = {
                    { name = "Echoes of Jawae", tip = "Schnell töten, Tethers trennen." },
                    { name = "Hungering Pyre", tip = "Lila Kugeln soaken." }
                }
            }
        },
        roles = { tank = "Boss im Kreis bewegen. Wechsel bei Debuff.", heal = "Raid-Explosionen und Absorbs gegenheilen.", dps = "Adds Prio 1! Schilde brechen, rausziehen." },
        position = "Kreisförmig um den Brunnen verteilt."
    },
    {
        id = 3010,
        name = "Entombed Sentinels (Jawae)",
        summary = "Seelenübertragung-Mechanik. Boss immun während Echo lebt.",
        phases = {
            {
                name = "Phase 1: Seelenübertragung",
                desc = "Boss beschwört regelmäßig Jawae.",
                mechanics = {
                    { name = "Echo-Add", tip = "Boss immun solange Echo lebt. Echo sofort fokussieren!" },
                    { name = "Soak-Zone", tip = "Gemeinsam darin sammeln. Draußen = Feuer-DoT." }
                }
            },
            {
                name = "Phase 2: Entschlingen",
                desc = "Dauerhafter Raid-Schaden ab 40%.",
                mechanics = {
                    { name = "Verbrennen", tip = "Leichen in Soak-Zonen ziehen und verbrennen!" }
                }
            }
        },
        roles = { tank = "Wechsel nach 100 Energie nötig.", heal = "Raid-Schaden in P2 extrem hoch.", dps = "Leichen-Management ist Key." },
        position = "Raid bewegt sich als Block."
    },
    {
        id = 3012,
        name = "Vashnik",
        summary = "Positionierung zwischen 3 Altären.",
        phases = {
            {
                name = "Hauptphase",
                desc = "Arena mit Lila, Rot, Orange Altären.",
                mechanics = {
                    { name = "Positionierung", tip = "Boss MUSS zwischen zwei Altären stehen!" }
                }
            }
        },
        roles = { tank = "Präzise Positionierung ist ALLES. Fehler = Wipe.", heal = "Viel Schaden auf Tank.", dps = "Maximale DPS." },
        position = "Sichere Bereiche zwischen inaktiven Altären nutzen."
    },
    {
        id = 3013,
        name = "The Lost Explorers",
        summary = "Rats-Kampf gegen 3 Tortollaner.",
        phases = {
            {
                name = "Rats-Phase",
                desc = "Iku, Nama, Gebbo gleichzeitig.",
                mechanics = {
                    { name = "Gebbos Kisten", tip = "Durchlaufen, Fisch aufnehmen, an Boss mit wenigster Energie verfüttern." },
                    { name = "Panzer", tip = "Namas Schildkrötenpanzern ausweichen!" }
                }
            }
        },
        roles = { tank = "Bosse trennen.", heal = "Viel unvorhersehbarer Schaden.", dps = "Fisch füttern verhindert Enrage." },
        position = "Großflächig verteilt."
    },
    {
        id = 3014,
        name = "Sszorak",
        summary = "Plattform-Kampf mit Windkanälen.",
        phases = {
            {
                name = "Plattform-Phase",
                desc = "6 Windkanäle um die Plattform.",
                mechanics = {
                    { name = "Knockback", tip = "Wind schiebt nach außen. Immer mittig stehen!" },
                    { name = "Giftwoge", tip = "Hinterlässt Voids. Am Rand ablegen." }
                }
            }
        },
        roles = { tank = "Boss mittig halten.", heal = "Giftwoge-Spieler heilen.", dps = "Nicht runterfallen!" },
        position = "Zentral sammeln für den Push."
    },
    {
        id = 3015,
        name = "Twin Fangs",
        summary = "Geteilte HP. Gleichzeitig töten.",
        phases = {
            {
                name = "Duo-Phase",
                desc = "Vexhul & Ithraz koordiniert bekämpfen.",
                mechanics = {
                    { name = "Ewiges Gift", tip = "Bei 11 Stacks = Tod. Durch Kicks reinigen." },
                    { name = "Kugeln", tip = "Einzeln soaken. Mehrere gleichzeitig = Wipe." }
                }
            }
        },
        roles = { tank = "Vexhul-Tank isolieren (4m).", heal = "Soaker heilen.", dps = "Gleichmäßiger Schaden." },
        position = "Zwei Gruppen bilden."
    },
    {
        id = 3016,
        name = "Coiled Altar",
        summary = "Zul'jan & Malacrass.",
        phases = {
            {
                name = "Phase 1: Zul'jan",
                desc = "Gift und Äxte.",
                mechanics = {
                    { name = "Guillotine", tip = "Mit 5+ Spielern soaken." }
                }
            },
            {
                name = "Phase 2: Malacrass",
                desc = "Unterbrechungen.",
                mechanics = {
                    { name = "Schild", tip = "Schild brechen, dann kicken!" }
                }
            }
        },
        roles = { tank = "Wechsel bei 2 Stacks.", heal = "Soaker retten.", dps = "Kicks auf Malacrass sind Prio 1." },
        position = "Kuscheln (P1) vs. Verteilen (P2)."
    },
    {
        id = 3017,
        name = "Ula'tek",
        summary = "Endboss. Spiraltoxine lösen.",
        phases = {
            {
                name = "Phase 1: Eier",
                desc = "Vipern/Rohlinge managen.",
                mechanics = {
                    { name = "Herz", tip = "Sofort töten!" },
                    { name = "Spiraltoxine", tip = "Farben über Köpfen matchen (Rot/Blau/Gelb)." }
                }
            }
        },
        roles = { tank = "Atem wegdrehen.", heal = "Blutgift spät dispellen.", dps = "Spiraltoxine lösen!" },
        position = "Verteilt am Rand."
    }
}
