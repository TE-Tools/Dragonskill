# Implementation Plan - Boss Assistant v1.0.0 (The Coordination Update)

Dieses Update erweitert den Dragon Skill Raid Assistant um zwei weitere Bosse des Venomous Abyss Raids und implementiert fortgeschrittene Tracking-Systeme für Spieler-Stacks und Positionierung.

## User Review Required

> [!IMPORTANT]
> **Stack-Monitoring (Twin Fangs)**: Wir fügen eine Echtzeit-Überwachung der "Eternal Venom" Stacks hinzu. Spieler, die 8 oder 9 Stacks erreichen, werden im Raidlead-Fenster rot markiert und erhalten eine Warnung, um sofort die "Ravenous Feast" Mechanik zu nutzen.

> [!IMPORTANT]
> **Positions-Assistent (Sszorak)**: Das Addon trackt die Windtunnel-Orbs und zeigt dem Raidlead an, an welcher Position die "Viscous Cysts" abgelegt werden müssen.

> [!NOTE]
> **Sound & Glow**: Wir führen visuelle "Glow"-Effekte für Frames und akustische Countdowns für kritische Phasen ein.

## Proposed Changes

### 1. Boss Mechanics Module

#### [NEW] [Sszorak.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/Sszorak.lua)
- Implementierung der **Wind Tunnel** Logik:
    - Tracking der Orbs (1, 2, 3) in den Tunneln.
    - Zuweisung von Cysten-Ablegeplätzen an Spieler mit dem Debuff.
    - Partner-Zuweisung für **Raging Crosswinds**.

#### [NEW] [TwinFangs.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/TwinFangs.lua)
- Überwachung der **Eternal Venom** Stacks im gesamten Raid.
- Liste der Spieler mit den höchsten Stacks im Raidlead-Fenster.
- Koordinations-Hilfe für den **Ravenous Feast** (wer darf soaken).

#### [MODIFY] [Core.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Core.lua)
- Neue Simulationen: `/ds testsszorak` und `/ds testfangs`.
- Hinzufügen von akustischen Signalen ("Achtung!", "Laufen!", "Soaken!") via `BossMechanics:PlaySound`.

---

### 2. UI & Interaction Polish

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/UI.lua)
- **Glow-System**: Integration von `LibCustomGlow` (oder manuellem Frame-Glow) für kritische Warnungen.
- **Side-List Erweiterung**: Unterstützung für Stack-Anzeigen (z.B. "Thomas (9)").

---

### 3. Metadata

#### [MODIFY] [DragonSkill.toc](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/DragonSkill.toc)
- Version auf `1.0.0` anheben.
- Registrierung der neuen Boss-Module.

## Verification Plan

### Manual Verification
1. **/ds testsszorak** -> Prüfen, ob die Cysten-Zuweisung und die Wind-Reihenfolge angezeigt wird.
2. **/ds testfangs** -> Prüfen, ob Spieler mit hohen Stacks (z.B. 9) rot blinken oder speziell hervorgehoben werden.
3. **Sound Check** -> Verifizieren der neuen Sprach-Warnungen/Sounds.
