/**
 * Dragon Skill - Wowhead Scraper (v1.5.7)
 * + Junk-Filter für Navigations-Listeneinträge
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
  if (!url) return null;
  try {
    const res = await fetch(url, {
      headers: {
        "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36",
        Accept:
          "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
        "Accept-Language": "en-US,en;q=0.9",
        Referer: "https://www.wowhead.com/",
      },
      timeout: 30000,
    });
    if (!res.ok) {
      console.warn(`  ⚠️  HTTP ${res.status} für ${url}`);
      return null;
    }
    return await res.text();
  } catch (e) {
    console.warn(`  ⚠️  Fetch-Fehler ${url}: ${e.message}`);
    return null;
  }
}

function unescapeWowheadMarkup(html) {
  if (!html) return "";
  return html
    .replace(/\\r\\n|\\n/g, "\n")
    .replace(/\\t/g, "\t")
    .replace(/\\"/g, '"')
    .replace(/\\\//g, "/");
}

const JUNK_TEXT =
  /^(cheat sheet|talent builds?|rotation|bis gear|consumables?|overview|basics?|abilities|guide|introduction|macros?|weak auras?|faq|table of contents|toc)$/i;

function isJunkText(text) {
  if (!text || text.length < 3) return true;
  if (JUNK_TEXT.test(text.trim())) return true;
  if (text.length < 8 && !/\d/.test(text)) return true;
  return false;
}

function extractTalents(markup) {
  const builds = [];
  const re = /\[copy="([^"]+)"\]([A-Za-z0-9+/=_-]{20,})\[\/copy\]/g;
  let m;
  while ((m = re.exec(markup))) {
    builds.push({ label: m[1], importString: m[2], provider: "wowhead" });
  }
  const seen = new Set();
  return builds.filter((b) => {
    if (seen.has(b.importString)) return false;
    seen.add(b.importString);
    return true;
  });
}

function extractStatPriority(markup) {
  if (!markup) return null;
  const stats =
    "Strength|Agility|Intellect|Stamina|Haste|Mastery|Critical Strike|Crit|Versatility|Avoidance|Leech|Speed";
  const re = new RegExp(
    `((?:${stats})(?:\\s*[>≥]\\s*(?:${stats})){1,})`,
    "gi"
  );
  const matches = [];
  let m;
  while ((m = re.exec(markup))) {
    const chain = m[1]
      .replace(/\s*[>≥]\s*/g, " > ")
      .replace(/\bCrit\b/gi, "Critical Strike");
    if (chain.length > 8) matches.push(chain);
  }
  if (matches.length === 0) return null;
  matches.sort((a, b) => b.length - a.length);
  return matches[0];
}

function extractBisGear(markup) {
  const results = [];
  const seen = new Set();
  const rowRe =
    /\[tr\]\s*\[td\]([^\[]+?)\[\/td\]\s*\[td\]\[item=(\d+)\]\[\/td\](?:\s*\[td\](?:\[url[^\]]*\])?([^\[\]]*?)(?:\[\/url\])?\[\/td\])?/gi;
  let m;
  while ((m = rowRe.exec(markup))) {
    const slot = m[1].replace(/\s+/g, " ").trim();
    const itemId = parseInt(m[2], 10);
    const text = (m[3] || "").replace(/\s+/g, " ").trim() || `Item ${itemId}`;
    const key = `${slot}|${itemId}`;
    if (seen.has(key)) continue;
    if (/^(slot|item|source)$/i.test(slot)) continue;
    seen.add(key);
    results.push({ slot, text, itemId });
  }
  if (results.length === 0) {
    for (const item of extractListByKeywords(markup, [
      "best gear",
      "bis gear",
      "best in slot",
      "equipment",
    ])) {
      results.push(item);
    }
  }
  return results;
}

