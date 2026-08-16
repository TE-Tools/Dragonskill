# Dragon Skill – Projekt-Kontext (Stand v1.5.3)

Repo: https://github.com/TE-Tools/Dragonskill  
Entwickler: **wear-alleria** (Gilde: Dragon Lords)

## Was ist Dragon Skill

WoW-Addon für Talent-Guides (Wowhead/Archon), Stat-Prioritäten, Trinkets/BiS-Anzeige,
Vergleich mit dem aktuellen Build und manuellem Import in die Blizzard-Talent-UI.

## Architektur

1. **`scraper/`** – Node.js außerhalb von WoW → JSON
2. **`DragonSkill/`** – Lua-Addon, liest nur `Data/GuideData.lua`

## Leitplanken

- Kein Auto-Speccen, keine Auto-Rotation, keine Secure Frames
- Nur offizielle Blizzard-APIs
- Module unter `DragonSkill/Modules/<Name>/` via `DragonSkill:RegisterModule`

## Aktueller Stand (v1.5.3)

**Fertig:**
- Core, EventManager, Database (Favorites/Skillungen CRUD)
- TalentCompare: Byte-Match-%, Node-Diff (`GetDetailedDiff` / `FormatDiffSummary`), Import-Fallbacks 12.1
- UI: 640px Breite, 8 Tabs, Favoritenliste, Rechtsklick-Diff, `/wear` `/ds` `/dragonskill`
- Module mit Gettern: StatPriority, Trinkets, Rotation, Crafting
- Tooltips BiS-Marker
- Scraper + `spec-list.json` alle 40 Specs; **Devourer = specID 1480** (kein 9999 mehr)

**Offen:**
- [ ] Scraper erweitern: BiS, Enchants, Consumables, Rotation vollständig befüllen
- [ ] Node-Diff-Namen verbessern, falls API-Felder je nach Patch fehlen
- [ ] PR #2 "Post merge/improvements" reviewen/mergen falls relevant

## Wichtige Pfade

```
DragonSkill/
  DragonSkill.toc
  Core/{Namespace,EventManager,Database}.lua
  Data/GuideData.lua          # generiert
  Modules/TalentCompare/{TalentCompare,UI}.lua
  Modules/{StatPriority,Trinkets,Rotation,Crafting,Tooltips}/
  Modules/BossMechanics/
scraper/
  scrape-*.js, build-data.js, spec-list.json
```

## Test im Spiel

1. Addon aktualisieren, `/reload`
2. `/wear` → Fenster, Tabs prüfen
3. Talent-Build: Linksklick Aktion, Rechtsklick Diff + Chat-Ausgabe
4. Anlegen + Import → Favoriten unter "Meine Skillungen"
