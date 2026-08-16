/**
 * Dragon Skill - JSON zu Lua Konverter
 * ------------------------------------
 * Wandelt einen oder mehrere Scraper-JSON-Outputs in eine einzige Lua-Datei um.
 * Erweitert um Gear, Enchants, Gems, Consumables und Stat-Durchschnitte.
 */

const fs = require("fs");
const path = require("path");

function parseArgs() {
  const args = process.argv.slice(2);
  const out = {};
  for (let i = 0; i < args.length; i += 2) {
    out[args[i].replace(/^--/, "")] = args[i + 1];
  }
  return out;
}

function luaEscape(str) {
  if (str === null || str === undefined) return "nil";
  return '"' + String(str).replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\n/g, "\\n") + '"';
}

function buildLuaTable(entries) {
  let lua = "-- AUTO-GENERATED von build-data.js - nicht manuell bearbeiten\n";
  lua += "-- Quelle: Wowhead / Archon\n\n";
  lua += "DragonSkillData = DragonSkillData or {}\n\n";

  for (const [classToken, specs] of Object.entries(entries)) {
    lua += `DragonSkillData["${classToken}"] = DragonSkillData["${classToken}"] or {}\n`;
    for (const [specID, data] of Object.entries(specs)) {
      lua += `DragonSkillData["${classToken}"][${specID}] = {\n`;
      lua += `    scrapedAt = ${luaEscape(data.scrapedAt)},\n`;

      // Stat Priority
      lua += `    statPriority = {\n`;
      for (const [provider, text] of Object.entries(data.statPriority || {})) {
        lua += `        ${provider} = ${luaEscape(text)},\n`;
      }
      lua += `    },\n`;

      // Stat Averages
      lua += `    statAverages = {\n`;
      for (const [provider, stats] of Object.entries(data.statAverages || {})) {
        lua += `        ${provider} = {\n`;
        if (stats) {
          for (const [sName, sVal] of Object.entries(stats)) {
            lua += `            [${luaEscape(sName)}] = ${luaEscape(sVal)},\n`;
          }
        }
        lua += `        },\n`;
      }
      lua += `    },\n`;

      // BiS Gear
      lua += `    bisGear = {\n`;
      for (const [provider, items] of Object.entries(data.bisGear || {})) {
        lua += `        ${provider} = {\n`;
        for (const item of items || []) {
          lua += `            { slot = ${luaEscape(item.slot)}, item = ${luaEscape(item.item)}, source = ${luaEscape(item.source)}, itemId = ${item.itemId || "nil"} },\n`;
        }
        lua += `        },\n`;
      }
      lua += `    },\n`;

      // Enchants
      lua += `    enchants = {\n`;
      for (const [provider, list] of Object.entries(data.enchants || {})) {
        lua += `        ${provider} = {\n`;
        for (const val of list || []) {
          lua += `            ${luaEscape(val)},\n`;
        }
        lua += `        },\n`;
      }
      lua += `    },\n`;

      // Gems
      lua += `    gems = {\n`;
      for (const [provider, list] of Object.entries(data.gems || {})) {
        lua += `        ${provider} = {\n`;
        for (const val of list || []) {
          lua += `            ${luaEscape(val)},\n`;
        }
        lua += `        },\n`;
      }
      lua += `    },\n`;

      // Consumables
      lua += `    consumables = {\n`;
      for (const [provider, list] of Object.entries(data.consumables || {})) {
        lua += `        ${provider} = {\n`;
        for (const val of list || []) {
          lua += `            ${luaEscape(val)},\n`;
        }
        lua += `        },\n`;
      }
      lua += `    },\n`;

      // Crafting
      lua += `    crafting = {\n`;
      for (const [provider, cData] of Object.entries(data.crafting || {})) {
        lua += `        ${provider} = {\n`;
        lua += `            embellishments = {\n`;
        for (const val of cData.embellishments || []) {
          lua += `                ${luaEscape(val)},\n`;
        }
        lua += `            },\n`;
        lua += `        },\n`;
      }
      lua += `    },\n`;

      // Rotation
      lua += `    rotation = {\n`;
      for (const [provider, list] of Object.entries(data.rotation || {})) {
        lua += `        ${provider} = {\n`;
        for (const entry of list || []) {
          lua += `            { text = ${luaEscape(entry.text)}, spellId = ${luaEscape(entry.spellId)} },\n`;
        }
        lua += `        },\n`;
      }
      lua += `    },\n`;

      // Trinkets
      lua += `    trinkets = {\n`;
      for (const [provider, list] of Object.entries(data.trinkets || {})) {
        lua += `        ${provider} = {\n`;
        for (const t of list || []) {
          lua += `            { name = ${luaEscape(t.name)}, rank = ${luaEscape(t.rank)}, score = ${luaEscape(t.score)}, itemId = ${luaEscape(t.itemId)} },\n`;
        }
        lua += `        },\n`;
      }
      lua += `    },\n`;

      // Talent Builds
      lua += `    talentBuilds = {\n`;
      for (const build of data.talentBuilds || []) {
        lua += `        {\n`;
        lua += `            provider = ${luaEscape(build.provider)},\n`;
        lua += `            context = ${luaEscape(build.context)},\n`;
        lua += `            label = ${luaEscape(build.label)},\n`;
        lua += `            importString = ${luaEscape(build.importString)},\n`;
        lua += `        },\n`;
      }
      lua += `    },\n`;

      lua += `}\n\n`;
    }
  }
  return lua;
}

function main() {
  const { dataDir, out } = parseArgs();
  if (!dataDir || !out) {
    console.error('Benutzung: node build-data.js --dataDir "<json-ordner>" --out "<GuideData.lua>"');
    process.exit(1);
  }

  const files = fs.readdirSync(dataDir).filter((f) => f.endsWith(".json"));
  const entries = {};
  for (const file of files) {
    const match = file.match(/^([A-Z]+)_(\d+)\.json$/);
    if (!match) continue;
    const [, classToken, specID] = match;
    const data = JSON.parse(fs.readFileSync(path.join(dataDir, file), "utf-8"));
    entries[classToken] = entries[classToken] || {};
    entries[classToken][specID] = data;
  }

  const lua = buildLuaTable(entries);
  const outPath = path.resolve(out);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, lua, "utf-8");
  console.log(`✅ Lua-Datei geschrieben: ${outPath}`);
}

main();
