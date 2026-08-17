/**
 * Dragon Skill - Archon.gg Scraper (v1.6.1)
 * Talent-Builds, Stat-Prio + BiS Gear/Weapons/Trinkets/Enchants/Gems
 * aus BuildsBestInSlotGearSection (__NEXT_DATA__).
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
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36",
      Accept: "text/html",
    },
  });
  if (!res.ok) throw new Error(`Fetch failed: ${res.status} ${res.statusText} (${url})`);
  return res.text();
}

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
  return (
    nextData &&
    nextData.props &&
    nextData.props.pageProps &&
    nextData.props.pageProps.page
  );
}

function extractTalentBuilds(page) {
  const builds = [];
  const sections = (page && page.sections) || [];
  for (const section of sections) {
    if (section.component !== "BuildsTalentTreeBuildSection") continue;
    const sets = (section.props && section.props.talentTreeBuildSets) || [];
    for (const set of sets) {
      for (const alt of set.alternatives || []) {
        const exportCodeParams =
          alt.talentTree && alt.talentTree.exportCodeParams;
        const code = exportCodeParams && exportCodeParams.exportCode;
        if (code && code.trim().length > 20) {
          builds.push({
            context: alt.popularity || null,
            label: alt.title || null,
            importString: code.trim(),
          });
        }
      }
    }
  }
  return builds;
}

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

const SLOT_HINTS = [
  [/helm|head|casque|hood|cowl|crown|mask|tusks/i, "Head"],
  [/neck|choker|amulet|pendant|reliquary/i, "Neck"],
  [/shoulder|pauldrons|spaulders|mantle|gibbet/i, "Shoulders"],
  [/cloak|cape|drape|wrap/i, "Cloak"],
  [/chest|breastplate|cuirass|robe|tunic|vest|hauberk/i, "Chest"],
  [/wrist|bracer|cuff/i, "Wrist"],
  [/glove|gauntlet|hand|grip/i, "Gloves"],
  [/belt|girdle|waist|cord/i, "Belt"],
  [/leg|greave|pant|kilt|chausse/i, "Legs"],
  [/boot|tread|sabaton|stomper|march|foot/i, "Boots"],
  [/ring|band|signet|loop/i, "Ring"],
  [/shield|bulwark|barrier|rebuke|scute|ward/i, "Shield"],
  [/sword|axe|mace|dagger|glaive|staff|bow|gun|wand|fist|polearm|blade|warblade|fury|vengeance/i, "Weapon"],
];

function guessSlot(name, section) {
  if (section === "trinkets") return "Trinket";
  if (section === "weapons") {
    if (/shield|bulwark|barrier|rebuke|scute|ward/i.test(name || "")) return "Shield";
    return "Weapon";
  }
  for (const [re, slot] of SLOT_HINTS) {
    if (re.test(name || "")) return slot;
  }
  return null;
}

/** GearIcon is embedded as a stringified React-like tag inside __NEXT_DATA__. */
function parseGearIcon(iconStr) {
  if (!iconStr || typeof iconStr !== "string") return null;
  const idm = iconStr.match(/id=\{(\d+)\}/);
  const namem = iconStr.match(/>([^<]+)<\/GearIcon>/);
  if (!idm || !namem) return null;
  const normalized = iconStr.replace(/'/g, '"');
  const enchants = [];
  const gems = [];
  const objRe = /\{"id":(\d+),"name":"([^"]+)","icon":"[^"]*","type":(\d+)/g;
  let m;
  while ((m = objRe.exec(normalized))) {
    const entry = {
      itemId: parseInt(m[1], 10),
      name: m[2],
      text: m[2],
    };
    const type = parseInt(m[3], 10);
    if (type === 1 || /enchant|rune of|armor kit/i.test(m[2])) {
      enchants.push(entry);
    } else {
      gems.push(entry);
    }
  }
  return {
    itemId: parseInt(idm[1], 10),
    name: namem[1].trim(),
    text: namem[1].trim(),
    enchants,
    gems,
  };
}

function extractBiS(page) {
  const gear = [];
  const weapons = [];
  const trinkets = [];
  const enchantsMap = new Map();
  const gemsMap = new Map();

  const sections = (page && page.sections) || [];
  for (const section of sections) {
    if (section.component !== "BuildsBestInSlotGearSection") continue;
    const props = section.props || {};
    for (const [sectionKey, out] of [
      ["gear", gear],
      ["weapons", weapons],
      ["trinkets", trinkets],
    ]) {
      for (const raw of props[sectionKey] || []) {
        if (raw.isPlaceholder) continue;
        const parsed = parseGearIcon(raw.icon || "");
        if (!parsed) continue;
        const slot = guessSlot(parsed.name, sectionKey);
        out.push({
          name: parsed.name,
          text: parsed.name,
          itemId: parsed.itemId,
          slot,
          rank: raw.topLabel || null,
          popularity: raw.topLabel || null,
        });
        for (const e of parsed.enchants || []) {
          if (!enchantsMap.has(e.itemId)) {
            enchantsMap.set(e.itemId, {
              ...e,
              slot: slot || null,
            });
          }
        }
        for (const g of parsed.gems || []) {
          if (!gemsMap.has(g.itemId)) {
            gemsMap.set(g.itemId, { ...g });
          }
        }
      }
    }
  }

  return {
    gear: [...gear, ...weapons],
    trinkets,
    enchants: [...enchantsMap.values()],
    gems: [...gemsMap.values()],
  };
}

async function main() {
  const { url, out } = parseArgs();
  if (!url || !out) {
    console.error(
      'Benutzung: node scrape-archon.js --url "<archon-url>" --out "<output.json>"'
    );
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
  const bis = extractBiS(page);

  console.log(
    `✅ talents=${builds.length} gear=${bis.gear.length} trinkets=${bis.trinkets.length} enchants=${bis.enchants.length} gems=${bis.gems.length} stats=${statPrio ? "yes" : "no"}`
  );

  const outPath = path.resolve(out);
  const existing = fs.existsSync(outPath)
    ? JSON.parse(fs.readFileSync(outPath, "utf-8"))
    : { talentBuilds: [], statPriority: null };

  const keptBuilds = (existing.talentBuilds || []).filter(
    (b) => b.provider !== "archon"
  );

  const data = {
    ...existing,
    scrapedAt: new Date().toISOString(),
    statPriority: {
      ...(existing.statPriority || {}),
      archon:
        statPrio ||
        (existing.statPriority && existing.statPriority.archon) ||
        null,
    },
    bisGear: {
      ...(existing.bisGear || {}),
      archon:
        bis.gear.length > 0
          ? bis.gear
          : (existing.bisGear && existing.bisGear.archon) || [],
    },
    trinkets: {
      ...(existing.trinkets || {}),
      archon:
        bis.trinkets.length > 0
          ? bis.trinkets
          : (existing.trinkets && existing.trinkets.archon) || [],
    },
    enchants: {
      ...(existing.enchants || {}),
      archon:
        bis.enchants.length > 0
          ? bis.enchants
          : (existing.enchants && existing.enchants.archon) || [],
    },
    gems: {
      ...(existing.gems || {}),
      archon:
        bis.gems.length > 0
          ? bis.gems
          : (existing.gems && existing.gems.archon) || [],
    },
    talentBuilds: [...keptBuilds, ...builds],
  };

  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, JSON.stringify(data, null, 2), "utf-8");
  console.log(`Gespeichert: ${outPath}`);
}

main().catch((err) => {
  console.error("Fehler:", err.message);
  process.exit(1);
});
