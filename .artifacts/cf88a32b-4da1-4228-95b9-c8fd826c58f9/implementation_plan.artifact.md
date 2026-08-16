# Implementation Plan - Data Expansion (v1.3.5)

In diesem Update befüllen wir die Datenbank mit den restlichen Klassen des Venomous Abyss Raids. Da Wowhead den Scraper aktuell blockiert, füge ich die Daten für die gängigsten Klassen manuell auf Basis aktueller Raid-Guides hinzu.

## User Review Required

> [!IMPORTANT]
> **Aktueller Stand**: In v1.3.4 sind aktuell nur **Todesritter**, **Paladine** und **Krieger** befüllt.
> [!NOTE]
> **Nächster Schritt**: Ich füge nun die Daten für **Dämonenjäger**, **Druiden** und **Magier** hinzu. Damit decken wir die meisten Klassen in deiner Raid-Gruppe ab.
> [!TIP]
> **Langfristig**: Ich arbeite an einem Weg, den Scraper wieder zu entsperren, um alle 80 Spezialisierungen automatisch zu laden.

## Proposed Changes

### 1. Data Expansion (GuideData.lua)

#### [MODIFY] [GuideData.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Data/GuideData.lua)
- **Demon Hunter (577, 581)**:
    - BiS Gear für Verwüstung und Rachsucht.
    - Enchants & Buffs für 12.1.
- **Druid (102, 103, 104, 105)**:
    - Vollständige Listen für Gleichgewicht, Wildheit, Wächter und Wiederherstellung.
- **Mage (62, 63, 64)**:
    - Daten für Arkan, Feuer und Frost.
- **Vorbereitung**: Talent-Builds (Archon) bleiben für alle Klassen erhalten, da diese bereits erfolgreich geladen wurden.

---

### 2. UI Improvements

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- **Platzhalter**: Falls für eine Spec nur die Talente, aber kein Gear vorhanden ist, zeigt das Addon nun eine hilfreiche Nachricht an ("Gear-Daten folgen im nächsten Update") statt einer harten Fehlermeldung.

## Verification Plan

### Manual Verification
1. **Spec-Test**: Logge auf einen Druiden oder Magier ein.
2. **Reiter-Check**: Prüfe, ob Gear, Enchants und Buffs nun befüllt sind.
3. **Talent-Check**: Klicke auf einen Magier-Build -> Prüfe, ob Kopieren funktioniert.
