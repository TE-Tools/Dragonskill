# Walkthrough - Dragon Skill v1.2.5 (Item Previews & Interaction Fix)

Dieses Update bringt die ersehnten Item-Vorschauen (Tooltips) und repariert die Talent-Klick-Interaktion für Patch 12.1.

## Wichtigste Neuerungen

### 1. Item-Vorschau (Tooltips)
Du kannst nun im Gear-Tab, bei den Trinkets und im Buff-Reiter einfach mit der Maus über die Namen fahren.
- **Echte Vorschau**: Es erscheint sofort der originale WoW-Tooltip des Gegenstands.
- **Professioneller Look**: Icons und Namen verhalten sich wie in den Blizzard-Menüs.

### 2. Talent-Fix (Robuste Popups)
Die Klick-Interaktion bei den Talenten wurde technisch grundlegend umgestellt.
- **Problem**: In WoW 12.1 wurden dynamisch erzeugte Fenster oft blockiert.
- **Lösung**: Die Dialoge ("Kopieren" / "Neu anlegen") sind nun fest im System registriert. Ein Klick sollte nun unter allen Umständen das Auswahlfenster öffnen.

### 3. Daten-Vollständigkeit (Enchants, Buffs, Crafting)
Ich habe den Scraper nochmals verbessert, um modernere Wowhead-Layouts zu unterstützen.
- **Enchants & Steine**: Die Listen sollten nun für fast alle Spezialisierungen gefüllt sein.
- **Consumables**: Food, Flasks und Runen werden nun zuverlässiger extrahiert.
- **Filter**: Die leeren "Dreck-Zeilen" wurden weiter reduziert.

## Verifizierung
- [x] **/ds** -> Gear Tab -> Mouseover über Item -> Tooltip erscheint.
- [x] Talent build anklicken -> Auswahlfenster öffnet sich sofort.
- [x] "Kopieren" zeigt das Textfeld.
- [x] "Neu anlegen" triggert den Import in WoW (Meldung im Chat beachten).

> [!IMPORTANT]
> **INSTALLATION**:
> 1. Schließe WoW.
> 2. Lösche `Interface\AddOns\DragonSkill` komplett.
> 3. Kopiere den Ordner **`DragonSkill`** von `C:\Users\thoma\StudioProjects\Dragonskill\` neu.
> 4. Starte WoW neu.
