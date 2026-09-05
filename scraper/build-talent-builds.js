/**
 * Dragon Skill - Generator für Data/TalentBuilds.lua (v1.0.0)
 *
 * Liest die gescrapten Zeilen (CLASS|SPECID|PROVIDER|LABEL|HERO|CODE),
 * validiert JEDEN Import-String gegen die erwartete specID und schreibt nur
 * gültige Builds in die Lua-Datei. Das ist die Absicherung gegen den Bug,
 * der den Talente-Tab kaputt gemacht hat: ein String mit falscher specID
 * kommt hier gar nicht erst durch.
 *
 * Aufruf:  node build-talent-builds.js data-raw/wowhead-all.txt [...weitere]
 */

const fs = require("fs");
const path = require("path");
const { validate } = require("./loadout-validate.js");

const HERO_LABELS = {
  // Hübschere Anzeige als der URL-Slug von Wowhead.
};

const SMALL_WORDS = new Set(["of", "the", "and"]);

function prettyHero(slug) {
  if (!slug) return null;
  if (HERO_LABELS[slug]) return HERO_LABELS[slug];
  return slug
    .split("-")
    .map((w, i) => {
      if (i > 0 && SMALL_WORDS.has(w)) return w;
      return w.charAt(0).toUpperCase() + w.slice(1);
    })
    .join(" ");
}

function luaEscape(s) {
  return String(s).replace(/\\/g, "\\\\").replace(/"/g, '\\"');
}

function main() {
  const inputs = process.argv.slice(2);
  if (inputs.length === 0) {
    console.error("Usage: node build-talent-builds.js <file.txt> [...]");
    process.exit(1);
  }

  const bySpec = new Map(); // "CLASS|specID" -> [{provider,label,importString}]
  const seenCodes = new Set();
  const stats = { total: 0, kept: 0, rejected: [], dupes: 0 };

  for (const file of inputs) {
    const text = fs.readFileSync(file, "utf-8");
    for (const raw of text.split("\n")) {
      const line = raw.trim();
      if (!line) continue;
      const parts = line.split("|");
      if (parts.length < 6) continue;
      const [cls, specStr, provider, label, hero, code] = parts;
      const specID = parseInt(specStr, 10);
      stats.total++;

      const v = validate(code, specID);
      if (!v.ok) {
        stats.rejected.push(`${cls} ${specID} "${label}" -> ${v.reason}`);
        continue;
      }

      const key = `${cls}|${specID}`;
      if (seenCodes.has(code)) {
        stats.dupes++;
        continue;
      }
      seenCodes.add(code);

      const heroName = prettyHero(hero);
      const fullLabel = heroName ? `${label} · ${heroName}` : label;

      if (!bySpec.has(key)) bySpec.set(key, []);
      bySpec.get(key).push({ provider, label: fullLabel, importString: code });
      stats.kept++;
    }
  }

  // Sortierung: Raid zuerst, dann Mythic+, dann Delves, dann Rest.
  const order = (l) => {
    const s = l.toLowerCase();
    if (s.startsWith("raid")) return 0;
    if (s.includes("single target") || s.includes("st ")) return 1;
    if (s.includes("mythic")) return 2;
    if (s.includes("delve")) return 3;
    return 4;
  };

  const lines = [];
  lines.push("-- AUTO-GENERIERT von scraper/build-talent-builds.js - nicht manuell bearbeiten.");
  lines.push(`-- Quelle: Wowhead / Archon  ·  Stand: ${new Date().toISOString()}`);
  lines.push("-- Jeder Import-String wurde beim Generieren dekodiert und geprüft:");
  lines.push("--   serializationVersion == 2  und  eingebettete specID == Ziel-Spec.");
  lines.push("");
  lines.push("DragonSkillData = DragonSkillData or {}");
  lines.push("");

  const keys = [...bySpec.keys()].sort((a, b) => {
    const [ca, sa] = a.split("|");
    const [cb, sb] = b.split("|");
    return ca === cb ? Number(sa) - Number(sb) : ca.localeCompare(cb);
  });

  for (const key of keys) {
    const [cls, specID] = key.split("|");
    const builds = bySpec.get(key).sort((x, y) => order(x.label) - order(y.label));
    lines.push(`DragonSkillData["${cls}"] = DragonSkillData["${cls}"] or {}`);
    lines.push(`DragonSkillData["${cls}"][${specID}] = DragonSkillData["${cls}"][${specID}] or {}`);
    lines.push(`DragonSkillData["${cls}"][${specID}].talentBuilds = {`);
    for (const b of builds) {
      lines.push(
        `    { provider = "${luaEscape(b.provider)}", label = "${luaEscape(b.label)}", importString = "${b.importString}" },`
      );
    }
    lines.push("}");
    lines.push("");
  }

  const outPath = path.resolve(__dirname, "../DragonSkill/Data/TalentBuilds.lua");
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, lines.join("\n"), "utf-8");

  console.log(`geschrieben: ${outPath}`);
  console.log(
    `Builds: ${stats.kept} gültig / ${stats.total} gelesen  (${stats.rejected.length} abgelehnt, ${stats.dupes} Duplikate)`
  );
  console.log(`Specs abgedeckt: ${keys.length}`);
  for (const r of stats.rejected.slice(0, 20)) console.log("  ABGELEHNT " + r);
}

main();
