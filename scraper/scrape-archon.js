/**
 * Dragon Skill - Archon.gg Scraper (v1.6.3)
 * Overview (Gear/Talents/Stats) + Consumables-Seite
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
  const res = await fetch(url, {
    headers: {
      "User-Agent": "Mozilla/5.0 (DragonSkillAddon-Scraper; contact: wear-alleria)",
      Accept: "text/html,application/xhtml+xml",
      "Accept-Language": "en-US,en;q=0.9",
    },
  });
  if (!res.ok) throw new Error(`Fetch failed: ${res.status} ${res.statusText}`);
  return res.text();
}

function extractNextData(html) {
  const m = html.match(/<script id="__NEXT_DATA__" type="application\/json">([\s\S]*?)<\/script>/);
  if (!m) return null;
  try { return JSON.parse(m[1]); } catch { return null; }
}

function getPage(nextData) {
  return nextData && nextData.props && nextData.props.pageProps && nextData.props.pageProps.page;
}

function extractTalentBuilds(page) {
  const builds = [];
  for (const section of (page && page.sections) || []) {
    if (section.component !== "BuildsTalentTreeBuildSection") continue;
    for (const set of (section.props && section.props.talentTreeBuildSets) || []) {
      for (const alt of set.alternatives || []) {
        const code = alt.talentTree && alt.talentTree.exportCodeParams && alt.talentTree.exportCodeParams.exportCode;
        if (code && code.trim().length > 20) {
          builds.push({ context: alt.popularity || null, label: alt.title || "Recommended", importString: code.trim() });
        }
      }
    }
  }
  return builds;
}

function extractStatPriority(page) {
  for (const section of (page && page.sections) || []) {
    if (section.component !== "BuildsStatPrioritySection") continue;
    const stats = (section.props && section.props.stats) || [];
    const names = [...stats].sort((a, b) => (a.order || 0) - (b.order || 0)).map((s) => s.name).filter(Boolean);
    if (names.length > 0) return names.join(" > ");
  }
  return null;
}

function parseGearIcon(iconStr) {
  if (!iconStr || typeof iconStr !== "string") return null;
  const idMatch = iconStr.match(/id=\{(\d+)\}/);
  const nameMatch = iconStr.match(/>([^<]+)<\/GearIcon>/) || iconStr.match(/>([^<]+)<\/ItemIcon>/);
  const itemId = idMatch ? parseInt(idMatch[1], 10) : null;
  const name = nameMatch ? nameMatch[1].trim() : null;
  if (!itemId && !name) return null;
  const gems = [];
  const gemMatch = iconStr.match(/gems=\{(\[[\s\S]*?\])\}/);
  if (gemMatch) {
    try {
      for (const g of JSON.parse(gemMatch[1])) {
        if (g && (g.id || g.name)) gems.push({ itemId: g.id || null, text: g.name || null, name: g.name || null });
      }
    } catch (_) {}
  }
  const enchants = [];
  const enchMatch = iconStr.match(/enchants=\{(\[[\s\S]*?\])\}/);
  if (enchMatch) {
    try {
      for (const e of JSON.parse(enchMatch[1])) {
        if (e && (e.id || e.name)) enchants.push({ itemId: e.id || null, text: e.name || null, name: e.name || null });
      }
    } catch (_) {}
  }
  return { itemId, text: name, name, gems, enchants };
}

function extractBiS(page) {
  const gear = [], weapons = [], trinkets = [];
  const enchantsMap = new Map(), gemsMap = new Map();
  for (const section of (page && page.sections) || []) {
    if (section.component !== "BuildsBestInSlotGearSection") continue;
    const props = section.props || {};
    const pushList = (list, target, defaultSlot) => {
      for (const entry of list || []) {
        if (entry.isPlaceholder) continue;
        const parsed = parseGearIcon(entry.icon);
        if (!parsed) continue;
        target.push({
          text: parsed.text,
          name: parsed.name,
          itemId: parsed.itemId,
          slot: defaultSlot || null,
          popularity: entry.topLabel || null,
          rank: entry.topLabel || null,
        });
        for (const e of parsed.enchants || []) {
          const key = e.itemId || e.text;
          if (key && !enchantsMap.has(key)) enchantsMap.set(key, e);
        }
        for (const g of parsed.gems || []) {
          const key = g.itemId || g.text;
          if (key && !gemsMap.has(key)) gemsMap.set(key, g);
        }
      }
    };
    pushList(props.gear, gear, null);
    pushList(props.weapons, weapons, "Weapon");
    pushList(props.trinkets, trinkets, "Trinket");
  }
  const combinedGear = [...gear, ...weapons.map((w) => ({ ...w, slot: w.slot || "Weapon" }))];
  return { gear: combinedGear, weapons, trinkets, enchants: [...enchantsMap.values()], gems: [...gemsMap.values()] };
}

/** Consumables aus BuildsBestConsumablesSection (+ optional Tables) */
function extractConsumables(page) {
  const out = [];
  const seen = new Set();
  const push = (itemId, name, slot, rank) => {
    const key = String(itemId || "") + "|" + String(name || "");
    if (key === "|" || seen.has(key)) return;
    seen.add(key);
    out.push({
      text: name,
      name: name,
      itemId: itemId || null,
      spellId: null,
      slot: slot || null,
      rank: rank || null,
    });
  };

  for (const section of (page && page.sections) || []) {
    if (section.component === "BuildsBestConsumablesSection") {
      for (const entry of (section.props && section.props.itemBreakdowns) || []) {
        const md = entry.itemMarkdown || "";
        const parsed = parseGearIcon(md);
        const slot = entry.slotLabel || null;
        const rank = (entry.popularityMarkdown || "").replace(/<[^>]+>/g, "").trim() || null;
        if (parsed) push(parsed.itemId, parsed.name || parsed.text, slot, rank);
      }
    }
    if (section.component === "BuildsConsumableTablesSection") {
      for (const table of (section.props && section.props.tables) || []) {
        let slot = null;
        const itemCol = table.columns && table.columns.item;
        if (itemCol && itemCol.header) {
          const hm = String(itemCol.header).match(/>([^<]+)<\/ImageIcon>/) || String(itemCol.header).match(/>([^<]+)</);
          if (hm) slot = hm[1].trim();
        }
        for (const row of table.data || []) {
          const itemMd = row.item || "";
          const idMatch = itemMd.match(/id=\{(\d+)\}/);
          const nameMatch = itemMd.match(/>([^<]+)<\/ItemIcon>/) || itemMd.match(/>([^<]+)<\/GearIcon>/);
          const itemId = idMatch ? parseInt(idMatch[1], 10) : null;
          const name = nameMatch ? nameMatch[1].trim() : null;
          let rank = null;
          if (row.popularity) rank = String(row.popularity).replace(/<[^>]+>/g, "").trim();
          if (name || itemId) push(itemId, name, slot, rank);
        }
      }
    }
  }
  return out;
}

