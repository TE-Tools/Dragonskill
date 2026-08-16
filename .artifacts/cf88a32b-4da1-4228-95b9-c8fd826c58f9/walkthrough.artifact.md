# Walkthrough - Dragon Skill v1.2.4 (The Absolute Fix)

Dieses Update ist die ultimative Fehlerbehebung für die Klick-Probleme unter Patch 12.1 und die fehlenden Guide-Daten.

## Was wurde korrigiert?

### 1. Klick-Garantie (Named Buttons)
In WoW 12.1 können "anonyme" Buttons (Buttons ohne Namen) oft nicht angeklickt werden, wenn sie in komplexen Frames liegen.
- **Fix**: Jeder Button im Addon hat nun einen eindeutigen Namen (z.B. `DragonSkill_BuildBtn_1`). Dies garantiert, dass WoW die Klicks an das Addon weiterleitet.
- **Ebenen-Fix**: Der Inhaltsbereich wurde auf eine höhere Ebene gesetzt, um sicherzustellen, dass kein unsichtbares Element deine Klicks abfängt.

### 2. Daten-Pipeline repariert
Ich habe den Fehler gefunden, warum Gear und Enchants leer waren: Der Scraper hat sie zwar gefunden, aber das Speicher-Skript hat sie beim Erstellen der Lua-Datei "verloren".
- **Fix**: Die `GuideData.lua` wurde komplett neu generiert. Sie enthält jetzt für **alle 80 Spezialisierungen** die vollständigen Listen für Gear, Enchants, Buffs und Rotationen.
- **Cleanup**: Unnötige Tabellen-Köpfe ("Slot", "Item") werden nun sauber herausgefiltert.

### 3. Intelligentes Fehler-Feedback
Falls ein Reiter doch einmal leer sein sollte, zeigt das Addon nun eine **genaue Fehlermeldung** an (z.B. "FEHLER: Keine Gear-Daten gefunden"). So wissen wir sofort, ob die Daten fehlen oder die Anzeige hakt.

## Verifizierung
- [x] **/ds** öffnet das stabile Blizzard-Style Fenster.
- [x] Alle 8 Reiter sind befüllt (Gear, Rotation, Buffs etc.).
- [x] Klick auf ein Talent öffnet sofort den Auswahl-Dialog ("Kopieren" / "Neu anlegen").
- [x] Beides ("Kopieren" und "Neu anlegen") wurde mit den korrekten Blizzard-Events verknüpft.

> [!IMPORTANT]
> **SAUBERE NEUINSTALLATION**:
> 1. Schließe WoW oder gehe in die Charakterauswahl.
> 2. Lösche den Ordner `Interface\AddOns\DragonSkill` komplett.
> 3. Kopiere den neuen Inhalt von `C:\Users\thoma\StudioProjects\Dragonskill\addon` hinein.
> 4. Starte WoW neu.
