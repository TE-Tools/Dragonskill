# Walkthrough - Dragon Skill v0.6 (Ultimate Polish)

Dieses Update behebt die leeren Tabs, verbessert den Stats-Vergleich und erweitert die Boss-Mechaniken.

## Wichtigste Änderungen

### 1. Daten-Vollständigkeit (Gear, Rotation, Trinkets)
Die `GuideData.lua` wurde massiv erweitert. Durch korrigierte Scraper-URLs werden nun folgende Informationen für alle 80 Specs geladen:
- **Best-in-Slot Gear**: Listen pro Slot inklusive Fundort (Wowhead).
- **Rotation Priority**: Die wichtigsten Fähigkeiten in der richtigen Reihenfolge mit Icons (Wowhead).
- **Trinket Tier List**: Rankings von Archon.gg (sofern verfügbar).
- **Stat-Vergleich**: Deine Werte vs. Guide-Empfehlung vs. Archon-Durchschnitt.

### 2. UI-Reparatur & Polish
- **Talent-Klick**: Der Fehler, bei dem Klicks auf Talente nicht reagierten, wurde behoben. Ein Klick öffnet nun zuverlässig den Speicher/Import-Dialog.
- **Stats-Tab**: Komplettes Redesign. Du siehst deine eigenen Werte nun direkt über den Empfehlungen von Wowhead und Archon.
- **Empty States**: Wenn keine Daten geladen sind, zeigt das Addon nun hilfreiche Hinweise statt nur einer leeren Fläche.

### 3. Bossmechanik: Sync & Testmodus
- **Echte Namen im Test**: `/ds testboss` nutzt nun die Namen deiner tatsächlichen Gruppen- oder Raidmitglieder für die Simulation der "Helical Toxins".
- **Zufällige Zuweisung**: Jeder Spieler erhält zufällig 1-3 Stacks, und das Addon berechnet live die Partner-Paare.

## Verifizierung
- [x] `GuideData.lua` ist nun ~135KB groß (vorher ~5KB) und enthält alle Daten.
- [x] Stats-Tab zeigt Echtzeit-Vergleich.
- [x] Talent-Dialog erscheint bei Klick.
- [x] Boss-Simulation nutzt Gruppennamen.

> [!IMPORTANT]
> **WICHTIG**: Bitte lösche den `DragonSkill`-Addon-Ordner erneut und kopiere die neuen Dateien aus `C:\Users\thoma\StudioProjects\Dragonskill\addon`. Besonders die befüllte `GuideData.lua` ist entscheidend für dieses Update!
