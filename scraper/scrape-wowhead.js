/**
 * Dragon Skill - Wowhead Talent Scraper
 * -------------------------------------
 * Läuft lokal bei dir (NICHT im WoW-Client). Holt eine Wowhead-Guide-Seite,
 * extrahiert Talent-Import-Strings + Metadaten und speichert sie als JSON.
 *
 * Benutzung:
 *   node scrape-wowhead.js --url "https://www.wowhead.com/guide/classes/warrior/protection/talent-builds" --out ../addon/Data/warrior_protection.json
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
      "User-Agent":
        "Mozilla/5.0 (DragonSkillAddon-Scraper; contact: wear-alleria)"
    }
  });
  if (!res.ok) {
    throw new Error(`Fetch failed: ${res.status} ${res.statusText} (${url})`);
  }
  return res.text();
}

/**
 * Wowhead rendert Talent-Import-Strings meist in Elementen mit
 * class="wh-icon-fx" Nachbarschaft oder <copy>-Buttons. Die exakte
 * Struktur ändert sich gelegentlich - daher mehrere Fallback-Strategien.
 */
function extractTalentBuilds($) {
  const builds = [];

  // Strategie 1: Tabellen mit Überschrift "Talent Import Codes" oder ähnlich
  $("table").each((_, table) => {
    const $table = $(table);
    const headerText = $table.prev("h2, h3").text().trim();
    $table.find("tr").each((__, row) => {
      const $row = $(row);
      const label = $row.find("td").eq(0).text().trim();
      const code = $row.find("td").eq(1).text().trim();
      // Blizzard Talent-Strings bestehen aus Base64-ähnlichen Zeichen
      if (code && /^[A-Za-z0-9+/=_-]{30,}$/.test(code)) {
        builds.push({
          context: headerText || null,
          label: label || null,
          importString: code
        });
      }
    });
  });

  // Strategie 2: <input> oder <textarea> Felder mit Import-Strings (Copy-Buttons)
  $("input[value], textarea").each((_, el) => {
    const val = $(el).attr("value") || $(el).text();
    const trimmed = (val || "").trim();
    if (/^[A-Za-z0-9+/=_-]{30,}$/.test(trimmed)) {
      builds.push({
        context: null,
        label: $(el).attr("data-label") || null,
        importString: trimmed
      });
    }
  });

  // Deduplizieren
  const seen = new Set();
  return builds.filter((b) => {
    if (seen.has(b.importString)) return false;
    seen.add(b.importString);
    return true;
  });
}

function extractStatPriority($) {
  // Sucht nach einer Liste/Text unter einer "Stat Priority" Überschrift
  let priority = null;
  $("h2, h3").each((_, h) => {
    const text = $(h).text().trim().toLowerCase();
    if (text.includes("stat priorit")) {
      const next = $(h).nextAll("ul, ol, p").first();
      priority = next.text().trim().replace(/\s+/g, " ");
    }
  });
  return priority;
}

async function main() {
  const { url, out } = parseArgs();
  if (!url || !out) {
    console.error(
      'Benutzung: node scrape-wowhead.js --url "<wowhead-url>" --out "<output.json>"'
    );
    process.exit(1);
  }

  console.log(`Lade ${url} ...`);
  const html = await fetchPage(url);
  const $ = cheerio.load(html);

  const existing = fs.existsSync(path.resolve(out))
    ? JSON.parse(fs.readFileSync(path.resolve(out), "utf-8"))
    : { talentBuilds: [], statPriority: null };

  const newTalents = extractTalentBuilds($).map((b) => ({ ...b, provider: "wowhead" }));
  const newStatPrio = extractStatPriority($);

  // Alte wowhead-Builds ersetzen, andere Provider (z.B. archon) behalten
  const keptBuilds = (existing.talentBuilds || []).filter((b) => b.provider !== "wowhead");

  const data = {
    scrapedAt: new Date().toISOString(),
    statPriority: {
      ...(existing.statPriority || {}),
      wowhead: newStatPrio || (existing.statPriority && existing.statPriority.wowhead) || null
    },
    talentBuilds: [...keptBuilds, ...newTalents]
  };

  if (data.talentBuilds.length === 0) {
    console.warn(
      "⚠️  Keine Talent-Strings gefunden. Wowhead-Seitenstruktur hat sich evtl. geändert - Parser prüfen."
    );
  } else {
    console.log(`✅ ${data.talentBuilds.length} Talent-Build(s) gefunden.`);
  }

  const outPath = path.resolve(out);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, JSON.stringify(data, null, 2), "utf-8");
  console.log(`Gespeichert: ${outPath}`);
}

main().catch((err) => {
  console.error("Fehler:", err.message);
  process.exit(1);
});
