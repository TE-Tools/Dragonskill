/**
 * Dragon Skill - Wowhead Talent Scraper
 * -------------------------------------
 * Läuft lokal bei dir (NICHT im WoW-Client). Holt die Wowhead-Guide-Seiten
 * "Talent Builds" und "Stat Priority" einer Spec, extrahiert Talent-Import-
 * Strings + Stat-Prioritäten und speichert sie als JSON.
 *
 * Wowhead trennt diese Infos seit dem Relaunch in zwei eigene Guide-Seiten
 * (z.B. .../talent-builds-pve-tank und .../stat-priority-pve-tank - das
 * Rollen-Suffix unterscheidet sich je Spec: pve-tank, pve-healer, pve-dps).
 *
 * Benutzung:
 *   node scrape-wowhead.js \
 *     --talentsUrl "https://www.wowhead.com/guide/classes/warrior/protection/talent-builds-pve-tank" \
 *     --statsUrl "https://www.wowhead.com/guide/classes/warrior/protection/stat-priority-pve-tank" \
 *     --out data-raw/WARRIOR_73.json
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
 * Wowhead liefert den eigentlichen Guide-Inhalt (inkl. Talent-Import-Codes
 * und Stat-Priorität) nicht als fertiges HTML, sondern als BBCode-artige
 * Markup-Sprache, die client-seitig per JS gerendert wird. Im rohen HTML
 * steckt dieser Text JSON-string-escaped (\r\n, \/, \") in einem <script>-
 * Block. Für den Scraper reicht es, diese Escapes rückgängig zu machen und
 * direkt gegen die BBCode-Shortcodes zu matchen - kein Browser/JS nötig.
 */
function unescapeWowheadMarkup(html) {
  return html
    .replace(/\\r\\n/g, "\n")
    .replace(/\\n/g, "\n")
    .replace(/\\\//g, "/")
    .replace(/\\"/g, '"');
}

/**
 * Talent-Import-Codes stehen als [copy="Raid"]CODE[/copy] Shortcodes im
 * Markup. Bei Specs mit mehreren Hero-Talent-Bäumen (z.B. Colossus vs.
 * Mountain Thane) taucht kurz davor ein [symbol=wow-hero-talent-XXX]
 * Shortcode auf, der als Kontext für den Build dient.
 */
function extractTalentBuilds(markup) {
  const builds = [];
  const codeRe = /\[copy="([^"]+)"\]([A-Za-z0-9+/=_-]{20,})\[\/copy\]/g;
  let m;
  while ((m = codeRe.exec(markup))) {
    const [, label, importString] = m;
    const contextWindow = markup.slice(Math.max(0, m.index - 500), m.index);
    const heroMatches = contextWindow.match(/wow-hero-talent-([a-z]+)/g);
    const hero = heroMatches
      ? heroMatches[heroMatches.length - 1].replace("wow-hero-talent-", "")
      : null;
    builds.push({ context: hero, label, importString });
  }

  // Deduplizieren (gleicher Import-Code + gleicher Kontext + gleiches Label)
  const seen = new Set();
  return builds.filter((b) => {
    const key = `${b.context}|${b.label}|${b.importString}`;
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

/**
 * Stat-Prioritäten stehen als [ol]/[li][b]Stat[/b][/li] Listen unter einer
 * "<Kategorie> Stat Priority"-Überschrift (Kategorie ist z.B. "Survivability"
 * / "DPS" oder ein Hero-Talent-Name wie "Lightsmith").
 */
function extractStatPriority(markup) {
  const blockRe =
    /\[color=[^\]]+\]([A-Za-z]+)\[\/color\] Stat Priority\[\/b\]\[\/center\]\n\[hr\]\n\[ol\]([\s\S]{0,800}?)\[\/ol\]/g;
  const sections = [];
  let m;
  while ((m = blockRe.exec(markup))) {
    const [, category, body] = m;
    const items = [...body.matchAll(/\[li\]\[b\]([^\[]+)\[\/b\]\[\/li\]/g)].map(
      (x) => x[1]
    );
    if (items.length > 0) {
      sections.push(`${category}: ${items.join(" > ")}`);
    }
  }
  return sections.length > 0 ? sections.join(" | ") : null;
}

async function main() {
  const { talentsUrl, statsUrl, out } = parseArgs();
  if (!talentsUrl && !statsUrl) {
    console.error(
      'Benutzung: node scrape-wowhead.js --talentsUrl "<url>" --statsUrl "<url>" --out "<output.json>"'
    );
    process.exit(1);
  }
  if (!out) {
    console.error("Fehlender --out Parameter.");
    process.exit(1);
  }

  let newTalents = [];
  if (talentsUrl) {
    console.log(`Lade ${talentsUrl} ...`);
    const markup = unescapeWowheadMarkup(await fetchPage(talentsUrl));
    newTalents = extractTalentBuilds(markup).map((b) => ({
      ...b,
      provider: "wowhead"
    }));
  }

  let newStatPrio = null;
  if (statsUrl) {
    console.log(`Lade ${statsUrl} ...`);
    const markup = unescapeWowheadMarkup(await fetchPage(statsUrl));
    newStatPrio = extractStatPriority(markup);
  }

  const outPath = path.resolve(out);
  const existing = fs.existsSync(outPath)
    ? JSON.parse(fs.readFileSync(outPath, "utf-8"))
    : { talentBuilds: [], statPriority: null };

  // Alte wowhead-Builds ersetzen, andere Provider (z.B. archon) behalten
  const keptBuilds = (existing.talentBuilds || []).filter(
    (b) => b.provider !== "wowhead"
  );

  const data = {
    scrapedAt: new Date().toISOString(),
    statPriority: {
      ...(existing.statPriority || {}),
      wowhead:
        newStatPrio ||
        (existing.statPriority && existing.statPriority.wowhead) ||
        null
    },
    talentBuilds: talentsUrl ? [...keptBuilds, ...newTalents] : keptBuilds
  };

  if (talentsUrl && newTalents.length === 0) {
    console.warn(
      "⚠️  Keine Talent-Strings gefunden. Wowhead-Seitenstruktur hat sich evtl. geändert - Parser prüfen."
    );
  } else if (talentsUrl) {
    console.log(`✅ ${newTalents.length} Talent-Build(s) gefunden.`);
  }
  if (statsUrl && !newStatPrio) {
    console.warn(
      "⚠️  Keine Stat-Priorität gefunden. Wowhead-Seitenstruktur hat sich evtl. geändert - Parser prüfen."
    );
  }

  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, JSON.stringify(data, null, 2), "utf-8");
  console.log(`Gespeichert: ${outPath}`);
}

main().catch((err) => {
  console.error("Fehler:", err.message);
  process.exit(1);
});
