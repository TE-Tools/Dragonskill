# Dragon Skill

Talent-Guides, Vergleich und Import direkt im Charakterfenster.
Entwickler: **wear-alleria** (Gilde: Dragon Lords)

## Workflow (Daten aktualisieren)

### Manuell, einzelne Spec
```
cd scraper
npm install
node scrape-wowhead.js --url "<wowhead-guide-url>" --out data-raw/WARRIOR_73.json
node scrape-archon.js  --url "<archon-guide-url>"  --out data-raw/WARRIOR_73.json
node build-data.js --dataDir data-raw --out ../addon/Data/GuideData.lua
```
Dateiname MUSS dem Format `<CLASSTOKEN>_<SPECID>.json` folgen (beide Scraper schreiben
in dieselbe Datei, mergen aber nur ihre eigene Provider-Sektion - kein Datenverlust).
Class-Tokens: WARRIOR, PALADIN, HUNTER, ROGUE, PRIEST, DEATHKNIGHT, SHAMAN,
MAGE, WARLOCK, MONK, DEMONHUNTER, DRUID, EVOKER.

### Alle konfigurierten Specs auf einmal
Trage neue Specs in `scraper/spec-list.json` ein, dann:
```
node scrape-all.js --list spec-list.json --outDir data-raw
node build-data.js --dataDir data-raw --out ../addon/Data/GuideData.lua
```

### Automatisch (GitHub Actions)
`.github/workflows/scrape.yml` läuft Montag + Donnerstag automatisch, scraped alle
Specs aus `spec-list.json`, baut `GuideData.lua` neu und committed die Änderung.
Voraussetzung: Repo auf GitHub, Actions aktiviert. Manuell auslösbar über
"Run workflow" im Actions-Tab.

**Im Spiel testen**: `/reload`, dann `/ds` öffnet das Fenster (Tabs: Talente, Stats).

## Status (v0.2)

- [x] Core: EventManager, Database, SavedVariables
- [x] TalentCompare Modul: Guide-Build vs. aktueller Char-Build
- [x] Talent-Diff: Ähnlichkeits-% + Anzahl Abweichungen (Byte-Level, siehe Kommentar
      in TalentCompare.lua - kein vollständiger Bit-Decoder, da Blizzard-Format
      inoffiziell/patch-abhängig ist)
- [x] Scraper: Wowhead (Talent-Strings + Stat-Priorität)
- [x] Scraper: Archon.gg als zweite Quelle (Provider-getaggt, beide sichtbar)
- [x] Stat-Prioritäten UI-Tab (Wowhead + Archon nebeneinander)
- [x] Automatisierung: `scrape-all.js` + GitHub Actions (2x/Woche + manuell)
- [ ] Rotation-Anzeige (bewusst zurückgestellt)
- [ ] Weitere Module lt. Roadmap (BiS Gear, Enchants, Consumables, etc.)

## Wichtig

Kein Auto-Speccen, keine automatische Rotation, keine geschützten Funktionen.
Nur Anzeige + manueller Import über die offizielle Blizzard Talent-UI.
