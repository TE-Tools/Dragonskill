# Implementation Plan - Dragon Skill Expansion (v0.7)

Dieses Update implementiert die nächsten drei Meilensteine: verbesserte Item-Icons, akustische Warnungen für Bosse und das Modul für den ersten Raid-Boss (Nek’zali).

## User Review Required

> [!IMPORTANT]
> **Item-Icons & IDs**: Wir nutzen nun primär `itemId` für die Icons im Gear-Tab. Falls eine ID fehlt (Wowhead-Scraper-Limitierung bei manchen Items), versuchen wir den Namen lokal aufzulösen.
> [!IMPORTANT]
> **Boss-Sounds**: Ich füge standardmäßige Blizzard-Warnsounds hinzu (z.B. Raid-Warnung-Ping bei Intermissions).

## Proposed Changes

### 1. UI & Icons Polish

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- Optimierung der `Helper_DrawListWithIcons` Funktion:
    - Bessere Fehlerbehandlung bei fehlenden Icons.
    - Automatisches "Pre-Caching" von Item-Informationen, damit Icons beim zweiten Öffnen geladen sind.
    - Anzeige der Item-Qualitätsfarben in den Texten.

---

### 2. Boss Mechanics: Sounds & Core

#### [MODIFY] [Core.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Core.lua)
- Hinzufügen einer `BossMechanics:PlaySound(type)` Funktion.
- Typen: `START`, `INTERMISSION`, `WARNING`, `DONE`.
- Nutzung von Standard-IDs (8959, 876098, etc.).

#### [MODIFY] [EntombedSentinels.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/EntombedSentinels.lua)
- Einbau der Sound-Trigger bei Phasenwechseln und Paar-Zuweisungen.

---

### 3. Neuer Boss: Nek’zali the Soulcoiler

#### [NEW] [Nekzali.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/Nekzali.lua)
- Implementierung der Logik für den Gatekeeper-Boss:
    - Überwachung der **Soulcoil Well** Energie (Power-Bar Anzeige).
    - Warnung bei Erreichen von 100% Energie.
    - Tracking von **Raised Amani** Adds (Anzeige im Raidlead-Fenster).

#### [MODIFY] [DragonSkill.toc](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/DragonSkill.toc)
- Registrierung der neuen Boss-Datei.

## Verification Plan

### Manual Verification
- **/ds** -> Gear Tab prüfen: Erscheinen Icons für die meisten Items? Sind die Namen farbig (Lila/Blau)?
- **/ds testboss** -> Kommen Sounds beim Start der Simulation?
- **Nek'zali Test**: Implementierung eines `/ds testnekzali` Befehls zur Simulation der Energie-Balken.
