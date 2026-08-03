# Dragon Skill - Projekt-Kontext für Claude Code

Repo-Ziel: https://github.com/TE-Tools/Dragonskill
Entwickler: **wear-alleria** (Gilde: Dragon Lords)

Dieses Dokument fasst zusammen, was das Projekt ist, warum es so aufgebaut ist,
und was als Nächstes ansteht - als Übergabe von einem Claude-Chat (ohne Internet-/
Ausführungszugriff auf echte Wowhead/Archon-Seiten) an Claude Code (mit echtem
Datei- und ggf. Internetzugriff).

## Was ist Dragon Skill

Ein World of Warcraft Addon, das Talent-Builds und Stat-Prioritäten von Wowhead
und Archon.gg anzeigt, mit dem aktuellen Charakter-Build vergleicht und den
Import als Blizzard-Talent-String per Klick bereitstellt. Inspiriert vom
Funktionsumfang des existierenden Addons "Class Codex" (Autor: Sogu), aber als
**eigenständiges Projekt mit eigenem Code, eigener Datenstruktur und eigenem
Namen** entwickelt - keine Kopie fremden Codes.

## Warum diese Architektur

WoW-Addons können im Spiel-Client **keine Netzwerkzugriffe** machen (feste
Sandbox-Beschränkung der Blizzard-API). Deshalb ist das Projekt zweigeteilt:

1. **`scraper/`** - Node.js-Skripte, laufen AUSSERHALB von WoW (lokal oder in
   CI/GitHub Actions). Holen Wowhead/Archon-Guide-Seiten, extrahieren
   Talent-Import-Strings + Stat-Prioritäten, speichern als JSON.
2. **`addon/`** - reines Lua/WoW-Addon. Liest nur bereits vorbereitete, ins
   Addon eingebettete Daten (`addon/Data/GuideData.lua`, generiert aus den
   JSON-Dateien). Kein Live-Netzwerkzugriff im Spiel.

Das ist exakt das Muster, das auch Class Codex nutzt (externer Scraper +
gebündelte Daten im Addon-Release), nur mit eigenem, hier neu geschriebenem Code.

## Wichtige Leitplanken (bitte beibehalten)

- **Kein Auto-Speccen, keine automatische Rotation, keine geschützten
  Funktionen/Secure Frames.** Nur Anzeige + manueller Import über die
  offizielle Blizzard-Talent-UI.
- Ausschließlich offizielle Blizzard-APIs/Templates nutzen
  (`C_ClassTalents`, `C_Traits`, `ButtonFrameTemplate`, `PanelTabButtonTemplate` etc.)
- Modularer Aufbau: jedes Feature ist ein eigenständiges Modul unter
  `addon/Modules/<Name>/`, registriert über `DragonSkill:RegisterModule(...)`.
- Kein Scraping-Code direkt im Addon - Trennung Scraper (Node) / Addon (Lua)
  bleibt bestehen.

## Aktueller Stand (v0.2)

**Fertig:**
- Core: Namespace, EventManager (zentrale Event-Registrierung), Database
  (SavedVariables + Guide-Daten-Zugriff)
- Modul `TalentCompare`: vergleicht Guide-Build mit aktuellem Char-Build,
  liefert Ähnlichkeits-% + Anzahl Abweichungen (Byte-Level-Diff, siehe
  Kommentar in `TalentCompare.lua` - kein vollständiger Bit-Decoder, da
  Blizzards Talent-String-Format inoffiziell und patch-abhängig ist)
- Modul `StatPriority`: zeigt Stat-Prioritäten aus Guide-Daten
- UI (`Modules/TalentCompare/UI.lua`): Fenster mit Tabs "Talente" und "Stats",
  Slash-Command `/ds` bzw. `/dragonskill`
- Scraper: `scrape-wowhead.js`, `scrape-archon.js` (Provider-getaggt, mergen
  ohne sich gegenseitig zu überschreiben), `scrape-all.js` (Batch über
  `spec-list.json`), `build-data.js` (JSON → Lua Konverter)
- Automatisierung: `.github/workflows/scrape.yml` - läuft Mo+Do automatisch,
  scraped alle Specs, baut `GuideData.lua` neu, committed bei Änderungen

