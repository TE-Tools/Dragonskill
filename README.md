# Dragon Skill

Talent-Guides, Vergleich und Import direkt im Spiel.  
Entwickler: **wear-alleria** (Gilde: Dragon Lords)

**Version:** 1.5.8 · **Interface:** 120100 (Patch 12.1)

## Im Spiel

| Befehl | Aktion |
|--------|--------|
| `/wear` | Fenster öffnen/schließen |
| `/ds` | gleich |
| `/dragonskill` | gleich |
| `/ds help` | Hilfe |
| `/ds minimap` | Minimap-Button an/aus |

### Tabs
Talente · Stats · Trinkets · Crafting · Rotation · Gear · Enchants · Gems · Buffs

### Talente
- **Linksklick** → Kopieren / Anlegen + Import
- **Rechtsklick** → Node-Diff (Match + Abweichungen)
- Match-% **node-basiert**, sortiert, Dedupliziert
- **Meine Skillungen** = Favoriten (gefiltert auf aktuelle Spec)
- ESC schließt das Fenster · Minimap-Button

### Tooltips
Items aus Guide-Daten: BiS, Trinket, Enchant, Gem, Consumable

Kein Auto-Speccen, keine automatische Rotation.

## Daten aktualisieren

```bash
cd scraper
npm install
node scrape-all.js --list spec-list.json --outDir data-raw
node build-data.js --dataDir data-raw --out ../DragonSkill/Data/GuideData.lua
```

CI: `.github/workflows/scrape.yml` – Mo + Do + manuell.  
Output: `DragonSkill/Data/GuideData.lua`

## Status

- [x] Core, Favoriten, Talent-Diff/Import, UI
- [x] Node-Match-%, Spec-Refresh, Gems-Tab, Junk-Filter
- [x] Scraper Wowhead + Archon + CI Push
- [x] Tooltips BiS/Trinket/Enchant/Gem/Consumable
- [x] Minimap + Slash-Hilfe

## Leitplanken

- Kein Auto-Speccen / keine Secure Actions / keine Auto-Rotation
- Nur offizielle Blizzard-APIs
- Scraper außerhalb von WoW; Addon nur lokale Daten
