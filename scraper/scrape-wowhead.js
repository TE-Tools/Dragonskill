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
  if (res.status === 404) return null; // Tolerant handling
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
    .replace(/\\t/g, "\t")
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
 * Stat-Prioritäten stehen als [ol]/[ul] Liste unter einer
 * "<Kategorie> Stat Priority"-Überschrift (Kategorie ist z.B. "Survivability"
 * / "DPS", ein Hero-Talent-Name wie "Lightsmith" oder "Colossus"/"Slayer").
 * Formatierungs-Details variieren leicht je Spec (mit/ohne [hr]-Trenner,
 * [li]Stat[/li] vs. [li][b]Stat[/b][/li]) - Regex ist entsprechend tolerant.
 */
function extractStatPriority(markup) {
  const blockRe =
    /\[color=[^\]]+\]([^\[]+)\[\/color\] (?:Stat |Defensive |Offensive )?Priority\[\/b\]\[\/center\][\s\S]{0,300}?\[(?:ol|ul)\]([\s\S]{0,800}?)\[\/(?:ol|ul)\]/g;
  const sections = [];
  let m;
  while ((m = blockRe.exec(markup))) {
    const [, category, body] = m;
    const liBlocks = body.match(/\[li\][\s\S]*?\[\/li\]/g) || [];
    const items = liBlocks
      .map((li) => li.replace(/\[li\]|\[\/li\]|\[b\]|\[\/b\]/g, "").trim())
      .filter(Boolean);
    if (items.length > 0) {
      sections.push(`${category.trim()}: ${items.join(" > ")}`);
    }
  }
  return sections.length > 0 ? sections.join(" | ") : null;
}

/**
 * Extrahiert Best-in-Slot Gear aus Tabellen.
 */
function extractBiSGear(markup) {
  const gear = [];
  // Wowhead nutzt oft [table] oder [box] für BiS Listen.
  const tableRe = /\[(?:table|box)[^\]]*\]([\s\S]*?)\[\/(?:table|box)\]/gi;
  let m;
  while ((m = tableRe.exec(markup))) {
    const content = m[1];
    const lc = content.toLowerCase();
    if (lc.includes("slot") || lc.includes("item") || lc.includes("bis")) {
      const rows = content.split(/\[tr\]/i).filter(r => r.includes("[td"));
      rows.forEach(row => {
        const itemMatch = row.match(/\[item=(\d+)\]/i);
        const cols = row.split(/\[td[^\]]*\]/i)
          .map(c => c.replace(/\[\/td\]|\[\/tr\]|\[b\]|\[\/b\]|\[url=[^\]]+\]|\[\/url\]|\[symbol=[^\]]+\]|\[span[^\]]*\]|\[\/span\]|\[item=\d+\]/gi, "").trim())
          .filter(Boolean);

        if (cols.length >= 2) {
          const slot = cols[0];
          const itemText = cols[1];
          const source = cols[2] || "Unknown";

          gear.push({
            slot: slot,
            item: itemText || (itemMatch ? `Item ${itemMatch[1]}` : "Unknown Item"),
            source: source.replace(/\[url=[^\]]+\]|\[\/url\]/gi, "").trim(),
            itemId: itemMatch ? parseInt(itemMatch[1]) : null
          });
        }
      });
    }
  }
  return gear;
}

function extractConsumables(markup) {
  const data = { enchants: [], gems: [], consumables: [] };
  // Erweitertes Suchmuster für Überschriften
  const sectionRe = /\[b\]([^\]]+(?:Enchants|Gems|Consumables|Potions|Flasks|Food|Oil|Phials|Rune))\[\/b\][\s\S]{0,600}?\[(?:ol|ul)\]([\s\S]{0,1500}?)\[\/(?:ol|ul)\]/gi;
  let m;
  while ((m = sectionRe.exec(markup))) {
    const title = m[1].toLowerCase();
    const body = m[2];
    const items = (body.match(/\[li\][\s\S]*?\[\/li\]/g) || [])
      .map(li => li.replace(/\[li\]|\[\/li\]|\[b\]|\[\/b\]|\[url=[^\]]+\]|\[\/url\]/g, "").trim())
      .filter(Boolean);

    if (title.includes("enchant")) data.enchants.push(...items);
    else if (title.includes("gem")) data.gems.push(...items);
    else data.consumables.push(...items);
  }
  return data;
}

