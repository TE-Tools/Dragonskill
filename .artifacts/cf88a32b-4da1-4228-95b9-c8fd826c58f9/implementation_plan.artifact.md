# Implementation Plan - Dragon Skill Expansion (v0.8)

Dieses Update erweitert das Addon um ein neues Bossmodul für "The Lost Explorers", fügt akustische Warnungen hinzu und verfeinert die Item-Icons sowie die allgemeine Stabilität.

## User Review Required

> [!IMPORTANT]
> **Neuer Boss: The Lost Explorers**:
> - Dieses Modul unterstützt den Raid-Rat (Nama, Eku, Gabbo).
> - **Mechanik-Tracking**: Überwachung der Boss-Energie (Mor’zahi) und Anzeige, wann ein Fisch gefüttert werden muss.
> - **Ultimate-Warnungen**: Spezielle Anzeigen für "Mighty Tad" (Soak), "Frostfire Wally" (Element-Clearing) und "Mushroom Bounce".

> [!IMPORTANT]
> **Sound-Integration**:
> - Ich füge eine zentrale Sound-Bibliothek hinzu, damit Bosse akustische Signale geben können (z.B. "Soaken!" oder "Energie kritisch!").

## Proposed Changes

### 1. Boss Mechanics Module

#### [NEW] [LostExplorers.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/LostExplorers.lua)
- Implementierung der Council-Logik:
    - Tracking der Energie von Mor’zahi (UnitPower boss4).
    - Warnungen für Boss-spezifische Ultimates.
    - Status-Anzeige der Interrupt-Rotation für Scroll Sage Eku.

#### [MODIFY] [Core.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Core.lua)
- Erweiterung der Simulationen um `/ds testexplorers`.
- Implementierung der Inter-Addon-Kommunikation für synchronisierte Warnungen in der Gruppe.

---

### 2. UI & Quality of Life

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **Item Icons**: Automatisches Auflösen von Icons via `GetItemIcon` für alle Listen.
- **Visuals**: Einbau eines kleinen "Glow"-Effekts für kritische Boss-Warnungen.

---

### 3. Scraper Fixes

#### [MODIFY] [scrape-wowhead.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-wowhead.js)
- Optimierung der Extraktion von "Rotation Priority" (Icons werden nun als Text-Präfix gespeichert).

## Verification Plan

### Manual Verification
1. **/ds testexplorers** -> Prüfen, ob das Raidlead-Fenster die Energie der drei Schildkröten anzeigt.
2. **Icons Check** -> Gear-Tab öffnen und prüfen, ob Icons nun zuverlässiger geladen werden.
3. **Sound Check** -> Verifizieren, dass akustische Signale bei den Simulationen abgespielt werden.