function extractListByKeywords(markup, keywords) {
  const results = [];
  const listRe = /\[(?:ol|ul)\]([\s\S]*?)\[\/(?:ol|ul)\]/gi;
  let m;
  while ((m = listRe.exec(markup))) {
    const body = m[1];
    const preText = markup
      .slice(Math.max(0, m.index - 600), m.index)
      .toLowerCase();
    if (!keywords.some((k) => preText.includes(k))) continue;
    const lis = body.match(/\[li\]([\s\S]*?)\[\/li\]/gi) || [];
    for (const li of lis) {
      const itemID = (li.match(/\[item=(\d+)/i) || [])[1];
      const spellID = (li.match(/\[spell=(\d+)/i) || [])[1];
      const text = li.replace(/\[[^\]]+\]/g, "").replace(/\s+/g, " ").trim();
      if (isJunkText(text)) continue;
      // Navigationslisten haben meist weder item noch spell
      if (!itemID && !spellID && text.length < 20) continue;
      results.push({
        text,
        itemId: itemID ? parseInt(itemID, 10) : null,
        spellId: spellID ? parseInt(spellID, 10) : null,
      });
    }
  }
  return results;
}

function extractRotation(markup) {
  const results = [];
  const seen = new Set();
  const listRe = /\[(?:ol|ul)\]([\s\S]*?)\[\/(?:ol|ul)\]/gi;
  let m;
  while ((m = listRe.exec(markup))) {
    const body = m[1];
    if (!/\[spell=\d+/i.test(body)) continue;
    const preText = markup
      .slice(Math.max(0, m.index - 800), m.index)
      .toLowerCase();
    const relevant =
      preText.includes("priority") ||
      preText.includes("rotation") ||
      preText.includes("single target") ||
      preText.includes("opener") ||
      preText.includes("cooldown");
    if (!relevant) continue;

    const lis = body.match(/\[li\]([\s\S]*?)\[\/li\]/gi) || [];
    for (const li of lis) {
      const spellID = (li.match(/\[spell=(\d+)/i) || [])[1];
      const text = li.replace(/\[[^\]]+\]/g, "").replace(/\s+/g, " ").trim();
      if (!text || isJunkText(text)) continue;
      const key = `${spellID || ""}|${text}`;
      if (seen.has(key)) continue;
      seen.add(key);
      results.push({
        text,
        spellId: spellID ? parseInt(spellID, 10) : null,
      });
    }
  }
  return results;
}

function extractEnchants(markup) {
  return extractListByKeywords(markup, [
    "enchant",
    "weapon -",
    "mana oil",
    "embellish",
    "rune of",
  ]).map((x) => ({ text: x.text, itemId: x.itemId }));
}

function extractGems(markup) {
  return extractListByKeywords(markup, [
    "gem",
    "diamond",
    "emerald",
    "ruby",
    "sapphire",
    "socket",
  ]).map((x) => ({ text: x.text, itemId: x.itemId }));
}

function extractConsumables(markup) {
  return extractListByKeywords(markup, [
    "food",
    "flask",
    "potion",
    "phial",
    "rune",
    "consumable",
    "combat potion",
  ]).map((x) => ({ text: x.text, itemId: x.itemId }));
}

function extractEmbellishments(markup) {
  return extractListByKeywords(markup, ["embellish"])
    .map((x) => x.text)
    .filter(Boolean);
}

function keepIfEmpty(newArr, oldArr) {
  if (Array.isArray(newArr) && newArr.length > 0) return newArr;
  return Array.isArray(oldArr) ? oldArr : [];
}

async function main() {
  const { talentsUrl, statsUrl, gearUrl, rotationUrl, consumablesUrl, out } =
    parseArgs();
  if (!out) {
    console.error("--out erforderlich");
    process.exit(1);
  }

  const pages = [
    ["talents", talentsUrl],
    ["stats", statsUrl],
    ["gear", gearUrl],
    ["rotation", rotationUrl],
    ["consumables", consumablesUrl],
  ];

  let allMarkup = "";
  for (const [label, url] of pages) {
    if (!url) continue;
    console.log(`  → ${label}: ${url}`);
    const html = await fetchPage(url);
    if (html) {
      allMarkup += "\n" + unescapeWowheadMarkup(html);
      await new Promise((r) => setTimeout(r, 400));
    }
  }

  const talents = extractTalents(allMarkup);
  const statPrio = extractStatPriority(allMarkup);
  const gear = extractBisGear(allMarkup);
  const enchants = extractEnchants(allMarkup);
  const gems = extractGems(allMarkup);
  const buffs = extractConsumables(allMarkup);
  const rotation = extractRotation(allMarkup);
  const embellishments = extractEmbellishments(allMarkup);

  console.log(
    `  gefunden: talents=${talents.length} gear=${gear.length} enchants=${enchants.length} gems=${gems.length} consumables=${buffs.length} rotation=${rotation.length} stats=${statPrio ? "yes" : "no"}`
  );

  const outPath = path.resolve(out);
  const existing = fs.existsSync(outPath)
    ? JSON.parse(fs.readFileSync(outPath, "utf-8"))
    : { talentBuilds: [] };

  const keptTalents = (existing.talentBuilds || []).filter(
    (b) => b.provider !== "wowhead"
  );

  const data = {
    ...existing,
    scrapedAt: new Date().toISOString(),
    statPriority: {
      ...(existing.statPriority || {}),
      wowhead:
        statPrio ||
        (existing.statPriority && existing.statPriority.wowhead) ||
        null,
    },
    bisGear: {
      ...(existing.bisGear || {}),
      wowhead: keepIfEmpty(gear, existing.bisGear && existing.bisGear.wowhead),
    },
    enchants: {
      ...(existing.enchants || {}),
      wowhead: keepIfEmpty(
        enchants,
        existing.enchants && existing.enchants.wowhead
      ),
    },
    gems: {
      ...(existing.gems || {}),
      wowhead: keepIfEmpty(gems, existing.gems && existing.gems.wowhead),
    },
    consumables: {
      ...(existing.consumables || {}),
      wowhead: keepIfEmpty(
        buffs,
        existing.consumables && existing.consumables.wowhead
      ),
    },
    rotation: {
      ...(existing.rotation || {}),
      wowhead: keepIfEmpty(
        rotation,
        existing.rotation && existing.rotation.wowhead
      ),
    },
    crafting: {
      ...(existing.crafting || {}),
      wowhead: {
        embellishments:
          embellishments.length > 0
            ? embellishments
            : (existing.crafting &&
                existing.crafting.wowhead &&
                existing.crafting.wowhead.embellishments) ||
              [],
      },
    },
    talentBuilds:
      talents.length > 0 ? [...keptTalents, ...talents] : existing.talentBuilds,
  };

  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, JSON.stringify(data, null, 2), "utf-8");
  console.log(`✅ ${outPath} aktualisiert.`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
