/**
 * Dragon Skill - JSON zu Lua Konverter
 * ------------------------------------
 * Wandelt einen oder mehrere Scraper-JSON-Outputs in eine einzige Lua-Datei um,
 * die das Addon per TOC lädt (DragonSkillData Tabelle).
 *
 * Benutzung:
 *   node build-data.js --dataDir ../addon/Data/json --out ../addon/Data/GuideData.lua
 *
 * Erwartet JSON-Dateinamen im Format: <CLASS>_<SPECID>.json
 * z.B. WARRIOR_73.json  (73 = Protection Warrior spec ID)
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
  lua += "-- Quelle: Wowhead / Archon (siehe sourceUrl je Eintrag)\n\n";
  lua += "DragonSkillData = DragonSkillData or {}\n\n";

  for (const [classToken, specs] of Object.entries(entries)) {
    lua += `DragonSkillData["${classToken}"] = DragonSkillData["${classToken}"] or {}\n`;
    for (const [specID, data] of Object.entries(specs)) {
      lua += `DragonSkillData["${classToken}"][${specID}] = {\n`;
      lua += `    scrapedAt = ${luaEscape(data.scrapedAt)},\n`;
      lua += `    statPriority = {\n`;
      const statPrio = data.statPriority || {};
      for (const [provider, text] of Object.entries(statPrio)) {
        lua += `        ${provider} = ${luaEscape(text)},\n`;
      }
      lua += `    },\n`;
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
    console.error(
      'Benutzung: node build-data.js --dataDir "<json-ordner>" --out "<GuideData.lua>"'
    );
    process.exit(1);
  }

  const files = fs.readdirSync(dataDir).filter((f) => f.endsWith(".json"));
  if (files.length === 0) {
    console.error("Keine JSON-Dateien in " + dataDir + " gefunden.");
    process.exit(1);
  }

  const entries = {};
  for (const file of files) {
    const match = file.match(/^([A-Z]+)_(\d+)\.json$/);
    if (!match) {
      console.warn(`⚠️  Überspringe ${file} - erwarte Format CLASS_SPECID.json`);
      continue;
    }
    const [, classToken, specID] = match;
    const data = JSON.parse(fs.readFileSync(path.join(dataDir, file), "utf-8"));
    entries[classToken] = entries[classToken] || {};
    entries[classToken][specID] = data;
    console.log(`✓ ${classToken} / Spec ${specID} (${data.talentBuilds?.length || 0} Builds)`);
  }

  const lua = buildLuaTable(entries);
  const outPath = path.resolve(out);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, lua, "utf-8");
  console.log(`\n✅ Lua-Datei geschrieben: ${outPath}`);
  console.log(`   Vergiss nicht "Data\\GuideData.lua" in die .toc einzutragen!`);
}

main();
