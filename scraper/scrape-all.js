/**
 * Dragon Skill - Scrape-All Orchestrator (v1.5.6)
 *
 *   node scrape-all.js --list spec-list.json --outDir data-raw
 *
 * Consumables-URLs werden NICHT mehr abgeleitet (Wowhead liefert oft 404).
 * Consumables/Gems/Enchants kommen aus Gear- und Guide-Seiten via Keywords.
 */

const fs = require("fs");
const path = require("path");
const { execFileSync } = require("child_process");

function parseArgs() {
  const args = process.argv.slice(2);
  const out = {};
  for (let i = 0; i < args.length; i += 2) {
    out[args[i].replace(/^--/, "")] = args[i + 1];
  }
  return out;
}

function sleep(ms) {
  Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, ms);
}

function runScraper(scriptName, args, outFile, label) {
  try {
    execFileSync("node", [scriptName, ...args, "--out", outFile], {
      stdio: "inherit",
    });
    return true;
  } catch (err) {
    console.error(`⚠️  ${scriptName} fehlgeschlagen für ${label}: ${err.message}`);
    return false;
  }
}

function deriveUrls(spec) {
  const base = spec.wowheadTalentsUrl || "";
  const m = base.match(/\/talent-builds-(pve-[a-z]+)$/);
  const role = m ? m[1] : null;
  const classPath = base.replace(/\/talent-builds-.*$/, "");

  const out = { ...spec };
  if (!out.wowheadStatsUrl && classPath && role) {
    out.wowheadStatsUrl = `${classPath}/stat-priority-${role}`;
  }
  if (!out.wowheadRotationUrl && classPath && role) {
    out.wowheadRotationUrl = `${classPath}/rotation-cooldowns-${role}`;
  }
  if (!out.wowheadGearUrl && classPath) {
    out.wowheadGearUrl = `${classPath}/bis-gear`;
  }
  // Keine auto-consumables-URL: oft 404; Daten aus gear/talents/stats Seiten
  return out;
}

function main() {
  const { list, outDir } = parseArgs();
  if (!list || !outDir) {
    console.error(
      'Benutzung: node scrape-all.js --list "spec-list.json" --outDir "data-raw"'
    );
    process.exit(1);
  }

  const specs = JSON.parse(fs.readFileSync(path.resolve(list), "utf-8"));
  fs.mkdirSync(path.resolve(outDir), { recursive: true });

  let successCount = 0;
  let failCount = 0;

  for (const raw of specs) {
    const spec = deriveUrls(raw);
    const outFile = path.join(outDir, `${spec.classToken}_${spec.specID}.json`);
    console.log(`\n=== ${spec.classToken} (Spec ${spec.specID}) ===`);

    const hasWh =
      spec.wowheadTalentsUrl ||
      spec.wowheadStatsUrl ||
      spec.wowheadRotationUrl ||
      spec.wowheadGearUrl ||
      spec.wowheadConsumablesUrl;

    if (hasWh) {
      const args = [];
      if (spec.wowheadTalentsUrl)
        args.push("--talentsUrl", spec.wowheadTalentsUrl);
      if (spec.wowheadStatsUrl) args.push("--statsUrl", spec.wowheadStatsUrl);
      if (spec.wowheadRotationUrl)
        args.push("--rotationUrl", spec.wowheadRotationUrl);
      if (spec.wowheadGearUrl) args.push("--gearUrl", spec.wowheadGearUrl);
      // Nur explizit in spec-list gesetzte Consumables-URL
      if (spec.wowheadConsumablesUrl)
        args.push("--consumablesUrl", spec.wowheadConsumablesUrl);
      const ok = runScraper("scrape-wowhead.js", args, outFile, "wowhead");
      ok ? successCount++ : failCount++;
      sleep(800);
    }

    if (spec.archonUrl) {
      const ok = runScraper(
        "scrape-archon.js",
        ["--url", spec.archonUrl],
        outFile,
        "archon"
      );
      ok ? successCount++ : failCount++;
      sleep(800);
    }
  }

  console.log(
    `\n✅ Fertig. Erfolgreich: ${successCount}, Fehlgeschlagen: ${failCount}`
  );
}

main();
