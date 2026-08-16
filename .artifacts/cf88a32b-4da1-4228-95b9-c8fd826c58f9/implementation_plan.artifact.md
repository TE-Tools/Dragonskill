# Implementation Plan - Reliability & Feature Update (v1.2.5)

Dieses Update behebt die verbleibenden Datenlücken, repariert die Talent-Klick-Interaktion und fügt Item-Vorschauen (Tooltips) für alle Listen hinzu.

## User Review Required

> [!IMPORTANT]
> **Tooltips (Vorschau)**: Wenn du nun im Gear-, Trinket- oder Buff-Reiter mit der Maus über einen Eintrag fährst, erscheint automatisch der WoW-Standard-Tooltip des Gegenstands (die "Vorschau").
> [!IMPORTANT]
> **Talent-Fix**: Ich stelle die Talent-Abfrage auf ein robusteres System um, das nicht mehr auf dynamischen Popups basiert, sondern eine feste Struktur nutzt. Dies sollte die Blockaden in WoW 12.1 umgehen.
> [!NOTE]
> **Daten-Pipeline**: Ich erweitere den Scraper, um auch modernere Wowhead-Layouts (z.B. mit [h3] Überschriften für Enchants) zu unterstützen.

## Proposed Changes

### 1. Scraper & Data Pipeline

#### [MODIFY] [scrape-wowhead.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-wowhead.js)
- Erweitertes Matching für Enchants/Gems/Consumables: Unterstützung für `[h2]`, `[h3]` und `[color]` basierte Überschriften.
- Fallback für BiS-Listen, falls diese in `[box]` statt `[table]` stehen.

#### [MODIFY] [scrape-archon.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-archon.js)
- Optimierung der Trinket-Extraktion: Unterstützung für `BuildsTrinketAnalysisSection`.

---

### 2. Addon UI & Tooltips

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- **Tooltips**: Hinzufügen von `OnEnter` und `OnLeave` Handlern für alle List-Buttons in `Helper_DrawListWithIcons`.
- **Talent Click**:
    - Umstellung der `StaticPopup` Registrierung (einmalige statische Definition statt Neuregistrierung pro Klick).
    - Hinzufügen von Debug-Chat-Ausgaben für jeden Schritt des Prozesses.
- **Layout**: Fix der Fenster-Ebenen, um sicherzustellen, dass Tooltips nicht hinter dem Fenster erscheinen.

---

### 3. Core Logic

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/TalentCompare.lua)
- Sicherstellung, dass der Import-Dialog auch bei minimalen Abweichungen (similarity > 99%) erscheint.

## Verification Plan

### Manual Verification
1. **/ds** -> Reiter "Gear" öffnen.
2. **Hover-Test**: Mit der Maus über ein Item fahren -> Tooltip muss erscheinen.
3. **Talent-Test**: Build anklicken -> Das Auswahlfenster **muss** erscheinen.
4. **Daten-Check**: Prüfen, ob "Enchants" und "Buffs" nun befüllt sind (nach Neukopieren der Daten).
