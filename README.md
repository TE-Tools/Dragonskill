# Dragon Skill

Talent-Guides, Vergleich und Import direkt im Spiel.
Entwickler: **wear-alleria** (Gilde: Dragon Lords)

**Version:** 1.5.4 · **Interface:** 120100 (Patch 12.1)

## Im Spiel

| Befehl | Aktion |
|--------|--------|
| `/wear` | Fenster öffnen/schließen |
| `/ds` | gleich |
| `/dragonskill` | gleich |

### Tabs
Talente · Stats · Trinkets · Crafting · Rotation · Gear · Enchants · Buffs

### Talente
- **Linksklick** → Kopieren / Anlegen + Import
- **Rechtsklick** → Node-Diff
- Match-% farbig auf dem Button
- **Meine Skillungen** = Favoriten in `DragonSkillDB`

Kein Auto-Speccen, keine automatische Rotation.

## Daten aktualisieren (Paket B)

Der Wowhead-Scraper holt jetzt:
- Talent-Import-Strings
- Stat-Priorität
- **BiS-Gear** (Tabellen `[tr][td]Slot[/td][td][item=…]`)
- **Enchants / Gems / Consumables** (Listen nach Keywords)
- **Rotation-Priorität** (Spell-Listen)
- Embellishments (Crafting)

Archon liefert weiterhin Talent-Builds, Stats und Trinkets.

### Einzelne Spec
```bash
cd scraper
npm install
node scrape-wowhead.js \
  --talentsUrl "https://www.wowhead.com/guide/classes/warrior/protection/talent-builds-pve-tank" \
  --statsUrl "https://www.wowhead.com/guide/classes/warrior/protection/stat-priority-pve-tank" \
  --gearUrl "https://www.wowhead.com/guide/classes/warrior/protection/bis-gear" \
  --rotationUrl "https://www.wowhead.com/guide/classes/warrior/protection/rotation-cooldowns-pve-tank" \
  --consumablesUrl "https://www.wowhead.com/guide/classes/warrior/protection/consumables-pve-tank" \
  --out data-raw/WARRIOR_73.json

node scrape-archon.js \
  --url "https://www.archon.gg/wow/builds/protection/warrior/mythic-plus/overview/10/all-dungeons/this-week" \
  --out data-raw/WARRIOR_73.json

node build-data.js --dataDir data-raw --out ../DragonSkill/Data/GuideData.lua
```

### Alle Specs
```bash
node scrape-all.js --list spec-list.json --outDir data-raw
node build-data.js --dataDir data-raw --out ../DragonSkill/Data/GuideData.lua
```
`scrape-all` leitet fehlende Gear-/Rotation-/Consumables-URLs automatisch aus der Talents-URL ab und wartet kurz zwischen Requests (Rate-Limits).

### CI
`.github/workflows/scrape.yml` – Mo + Do + **manuell** (Actions → Run workflow).  
Output-Pfad: `DragonSkill/Data/GuideData.lua` (nicht mehr `addon/…`).

## Status

- [x] Core, Favoriten, Talent-Diff/Import, UI 1.5.3+
- [x] Scraper Wowhead: Talente + Stats + **BiS + Enchants + Gems + Consumables + Rotation**
- [x] Scraper Archon: Talente + Stats + Trinkets
- [x] `build-data.js` schreibt alle Provider-Felder korrekt nach Lua
- [x] CI-Pfad auf `DragonSkill/Data/GuideData.lua` korrigiert
- [ ] Vollständiger Daten-Refresh aller 40 Specs (lokal oder via **Run workflow**) – `GuideData.lua` wird erst nach dem Lauf voll
- [ ] Node-Diff-Namen hängen von `C_Traits` ab

## Leitplanken

- Kein Auto-Speccen / keine Secure Actions / keine Auto-Rotation
- Nur offizielle Blizzard-APIs
- Scraper außerhalb von WoW; Addon nur lokale Daten
