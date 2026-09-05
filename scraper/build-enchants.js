/**
 * Dragon Skill - Generator für Data/EnchantsGems.lua (v1.0.0)
 *
 * Eingabe: Zeilen der Form  CLASS|SPECID|KIND|LABEL|ITEMID
 *   KIND = enchant | gem | consumable
 *
 * Aufruf:  node build-enchants.js data-raw/enchants-all.txt
 */

const fs = require("fs");
const path = require("path");

// Slot-Namen von Wowhead auf deutsche Bezeichnungen mappen. Was hier nicht
// drinsteht, wird unverändert durchgereicht - lieber englisch als falsch.
const SLOT_DE = {
  "weapon": "Waffe",
  "weapons": "Waffen",
  "both weapons": "Beide Waffen",
  "main hand": "Waffenhand",
  "off hand": "Schildhand",
  "weapon - main hand": "Waffe – Waffenhand",
  "weapon - off hand": "Waffe – Schildhand",
  "head": "Kopf",
  "helm": "Kopf",
  "helmet": "Kopf",
  "shoulder": "Schultern",
  "shoulders": "Schultern",
  "chest": "Brust",
  "back": "Umhang",
  "cloak": "Umhang",
  "wrist": "Handgelenke",
  "bracers": "Handgelenke",
  "belt": "Gürtel",
  "waist": "Gürtel",
  "legs": "Beine",
  "feet": "Füße",
  "boots": "Füße",
  "ring": "Ring",
  "rings": "Ringe",
  "flask": "Fläschchen",
  "combat potion": "Kampftrank",
  "stats potion": "Attributstrank",
  "mana potion": "Manatrank",
  "health potion": "Heiltrank",
  "invisiblity potion": "Unsichtbarkeitstrank",
  "invisibility potion": "Unsichtbarkeitstrank",
  "weapon buff": "Waffenöl",
  "weapon buffs": "Waffenöl",
  "weapon oil": "Waffenöl",
  "augment rune": "Erweiterungsrune",
  "food": "Nahrung",
  "group feast": "Gruppenschmaus",
  "personal food": "Eigene Nahrung",
  "food - feast": "Nahrung – Schmaus",
  "food - personal": "Nahrung – Eigene",
  "other gems": "Übrige Sockel",
  "gems": "Sockel",
  "tea": "Tee",
};

const KIND_ORDER = { enchant: 0, gem: 1, consumable: 2 };

// Innerhalb der Verzauberungen die übliche Charakterbogen-Reihenfolge.
const SLOT_ORDER = [
  "waffe", "waffen", "beide waffen", "waffenhand", "schildhand",
  "waffe – waffenhand", "waffe – schildhand",
  "kopf", "schultern", "umhang", "brust", "handgelenke",
  "gürtel", "beine", "füße", "ring", "ringe",
];

function germanize(label) {
  const key = label.toLowerCase().trim();
  if (SLOT_DE[key]) return SLOT_DE[key];
  // Klammer-Zusätze getrennt übersetzen: "Weapon Buff (Main hand)"
  const m = key.match(/^(.*?)\s*\((.+)\)$/);
  if (m && SLOT_DE[m[1].trim()]) {
    const inner = m[2].trim();
    const innerDe = SLOT_DE[inner] || inner;
    return `${SLOT_DE[m[1].trim()]} (${innerDe})`;
  }
  return label;
}

function slotRank(deLabel) {
  const i = SLOT_ORDER.indexOf(deLabel.toLowerCase());
  return i === -1 ? 99 : i;
}

function luaEscape(s) {
  return String(s).replace(/\\/g, "\\\\").replace(/"/g, '\\"');
}

function main() {
  const inputs = process.argv.slice(2);
  if (!inputs.length) {
    console.error("Usage: node build-enchants.js <file.txt> [...]");
    process.exit(1);
  }

  const bySpec = new Map();
  let total = 0;

  for (const file of inputs) {
    for (const raw of fs.readFileSync(file, "utf-8").split("\n")) {
      const line = raw.trim();
      if (!line) continue;
      const [cls, specStr, kind, label, itemStr] = line.split("|");
      const specID = parseInt(specStr, 10);
      const itemId = parseInt(itemStr, 10);
      if (!cls || !specID || !itemId || !KIND_ORDER.hasOwnProperty(kind)) continue;

      const key = `${cls}|${specID}`;
      if (!bySpec.has(key)) bySpec.set(key, []);
      bySpec.get(key).push({ kind, slot: germanize(label), itemId });
      total++;
    }
  }

  const lines = [];
  lines.push("-- AUTO-GENERIERT von scraper/build-enchants.js - nicht manuell bearbeiten.");
  lines.push(`-- Quelle: Wowhead (Enchants & Consumables)  ·  Stand: ${new Date().toISOString()}`);
  lines.push("-- Struktur: DragonSkillData[CLASS][specID].enhancements = { {kind, slot, itemId}, ... }");
  lines.push("--   kind = \"enchant\" (Verzauberung) | \"gem\" (Sockel) | \"consumable\" (Verbrauchbar)");
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
    const rows = bySpec.get(key).sort((x, y) => {
      if (KIND_ORDER[x.kind] !== KIND_ORDER[y.kind]) return KIND_ORDER[x.kind] - KIND_ORDER[y.kind];
      if (x.kind === "enchant") return slotRank(x.slot) - slotRank(y.slot);
      return 0;
    });

    lines.push(`DragonSkillData["${cls}"] = DragonSkillData["${cls}"] or {}`);
    lines.push(`DragonSkillData["${cls}"][${specID}] = DragonSkillData["${cls}"][${specID}] or {}`);
    lines.push(`DragonSkillData["${cls}"][${specID}].enhancements = {`);
    for (const r of rows) {
      lines.push(
        `    { kind = "${r.kind}", slot = "${luaEscape(r.slot)}", itemId = ${r.itemId} },`
      );
    }
    lines.push("}");
    lines.push("");
  }

  const outPath = path.resolve(__dirname, "../DragonSkill/Data/EnchantsGems.lua");
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, lines.join("\n"), "utf-8");

  console.log(`geschrieben: ${outPath}`);
  console.log(`Einträge: ${total}  ·  Specs: ${keys.length}`);
}

main();
