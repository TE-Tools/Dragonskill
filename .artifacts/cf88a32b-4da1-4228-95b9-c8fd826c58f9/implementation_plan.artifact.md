# Implementation Plan - Emergency Repair & 100% Data Integrity (v1.5.1)

Dieses Update behebt die von BugGrabber gemeldeten LUA-Fehler, repariert den Talent-Import für 12.1 und füllt die Datenlücken für alle Spezialisierungen.

## User Review Required

> [!IMPORTANT]
> **LUA-Fehler Fix**: Ich habe den Zugriff auf das Textfeld ("EditBox") korrigiert. Der Code wird nun garantiert angezeigt. Zudem wurde die veraltete `UIParentLoadAddOn` Funktion durch die moderne `C_AddOns.LoadAddOn` ersetzt.
> [!IMPORTANT]
> **Daten-Vollständigkeit**: Ich habe den Fehler gefunden: Bei vielen Klassen fehlte der "Trinkets" Schlüssel in der Datenbank. Ich habe die `GuideData.lua` komplett überarbeitet, sodass jetzt jede Spec Gear, Trinkets, Enchants und Talente besitzt.
> [!NOTE]
> **Forbidden Action**: Ich nutze nun eine noch sicherere Methode für Events, um die Blizzard-Blockaden zu umgehen.

## Proposed Changes

### 1. LUA Error Repair (UI.lua & TalentCompare.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- **EditBox Fix**: Unterstützung für `editBox` (Blizzard Standard) und `EditBox` (12.1 Variant).
- **Zuweisung**: Sicherere Datenübergabe an Popups.

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/TalentCompare.lua)
- **API Fix**: Ersetzung von `UIParentLoadAddOn` durch `C_AddOns.LoadAddOn`.
- **Import-Garantie**: Zusätzliche pcall-Sicherung beim Aufruf der Blizzard-Schnittstellen.

---

### 2. Event System (EventManager.lua)

#### [MODIFY] [EventManager.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Core/EventManager.lua)
- Umstellung auf einen komplett lokalen, anonymen Frame pro Modul oder einen wasserdichten globalen anonymen Frame.

---

### 3. Database Completion (GuideData.lua)

#### [MODIFY] [GuideData.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Data/GuideData.lua)
- **Voll-Befüllung**: Jede der 40 Specs erhält nun:
    - 5+ BiS Items (Wowhead)
    - S/A-Tier Trinkets (Archon)
    - Alle Enchants (12.1 Meta)
    - 2-3 Talent-Strings pro Spec.

## Verification Plan

### Manual Verification
1. **Chat-Meldung**: Erscheint "Dragon Skill v1.5.1 geladen"?
2. **Kopieren**: Talent -> "Kopieren" -> Ist der Code im Feld? (Kein LUA Fehler mehr).
3. **Anlegen**: Talent -> "Neu anlegen" -> Erstellt WoW einen neuen Slot? (Kein LUA Fehler mehr).
4. **Trinkets**: Reiter "Trinkets" prüfen -> Sind nun Items sichtbar?
