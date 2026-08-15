# Implementation Plan - Dragon Skill UI Final Reconstruction (v0.6.6)

Dieses Update strukturiert das UI-System grundlegend um, um die Klickbarkeit unter allen Umständen zu garantieren und das fehlerhafte Layout am unteren Rand (Tabs) zu fixen.

## User Review Required

> [!IMPORTANT]
> **Radikaler Klick-Fix**: Wir setzen das gesamte Fenster auf `FrameStrata("DIALOG")` und die Buttons auf eine noch höhere Ebene. Dies erzwingt, dass das Addon Vorrang vor allen anderen UI-Elementen hat.
> [!IMPORTANT]
> **Layout Redesign**: Wir entfernen das problematische `ButtonFrameTemplate` und bauen ein eigenes, stabiles Fenster mit klaren Grenzen. Die Tabs werden sauber getrennt vom Inhaltsbereich platziert.
> [!NOTE]
> **Debug-Output**: Beim Klicken auf einen Talent-Button wird nun eine Chat-Nachricht ausgegeben, damit wir sofort sehen, ob der Klick überhaupt registriert wurde.

## Proposed Changes

### 1. UI-Neubau (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **Eigenes Template**: Wechsel von `ButtonFrameTemplate` zu einem einfachen `Backdrop`-Frame. Dies gibt uns volle Kontrolle über die Schichtung.
- **Klick-Priorität**:
    - Der `ScrollFrame` und alle Buttons bekommen explizit `SetFrameStrata("FULLSCREEN_DIALOG")`.
    - Alle Buttons erhalten ein `OnMouseDown` und `OnMouseUp` Feedback (visuell), um die Interaktion zu bestätigen.
- **Layout**:
    - Das Inset (schwarzer Hintergrund) wird massiv verkleinert, damit die Tabs unten **außerhalb** des Hintergrunds liegen.
    - Die Tabs werden mit einem größeren Abstand zueinander und zum Rand platziert.

---

### 2. Talent-Logik Robustness

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/TalentCompare.lua)
- Hinzufügen von `pcall` (Protected Call) beim Talent-Vergleich, um zu verhindern, dass ein Fehler in der Blizzard-API den gesamten Klick-Prozess lautlos abbricht.

## Verification Plan

### Manual Verification
1. **/ds** -> Fenster erscheint.
2. **Klick auf Talente** -> Prüfen, ob "Klick registriert" im Chat erscheint und ob der Dialog aufgeht.
3. **Tab-Wechsel** -> Prüfen, ob die unteren Buttons nun sauber anklickbar sind.
4. **Layout** -> Verifizieren, dass nichts mehr überlappt oder abgeschnitten ist.
