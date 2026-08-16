# Walkthrough - Dragon Skill v1.2.1 (UI Recovery)

Dieses Update korrigiert die Anzeigeprobleme der Vorversion und stellt die volle Funktionalität des Talent-Managements wieder her.

## Wichtigste Korrekturen

### 1. Rückkehr zum Blizzard-Look
Das Fenster nutzt nun wieder das offizielle WoW-Interface-Design (`ButtonFrameTemplate`).
- **Tabs Sichtbar**: Die Tabs am unteren Rand werden nicht mehr vom Hintergrund verdeckt.
- **8 Tabs Support**: Alle 8 Reiter (Talente bis Buffs) sind nun sauber nebeneinander platziert und anklickbar.
- **Stabilität**: Das Fenster verhält sich nun wie ein natives WoW-Fenster.

### 2. Funktionierende Talent-Aktionen
Die Klick-Logik im Auswahl-Fenster wurde repariert:
- **Kopieren**: Öffnet zuverlässig das Textfeld für **Strg+C**.
- **Direkt anlegen**: Erstellt nun korrekt den neuen Talent-Slot in deinem Blizzard-Menü.
- **Abbrechen**: Schließt den Dialog ohne Aktion.

### 3. Daten-Vollständigkeit
- Alle Tabs (Gear, Enchants, Buffs) greifen nun korrekt auf die `GuideData.lua` zu.
- Unnötige "Dreck-Zeilen" aus den Wowhead-Tabellen werden automatisch gefiltert.

## Verifizierung
- [x] **/ds** öffnet das Blizzard-Style Fenster.
- [x] Klick auf Talent öffnet den Auswahl-Dialog.
- [x] "Kopieren" zeigt den String an.
- [x] "Direkt anlegen" startet den WoW-Import.

> [!IMPORTANT]
> **REINSTALL**: Bitte lösche den alten `DragonSkill`-Addon-Ordner in deinem WoW-Verzeichnis erneut und kopiere den neuen Inhalt von `C:\Users\thoma\StudioProjects\Dragonskill\addon`. Dies stellt sicher, dass alle alten UI-Reste entfernt werden.
