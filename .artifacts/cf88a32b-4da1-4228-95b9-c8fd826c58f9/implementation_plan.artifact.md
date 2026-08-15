# Implementation Plan - Dragon Skill UI & Data Fix (v0.6.4)

Dieses Update behebt die Layout-Fehler (überlappende Tabs), repariert die Klickbarkeit der Buttons und stellt sicher, dass die Daten für alle Reiter korrekt geladen werden.

## User Review Required

> [!IMPORTANT]
> **Layout-Korrektur**: Ich werde die Insets und Tabs neu verankern, damit sie nicht mehr übereinander liegen und die Tabs am unteren Rand sauber sichtbar sind.
> [!IMPORTANT]
> **Klick-Fix**: Wir stellen sicher, dass der Inhalt (`Content`) eine höhere Frame-Ebene hat als der Hintergrund, damit Klicks auf Talente/Items wieder registriert werden.
> [!NOTE]
> **Daten-Sync**: Ich werde den Scraper so anpassen, dass er bei leeren Feldern (Gear, Rotation) aggressiver nach den Informationen sucht.

## Proposed Changes

### 1. UI & Layout Repair

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **Anchoring**: Tabs werden fest am unteren Rand des Fensters verankert, und das Inset (Hintergrund) wird so angepasst, dass es oberhalb der Tabs endet.
- **Frame Strata**: Erhöhung der Frame-Ebene für den `scrollFrame` und den `content`, um die Klickbarkeit sicherzustellen.
- **Visuals**: Korrektur der Fenstergröße und der Positionierung des Porträts.

---

### 2. Scraper Robustness

#### [MODIFY] [scrape-wowhead.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-wowhead.js)
- **Regex Update**: Unterstützung für weitere Tabellen-Formate auf Wowhead.
- **Fallback Handling**: Wenn eine spezifische URL (z.B. `/bis-gear`) nicht existiert, versuchen wir die Daten aus der `/overview` Seite zu extrahieren.

---

### 3. Boss Mechanics Simulation

#### [MODIFY] [EntombedSentinels.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/EntombedSentinels.lua)
- **Group Check**: Bessere Überprüfung der Gruppenmitglieder, um sicherzustellen, dass Namen im Testmodus korrekt erscheinen.

## Verification Plan

### Manual Verification
1. **/ds** -> Prüfen, ob die Tabs unten sauber getrennt vom Hintergrund sind.
2. **Klick-Test** -> Auf einen Talent-Button klicken und prüfen, ob der Dialog erscheint.
3. **Daten-Check** -> Alle Tabs durchgehen (Gear, Rotation etc.) und prüfen, ob Listen angezeigt werden.
4. **/ds testboss** -> In einer Gruppe prüfen, ob Namen gelistet werden.
