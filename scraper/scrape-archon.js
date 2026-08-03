/**
 * Dragon Skill - Archon.gg Scraper
 * --------------------------------
 * Zweite Datenquelle neben Wowhead. Läuft lokal, holt eine Archon.gg-Guide-Seite,
 * merged Talent-Builds + Stat-Priorität mit einer bestehenden JSON-Datei (Provider-Tag).
 *
 * Benutzung:
 *   node scrape-archon.js --url "https://www.archon.gg/wow/builds/warrior/protection/talents" --out data-raw/WARRIOR_73.json
 *
 * Voraussetzung: npm install node-fetch cheerio
 */

const fs = require("fs");
const path = require("path");
const fetch = require("node-fetch");
const cheerio = require("cheerio");

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
 * Archon rendert Builds oft über eingebettete JSON-Blobs (Next.js __NEXT_DATA__)
 * statt reinem HTML - deshalb zwei Strategien: erst JSON-Blob versuchen, dann HTML-Fallback.
 */
function extractFromNextData($) {
  const script = $("#__NEXT_DATA__").html();
  if (!script) return [];
  let json;
  try {
    json = JSON.parse(script);
  } catch {
    return [];
  }

  const builds = [];
  const raw = JSON.stringify(json);
  // Blizzard Talent-Strings suchen (lange Base64-ähnliche Sequenzen) irgendwo im Blob
  const matches = raw.match(/"[A-Za-z0-9+/=_-]{40,}"/g) || [];
  for (const m of matches) {
    const code = m.replace(/"/g, "");
    // Grobfilter: enthält typische Zeichenmischung, keine reine URL
    if (!code.includes("http") && /[A-Za-z]/.test(code) && /[0-9]/.test(code)) {
      builds.push({ context: null, label: null, importString: code });
    }
  }
  return builds;
}

function extractFromHtml($) {
  const builds = [];
  $("[data-import-string], [data-talent-code]").each((_, el) => {
    const code = $(el).attr("data-import-string") || $(el).attr("data-talent-code");
    if (code && code.trim().length > 30) {
      builds.push({ context: null, label: $(el).attr("data-label") || null, importString: code.trim() });
    }
  });
  return builds;
}

function extractStatPriority($) {
  let priority = null;
  $("h2, h3").each((_, h) => {
    const text = $(h).text().trim().toLowerCase();
    if (text.includes("stat") && (text.includes("priorit") || text.includes("weight"))) {
      const next = $(h).nextAll("ul, ol, p").first();
      priority = next.text().trim().replace(/\s+/g, " ");
    }
  });
  return priority;
}

async function main() {
  const { url, out } = parseArgs();
  if (!url || !out) {
    console.error('Benutzung: node scrape-archon.js --url "<archon-url>" --out "<output.json>"');
    process.exit(1);
  }

  console.log(`Lade ${url} ...`);
  const html = await fetchPage(url);
  const $ = cheerio.load(html);

  let builds = extractFromNextData($);
  if (builds.length === 0) builds = extractFromHtml($);

  const seen = new Set();
  builds = builds.filter((b) => {
    if (seen.has(b.importString)) return false;
    seen.add(b.importString);
    return true;
  }).map((b) => ({ ...b, provider: "archon" }));

  if (builds.length === 0) {
    console.warn(
      "⚠️  Keine Talent-Strings gefunden. Archon-Seitenstruktur hat sich evtl. geändert - Parser prüfen (data-import-string Attribute oder __NEXT_DATA__ Format)."
    );
  } else {
    console.log(`✅ ${builds.length} Talent-Build(s) von Archon gefunden.`);
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
      archon: extractStatPriority($) || (existing.statPriority && existing.statPriority.archon) || null
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