function deriveConsumablesUrl(overviewUrl) {
  if (!overviewUrl) return null;
  return overviewUrl.replace(/\/overview\//, "/consumables/");
}

async function main() {
  const { url, out } = parseArgs();
  if (!url || !out) {
    console.error('Usage: node scrape-archon.js --url "..." --out "..."');
    process.exit(1);
  }
  console.log(`Lade ${url} ...`);
  const html = await fetchPage(url);
  const nextData = extractNextData(html);
  if (!nextData) throw new Error("Konnte __NEXT_DATA__ nicht finden");
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
  let trinkets = bis.trinkets.map((t) => ({
    name: t.name || t.text,
    text: t.text || t.name,
    rank: t.rank || t.popularity || null,
    itemId: t.itemId || null,
    popularity: t.popularity || null,
  }));

  let consumables = [];
  const consUrl = deriveConsumablesUrl(url);
  if (consUrl && consUrl !== url) {
    try {
      console.log(`Lade Consumables ${consUrl} ...`);
      const consHtml = await fetchPage(consUrl);
      const consNext = extractNextData(consHtml);
      const consPage = getPage(consNext);
      consumables = extractConsumables(consPage);
    } catch (e) {
      console.warn("Consumables-Seite fehlgeschlagen:", e.message);
    }
  }

  console.log(
    `✅ ${builds.length} Builds, ${bis.gear.length} Gear, ${trinkets.length} Trinkets, ${bis.enchants.length} Enchants, ${bis.gems.length} Gems, ${consumables.length} Consumables`
  );

  const outPath = path.resolve(out);
  const existing = fs.existsSync(outPath) ? JSON.parse(fs.readFileSync(outPath, "utf-8")) : { talentBuilds: [] };
  const keptBuilds = (existing.talentBuilds || []).filter((b) => b.provider !== "archon");

  const data = {
    ...existing,
    scrapedAt: new Date().toISOString(),
    statPriority: {
      ...(existing.statPriority || {}),
      archon: statPrio || (existing.statPriority && existing.statPriority.archon) || null,
    },
    bisGear: {
      ...(existing.bisGear || {}),
      archon: bis.gear.length > 0 ? bis.gear : (existing.bisGear && existing.bisGear.archon) || [],
    },
    enchants: {
      ...(existing.enchants || {}),
      archon: bis.enchants.length > 0 ? bis.enchants : (existing.enchants && existing.enchants.archon) || [],
    },
    gems: {
      ...(existing.gems || {}),
      archon: bis.gems.length > 0 ? bis.gems : (existing.gems && existing.gems.archon) || [],
    },
    trinkets: {
      ...(existing.trinkets || {}),
      archon: trinkets.length > 0 ? trinkets : (existing.trinkets && existing.trinkets.archon) || [],
    },
    consumables: {
      ...(existing.consumables || {}),
      archon: consumables.length > 0 ? consumables : (existing.consumables && existing.consumables.archon) || [],
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
