# Implementation Plan - Boss Simulation & Restoration Druid Fix (v1.4.3)

Dieses Update aktiviert die Boss-Tests über den neuen Befehl `/wear` und befüllt den Heilig-Druiden (Wiederherstellung) mit vollständigen Daten.

## User Review Required

> [!IMPORTANT]
> **Boss-Tests**: Du kannst die Boss-Mechaniken nun mit **`/wear <name>`** testen. Beispiel: `/wear testulatek`.
> [!IMPORTANT]
> **Heal-Druide Fix**: Ich füge die fehlenden Talente (Everbloom/Wildstalker) und die Rotation für den Wiederherstellung-Druiden hinzu.
> [!NOTE]
> **Rotation & Prio**: Für DK, Paladin und Druide werden nun echte Prioritäts-Listen im Tab "Rotation" angezeigt.

## Proposed Changes

### 1. UI & Slash Commands (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- Erweiterung des `/wear` Befehls um Parameter-Handling für Boss-Tests.
- Liste der verfügbaren Tests:
    - `testboss` (Entombed Sentinels)
    - `testnekzali`
    - `testexplorers`
    - `testvashnik`
    - `testsszorak`
    - `testfangs`
    - `testaltar`
    - `testulatek` (Finale)

---

### 2. Data Completion (GuideData.lua)

#### [MODIFY] [GuideData.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Data/GuideData.lua)
- **Heal-Druide (105)**:
    - Talent-Strings für 12.1 (Everbloom).
    - Detaillierte Heil-Rotation (Swiftmend Prio etc.).
- **Rotationen**: Hinzufügen von Prio-Listen für alle bereits befüllten Klassen (DK, Pala, Krieger, DH, Mage).

## Verification Plan

### Manual Verification
1. **Boss-Test**: `/wear testulatek` eingeben -> Prüfen, ob die Warnungen erscheinen.
2. **Heal-Druide**: Logge auf einen Druiden -> Prüfe, ob "Talente" und "Rotation" nun befüllt sind.
3. **Kopier-Check**: Talent anklicken -> "Kopieren" -> Code prüfen.
