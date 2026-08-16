# Implementation Plan - Dragon Skill Absolute Stability & Data Fix (v1.2.4)

Dieses Update ist eine radikale Fehlerbehebung, um die Klickbarkeit der Buttons und die Vollständigkeit der Guide-Daten unter WoW 12.1 zu garantieren.

## User Review Required

> [!IMPORTANT]
> **Klick-Garantie**: Ich verwende nun benannte Buttons und ein vereinfachtes Ereignis-System. Dies verhindert, dass Blizzard-Sicherheitsmechanismen (Tainting) die Buttons blockieren.
> [!IMPORTANT]
> **Daten-Audit**: Ich habe festgestellt, dass der Scraper in bestimmten Fällen die Daten zwar findet, aber nicht korrekt in die finale Lua-Datei schreibt. Ich korrigiere den `build-data.js` Prozess.
> [!NOTE]
> **Debug-Modus**: Wenn Daten fehlen, zeigt das Addon nun im Fenster exakt an, welche Tabelle (bisGear, rotation, enchants) leer ist.

## Proposed Changes

### 1. UI Robustness (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **Buttons**: Alle Buttons bekommen nun einen eindeutigen Namen (erforderlich für manche Templates in 12.1).
- **Layering**: Explizite Erhöhung des `FrameLevel` für den Scroll-Inhalt.
- **Error Handling**: Umwickeln des gesamten `Update`-Prozesses mit `pcall`, um lautlose Abstürze zu verhindern.

---

### 2. Scraper & Data Pipeline Fix

#### [MODIFY] [scrape-wowhead.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-wowhead.js)
- Optimierung der BiS-Gear Extraktion (Wowhead hat das Markup leicht geändert).
- Hinzufügen von Fallbacks für Rotationen.

#### [MODIFY] [build-data.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/build-data.js)
- Fix der Logik beim Zusammenführen von Provider-Daten (Wowhead/Archon).

---

### 3. Talent Logic Stability

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/TalentCompare.lua)
- Sicherstellung, dass `C_ClassTalents` APIs nur aufgerufen werden, wenn das entsprechende System bereit ist.

## Verification Plan

### Manual Verification
1. **/ds** -> Das Fenster **muss** erscheinen.
2. **Klick-Test** -> Auf ein Talent klicken. Falls nichts passiert, schau in den Chat (Debug-Meldungen).
3. **Tab-Test** -> Alle Reiter prüfen. Wenn ein Reiter leer ist, muss nun eine spezifische Meldung erscheinen (z.B. "Keine Gear-Daten in GuideData.lua").
4. **Data-Check** -> Ich werde den Scraper für eine Spec (z.B. DEATKNIGHT 250) manuell prüfen.
