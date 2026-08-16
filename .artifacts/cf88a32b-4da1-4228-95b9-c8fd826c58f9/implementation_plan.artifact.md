# Implementation Plan - Final Survival Update (v1.3.3)

Dieses Update ist der definitive Versuch, die Blockaden von WoW 12.1 zu umgehen und die fehlenden Daten (Gear, Enchants etc.) durch eine neue Scraper-Strategie wiederherzustellen.

## User Review Required

> [!IMPORTANT]
> **Talent-Dialog Fix**: Ich habe das Problem gefunden, warum das Kopier-Feld leer war. WoW 12.1 löscht das `data` Argument beim Wechsel von Popups. Ich nutze nun eine globale Variable innerhalb des Addons, um den Talent-String absolut sicher zwischenzuspeichern.
> [!IMPORTANT]
> **Blizzard API Rettung**: Ich habe die Import-Befehle nochmals überarbeitet. Falls Blizzard das Fenster im Hintergrund blockiert, wird nun eine Warnung ausgegeben, die dir genau sagt, was zu tun ist.
> [!NOTE]
> **Daten-Rekonstruktion**: Da Wowhead den Scraper blockiert, habe ich die `GuideData.lua` für deine Klasse (Todesritter/Krieger) manuell befüllt, damit du sofort loslegen kannst.

## Proposed Changes

### 1. UI & Dialog Logic (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- **Persistenter Speicher**: Hinzufügen einer Modul-globalen Variable `UI.currentBuild`, die niemals verloren geht.
- **Dialog-Handler**: Umstellung der Popups auf diese Variable.
- **Tooltip Fix**: Sicherstellung, dass `GameTooltip:SetItemByID` auch in 12.1 zuverlässig funktioniert (durch explizites `SetOwner`).

---

### 2. Talent Logic (TalentCompare.lua)

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/TalentCompare.lua)
- **Import Fallback**: Erweitertes Error-Handling beim Aufruf von `ImportLoadout`.

---

### 3. Data Integrity (GuideData.lua)

#### [MODIFY] [GuideData.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Data/GuideData.lua)
- Manuelle Injektion von BiS-Gear, Enchants und Buffs für die am häufigsten gespielten Specs, um die Wowhead-Blockade zu überbrücken.

## Verification Plan

### Manual Verification
1. **Befehl**: `/wear` muss das Fenster öffnen.
2. **Kopieren**: Talent anklicken -> "Kopieren" -> Das Feld **muss** den Code enthalten.
3. **Anlegen**: Talent anklicken -> "Neu anlegen" -> "Import gestartet" Nachricht im Chat prüfen.
4. **Vorschau**: Im Gear-Tab über ein Item fahren -> Vorschaubild (Tooltip) muss erscheinen.
5. **Daten**: Prüfen, ob für Todesritter/Krieger nun Gear und Enchants sichtbar sind.
