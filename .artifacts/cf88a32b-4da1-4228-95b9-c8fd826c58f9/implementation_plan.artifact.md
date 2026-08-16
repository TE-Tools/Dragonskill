# Implementation Plan - Slash Command & Data Access Rescue (v1.2.8)

Dieses Update behebt das Problem, dass `/ds` nicht mehr reagiert, und stellt sicher, dass die Daten für alle Spezialisierungen korrekt geladen werden. Zudem fügen wir eine "Anti-Konflikt" Schicht ein, falls Reste alter Versionen vorhanden sind.

## User Review Required

> [!IMPORTANT]
> **Ordner-Bereinigung**: Da wir den Addon-Ordner von `addon` zu `DragonSkill` umbenannt haben, **muss** der alte Ordner `addon` im WoW-Verzeichnis gelöscht werden, sonst kommt es zu Fehlern.
> [!IMPORTANT]
> **Slash-Command Fix**: Ich registriere den Befehl `/ds` nun direkt beim Laden des Addons (nicht erst beim Login), um sicherzustellen, dass er immer verfügbar ist.
> [!NOTE]
> **Debug-Ausgabe**: Das Addon schreibt jetzt beim Start "Dragon Skill geladen!" in den Chat, damit wir sehen, ob es überhaupt aktiv ist.

## Proposed Changes

### 1. UI & Slash Command (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- **Registrierung**: Slash-Commands werden an den Anfang der Datei verschoben.
- **Robustheit**:
    - Absicherung von `GetSpecializationInfo`, um Fehler bei Charakteren ohne Spec zu verhindern.
    - Hinzufügen von Chat-Feedback, wenn `/ds` eingegeben wird.
- **Data Lookup**: Verbesserung der Fehlermeldungen, wenn `GuideData` nicht gefunden wird (zeigt nun auch den erwarteten Pfad an).

---

### 2. Talent Logic (TalentCompare.lua)

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/TalentCompare.lua)
- **Import-Fix**: Zusätzliche Prüfung, ob `C_ClassTalents` Funktionen existieren (für den Fall, dass Blizzard sie in einem Mini-Patch verschiebt).

---

### 3. Data Pipeline (GuideData.lua)

#### [MODIFY] [GuideData.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Data/GuideData.lua)
- Überprüfung der globalen Tabelle `DragonSkillData`.

## Verification Plan

### Manual Verification
1. **Startup**: Prüfen, ob nach dem Einloggen "Dragon Skill geladen!" im Chat steht.
2. **/ds**: Prüfen, ob das Fenster erscheint.
3. **Daten-Check**: Tab "Talente" und "Gear" prüfen. Falls leer, die neue (detaillierte) Fehlermeldung lesen und mir mitteilen.
4. **Talent-Klick**: Prüfen, ob der Dialog nun zuverlässig erscheint.
