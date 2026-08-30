-- Dragon Skill - Raid Guides Master Database (v2.2.0)
-- Full data extracted from video "Aufzeichnung 2026-08-30 164121.mp4"

DragonSkillRaidGuides = {
    {
        id = 3011,
        name = "Nek'zali the Soulcoiler",
        icon = "Interface\\Icons\\Inv_misc_head_dragon_01",
        summary = "P1 bis 50% HP. Adds vom Well fernhalten. 100 Energie = Wipe.",
        phases = {
            {
                name = "Phase 1: Soulcoil Well",
                desc = "Der Boss steht in der Mitte eines Giftbrunnens. Niemals den Brunnen berühren (Hoher Schaden!).",
                mechanics = {
                    { name = "Seelenwinderzündung", tip = "Boss schwebt in die Luft. Spieler müssen Geister an den Sarkophagen am Rand aktivieren, um den Boss zurückzuholen." },
                    { name = "Restless Amani (Adds)", tip = "Kleine Adds laufen zum Brunnen. Sie haben Absorb-Schilde. Schilde brechen, dann Adds wegziehen. Wenn ein Add stirbt, explodiert es (15m Abstand halten!)." },
                    { name = "100 Energie", tip = "Altar-Aktivierung verursacht massive Raid-Explosionen und stärkt Boss/Adds permanent." }
                }
            },
            {
                name = "Intermission (50%): Ritual of Awakening",
                desc = "Boss wird immun. Fokus auf Echoes of Jawae.",
                mechanics = {
                    { name = "Echoes of Jawae", tip = "Müssen schnell getötet werden, während man Tethers (Verbindungen) trennt." },
                    { name = "Hungering Pyre", tip = "Lila Kugeln müssen von Spielern abgefangen (gesoakt) werden." }
                }
            },
            {
                name = "Phase 2: Burn Phase",
                desc = "Boss nutzt alle Fähigkeiten aus P1 verstärkt. Burn-Phase.",
                mechanics = {
                    { name = "Invoke", tip = "Kombiniert Seelenwinderzündung mit Add-Spawns. Maximaler Fokus." }
                }
            }
        },
        roles = {
            tank = "Boss im Kreis um den Brunnen bewegen. Nicht stehen bleiben! Tank-Wechsel bei Debuff (100% mehr Schaden).",
            heal = "Raid-Explosionen bei 100 Energie und Heal-Absorbs auf Spielern (Essence Rend) sofort gegenheilen.",
            dps = "Adds haben absolute Priorität. Schilde brechen, Adds rausziehen, dann erst Killen. 15m Abstand beim Add-Tod!"
        },
        position = "Raid verteilt sich kreisförmig um den Brunnen. Melees folgen dem Boss am Rand des Brunnens."
    },
    {
        id = 3010,
        name = "Entombed Sentinels (Jawae)",
        icon = "Interface\\Icons\\Spell_holy_mindvision",
        summary = "Seelenübertragung-Mechanik. Boss immun während Echo lebt. Soak-Management.",
        phases = {
            {
                name = "Phase 1: Seelenübertragung",
                desc = "Boss beschwört regelmäßig ein Echo (Jawae).",
                mechanics = {
                    { name = "Echo-Add", tip = "Boss ist zu 100% immun, solange das Echo lebt. Das Echo muss sofort fokussiert werden." },
                    { name = "Soak-Zone", tip = "Große Fläche am Boden. Alle Spieler müssen sich darin sammeln. Wer draußen steht, erhält einen stapelbaren Feuer-DoT." }
                }
            },
            {
                name = "Phase 2 (Ab 40%): Entschlingen",
                desc = "Der Boss beginnt, den Raid langsam zu verzehren.",
                mechanics = {
                    { name = "Entschlingen", tip = "Dauerhafter, ansteigender Raid-Schaden. Muss vor dem Soft-Enrage (100 Energie) beendet werden." }
                }
            },
            {
                name = "Zwischenphase: Leichen-Management",
                desc = "Adds hinterlassen Leichen auf dem Feld.",
                mechanics = {
                    { name = "Verbrennen", tip = "Add-Leichen müssen in die Soak-Zonen gezogen werden, um sie zu verbrennen. Nicht verbrannte Leichen kehren als gefährliche Adds zurück." }
                }
            }
        },
        roles = {
            tank = "Tank-Beschuss durch den Boss reduziert die erhaltene Heilung pro Stapel. Wechsel nach jeder 100-Energie-Phase nötig.",
            heal = "Starker Gruppenschaden in P2. Fokus auf Spieler mit hohen DoT-Stapeln außerhalb der Soak-Zone.",
            dps = "Echos haben absolute Prio. Add-Leichen müssen koordiniert verbrannt werden."
        },
        position = "Gesamter Raid bewegt sich als Block von Soak-Zone zu Soak-Zone."
    },
    {
        id = 3012,
        name = "Vashnik",
        icon = "Interface\\Icons\\Spell_nature_earthquake",
        summary = "Positionierung zwischen 3 Altären. Präzises Tank-Movement erforderlich.",
        phases = {
            {
                name = "Hauptphase",
                desc = "Kampf findet in einer Arena mit 3 Altären (Lila, Rot, Orange) statt.",
                mechanics = {
                    { name = "Altar-Aktivierung", tip = "Bei 100 Energie wird der Altar aktiv, vor dem der Boss steht." },
                    { name = "Positionierung", tip = "Der Boss MUSS immer genau zwischen zwei Altären stehen, um die Energieentladung zu minimieren." }
                }
            }
        },
        roles = {
            tank = "Die wichtigste Rolle hier: Bewege den Boss präzise zwischen die Altäre. Ein Fehler führt zum Wipe der gesamten Gruppe.",
            heal = "Massiver Schaden auf dem aktiven Tank durch 'Schmetterschlag'.",
            dps = "Maximale DPS auf den Boss, während die Altäre gewechselt werden."
        },
        position = "Tanks stehen sich gegenüber. Raid steht im 'sicheren' Bereich zwischen den nicht aktiven Altären."
    },
    {
        id = 3013,
        name = "The Lost Explorers",
        icon = "Interface\\Icons\\Inv_misc_monstertusk_01",
        summary = "Rats-Kampf gegen 3 Tortollaner (Iku, Nama, Gebbo). Fisch-Fütterungs Mechanik.",
        phases = {
            {
                name = "Rats-Phase",
                desc = "Alle drei Bosse teilen sich keine HP. Ein Troll im Hintergrund (nicht angreifbar) bufft sie.",
                mechanics = {
                    { name = "Ermächtigung", tip = "Der Troll im Hintergrund wirkt Buffs auf die Tortollaner. Diese MÜSSEN unterbrochen werden." },
                    { name = "Gebbos Kisten", tip = "Kisten erscheinen auf dem Feld. Durchlaufen, um Fisch zu erhalten. Fisch per Extra-Action-Button an den Boss mit der wenigsten Energie verfüttern." },
                    { name = "Namas Schildkrötenpanzer", tip = "Panzer fliegen durch den Raid. Ausweichen ist Pflicht, sonst 5 Sek. Betäubung." }
                }
            }
        },
        roles = {
            tank = "Trennt die Bosse voneinander, um Cross-Buffs zu vermeiden.",
            heal = "Viel unvorhersehbarer Schaden durch die fliegenden Panzer.",
            dps = "Kistenmanagement ist Prio 1. Fisch füttern verhindert den Enrage der Bosse."
        },
        position = "Großflächig verteilt stehen, um den Panzern besser ausweichen zu können."
    },
    {
        id = 3014,
        name = "Sszorak",
        icon = "Interface\\Icons\\Spell_nature_cyclone",
        summary = "Plattform-Kampf mit Wind-Mechanik. 6 Windkanäle drohen dich runterzustoßen.",
        phases = {
            {
                name = "Phase 1: Windkanäle",
                desc = "Der Boss nutzt die 6 Kanäle um die Plattform herum.",
                mechanics = {
                    { name = "Knockback", tip = "Regelmäßiger Windstoß schiebt Spieler nach außen. Stehe immer so nah wie möglich an der Mitte des Bosses." },
                    { name = "Giftwoge", tip = "Debuff auf zufälligen Spielern. Hinterlässt beim Auslaufen zähflüssige grüne Flächen (Voids). Diese müssen am Rand abgelegt werden." }
                }
            }
        },
        roles = {
            tank = "Boss strikt in der Mitte halten. Bei Push-Phasen Cooldowns nutzen.",
            heal = "Heile Spieler mit der Giftwoge besonders stark gegen.",
            dps = "Nicht gierig werden! Positionierung geht vor Schaden, wer fällt ist tot."
        },
        position = "Mittig sammeln für den Push. Flächen gezielt zum Rand bringen (aber nicht runterfallen!)."
    },
    {
        id = 3015,
        name = "Twin Fangs (Vexhul & Ithraz)",
        icon = "Interface\\Icons\\Ability_creature_poison_05",
        summary = "Geteilte HP. Beide müssen gleichzeitig sterben. Ewiges Gift Management.",
        phases = {
            {
                name = "Hauptphase",
                desc = "Zwei Schlangen-Bosse, die koordiniert bekämpft werden müssen.",
                mechanics = {
                    { name = "Ewiges Gift", tip = "Stapelbarer Debuff. Bei 11 Stapeln erfolgt eine 8-sekündige Betäubung gefolgt vom Tod. Reinige Stacks durch koordinierte Kicks." },
                    { name = "Ätzende Kugeln", tip = "Kugeln fliegen durch den Raum. Sie müssen einzeln von Spielern aufgesogen werden (Soaken). Mehrere Kugeln gleichzeitig = Wipe." }
                }
            }
        },
        roles = {
            tank = "Vexhul-Tank muss isoliert stehen (4m Gift-Radius). Ithraz-Tank muss 3 schwere Bodenschläge abfangen.",
            heal = "Starker Schaden auf den 'Soakern' der Kugeln.",
            dps = "Fokus auf beide Bosse gleichmäßig. Kugeln nacheinander soaken."
        },
        position = "Raid teilt sich in zwei Gruppen. Jede Gruppe kümmert sich um einen Boss und dessen Kugeln."
    },
    {
        id = 3016,
        name = "Coiled Altar (Zul'jan & Malacrass)",
        icon = "Interface\\Icons\\Spell_shadow_shadowwordpain",
        summary = "3 Phasen. P1 Zul'jan, P2 Malacrass, P3 beide gleichzeitig. Prio: Unterbrechen!",
        phases = {
            {
                name = "Phase 1: Zul'jan",
                desc = "Fokus auf Gift-Management und Äxte.",
                mechanics = {
                    { name = "Wirbelnde Äxte", tip = "Äxte fliegen im Kreis. Safe-Zone in der Mitte oder weit außen suchen." },
                    { name = "Guillotine", tip = "Boss fixiert Spieler. Muss mit mindestens 5 Spielern abgefangen werden, um den Schaden zu teilen." }
                }
            },
            {
                name = "Phase 2: Malacrass",
                desc = "Fokus auf Zauber-Unterbrechungen.",
                mechanics = {
                    { name = "Absorb-Schild", tip = "Boss erhält einen Schild. Währenddessen wirkt er einen tödlichen Zauber. Schild brechen, dann sofort kicken!" },
                    { name = "Düsterbombe", tip = "Spieler wird zur Bombe. Sofort von der Gruppe entfernen (isolieren)." }
                }
            }
        },
        roles = {
            tank = "Tank-Wechsel bei 2 Stapeln von 'Zorn der Mutter'.",
            heal = "Guillotine-Soaker müssen schnell hochgeheilt werden.",
            dps = "Malacrass-Zauber 'Todesurteil' MUSS gekickt werden. Schild brechen ist Prio 1."
        },
        position = "P1: Kuscheln für Guillotine. P2: Verteilen für Düsterbombe."
    },
    {
        id = 3017,
        name = "Ula'tek",
        icon = "Interface\\Icons\\Spell_shadow_sealofkings",
        summary = "Endboss. 3 Phasen + Spiraltoxine. Farbkombinationen lösen.",
        phases = {
            {
                name = "Phase 1 & 2: Eier und Schwanz",
                desc = "Boss beschwört Eier (Vipern/Rohlinge). Der Schwanz teilt sich HP mit dem Boss.",
                mechanics = {
                    { name = "Herz von Ula'tek", tip = "Erscheint regelmäßig. MUSS sofort getötet werden (Prio 1)." },
                    { name = "Blutgift", tip = "Debuff auf Heilern. Nicht sofort reinigen! Hinterlässt Flächen, deren Größe mit der Restdauer skaliert. Spät dispellen!" }
                }
            },
            {
                name = "Intermission: Spiraltoxine",
                desc = "Über den Köpfen erscheinen Farben (Rot, Blau, Gelb).",
                mechanics = {
                    { name = "Farb-Matching", tip = "Finde den Partner mit der komplementären Farbe und laufe mit ihm zusammen. Falsches Match = Raid-Wipe." }
                }
            }
        },
        roles = {
            tank = "Atem-Schaden (Void Breath) vom Raid wegdrehen. Wechsel nach jeder Intermission.",
            heal = "Blutgift-Management ist spielentscheidend. Dispelle nur, wenn der Spieler am Rand steht und der Timer fast abgelaufen ist.",
            dps = "Spiraltoxine fehlerfrei lösen. Adds/Herz immer Prio vor Boss-Schaden."
        },
        position = "Phase 1: Verteilt am Rand. Intermission: In der Mitte sammeln für Farbauswahl."
    }
}
