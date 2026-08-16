# Implementation Plan - Talent Import & Clipboard Enhancement (v1.1.0)

Dieses Update verbessert den Workflow beim Klick auf einen Talent-Build. Es ermöglicht nun das direkte Anlegen einer neuen Skillung im offiziellen Blizzard-Interface sowie ein verbessertes Kopieren in die Zwischenablage.

## User Review Required

> [!IMPORTANT]
> **Direkt-Import**: Wir nutzen nun die offizielle `ClassTalentFrame:ImportLoadout` API. Das bedeutet, dass beim Klick auf "Als neue Skillung anlegen" tatsächlich ein neuer Loadout-Slot in deinem WoW-Talentbaum erstellt wird.
> - Dies funktioniert nur außerhalb des Kampfes.
> - Das offizielle Talent-Fenster wird dabei kurzzeitig im Hintergrund geladen, falls es noch nicht offen war.

> [!NOTE]
> **Zwischenablage**: Da WoW keinen direkten Zugriff auf die Windows-Zwischenablage erlaubt (Sicherheitsbeschränkung), nutzen wir weiterhin ein Textfeld mit Auto-Markierung. Du musst lediglich **Strg+C** drücken.

## Proposed Changes

### 1. UI & Workflow (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **Neuer Dialog-Ablauf**:
    1. Klick auf einen Build in der Liste.
    2. Ein Info-Dialog zeigt die Details (Provider, Name, %-Abgleich, konkrete Talent-Abweichungen).
    3. Drei Buttons zur Auswahl:
        - **Kopieren**: Öffnet das Textfeld für Strg+C.
        - **Neu Anlegen**: Erstellt den Loadout direkt in WoW.
        - **Abbrechen**.
- **Automatisches Laden**: Sicherstellen, dass `Blizzard_ClassTalentUI` geladen wird, bevor der Import-Befehl ausgeführt wird.

---

### 2. Talent Logic (TalentCompare.lua)

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/TalentCompare.lua)
- Hinzufügen einer Hilfsfunktion `ImportToWoW(importString, name)`, die die Blizzard-API sicher aufruft.

## Verification Plan

### Manual Verification
1. **/ds** -> Tab "Talente".
2. Klick auf einen Build (z.B. "Archon Recommended").
3. Dialog prüfen: Erscheinen die neuen Optionen?
4. **Test "Kopieren"**: Erscheint das Edit-Feld? Funktioniert Strg+C?
5. **Test "Neu Anlegen"**: Öffne danach das Blizzard-Talentfenster (`N`). Ist dort ein neuer Slot mit dem korrekten Namen und den Talenten erschienen?
6. **Kampf-Check**: Prüfen, ob das Addon eine Warnung ausgibt, wenn man versucht, während eines Kampfes zu importieren.