**Seit letzter Übergabe erledigt (Claude Code, mit echtem Internetzugriff):**
- [x] **Scraper gegen echte Live-Seiten getestet und komplett neu geschrieben.**
      Beide alten Parser-Strategien gingen von falschen Annahmen aus:
      - Wowhead: Die alten URLs (`.../talent-builds`) existieren nicht mehr -
        Wowhead hat Talente und Stat-Priorität in zwei eigene Guide-Seiten
        aufgeteilt (`.../talent-builds-pve-<rolle>` und
        `.../stat-priority-pve-<rolle>`, Rolle = tank/healer/dps). Außerdem
        rendert Wowhead die Talent-Codes nicht als fertiges HTML, sondern als
        BBCode-Markup, das im rohen HTML JSON-string-escaped vorliegt und erst
        client-seitig per JS in die sichtbare Seite gerendert wird - deshalb
        fanden die alten `cheerio`-DOM-Selektoren (`table`, `input`, `textarea`)
        nie etwas. Der neue Scraper unescaped das Markup und matcht direkt
        gegen die `[copy="Label"]CODE[/copy]` Shortcodes.
      - Archon.gg: Die alten URLs (`.../wow/builds/<class>/<spec>/talents`)
        existieren nicht mehr. Aktuelle URL-Struktur:
        `.../wow/builds/<spec>/<class>/mythic-plus/overview/10/all-dungeons/this-week`
        (Reihenfolge Spec/Class vertauscht ggü. der alten Annahme). Die
        Talent-Codes stecken nicht in `data-*`-Attributen, sondern im
        `__NEXT_DATA__`-JSON-Blob unter
        `page.sections[].props.talentTreeBuildSets[].alternatives[].talentTree.exportCodeParams.exportCode`.
      - Beide Scraper wurden entsprechend neu implementiert (siehe
        `scrape-wowhead.js`, `scrape-archon.js`) und gegen zwei echte Specs
        (Warrior Protection, Paladin Holy - je eine Tank- und eine Healer-Spec)
        end-to-end verifiziert: `scrape-all.js` → `build-data.js` →
        `addon/Data/GuideData.lua` mit echten Import-Codes.
      - `spec-list.json`-Schema geändert: statt einer `wowheadUrl` jetzt
        `wowheadTalentsUrl` + `wowheadStatsUrl` (da beide Infos auf getrennten
        Seiten liegen). `scrape-all.js` entsprechend angepasst.

**`spec-list.json` auf alle 40 Specs erweitert:**
- [x] Alle 13 Klassen / 40 Specs eingetragen (aktueller Spec-Stand direkt von
      Archon.gg's Klassen-Übersicht abgeleitet, nicht aus dem Gedächtnis -
      der Spec-Stand hat sich ggü. älterem Wissen verändert, z.B. hat Demon
      Hunter inzwischen 3 Specs: Havoc, Vengeance, **Devourer** (neu)).
      End-to-end mit `scrape-all.js` gegen alle 40 Specs verifiziert (0
      Warnungen, jede Spec liefert Talent-Builds + Stat-Priorität von beiden
      Quellen) und zu `GuideData.lua` gebaut.
- [ ] **Offene Ausnahme:** Für "Devourer" (Demon Hunter) konnte die echte
      Blizzard-Spec-ID nicht über Wowhead/Archon ermittelt werden (weder in
      HTML noch in den JSON-Datenblobs auffindbar - Archon nutzt dort eigene
      interne IDs, keine Blizzard-Spec-IDs). `spec-list.json` nutzt aktuell
      den Platzhalter `specID: 9999` mit `specIDVerified: false` +
      `specIDNote`. Bitte in-game auf einem Devourer-Demon-Hunter verifizieren
      (z.B. `/run print(select(2, GetSpecializationInfo(GetSpecialization())))`)
      und sowohl den `spec-list.json`-Eintrag als auch die Datei
      `data-raw/DEMONHUNTER_9999.json` auf die echte ID umbenennen/anpassen,
      dann `build-data.js` neu laufen lassen.

**Noch offen / nächste Schritte:**
- [ ] Rotation-Anzeige (bewusst zurückgestellt, siehe Chatverlauf)
- [ ] Weitere Module gemäß ursprünglicher Roadmap: BiS Gear, Enchants, Gems,
      Consumables, Trinkets, Crafting (siehe Class-Codex-Funktionsumfang als
      Referenz für "was fehlt noch", aber eigenständig umsetzen)
