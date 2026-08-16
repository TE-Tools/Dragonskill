/**
 * Dragon Skill - Wowhead Talent Scraper (v1.3.1)
 */

const fs = require("fs");
const path = require("path");
const fetch = require("node-fetch");

function parseArgs() {
  const args = process.argv.slice(2);
  const out = {};
  for (let i = 0; i < args.length; i += 2) out[args[i].replace(/^--/, "")] = args[i + 1];
  return out;
}

async function fetchPage(url) {
  try {
    const res = await fetch(url, {
      headers: {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8",
        "Accept-Language": "en-US,en;q=0.9"
      }
    });
    if (res.status === 403) return null;
    if (res.status === 404) return null;
    return await res.text();
  } catch (e) { return null; }
}

function unescapeWowheadMarkup(html) {
  if (!html) return "";
  return html.replace(/\\r\\n|\\n/g, "\n").replace(/\\t/g, "\t").replace(/\\"/g, '"').replace(/\\\//g, "/");
}

function extractTalents(markup) {
  const builds = [];
  const re = /\[copy="([^"]+)"\]([A-Za-z0-9+/=_-]{20,})\[\/copy\]/g;
  let m;
  while ((m = re.exec(markup))) {
    builds.push({ label: m[1], importString: m[2], provider: "wowhead" });
  }
  return builds;
}

function extractListByKeywords(markup, keywords) {
  const results = [];
  // Suche alle Listen [ul]...[/ul] oder [ol]...[/ol]
  const listRe = /\[(?:ol|ul)\]([\s\S]*?)\[\/(?:ol|ul)\]/gi;
  let m;
  while ((m = listRe.exec(markup))) {
    const body = m[1];
    const preText = markup.slice(Math.max(0, m.index - 500), m.index).toLowerCase();

    if (keywords.some(k => preText.includes(k))) {
      const lis = body.match(/\[li\]([\s\S]*?)\[\/li\]/gi) || [];
      lis.forEach(li => {
        const itemID = (li.match(/\[item=(\d+)\]/i) || [])[1];
        const text = li.replace(/\[[^\]]+\]/g, "").trim();
        if (text.length > 2) {
          results.push({ text, itemId: itemID ? parseInt(itemID) : null });
        }
      });
    }
  }
  return results;
}

async function main() {
  const { talentsUrl, statsUrl, gearUrl, out } = parseArgs();
  if (!out) process.exit(1);

  const urls = [talentsUrl, statsUrl, gearUrl].filter(Boolean);
  let allMarkup = "";
  for (const url of urls) {
    const html = await fetchPage(url);
    if (html) allMarkup += unescapeWowheadMarkup(html);
  }

  const talents = extractTalents(allMarkup);
  const gear = extractListByKeywords(allMarkup, ["best gear", "bis gear", "equipment"]);
  const enchants = extractListByKeywords(allMarkup, ["enchant", "weapon -", "mana oil"]);
  const gems = extractListByKeywords(allMarkup, ["gem", "diamond", "emerald", "ruby"]);
  const buffs = extractListByKeywords(allMarkup, ["food", "flask", "potion", "phial", "rune", "consumable"]);

  const outPath = path.resolve(out);
  const existing = fs.existsSync(outPath) ? JSON.parse(fs.readFileSync(outPath, "utf-8")) : { talentBuilds: [] };

  // Merge Logic
  const data = {
    ...existing,
    scrapedAt: new Date().toISOString(),
    bisGear: { wowhead: gear.length > 0 ? gear : (existing.bisGear && existing.bisGear.wowhead) || [] },
    enchants: { wowhead: enchants.length > 0 ? enchants : (existing.enchants && existing.enchants.wowhead) || [] },
    gems: { wowhead: gems.length > 0 ? gems : (existing.gems && existing.gems.wowhead) || [] },
    consumables: { wowhead: buffs.length > 0 ? buffs : (existing.consumables && existing.consumables.wowhead) || [] },
    talentBuilds: talents.length > 0 ? talents : existing.talentBuilds
  };

  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, JSON.stringify(data, null, 2), "utf-8");
  console.log(`✅ ${outPath} aktualisiert.`);
}

main().catch(console.error);
