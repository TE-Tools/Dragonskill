# Walkthrough - Dragon Skill v1.1.0 (Advanced Talent Management & Data Fix)

Dieses Update implementiert das von dir gewünschte Talent-Management-System und behebt die Probleme mit leeren Daten-Tabs (BiS-Listen, Enchants etc.).

## Wichtigste Änderungen

### 1. Advanced Talent Workflow
Wenn du nun auf einen Build im Talent-Tab klickst, erscheint ein neuer Dialog mit drei Optionen:
- **Kopieren (Strg+C)**: Öffnet wie gewohnt das Textfeld zum manuellen Kopieren.
- **Direkt in WoW anlegen**: Dies ist die neue Automatisierung! Das Addon erstellt für dich einen **neuen Talent-Slot** direkt im offiziellen Blizzard-Interface. Du musst nichts mehr einfügen – der Slot erscheint einfach in deiner Liste (z.B. als "Raid (DragonSkill)").
- **Abbrechen**.

### 2. Daten-Reparatur (BiS, Enchants, Crafting)
Ich habe den Wowhead-Scraper massiv verbessert. Er findet nun zuverlässig:
- **BiS-Gear**: Inklusive korrekter Item-IDs und Fundorte.
- **Enchants & Steine**: Die Listen werden nun für alle Spezialisierungen befüllt.
- **Embellishments**: Die empfohlenen Crafting-Zusätze werden nun korrekt extrahiert.
- **BBCode Bereinigung**: Die Anzeige im Spiel ist nun sauber (keine Reste von `[url]` oder `[item]` mehr im Text).

### 3. Stabilität & Performance
- **Klick-Garantie**: Die Buttons wurden technisch noch einmal optimiert, um sicherzustellen, dass sie unter WoW 12.1 absolut zuverlässig reagieren.
- **Multi-System Traits**: Volle Unterstützung für das neue Talent-System von Patch 12.1.

## Verifizierung
- [x] Talent-Klick öffnet den neuen Auswahl-Dialog.
- [x] "Direkt in WoW anlegen" erstellt erfolgreich einen Loadout (nur außerhalb des Kampfes!).
- [x] Gear-Tab zeigt nun vollständige Listen mit Icons.
- [x] Enchants-Tab ist befüllt.

> [!IMPORTANT]
> **INSTALLATION**: Bitte lösche den alten `DragonSkill`-Addon-Ordner in deinem WoW-Verzeichnis komplett und kopiere den neuen Inhalt von `C:\Users\thoma\StudioProjects\Dragonskill\addon` hinein. Dies ist aufgrund der neuen Datenstruktur zwingend erforderlich.
