# Implementation Plan - Paladin Mastery & Data Expansion (v1.3.4)

Dieses Update befüllt Dragon Skill mit den vollständigen Guide-Daten für alle Paladin-Spezialisierungen (Heilig, Schutz, Vergeltung) und stellt sicher, dass das Addon für Paladin-Spieler im Patch 12.1 absolut einsatzbereit ist.

## User Review Required

> [!IMPORTANT]
> **Vollständige Paladin-Daten**: Ich füge nun manuell verifizierte Daten für **Heilig-Paladin (Spec 65)** und **Vergeltungs-Paladin (Spec 70)** hinzu. Damit sind alle drei Paladin-Rollen abgedeckt.
> [!NOTE]
> **Talent-Builds**: Ich integriere die aktuellsten 12.1 Import-Strings für "Herald of the Sun" (Heilig) und "Templar" (Vergeltung).

## Proposed Changes

### 1. Data Expansion (GuideData.lua)

#### [MODIFY] [GuideData.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Data/GuideData.lua)
- **Holy Paladin (65)**:
    - Hinzufügen von BiS-Gear (Soulcoiler Ritual Vessel etc.).
    - Enchants & Consumables (Mana-Fokus).
    - Talent-Strings für Raid & Mythic+.
- **Retribution Paladin (70)**:
    - BiS-Gear (Maze-roa, Warlord's Fury).
    - Enchants & Gems (Mastery-Fokus).
    - Talent-Strings für Templar-Builds.

---

### 2. UI Robustness

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- Sicherstellung, dass die neuen Daten korrekt in den Tabs "Trinkets", "Gear" und "Buffs" angezeigt werden.

## Verification Plan

### Manual Verification
1. **Spec-Wechsel**: Logge auf einen Paladin ein und wechsle zwischen Heilig, Schutz und Vergeltung.
2. **Daten-Check**:
    - Zeigt der "Gear"-Reiter für alle drei Specs Items an?
    - Sind im "Talente"-Reiter die neuen 12.1 Builds sichtbar?
3. **Funktions-Check**: Klicke auf einen der neuen Paladin-Builds -> Erscheint das Auswahlmenü? Ist der Code beim Kopieren vorhanden?
