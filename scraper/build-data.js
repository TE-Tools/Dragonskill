/**
 * Dragon Skill - JSON zu Lua Konverter (v1.3.1)
 */

const fs = require("fs");
const path = require("path");

function parseArgs() {
  const args = process.argv.slice(2);
  const out = {};
  for (let i = 0; i < args.length; i += 2) out[args[i].replace(/^--/, "")] = args[i + 1];
  return out;
}

function luaEscape(str) {
  if (str === null || str === undefined) return "nil";
  return '"' + String(str).replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\n/g, "\\n") + '"';
}

function buildLuaTable(entries) {
  let lua = "-- AUTO-GENERATED - nicht manuell bearbeiten\n\n";
  lua += "DragonSkillData = DragonSkillData or {}\n\n";

  for (const [classToken, specs] of Object.entries(entries)) {
    lua += `DragonSkillData["${classToken}"] = DragonSkillData["${classToken}"] or {}\n`;
    for (const [specID, data] of Object.entries(specs)) {
      lua += `DragonSkillData["${classToken}"][${specID}] = {\n`;
      lua += `    scrapedAt = ${luaEscape(data.scrapedAt)},\n`;

      const writeList = (name, providers) => {
        lua += `    ${name} = {\n`;
        for (const [provider, items] of Object.entries(providers || {})) {
          lua += `        ${provider} = {\n`;
          if (Array.isArray(items)) {
            for (const item of items) {
              lua += `            { text = ${luaEscape(item.text)}, itemId = ${item.itemId || "nil"}, slot = ${luaEscape(item.slot || nil)} },\n`;
            }
          }
          lua += `        },\n`;
        }
        lua += `    },\n`;
      };

      lua += `    statPriority = {\n`;
      for (const [provider, text] of Object.entries(data.statPriority || {})) {
        lua += `        ${provider} = ${luaEscape(text)},\n`;
      }
      lua += `    },\n`;

      writeList("bisGear", data.bisGear);
      writeList("enchants", data.enchants);
      writeList("gems", data.gems);
      writeList("consumables", data.consumables);

      lua += `    crafting = {\n`;
      for (const [provider, c] of Object.entries(data.crafting || {})) {
        if (!c) continue;
        lua += `        ${provider} = { embellishments = {\n`;
        for (const v of (c.embellishments || [])) lua += `            ${luaEscape(v)},\n`;
        lua += `        }},\n`;
      }
      lua += `    },\n`;

      lua += `    rotation = {\n`;
      for (const [provider, list] of Object.entries(data.rotation || {})) {
        lua += `        ${provider} = {\n`;
        for (const e of (list || [])) lua += `            { text = ${luaEscape(e.text)}, spellId = ${luaEscape(e.spellId)} },\n`;
        lua += `        },\n`;
      }
      lua += `    },\n`;

      lua += `    trinkets = {\n`;
      for (const [provider, list] of Object.entries(data.trinkets || {})) {
        lua += `        ${provider} = {\n`;
        for (const t of (list || [])) lua += `            { name = ${luaEscape(t.name)}, rank = ${luaEscape(t.rank)}, itemId = ${luaEscape(t.itemId)} },\n`;
        lua += `        },\n`;
      }
      lua += `    },\n`;

      lua += `    talentBuilds = {\n`;
      for (const b of (data.talentBuilds || [])) {
        lua += `        { provider = ${luaEscape(b.provider)}, label = ${luaEscape(b.label)}, importString = ${luaEscape(b.importString)} },\n`;
      }
      lua += `    },\n`;

      lua += `}\n\n`;
    }
  }
  return lua;
}

function main() {
  const { dataDir, out } = parseArgs();
  if (!dataDir || !out) process.exit(1);

  const entries = {};
  fs.readdirSync(dataDir).forEach(file => {
    const m = file.match(/^([A-Z]+)_(\d+)\.json$/);
    if (m) {
      const data = JSON.parse(fs.readFileSync(path.join(dataDir, file), "utf-8"));
      if (!entries[m[1]]) entries[m[1]] = {};
      entries[m[1]][m[2]] = data;
    }
  });

  fs.writeFileSync(path.resolve(out), buildLuaTable(entries), "utf-8");
  console.log(`✅ Lua-Datei geschrieben.`);
}
main();
