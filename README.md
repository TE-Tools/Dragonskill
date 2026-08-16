# Dragon Skill

Talent-Guides, Vergleich und Import direkt im Spiel.
Entwickler: **wear-alleria** (Gilde: Dragon Lords)

**Version:** 1.5.3 · **Interface:** 120100 (Patch 12.1)

## Im Spiel

| Befehl | Aktion |
|--------|--------|
| `/wear` | Fenster öffnen/schließen |
| `/ds` | gleich |
| `/dragonskill` | gleich |

### Tabs
Talente · Stats · Trinkets · Crafting · Rotation · Gear · Enchants · Buffs

### Talente
- **Linksklick** auf einen Guide-Build → Kopieren / Anlegen + Import
- **Rechtsklick** → Node-Diff (welche Talente weichen ab)
- Match-% farbig auf dem Button (grün ≥90 %, gelb ≥70 %, rot darunter)
- **Meine Skillungen** = gespeicherte Favoriten (`DragonSkillDB.favorites`)

Kein Auto-Speccen, keine automatische Rotation – nur Anzeige + manueller Import über die Blizzard-Talent-UI.

## Workflow (Daten aktualisieren)

### Manuell, einzelne Spec
```
cd scraper
npm install
node scrape-wowhead.js --talentsUrl "<wowhead-talent-builds-url>" --statsUrl "<wowhead-stat-priority-url>" --out data-raw/WARRIOR_73.json
node scrape-archon.js  --url "<archon-build-url>" --out data-raw/WARRIOR_73.json
node build-data.js --dataDir data-raw --out ../DragonSkill/Data/GuideData.lua
```
Dateiname: `<CLASSTOKEN>_<SPECID>.json`

### Alle Specs
```
node scrape-all.js --list spec-list.json --outDir data-raw
node build-data.js --dataDir data-raw --out ../DragonSkill/Data/GuideData.lua
```

### CI
`.github/workflows/scrape.yml` – Mo + Do + manuell.

## Status

- [x] Core, Database, SavedVariables, Favoriten/Skillungen
- [x] TalentCompare: Match-%, Node-Diff, Import (12.1 Fallbacks)
- [x] UI v1.5.3: Fensterbreite, Tabs, Favoriten, Diff-Rechtsklick
- [x] Scraper Wowhead + Archon (Talent + Stats)
- [x] Alle 40 Specs in `spec-list.json` (Devourer = **1480**)
- [x] Module: StatPriority, Trinkets, Rotation, Crafting (Getter)
- [x] Tooltips: BiS-Hinweis
- [ ] Vollständige BiS/Enchants/Consumables/Rotation-Daten über Scraper (viele Specs noch dünn)
- [ ] Node-Diff-Namen hängen von `C_Traits`-API ab (Fallback: Node-ID)

## Leitplanken

- Kein Auto-Speccen / keine Secure Actions / keine Auto-Rotation
- Nur offizielle Blizzard-APIs/Templates
- Scraper außerhalb von WoW; Addon nur lokale Daten
