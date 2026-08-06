# Implementation Plan - Dragon Skill Ultimate Update (v0.4)

Dieses Update verwandelt Dragon Skill in ein vollwertiges Guide-Zentrum, indem es Trinket-Rankings, Crafting-Tipps, Rotations-Prioritäten und Tooltip-Integration hinzufügt.

## User Review Required

> [!CAUTION]
> **UI-Fehlerbehebung**: Der gemeldete Fehler `attempt to index field 'TitleText' (a nil value)` wird sofort behoben, indem der Zugriff auf die Titel-Container an die aktuelle Retail-API angepasst wird.

> [!IMPORTANT]
> **Tooltip-Integration**: Wir fügen einen "Dragon Skill"-Hinweis zu Item-Tooltips hinzu. Wenn ein Item in der BiS-Liste des aktuellen Guides steht, wird dies direkt am Gegenstand angezeigt.

> [!NOTE]
> **Rotation**: Dies ist eine statische Prioritätenliste (Text + Icons), kein aktiver Rotations-Helfer (kein "Glow" auf Buttons), um innerhalb der Blizzard-Richtlinien zu bleiben.

## Proposed Changes

### UI & Core Fixes

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- Behebung des `TitleText`-Fehlers.
- Erweiterung des Tab-Systems auf 8 Tabs: **Talente, Stats, Gear, Trinkets, Enchants, Consumables, Crafting, Rotation**.
- Icons zu den Listen hinzufügen (Verwendung von `GetItemIcon` oder Spell-Icons).

---

### Scraper Enhancements (Node.js)

#### [MODIFY] [scrape-archon.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-archon.js)
- Extraktion der **Trinket Tier List** aus den `initialData` des `__NEXT_DATA__` Blobs.

#### [MODIFY] [scrape-wowhead.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-wowhead.js)
- Neue Parser für **Rotation Priority** (Suche nach "Rotation" oder "Priority" Sektionen).
- Neue Parser für **Crafting & Embellishments**.

#### [MODIFY] [build-data.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/build-data.js)
- Export der neuen Felder (`trinkets`, `crafting`, `rotation`) in die `GuideData.lua`.

---

### Addon Modules

#### [NEW] [Trinkets.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/Trinkets/Trinkets.lua)
- Modul zur Anzeige der Trinket-Rangliste (S-Tier bis D-Tier).

#### [NEW] [Rotation.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/Rotation/Rotation.lua)
- Anzeige der Fähigkeiten-Priorität mit Icons.

#### [NEW] [Crafting.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/Crafting/Crafting.lua)
- Tipps für hergestellte Gegenstände und Verzierungen.

#### [NEW] [Tooltips.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/Tooltips/Tooltips.lua)
- Integration in `TooltipDataProcessor`, um BiS-Status auf Items anzuzeigen.

## Verification Plan

### Automated Tests
- `cd scraper && node scrape-all.js` zur Validierung der neuen Felder.
- `node build-data.js` zur Syntax-Prüfung der Lua-Daten.

### Manual Verification
- **Fehlerprüfung**: Nach dem Login prüfen, ob das Hauptfenster ohne Fehler erscheint.
- **Tooltip Check**: Über ein bekanntes BiS-Item (z.B. aus der Vault) fahren und den Hinweis prüfen.
- **Tab-Navigation**: Alle 8 Tabs auf Vollständigkeit und Icons prüfen.
