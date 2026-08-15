# Implementation Plan - Patch 12.1 Update (Curse of Ula’tek)

Dieses Update bereitet Dragon Skill auf den **Patch 12.1** vor, indem die Interface-Version aktualisiert und die Talent-API an die neuen "Multi-System" Anforderungen von Blizzard angepasst wird.

## User Review Required

> [!IMPORTANT]
> **API-Änderung (C_Traits)**: Mit Patch 12.1 verlangt Blizzard für viele Talent-Abfragen explizite `systemID`s (da es nun Hausbau-Talente, Zonen-Talente etc. gibt). Ich passe die `TalentCompare.lua` an, um dynamisch das richtige System (Class Talents) zu identifizieren.

> [!IMPORTANT]
> **Talent-Strings (V2)**: Blizzard hat das Format der Import-Strings auf Version 2 aktualisiert. Die `GetImportConfigSlotMap` API sollte dies intern handhaben, aber unser Byte-Level-Diff könnte bei alten Strings (v0.6.2 Daten) ungenauer werden, bis der Scraper neue 12.1-Daten liefert.

## Proposed Changes

### 1. Core & Metadata

#### [MODIFY] [DragonSkill.toc](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/DragonSkill.toc)
- Update Interface: `120100` (Curse of Ula’tek).
- Update Version: `0.9.0`.

---

### 2. Talent Logic (Patch 12.1 Compatibility)

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/TalentCompare.lua)
- **Multi-System Support**:
    - Implementierung einer Suche nach der `systemID` für Klassentalente (Standard ID 1).
    - Anpassung von `C_Traits.GetNodeInfo` und `C_Traits.GetConfigInfo` Aufrufen.
- **Serialization Check**: Hinzufügen einer Prüfung, ob der Import-String Version 2 nutzt.

---

### 3. Boss Mechanics (Venomous Abyss)

#### [MODIFY] [LostExplorers.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/LostExplorers.lua)
- Aktualisierung der Encounter-ID für Patch 12.1 (The Lost Explorers).
- Verfeinerung des Energie-Trackings für "Mor’zahi".

#### [NEW] [Vashnik.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/Vashnik.lua)
- Neues Modul für den 4. Boss (**Vashnik the Malignant**).
- Tracking der Gift-Quadranten (**Toxic Distillation**).

## Verification Plan

### Manual Verification
1. **/ds** -> Prüfen, ob das Fenster ohne API-Fehler (LUA Errors) aufgeht.
2. **Talent Tab** -> Klick auf einen Build. Prüfen, ob `GetImportConfigSlotMap` in 12.1 weiterhin die korrekte Map liefert.
3. **/ds testexplorers** -> Test der 12.1 Boss-Logik.
4. **Tooltips** -> Prüfen, ob `TooltipDataProcessor` in 12.1 weiterhin BiS-Infos anzeigt (Housing Items könnten nun ebenfalls Tooltips haben).
