# Dragon Skill

Talent-Guides, Vergleich und Import direkt im Spiel.  
Entwickler: **wear-alleria** (Gilde: Dragon Lords)

**Version:** 1.6.3 · **Interface:** 120100 (Patch 12.1 / Midnight)

## Im Spiel

| Befehl | Aktion |
|--------|--------|
| `/wear` / `/ds` | Fenster öffnen/schließen |
| `/ds help` | Hilfe |
| `/ds bis` | BiS-Tab öffnen |
| `/ds minimap` | Minimap-Button an/aus |
| `/ds boss list` | BossMechanics – Boss-Liste |
| `/ds boss <name\|id>` | Boss-Mechanik simulieren |

### Tabs
Talente · Stats · Trinkets · Crafting · Rotation · Gear · Enchants · Gems · **Buffs (Consumables)**

### Talente
- **Linksklick** → Kopieren / Anlegen + Import
- **Rechtsklick** → Node-Diff (Match + Abweichungen)
- Match-% **node-basiert**, sortiert, dedupliziert
- **Meine Skillungen** = Favoriten (gefiltert auf aktuelle Spec)
- ESC schließt das Fenster · Minimap-Button (Links = BiS, Rechts = Menü)

### Gear / Enchants / Gems / Buffs
- **Archon first**, danach Wowhead (MergeProviderLists)
- Sortierung: Slot-Gruppe → Popularität absteigend
- Leere Tabs zeigen klaren Empty-State
- Buffs-Tab = Archon Consumables (Flask, Food, Potion, Weapon Oil, …)

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

Der Archon-Scraper holt automatisch die **Consumables-Seite** (URL: `…/overview/…` → `…/consumables/…`).

CI: `.github/workflows/scrape.yml` – Mo + Do + manuell.  
Output: `DragonSkill/Data/GuideData.lua`

## Status

- [x] Core, Favoriten, Talent-Diff/Import, UI
- [x] Node-Match-%, Spec-Refresh, Gems-Tab, Junk-Filter
- [x] Scraper Wowhead + Archon (Gear/Enchants/Gems/**Consumables**) + CI
- [x] Tooltips BiS/Trinket/Enchant/Gem/Consumable
- [x] Minimap + Slash-Hilfe + BossMechanics (Venomous Abyss + Lair)
- [x] UI: Sort nach Slot/Popularität, Empty-States, Archon-first Merge

## Leitplanken

- Kein Auto-Speccen / keine Secure Actions / keine Auto-Rotation
- Nur offizielle Blizzard-APIs
- Scraper außerhalb von WoW; Addon nur lokale Daten
