/**
 * Dragon Skill - JSON zu Lua Konverter (v1.5.4)
 * Output: DragonSkill/Data/GuideData.lua
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
  return (
    '"' +
    String(str)
      .replace(/\\/g, "\\\\")
      .replace(/"/g, '\\"')
      .replace(/\n/g, "\\n") +
    '"'
  );
}

function luaNum(n) {
  if (n === null || n === undefined || n === "") return "nil";
  const v = Number(n);
  return Number.isFinite(v) ? String(v) : "nil";
}

function writeItemList(luaParts, name, providers) {
  luaParts.push(`    ${name} = {`);
  for (const [provider, items] of Object.entries(providers || {})) {
    luaParts.push(`        ${provider} = {`);
    if (Array.isArray(items)) {
      for (const item of items) {
        const text = item.text || item.name || "";
        luaParts.push(
          `            { text = ${luaEscape(text)}, name = ${luaEscape(
            item.name || null
          )}, itemId = ${luaNum(item.itemId)}, spellId = ${luaNum(
            item.spellId
          )}, slot = ${luaEscape(item.slot || null)}, rank = ${luaEscape(
            item.rank || null
          )} },`
        );
      }
    }
    luaParts.push(`        },`);
  }
  luaParts.push(`    },`);
}

function buildLuaTable(entries) {
  const parts = [];
  parts.push("-- AUTO-GENERATED - nicht manuell bearbeiten");
  parts.push("-- build-data.js v1.5.4\n");
  parts.push("DragonSkillData = DragonSkillData or {}\n");

  for (const [classToken, specs] of Object.entries(entries)) {
    parts.push(
      `DragonSkillData["${classToken}"] = DragonSkillData["${classToken}"] or {}`
    );
    for (const [specID, data] of Object.entries(specs)) {
      parts.push(`DragonSkillData["${classToken}"][${specID}] = {`);
      parts.push(`    scrapedAt = ${luaEscape(data.scrapedAt)},`);

      parts.push(`    statPriority = {`);
      for (const [provider, text] of Object.entries(data.statPriority || {})) {
        parts.push(`        ${provider} = ${luaEscape(text)},`);
      }
      parts.push(`    },`);

      writeItemList(parts, "bisGear", data.bisGear);
      writeItemList(parts, "enchants", data.enchants);
      writeItemList(parts, "gems", data.gems);
      writeItemList(parts, "consumables", data.consumables);

      parts.push(`    crafting = {`);
      for (const [provider, c] of Object.entries(data.crafting || {})) {
        if (!c) continue;
        parts.push(`        ${provider} = { embellishments = {`);
        for (const v of c.embellishments || []) {
          parts.push(`            ${luaEscape(v)},`);
        }
        parts.push(`        } },`);
      }
      parts.push(`    },`);

      parts.push(`    rotation = {`);
      for (const [provider, list] of Object.entries(data.rotation || {})) {
        parts.push(`        ${provider} = {`);
        for (const e of list || []) {
          parts.push(
            `            { text = ${luaEscape(
              e.text
            )}, spellId = ${luaNum(e.spellId)} },`
          );
        }
        parts.push(`        },`);
      }
      parts.push(`    },`);

      parts.push(`    trinkets = {`);
      for (const [provider, list] of Object.entries(data.trinkets || {})) {
        parts.push(`        ${provider} = {`);
        for (const t of list || []) {
          parts.push(
            `            { name = ${luaEscape(t.name)}, rank = ${luaEscape(
              t.rank
            )}, itemId = ${luaNum(t.itemId)} },`
          );
        }
        parts.push(`        },`);
      }
      parts.push(`    },`);

      parts.push(`    talentBuilds = {`);
      for (const b of data.talentBuilds || []) {
        parts.push(
          `        { provider = ${luaEscape(b.provider)}, label = ${luaEscape(
            b.label
          )}, importString = ${luaEscape(b.importString)} },`
        );
      }
      parts.push(`    },`);

      parts.push(`}\n`);
    }
  }
  return parts.join("\n");
}

function main() {
  const { dataDir, out } = parseArgs();
  if (!dataDir || !out) {
    console.error(
      'Benutzung: node build-data.js --dataDir data-raw --out ../DragonSkill/Data/GuideData.lua'
    );
    process.exit(1);
  }

  const entries = {};
  const dir = path.resolve(dataDir);
  if (!fs.existsSync(dir)) {
    console.error("dataDir fehlt:", dir);
    process.exit(1);
  }

  for (const file of fs.readdirSync(dir)) {
    const m = file.match(/^([A-Z]+)_(\d+)\.json$/);
    if (!m) continue;
    const data = JSON.parse(fs.readFileSync(path.join(dir, file), "utf-8"));
    if (!entries[m[1]]) entries[m[1]] = {};
    entries[m[1]][m[2]] = data;
  }

  const outPath = path.resolve(out);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, buildLuaTable(entries), "utf-8");
  const nClasses = Object.keys(entries).length;
  const nSpecs = Object.values(entries).reduce((a, s) => a + Object.keys(s).length, 0);
  console.log(`✅ Lua geschrieben: ${outPath} (${nClasses} Klassen, ${nSpecs} Specs)`);
}

main();
