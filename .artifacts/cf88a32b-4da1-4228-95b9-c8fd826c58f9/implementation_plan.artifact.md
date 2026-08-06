# Implementation Plan - Dragon Skill Final Sync (v0.6.1)

Dieses Update behebt die verbleibenden Interaktionsprobleme, befüllt die leeren Tabs mit robusteren Scraper-Methoden und stellt sicher, dass der Boss-Testmodus auch für Gruppen funktioniert.

## User Review Required

> [!IMPORTANT]
> **Scraper-Korrektur**: Ich habe festgestellt, dass Wowhead einige Daten (Gear/Rotation) auf unterschiedlichen Unterseiten versteckt. Ich passe den Scraper so an, dass er bei Fehlern (404) intelligent alternative URLs probiert.

> [!IMPORTANT]
> **UI-Interaktion**: Ich verschiebe die Slash-Commands in den globalen Bereich, um sicherzustellen, dass `/ds testboss` immer reagiert. Zudem optimiere ich die Klick-Reaktion im Talent-Tab.

## Proposed Changes

### 1. Scraper & Data Polish

#### [MODIFY] [scrape-wowhead.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-wowhead.js)
- Implementierung eines Fallback-Systems für URLs.
- Lockerung der Regex-Muster für Gear-Tabellen und Rotations-Listen.

#### [MODIFY] [build-data.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/build-data.js)
- Sicherstellung, dass auch "nil"-Werte sauber in die Lua-Tabelle exportiert werden, ohne die Struktur zu brechen.

---

### 2. Addon UI & Logic

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **Slash Commands**: Global registriert (außerhalb von Init).
- **Z-Order**: Sicherstellung, dass Buttons im ScrollFrame immer klickbar sind.
- **Stats-Tab**: Anzeige von Archon-Durchschnitten direkt neben Spielerwerten.

#### [MODIFY] [EntombedSentinels.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/EntombedSentinels.lua)
- Korrektur der `SimulateIntermission` Logik, um das Boss-UI zuverlässig zu triggern.

## Verification Plan

### Manual Verification
- `/ds` -> Alle Tabs prüfen (Gear, Rotation, Enchants sollten nun befüllt sein).
- `/ds testboss` -> Prüfen, ob das Raidlead-Fenster mit Gruppennamen erscheint.
- Klick auf Talent -> Import-Popup muss erscheinen.

---

## Open Items (To-Do für morgen)
1. **Detaillierte Item-Icons**: Einige Items in der BiS-Liste fehlen noch Icons.
2. **Boss-Sounds**: Implementierung der akustischen Warnungen.
3. **Weitere Bosse**: Vorbereitung für den nächsten Boss im Venomous Abyss.