async function main() {
  const { talentsUrl, statsUrl, rotationUrl, gearUrl, out } = parseArgs();
  if (!talentsUrl && !statsUrl && !rotationUrl && !gearUrl) {
    console.error(
      'Benutzung: node scrape-wowhead.js --talentsUrl "<url>" --statsUrl "<url>" --rotationUrl "<url>" --gearUrl "<url>" --out "<output.json>"'
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
    const html = await fetchPage(talentsUrl);
    if (html) {
      const markup = unescapeWowheadMarkup(html);
      newTalents = extractTalentBuilds(markup).map((b) => ({
        ...b,
        provider: "wowhead"
      }));
    } else {
      console.warn(`⚠️  Talent-Seite nicht gefunden: ${talentsUrl}`);
    }
  }

  let newStatPrio = null;
  let bisGear = [];
  let consumables = { enchants: [], gems: [], consumables: [] };
  let crafting = { embellishments: [], items: [] };

  if (statsUrl) {
    console.log(`Lade ${statsUrl} ...`);
    const html = await fetchPage(statsUrl);
    if (html) {
      const markup = unescapeWowheadMarkup(html);
      newStatPrio = extractStatPriority(markup);
      bisGear = extractBiSGear(markup);
      consumables = extractConsumables(markup);

      // Extrahiere Crafting/Embellishments
      const embRe = /\[b\](?:Best )?Embellishments\[\/b\][\s\S]{0,500}?\[(?:ol|ul)\]([\s\S]{0,1000}?)\[\/(?:ol|ul)\]/gi;
      let m = embRe.exec(markup);
      if (m) {
        crafting.embellishments = (m[1].match(/\[li\][\s\S]*?\[\/li\]/g) || [])
          .map(li => li.replace(/\[li\]|\[\/li\]|\[b\]|\[\/b\]|\[url=[^\]]+\]|\[\/url\]/g, "").trim())
          .filter(Boolean);
      }
    } else {
      console.warn(`⚠️  Stats-Seite nicht gefunden: ${statsUrl}`);
    }
  }

  if (gearUrl) {
    console.log(`Lade ${gearUrl} ...`);
    let html = await fetchPage(gearUrl);
    if (!html) {
        // Fallback: Probiere URL ohne Suffix falls es eines gab
        const fallback = gearUrl.replace(/-pve-(tank|healer|dps)$/, "");
        if (fallback !== gearUrl) {
            console.log(`Probier Fallback: ${fallback}`);
            html = await fetchPage(fallback);
        }
    }

    if (html) {
      const markup = unescapeWowheadMarkup(html);
      const newGear = extractBiSGear(markup);
      if (newGear.length > 0) bisGear = newGear;

      const newConsumables = extractConsumables(markup);
      if (newConsumables.enchants.length > 0) consumables.enchants = newConsumables.enchants;
      if (newConsumables.gems.length > 0) consumables.gems = newConsumables.gems;
      if (newConsumables.consumables.length > 0) consumables.consumables = newConsumables.consumables;
    } else {
      console.warn(`⚠️  Gear-Seite nicht gefunden: ${gearUrl}`);
    }
  }

  let rotation = [];
  if (rotationUrl) {
    console.log(`Lade ${rotationUrl} ...`);
    let html = await fetchPage(rotationUrl);
    if (!html) {
        const fallback = rotationUrl.replace(/-pve-(tank|healer|dps)$/, "");
        if (fallback !== rotationUrl) {
            console.log(`Probier Fallback: ${fallback}`);
            html = await fetchPage(fallback);
        }
    }

    if (html) {
      const markup = unescapeWowheadMarkup(html);
      // Lockerer Regex für Rotation: Sucht nach [h3] oder [b] mit "Priority" oder "Rotation"
      const rotRe = /\[(?:h\d|b)[^\]]*\](?:PvE |Single Target |AoE )?(?:Rotation )?Priority\[\/(?:h\d|b)\][\s\S]{0,800}?\[ol\]([\s\S]{0,3500}?)\[\/ol\]/gi;
      let m;
      while ((m = rotRe.exec(markup))) {
        const body = m[1];
        const items = (body.match(/\[li\][\s\S]*?\[\/li\]/g) || [])
          .map(li => {
            const text = li.replace(/\[li\]|\[\/li\]|\[b\]|\[\/b\]|\[i\]|\[\/i\]/g, "").trim();
            const spellMatch = li.match(/\[spell=(\d+)\]/);
            return {
              text: text.replace(/\[spell=\d+\]|\[url=[^\]]+\]|\[\/url\]/g, "").trim(),
              spellId: spellMatch ? spellMatch[1] : null
            };
          })
          .filter(r => r.text.length > 2);

        if (items.length > 0) {
            rotation.push(...items);
            break; // Erste gefundene Liste reicht meist
        }
      }
    } else {
      console.warn(`⚠️  Rotation-Seite nicht gefunden: ${rotationUrl}`);
    }
  }

  const outPath = path.resolve(out);
  const existing = fs.existsSync(outPath)
    ? JSON.parse(fs.readFileSync(outPath, "utf-8"))
    : { talentBuilds: [], statPriority: null };

  const keptBuilds = (existing.talentBuilds || []).filter(
    (b) => b.provider !== "wowhead"
  );

  const data = {
    scrapedAt: new Date().toISOString(),
    statPriority: {
      ...(existing.statPriority || {}),
      wowhead: newStatPrio || (existing.statPriority && existing.statPriority.wowhead) || null
    },
    bisGear: {
      ...(existing.bisGear || {}),
      wowhead: bisGear.length > 0 ? bisGear : (existing.bisGear && existing.bisGear.wowhead) || []
    },
    enchants: {
      ...(existing.enchants || {}),
      wowhead: consumables.enchants.length > 0 ? consumables.enchants : (existing.enchants && existing.enchants.wowhead) || []
    },
    gems: {
      ...(existing.gems || {}),
      wowhead: consumables.gems.length > 0 ? consumables.gems : (existing.gems && existing.gems.wowhead) || []
    },
    consumables: {
      ...(existing.consumables || {}),
      wowhead: consumables.consumables.length > 0 ? consumables.consumables : (existing.consumables && existing.consumables.wowhead) || []
    },
    crafting: {
      ...(existing.crafting || {}),
      wowhead: crafting.embellishments.length > 0 ? crafting : (existing.crafting && existing.crafting.wowhead) || { embellishments: [], items: [] }
    },
    rotation: {
      ...(existing.rotation || {}),
      wowhead: rotation.length > 0 ? rotation : (existing.rotation && existing.rotation.wowhead) || []
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

  if (bisGear.length > 0) console.log(`✅ ${bisGear.length} Gear-Items gefunden.`);
  if (rotation.length > 0) console.log(`✅ ${rotation.length} Rotations-Schritte gefunden.`);

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
