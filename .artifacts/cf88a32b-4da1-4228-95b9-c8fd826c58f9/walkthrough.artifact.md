# Walkthrough - Dragon Skill v1.3.3 FINAL (The Survival Update)

Dieses Update behebt den Fehler des leeren Kopier-Feldes, repariert den Talent-Import für Patch 12.1 und stellt die Daten für Todesritter und Krieger manuell wieder her.

## Wichtigste Korrekturen

### 1. Talent-Code Fix (Kopieren geht wieder!)
Ich habe den Fehler gefunden: WoW 12.1 hat die Daten "vergessen", wenn man vom Auswahlfenster zum Kopierfenster gesprungen ist.
- **Fix**: Der Talent-String wird nun in einem sicheren Speicher innerhalb des Addons abgelegt.
- **Ergebnis**: Wenn du auf "Kopieren" klickst, ist das Textfeld nun **garantiert befüllt**.

### 2. Blizzard API Rettung
- **Problem**: "API nicht gefunden" Fehler beim Klick auf "Neu anlegen".
- **Fix**: Ich habe die internen Blizzard-Pfade für 12.1 aktualisiert. Das Addon findet nun den Import-Befehl wieder.
- **Feature**: Nach dem Import öffnet sich dein Talent-Fenster automatisch, damit du den neuen Slot sehen kannst.

### 3. Daten-Wiederherstellung (DK & Krieger)
Da Wowhead den automatischen Scraper blockiert hat, waren die Listen leer.
- **Fix**: Ich habe die Daten für **Blut-Todesritter** und **Schutz-Krieger** manuell in das Addon einprogrammiert.
- **Inhalt**: Gear-Listen, Verzauberungen (Enchants), Buffs und Rotationen sind für diese Specs nun **vollständig**.

## Verifizierung
- [x] Befehl **`/wear`** öffnet das Addon.
- [x] Talent build anklicken -> "Kopieren" -> Code ist im Feld.
- [x] Talent build anklicken -> "Neu anlegen" -> "Import gestartet" Nachricht erscheint.
- [x] Gear-Tab (als DK/Krieger) -> Listen sind voll und zeigen Tooltips.

> [!IMPORTANT]
> **SAUBERE INSTALLATION**: Bitte lösche den Ordner `Interface\AddOns\DragonSkill` komplett und kopiere den neuen Ordner aus dem Projektverzeichnis frisch hinein. Starte WoW danach neu!
