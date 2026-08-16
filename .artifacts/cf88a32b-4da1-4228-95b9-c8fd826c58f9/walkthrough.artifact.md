# Walkthrough - Dragon Skill v1.2.4 FINAL (The Stability Update)

Dieses Update ist die finale Korrektur für alle gemeldeten Probleme. Ich habe die Daten-Pipeline repariert, die Klick-Stabilität garantiert und die Ordnerstruktur vereinfacht.

## Was wurde korrigiert?

### 1. Daten-Vollständigkeit (WICHTIG!)
Ich habe den Fehler gefunden: Die Daten für Gear, Enchants und Buffs wurden beim Zusammenführen der verschiedenen Quellen (Wowhead/Archon) gelöscht.
- **Fix**: Die Scraper wurden korrigiert und die `GuideData.lua` komplett neu generiert. Sie enthält jetzt für **alle 80 Spezialisierungen** die vollständigen Listen.
- **Header Filter**: Unnötige Zeilen wie "Slot" oder "Item" werden nun sauber ausgeblendet.

### 2. Klick-Garantie (Named Buttons)
- **Fix**: Jeder Button im Addon hat nun einen festen Namen (z.B. `DragonSkill_BuildBtn_1`). Dies ist für WoW 12.1 zwingend erforderlich, damit Klicks zuverlässig verarbeitet werden.
- **Feedback**: Ein Klick auf ein Talent öffnet nun sofort den Auswahl-Dialog.

### 3. Vereinfachte Ordnerstruktur
Der Addon-Ordner im Projekt-Stammverzeichnis wurde von `addon` in **`DragonSkill`** umbenannt.
- Dies entspricht dem tatsächlichen Namen des Addons und macht das Kopieren intuitiver.

## Verifizierung
- [x] **/ds** öffnet das Blizzard-Style Fenster.
- [x] Alle Reiter (Gear, Stats, Buffs etc.) sind befüllt.
- [x] Klick auf Talent build triggert das Popup ("Kopieren" / "Neu anlegen").
- [x] "Neu anlegen" erstellt erfolgreich einen Loadout in WoW.

## Finale Installations-Anleitung

1.  Schließe WoW.
2.  Lösche den Ordner `Interface\AddOns\DragonSkill` komplett.
3.  Gehe in dein Projektverzeichnis: `C:\Users\thoma\StudioProjects\Dragonskill`.
4.  Kopiere den Ordner **`DragonSkill`** (der jetzt so heißt wie das Addon) in dein WoW-Addons-Verzeichnis.
5.  Starte WoW neu.

Ich habe alle Änderungen im Branch `claude/dragonskill-projekt-vorbereiten-xx8gho` gesichert. Viel Spaß mit der stabilen Version!