- [ ] Node-genauerer Talent-Diff, falls ein zuverlässiger Weg gefunden wird,
      Blizzard-Talent-Strings vollständig zu dekodieren (z.B. über
      `C_Traits.GenerateInspectImportString` Reverse Engineering oder
      Community-Dokumentation des Formats)

## Datei-Übersicht

```
DragonSkill/
├── .github/workflows/scrape.yml   # CI: automatisches Scrapen 2x/Woche
├── README.md                       # Workflow-Anleitung (Scrapen→Konvertieren→Testen)
├── addon/
│   ├── DragonSkill.toc            # Addon-Manifest (Ladereihenfolge!)
│   ├── Core/
│   │   ├── Namespace.lua          # Globaler Einstiegspunkt, Modul-Registry
│   │   ├── EventManager.lua       # Zentrale WoW-Event-Verteilung
│   │   └── Database.lua           # SavedVariables + Guide-Daten-Zugriff
│   ├── Data/GuideData.lua         # AUTO-GENERIERT von scraper/build-data.js
│   └── Modules/
│       ├── TalentCompare/
│       │   ├── TalentCompare.lua  # Vergleichslogik (Diff-Algorithmus)
│       │   └── UI.lua             # Fenster mit Tabs, Slash-Command /ds
│       └── StatPriority/
│           └── StatPriority.lua   # Stat-Daten-Zugriff für aktuelle Spec
└── scraper/
    ├── package.json               # Dependencies: cheerio, node-fetch
    ├── scrape-wowhead.js          # Scraper Quelle 1
    ├── scrape-archon.js           # Scraper Quelle 2
    ├── scrape-all.js              # Orchestriert beide über spec-list.json
    ├── build-data.js              # JSON → addon/Data/GuideData.lua
    └── spec-list.json             # Konfiguration: welche Specs/URLs scrapen
```

## Chatverlauf-Zusammenfassung (Kontext, wie es entstanden ist)

1. Nutzer hatte ursprünglich eine sehr umfangreiche Spezifikation ("Class
   Codex Master Spec") für ein Mega-Addon - wurde als unrealistisch für einen
   Schritt eingeordnet, stattdessen modularer, iterativer Ansatz vorgeschlagen.
2. Nutzer wollte eigentlich Funktionsparität mit dem existierenden Addon
   "Class Codex" (Wago/CurseForge, Autor Sogu, ~950k Downloads) - wurde als
   eigenständiges Projekt umgesetzt statt als Kopie, da 1:1-Nachbau fremder
   Arbeit nicht unterstützt wird.
3. Namensfindung: Nutzer nutzt Ingame-Namen **wear-alleria**, Gilde
   **Dragon Lords** → Projektname **Dragon Skill**.
4. Iterativ gebaut: zuerst Kern-Feature (Talent-Import + Vergleich), dann auf
   Wunsch erweitert um: Archon.gg als zweite Quelle, genauerer Diff (Ähnlichkeits-%
   statt nur ja/nein), Stat-Prioritäten-Tab (explizit OHNE Rotation-Tab fürs
   Erste), Automatisierung via GitHub Actions.
5. Aktuelle Übergabe: Code liegt fertig vor, aber die Scraper-Parser wurden
   nie gegen echte Live-Seiten getestet (keine Internetverbindung in der
   Entwicklungsumgebung) - das ist die wichtigste offene Aufgabe für Claude Code.

## Erste Aufgabe für Claude Code

Bitte als Erstes:
1. `cd scraper && npm install`
2. `node scrape-wowhead.js --url "https://www.wowhead.com/guide/classes/warrior/protection/talent-builds" --out data-raw/WARRIOR_73.json`
3. Prüfen ob `talentBuilds` befüllt wird. Falls leer/falsch: die
   Selektoren in `extractTalentBuilds()` / `extractStatPriority()` in
   `scrape-wowhead.js` gegen die tatsächliche Wowhead-Seitenstruktur anpassen
   (z.B. Browser-DevTools nutzen, um zu sehen wie die Talent-Strings dort
   aktuell im HTML eingebettet sind).
4. Gleiches für `scrape-archon.js` gegen eine echte Archon.gg-Build-Seite.
5. Danach `git remote add origin https://github.com/TE-Tools/Dragonskill.git`
   und `git push -u origin main` (Repo ist bereits lokal initialisiert und
   committed).
