# Walkthrough - Dragon Skill v0.7 (Icons, Sounds & Nek'zali)

Dieses Update implementiert die nächsten drei Meilensteine und verbessert die visuelle sowie akustische Qualität des Addons.

## Wichtigste Änderungen

### 1. Verbesserte Item-Icons & Farben
Die Listen im Gear-Tab und in den Bossmechaniken sind nun deutlich professioneller gestaltet.
- **Echte Icons**: Das Addon nutzt nun `itemId`, um die korrekten WoW-Icons für Gegenstände anzuzeigen.
- **Qualitätsfarben**: Item-Namen werden automatisch in ihrer Seltenheitsfarbe (Lila für Episch, Blau für Selten etc.) dargestellt.
- **Shift-Klick Support**: Gegenstände in den Listen können nun mit Shift-Klick direkt in den Chat gepostet werden.

### 2. Boss-Sounds (Audio-Warnungen)
Wichtige Kampfphasen werden nun akustisch untermalt, um die Aufmerksamkeit des Raidleads zu steigern.
- **Raid-Warnung Ping**: Ertönt beim Start einer Intermission (z.B. Helical Toxins).
- **Bereitschaftscheck-Sound**: Spielt beim Start eines Bosskampfes.
- **Boss-Flüstern**: Ein spezieller Warnsound ertönt, wenn eine Mechanik kritisch wird (z.B. Energie zu hoch).

### 3. Neuer Boss: Nek’zali the Soulcoiler
Das zweite Bossmodul für den "Venomous Abyss" Raid wurde hinzugefügt.
- **Soulcoil Well Tracking**: Überwacht die Energie des zentralen Brunnens und warnt lautstark bei 90%.
- **Add-Tracking**: Behält den Überblick über die "Raised Amani" Adds und zeigt sie in der Raidlead-Liste an.
- **Testmodus**: Mit **`/ds testnekzali`** kannst du diesen Bosskampf trocken simulieren.

## Verifizierung
- [x] Icons im Gear-Tab werden geladen (Cache-abhängig, evtl. zweimal öffnen).
- [x] Sounds spielen bei `/ds testboss` und `/ds testnekzali`.
- [x] Alle neuen Dateien sind in der `.toc` registriert.

> [!IMPORTANT]
> **WICHTIG**: Bitte kopiere den `addon`-Ordner erneut in dein WoW-Verzeichnis, um das neue Modul `Nekzali.lua` und die verbesserten UI-Skripte zu erhalten.
