# Dragon Skill – Projekt-Kontext (Stand v1.5.6)

Repo: https://github.com/TE-Tools/Dragonskill  
Entwickler: **wear-alleria**

## Stand v1.5.6

**Fertig:**
- Talent-UI: Gems-Tab, Fenster 680px, Spec-Name im Titel
- Match-% primär **node-basiert** (`CompareBuild`), Fallback Byte-String
- Node-Diff mit Namen (Definition / Spell / SubTree)
- Spec-Refresh Events
- Scraper: keine auto-`consumables-*-` URLs mehr (oft 404)
- CI: `contents: write` für GuideData-Push

**Hinweis:**
- Nach erfolgreichem Scrape-Workflow sollte `GuideData.lua` auf main aktualisiert sein
- Manche Node-Namen bleiben `Node <id>`, wenn die Trait-API nichts liefert

## Befehle
`/wear` · `/ds` · `/dragonskill`
