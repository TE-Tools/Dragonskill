# Implementation Plan - Emergency Slash Command & Data Fix (v1.3.1)

Dieses Update behebt das Problem, dass `/ds` ein Emote auslöst statt das Addon zu öffnen, und stellt sicher, dass die Daten für Gear, Enchants und Buffs endlich im Spiel ankommen.

## User Review Required

> [!IMPORTANT]
> **Slash-Command Priorität**: Ich verschiebe die Registrierung des Befehls `/ds` an den Anfang des Addons. Das verhindert, dass WoW den Befehl mit `/danke` verwechselt oder ignoriert.
> [!IMPORTANT]
> **Daten-Reparatur**: Ich habe festgestellt, dass die `GuideData.lua` tatsächlich leere Listen enthält. Ich befeuere den Scraper neu und erzwinge das Schreiben der Daten für alle Sektionen.
> [!CAUTION]
> **Ordner-Pflicht**: Bitte lösche vor der Installation UNBEDINGT alle alten `DragonSkill` und `addon` Ordner in deinem WoW-Verzeichnis.

## Proposed Changes

### 1. Slash Command Fix (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- **Registrierung**: Slash-Befehle werden an den Zeilenanfang (Zeile 1) verschoben.
- **Eindeutigkeit**: Umbenennung des internen Befehlshandlers von `DRAGONSKILL` zu `DS_MAIN`, um Konflikte zu vermeiden.
- **Addon-Signal**: Das Addon schreibt nun eine fette, farbige Nachricht in den Chat, sobald es geladen ist.

---

### 2. Daten-Pipeline Reparatur

#### [MODIFY] [scrape-wowhead.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-wowhead.js)
- Optimierung der `extractConsumables` Funktion, um auch Listen zu finden, die nicht direkt unter einer fettgedruckten Überschrift stehen.

#### [MODIFY] [build-data.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/build-data.js)
- Sicherstellung, dass Listen (Gear, Enchants etc.) beim Mergen von Wowhead- und Archon-Daten nicht überschrieben werden.

---

### 3. Tooltip-Vorschau (UI.lua)

- Implementierung von `GameTooltip:SetHyperlink` als Fallback, falls `SetItemByID` bei manchen Items in 12.1 Probleme macht.

## Verification Plan

### Manual Verification
1. **Startup**: Steht beim Einloggen "Dragon Skill v1.3.1 - AKTIV!" im Chat?
2. **/ds**: Öffnet sich das Fenster? (Erscheint kein Emote mehr?)
3. **Daten-Check**: Sind die Tabs (Gear, Enchants) nun befüllt?
4. **Talent-Klick**: Öffnet sich der Dialog zum Kopieren/Importieren?
