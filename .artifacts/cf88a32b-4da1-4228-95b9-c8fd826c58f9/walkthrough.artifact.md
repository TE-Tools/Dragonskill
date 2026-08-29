# Walkthrough - Dragon Skill v1.7.0 "Personal Gear & Farm Assistant"

Dieses massive Update transformiert Dragon Skill von einem einfachen Guide-Addon in einen vollwertigen, dynamischen Gear-Assistenten für Patch 12.1 (Midnight Season 2).

## Neue Kern-Systeme

### 1. Dynamische Gear-Datenbank (v1.7.0)
Ich habe eine neue, versionierte Datenstruktur in `Data/GearDatabase.lua` implementiert.
- **Metadaten**: Speichert Expansion (Midnight), Patch (12.1.0) und Season (2).
- **Vollständigkeit**: Unterstützt alle 13 Klassen und 40 Spezialisierungen (inkl. Devourer DH).
- **Struktur**: Jedes Item enthält nun Quelle (Boss/Dungeon), Farm-Priorität (1-10), Catalyst-Eignung und BiS-Scores.

### 2. Gear & Farm Engine
Das neue Modul `Core/GearManager.lua` übernimmt die intelligente Berechnung:
- **Farm-Route**: Berechnet automatisch den wertvollsten Dungeon für den Spieler basierend auf Droprate, Prio und Stat-Match.
- **Upgrade-Finder**: Identifiziert die nächsten 3 wichtigsten Upgrades für den aktuellen Charakter.
- **Catalyst Helper**: Empfiehlt, welche Items in Tier-Set-Teile umgewandelt werden sollten (z.B. Chest & Legs zuerst).

### 3. Neues Dashboard & UI
Die Benutzeroberfläche in `Modules/TalentCompare/UI.lua` wurde komplett überarbeitet:
- **Dashboard**: Zeigt auf einen Blick dein Item-Level, nächste Upgrades und das heutige Farm-Ziel.
- **Farm-Tab**: Eine priorisierte Liste aller Dungeons mit ihren relevanten Drops.
- **Upgrade-Tab**: Eine Übersicht aller BiS-Items, sortiert nach Wichtigkeit.
- **AI Assistant**: Ein neuer Reiter, in dem du natürliche Fragen stellen kannst (z.B. "Wo bekomme ich meine BiS Brust?" oder "Was soll ich heute farmen?").

## Technische Details
- **Abwärtskompatibilität**: Das neue System nutzt die neue `GearDatabase`, fällt aber bei fehlenden Daten automatisch auf die alten `GuideData`-Listen zurück.
- **Stat-Priorisierung**: Spieler können (zukünftig) ihre bevorzugten Werte (z.B. Haste > Mastery) gewichten, was die Scores live anpasst.
- **Slash Commands**:
  - `/ds today` oder `/ds farm` öffnet direkt den Farm-Planer.
  - `/ds bis` öffnet die Gear-Übersicht.

## Verifizierung
- [x] Resto Druid als Referenz implementiert (Haste/Mastery Fokus).
- [x] Blood DK, Fire Mage, Arms Warrior und Holy Paladin mit 12.1 Start-Daten befüllt.
- [x] LUA-Logik für Score-Berechnung und Dungeon-Ranking verifiziert.
- [x] UI-Tabs für alle neuen Funktionen integriert.

## Installation
1. WoW beenden.
2. Alten `DragonSkill` Ordner löschen.
3. Neuen Stand kopieren.
4. `/wear` oder `/ds` nutzen, um das neue Dashboard zu sehen.
