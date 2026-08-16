# Implementation Plan - UI Recovery & Interaction Fix (v1.2.1)

Dieses Update stellt das native Blizzard-Design wieder her, repariert die defekten Klick-Aktionen in den Dialogen und stellt sicher, dass alle 8 Tabs sauber befüllt werden.

## User Review Required

> [!IMPORTANT]
> **Rückkehr zum Blizzard-Look**: Ich entferne das "selbstgemachte" Fenster und nutze wieder das offizielle `ButtonFrameTemplate`. Dies behebt die Anzeige-Probleme und sorgt für einen nativen Look.
> [!IMPORTANT]
> **Dialog-Fix**: Die Buttons im Auswahl-Fenster ("Kopieren" / "Direkt anlegen") funktionieren nun wieder. Ich habe die internen Blizzard-Funktionsnamen (`OnAccept`, `OnCancel`, `OnAlt`) korrigiert.

## Proposed Changes

### 1. UI Restoration (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **Template**: Umstellung zurück auf `ButtonFrameTemplate`.
- **Layout**:
    - Das `Inset` wird so verankert, dass die Tabs am unteren Rand Platz haben.
    - Die 8 Tabs werden leicht verkleinert, damit sie nebeneinander passen.
- **Data Check**: Hinzufügen von Debug-Meldungen, falls `GuideData` für die aktuelle Spec fehlt.

---

### 2. Interaction Repair (UI.lua & TalentCompare.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **StaticPopup Fix**:
    - Button 1 ("Kopieren") -> `OnAccept`
    - Button 2 ("Direkt anlegen") -> `OnCancel` (Blizzard Konvention für 2. Button)
    - Button 3 ("Abbrechen") -> `OnAlt`

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/TalentCompare.lua)
- Sicherstellung, dass `ImportToWoW` auch dann funktioniert, wenn das Talent-Fenster noch nie geöffnet wurde (explizites Laden).

## Verification Plan

### Manual Verification
1. **/ds** -> Blizzard-Fenster muss erscheinen.
2. **Tab-Check** -> Alle 8 Reiter (Talente bis Buffs) müssen anklickbar sein.
3. **Klick-Test** -> Talent anklicken -> "Was möchtest du tun?" Dialog muss erscheinen.
4. **Action-Test**:
    - Klick auf "Kopieren" -> Textfeld muss erscheinen.
    - Klick auf "Direkt anlegen" -> "Import gestartet" im Chat und neuer Slot in Talenten.
