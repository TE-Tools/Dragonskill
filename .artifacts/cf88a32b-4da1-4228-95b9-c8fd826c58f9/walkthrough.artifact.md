# Walkthrough - Dragon Skill v0.3

Die Erweiterung des Dragon Skill Addons ist abgeschlossen. Die neuen Funktionen umfassen einen detaillierten Talent-Abgleich, Stat-Vergleiche mit Durchschnittswerten sowie neue Guides für Gear und Verbrauchsgegenstände.

## Wichtigste Änderungen

### 1. Detaillierter Talent-Abgleich
Statt nur einer Prozentzahl zeigt das Addon nun beim Klick auf einen Guide-Build die konkreten Abweichungen an.
- Nutzt die offizielle Blizzard-API `GetImportConfigSlotMap`.
- Listet Talentname und Rang (Soll vs. Ist) direkt im Bestätigungsdialog auf.

### 2. Stat-Vergleich mit Archon-Durchschnittswerten
Im "Stats"-Tab werden nun deine aktuellen Charakterwerte (Haste, Crit, etc.) direkt den Durchschnittswerten aus den Archon.gg-Guides gegenübergestellt.
- Hilft dabei zu sehen, ob man zu viel oder zu wenig in einen bestimmten Stat investiert hat.

### 3. Neue Guide-Inhalte
Das Addon verfügt nun über drei neue Tabs:
- **Gear**: Zeigt Best-in-Slot Empfehlungen pro Slot inklusive Fundort.
- **Enchants/Gems**: Empfehlungen für Verzauberungen und Edelsteine.
- **Consumables**: Die besten Fläschchen, Tränke und Bufffood für deine Spec.

### 4. Verbesserter Workflow & Fixes
- **Import-Benennung**: Gespeicherte Skillungen werden nun automatisch nach dem Schema `Provider: Label (Datum Uhrzeit)` benannt.
- **Spec-ID Fix**: Der Demon Hunter (Devourer) wurde auf die korrekte ID `1480` aktualisiert.
- **UI-Reparatur**: Das korrupte UI-Modul wurde vollständig neu aufgebaut.

## Verifizierung
- Die Scraper-Logik für Wowhead wurde erweitert, um Tabellen und Listen zu erfassen.
- Der Lua-Konverter wurde angepasst, um die neuen Datenfelder in die `GuideData.lua` zu schreiben.
- Die `spec-list.json` wurde erfolgreich aktualisiert.

> [!TIP]
> Nutze `/ds` im Spiel, um das neue Interface zu öffnen und die Tabs zu erkunden.
