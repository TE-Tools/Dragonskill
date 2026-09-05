/**
 * Dragon Skill - Loadout-String Validator (v1.0.0)
 *
 * Dekodiert den Header eines WoW-Talent-Loadout-Strings genau so wie
 * Blizzards ExportUtil/ClassTalentImportExport es tut:
 *
 *   Base64 (Standard-Alphabet), 6 Bit pro Zeichen, Bits LSB-first.
 *   Header: 8 Bit serializationVersion | 16 Bit specID | 16 * 8 Bit treeHash
 *
 * Blizzard lehnt einen Import ab wenn
 *   - serializationVersion != LOADOUT_SERIALIZATION_VERSION  -> "veraltet"
 *   - specID != aktuelle Spec des Spielers                   -> "falsche Spez"
 *   - der Bit-Stream zu kurz ist                             -> "ungültig"
 * Ein Tree-Hash aus lauter Nullen ist ausdrücklich erlaubt.
 */

const B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

// Aktuelle Serialisierungsversion des Clients (Dragonflight/TWW/Midnight = 2)
const LOADOUT_SERIALIZATION_VERSION = 2;

class BitReader {
  constructor(str) {
    this.bits = [];
    for (const ch of str) {
      const v = B64.indexOf(ch);
      if (v < 0) throw new Error(`Ungültiges Base64-Zeichen: "${ch}"`);
      for (let i = 0; i < 6; i++) this.bits.push((v >> i) & 1);
    }
    this.pos = 0;
  }
  remaining() {
    return this.bits.length - this.pos;
  }
  read(width) {
    if (this.remaining() < width) throw new Error("Bit-Stream zu kurz");
    let v = 0;
    for (let i = 0; i < width; i++) v += this.bits[this.pos + i] << i;
    this.pos += width;
    return v;
  }
}

function decodeHeader(importString) {
  const s = String(importString || "").trim();
  if (!s) throw new Error("leerer String");
  const r = new BitReader(s);
  const version = r.read(8);
  const specID = r.read(16);
  const hash = [];
  for (let i = 0; i < 16; i++) hash.push(r.read(8));
  return {
    version,
    specID,
    treeHash: hash,
    hashEmpty: hash.every((b) => b === 0),
    payloadBits: r.remaining(),
  };
}

/**
 * @returns {{ok: boolean, reason?: string, version?: number, specID?: number}}
 */
function validate(importString, expectedSpecID) {
  let h;
  try {
    h = decodeHeader(importString);
  } catch (e) {
    return { ok: false, reason: e.message };
  }
  if (h.version !== LOADOUT_SERIALIZATION_VERSION) {
    return {
      ok: false,
      reason: `serializationVersion ${h.version} != ${LOADOUT_SERIALIZATION_VERSION}`,
      ...h,
    };
  }
  if (expectedSpecID != null && h.specID !== Number(expectedSpecID)) {
    return {
      ok: false,
      reason: `specID ${h.specID} != erwartet ${expectedSpecID}`,
      ...h,
    };
  }
  if (h.payloadBits < 32) {
    return { ok: false, reason: `Payload zu kurz (${h.payloadBits} Bit)`, ...h };
  }
  return { ok: true, ...h };
}

module.exports = { decodeHeader, validate, LOADOUT_SERIALIZATION_VERSION };

// CLI:  node loadout-validate.js <string> [specID]
if (require.main === module) {
  const [str, spec] = process.argv.slice(2);
  if (!str) {
    console.error("Usage: node loadout-validate.js <importString> [specID]");
    process.exit(1);
  }
  console.log(JSON.stringify(validate(str, spec), null, 2));
}
