# Dragon Skill – Projekt-Kontext (Stand v1.5.5)

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

## Aktueller Stand (v1.5.5)

**Fertig:**
- Core, EventManager, Database (Favorites/Skillungen CRUD)
- TalentCompare: Match-%, Node-Diff mit robusten Namen (Definition/Spell/SubTree), Import 12.1
- UI: Spec-Refresh (`PLAYER_SPECIALIZATION_CHANGED`, `TRAIT_CONFIG_UPDATED`, …)
- Scraper BiS/Enchants/Gems/Consumables/Rotation + Archon
- CI: `permissions: contents: write` für Push von GuideData
- PR #2 (post-merge/improvements) **geschlossen** (obsolet vs. main)

**Offen / Hinweis:**
- [ ] Erster erfolgreicher CI-Push von `GuideData.lua` nach Permission-Fix (Workflow erneut laufen lassen)
- [ ] Consumables-URLs oft 404 auf Wowhead – Daten kommen aus Gear-/Guide-Seiten mit Keywords
- [ ] Manche Node-Namen bleiben Fallback `Node <id>`, wenn Trait-API keine Definition liefert

## Test im Spiel

1. `/reload` nach Update
2. `/wear` – Spec wechseln → Inhalt aktualisiert sich
3. Talent-Build Rechtsklick → Diff mit lesbaren Talentnamen wo möglich
