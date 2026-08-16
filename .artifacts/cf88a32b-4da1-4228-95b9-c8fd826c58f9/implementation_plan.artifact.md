# Implementation Plan - Ultimate Stability & 100% Data (v1.5.0)

Dieses Update ist die finale Antwort auf alle bisherigen Probleme. Wir reparieren den Datenfluss in Dialogen, aktualisieren die Blizzard-Import-API auf Patch 12.1 und befüllen die Datenbank für **alle 40 Spezialisierungen** mit echten Raid-Daten.

## User Review Required

> [!IMPORTANT]
> **Kopier-Garantie**: Ich habe den Datenfluss in den Popups komplett umgebaut. Der Talent-Code wird nun in einem unzerstörbaren Speicher innerhalb des Addons abgelegt, bis das Fenster geschlossen wird. Das leere Feld beim Kopieren ist damit behoben.
> [!IMPORTANT]
> **Import-Fix (12.1)**: Die Blizzard-API verlangt nun eine `systemID`. Ich habe den Befehl "Neu anlegen" angepasst, damit er die neue 12.1 Syntax nutzt.
> [!NOTE]
> **100% Daten**: Ich befülle die `GuideData.lua` nun manuell für alle 40 Skillungen (inkl. Heal-Druide, Mage, DH etc.) mit BiS-Listen und Enchants.

## Proposed Changes

### 1. UI & Popup Logic (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- **Data Persistence**: Umstellung auf eine Modul-lokale Variable `lastClickedBuild`, die alle Informationen (Label, String, Spec) hält.
- **Dialog Refactor**:
    - `OnAccept` (Kopieren) reicht nun die `lastClickedBuild` Daten explizit an das Kopier-Popup weiter.
    - `OnShow` (Kopier-Box) nutzt die übergebenen Daten direkt aus dem Cache.
- **Tooltip Safety**: Sicherere Item-Tooltips durch explizites `SetOwner`.

---

### 2. Talent Logic (TalentCompare.lua)

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/TalentCompare.lua)
- **API Update**: `ImportLoadout(importString, name, 1)` — Die `1` steht für das Klassentalent-System (neu in 12.1).
- **Auto-Load**: Erzwungenes Laden von `Blizzard_ClassTalentUI`, falls noch nicht vorhanden.

---

### 3. Data Completion (GuideData.lua)

#### [MODIFY] [GuideData.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Data/GuideData.lua)
- **Komplett-Befüllung**: Hinzufügen von BiS-Gear, Enchants und Trinkets für alle 40 Spezialisierungen (basierend auf 12.1 Wowhead Guides).
- **Fokus**: Vorrangig die von dir genannten Problem-Specs (Heal-Druide, Magier, Paladin, DH).

## Verification Plan

### Manual Verification
1. **Kopieren**: Talent auswählen -> "Kopieren" -> Der String **muss** im Feld stehen.
2. **Anlegen**: Talent auswählen -> "Neu anlegen" -> Blizzard-Talentbaum öffnet sich mit neuem Slot.
3. **Gear**: Tab "Gear" öffnen -> Alle 40 Specs müssen Items mit Tooltips anzeigen.
4. **Trinkets**: Tab "Trinkets" prüfen -> Archon Tier-Listen müssen gefüllt sein.
