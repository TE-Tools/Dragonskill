# Implementation Plan - Dragon Skill Expansion (v0.3)

Dieses Projekt erweitert das Dragon Skill Addon um zusätzliche Guides (Gear, Enchants, Gems, Consumables), verfeinert den Talent-Diff, implementiert einen Stat-Abgleich und repariert das korrupte UI-Modul.

## User Review Required

> [!IMPORTANT]
> **Detaillierter Talent-Diff**: Statt nur einer Prozentzahl werden wir `C_ClassTalents.GetImportConfigSlotMap` nutzen, um genau anzuzeigen, welche Talente abweichen (Soll vs. Ist). Das UI wird dies in einer Liste oder Gegenüberstellung darstellen.

> [!IMPORTANT]
> **Stat-Abgleich**: Wir werden versuchen, von Archon.gg die durchschnittlichen Stat-Prozentwerte (z.B. "Haste 32%") zu scrapen. Im Addon werden diese neben den aktuellen Spielerwerten (aus `GetCombatRatingBonus` etc.) angezeigt, um einen direkten Vergleich zu ermöglichen.

> [!NOTE]
> **Import-Workflow**: Beim Speichern einer Skillung wird der Name automatisch um Provider (Wowhead/Archon), Build-Label und Zeitstempel ergänzt, um die Historie besser nachvollziehbar zu machen.

## Proposed Changes

### Core & Data Configuration

#### [MODIFY] [spec-list.json](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/spec-list.json)
- Korrektur der Spec-ID für "Devourer" Demon Hunter auf `1480`.
- Entfernen der Platzhalter-Notizen.

---

### Scraper (Node.js)

#### [MODIFY] [scrape-wowhead.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-wowhead.js)
- Erweiterung um `extractBiSGear`, `extractEnchantsAndGems` und `extractConsumables`.

#### [MODIFY] [scrape-archon.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-archon.js)
- Erweiterung um das Scraping von **durchschnittlichen Stat-Prozentwerten** aus dem `__NEXT_DATA__` Blob (falls dort vorhanden) oder per Selektor.

#### [MODIFY] [build-data.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/build-data.js)
- Lua-Konverter anpassen für neue Felder: `bisGear`, `enchants`, `gems`, `consumables` und `statAverages` (Archon).

---

### Addon (Lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **Kompletter Neubau**:
    - Hauptfenster mit Tabs: **Talente**, **Stats**, **Gear**, **Enchants**, **Consumables**.
    - **Talent-Tab**: Zeigt den %-Vergleich UND eine Liste der abweichenden Talente (Name + Rang) durch Nutzung von `C_ClassTalents.GetImportConfigSlotMap`.
    - **Stats-Tab**: Gegenüberstellung Guide-Priorität vs. Guide-Durchschnittswerte vs. Aktuelle Spielerwerte.
    - Slash-Commands `/ds` / `/dragonskill`.

#### [MODIFY] [Database.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Core/Database.lua)
- `CreateSkilling` anpassen, um Metadaten (Provider, Timestamp) in den Standardnamen zu integrieren.

#### [NEW] [Gear.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/Gear/Gear.lua)
#### [NEW] [Enchants.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/Enchants/Enchants.lua)

## Verification Plan

### Automated Tests
- `cd scraper && node scrape-all.js` (Testlauf für einige Specs).
- `node build-data.js` -> Validierung der `GuideData.lua`.

### Manual Verification
- In-Game: `/ds` -> Prüfen der Tabs.
- Talent-Vergleich: Eine abweichende Skillung wählen und prüfen, ob die konkreten Talente aufgelistet werden.
- Stat-Vergleich: Prüfen, ob die eigenen %-Werte (Haste/Crit/etc.) korrekt neben den Guide-Werten erscheinen.
