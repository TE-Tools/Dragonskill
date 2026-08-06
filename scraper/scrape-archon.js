/**
 * Dragon Skill - Archon.gg Scraper
 * --------------------------------
 * Zweite Datenquelle neben Wowhead. Läuft lokal, holt eine Archon.gg-Guide-Seite,
 * merged Talent-Builds + Stat-Priorität mit einer bestehenden JSON-Datei (Provider-Tag).
 *
 * Benutzung:
 *   node scrape-archon.js --url "https://www.archon.gg/wow/builds/protection/warrior/mythic-plus/overview/10/all-dungeons/this-week" --out data-raw/WARRIOR_73.json
 *
 * Voraussetzung: npm install node-fetch cheerio
 */

const fs = require("fs");
const path = require("path");
const fetch = require("node-fetch");

function parseArgs() {
  const args = process.argv.slice(2);
  const out = {};
  for (let i = 0; i < args.length; i += 2) {
    out[args[i].replace(/^--/, "")] = args[i + 1];
  }
  return out;
}

async function fetchPage(url) {
  const res = await fetch(url, {
    headers: {
      "User-Agent": "Mozilla/5.0 (DragonSkillAddon-Scraper; contact: wear-alleria)"
    }
  });
  if (!res.ok) throw new Error(`Fetch failed: ${res.status} ${res.statusText} (${url})`);
  return res.text();
}

/**
 * Archon (Next.js) liefert die komplette Seiten-Payload als JSON im
 * <script id="__NEXT_DATA__"> Tag. Talent-Builds und Stat-Priorität stecken
 * in page.sections, identifiziert über den jeweiligen "component"-Namen -
 * kein DOM-Parsing der (client-seitig gerenderten) sichtbaren HTML nötig.
 */
function extractNextData(html) {
  const m = html.match(
    /<script id="__NEXT_DATA__" type="application\/json">([\s\S]*?)<\/script>/
  );
  if (!m) return null;
  try {
    return JSON.parse(m[1]);
  } catch {
    return null;
  }
}

function getPage(nextData) {
  return nextData &&
    nextData.props &&
    nextData.props.pageProps &&
    nextData.props.pageProps.page;
}

/**
 * Jede Sektion vom Typ "BuildsTalentTreeBuildSection" enthält talentTreeBuildSets,
 * deren "alternatives" jeweils einen konkreten Build mit Blizzard-Export-Code
 * (talentTree.exportCodeParams.exportCode) und Popularität liefern.
 */
function extractTalentBuilds(page) {
  const builds = [];
  const sections = (page && page.sections) || [];
  for (const section of sections) {
    if (section.component !== "BuildsTalentTreeBuildSection") continue;
    const sets = (section.props && section.props.talentTreeBuildSets) || [];
    for (const set of sets) {
      for (const alt of set.alternatives || []) {
        const exportCodeParams = alt.talentTree && alt.talentTree.exportCodeParams;
        const code = exportCodeParams && exportCodeParams.exportCode;
        if (code && code.trim().length > 20) {
          builds.push({
            context: alt.popularity || null,
            label: alt.title || null,
            importString: code.trim()
          });
        }
      }
    }
  }
  return builds;
}

/**
 * Die Sektion "BuildsStatPrioritySection" liefert stats[] mit einem "order"
 * Feld (Rang) - daraus bauen wir eine einfache priorisierte Liste.
 */
function extractStatPriority(page) {
  const sections = (page && page.sections) || [];
  for (const section of sections) {
    if (section.component !== "BuildsStatPrioritySection") continue;
    const stats = (section.props && section.props.stats) || [];
    const names = [...stats]
      .sort((a, b) => (a.order || 0) - (b.order || 0))
      .map((s) => s.name)
      .filter(Boolean);
    if (names.length > 0) return names.join(" > ");
  }
  return null;
}

/**
 * Extrahiert durchschnittliche Stat-Prozentwerte aus Archon.
 * Archon zeigt oft "Haste 32%", "Crit 18%" etc.
 */
function extractStatAverages(page) {
  const averages = {};
  const sections = (page && page.sections) || [];
  for (const section of sections) {
    if (section.component !== "BuildsStatPrioritySection") continue;
    const stats = (section.props && section.props.stats) || [];
    for (const stat of stats) {
      if (stat.name && stat.averageValue) {
        // averageValue ist oft ein Dezimalwert oder String
        averages[stat.name] = stat.averageValue;
      }
    }
  }
  return Object.keys(averages).length > 0 ? averages : null;
}

async function main() {
  const { url, out } = parseArgs();
  if (!url || !out) {
    console.error('Benutzung: node scrape-archon.js --url "<archon-url>" --out "<output.json>"');
    process.exit(1);
  }

  console.log(`Lade ${url} ...`);
  const html = await fetchPage(url);
  const nextData = extractNextData(html);
  if (!nextData) {
    throw new Error(
      "Konnte __NEXT_DATA__ nicht finden/parsen - Archon-Seitenstruktur hat sich evtl. geändert."
    );
  }
  const page = getPage(nextData);

  let builds = extractTalentBuilds(page);
  const seen = new Set();
  builds = builds
    .filter((b) => {
      if (seen.has(b.importString)) return false;
      seen.add(b.importString);
      return true;
    })
    .map((b) => ({ ...b, provider: "archon" }));

  const statPrio = extractStatPriority(page);
  const statAverages = extractStatAverages(page);

  if (builds.length === 0) {
    console.warn(
      "⚠️  Keine Talent-Strings gefunden. Archon-Seitenstruktur hat sich evtl. geändert - Parser prüfen (__NEXT_DATA__ / BuildsTalentTreeBuildSection)."
    );
  } else {
    console.log(`✅ ${builds.length} Talent-Build(s) von Archon gefunden.`);
  }
  if (!statPrio) {
    console.warn(
      "⚠️  Keine Stat-Priorität gefunden. Archon-Seitenstruktur hat sich evtl. geändert - Parser prüfen (BuildsStatPrioritySection)."
    );
  }

  const outPath = path.resolve(out);
  const existing = fs.existsSync(outPath)
    ? JSON.parse(fs.readFileSync(outPath, "utf-8"))
    : { talentBuilds: [], statPriority: null };

  const keptBuilds = (existing.talentBuilds || []).filter((b) => b.provider !== "archon");

  const data = {
    scrapedAt: new Date().toISOString(),
    statPriority: {
      ...(existing.statPriority || {}),
      archon: statPrio || (existing.statPriority && existing.statPriority.archon) || null
    },
    statAverages: {
      ...(existing.statAverages || {}),
      archon: statAverages || (existing.statAverages && existing.statAverages.archon) || null
    },
    talentBuilds: [...keptBuilds, ...builds]
  };

  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, JSON.stringify(data, null, 2), "utf-8");
  console.log(`Gespeichert: ${outPath}`);
}

main().catch((err) => {
  console.error("Fehler:", err.message);
  process.exit(1);
});
