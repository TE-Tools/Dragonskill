/**
 * Dragon Skill - Scrape-All Orchestrator
 * ---------------------------------------
 * Liest eine Liste von Specs (spec-list.json) und ruft für jede sowohl
 * scrape-wowhead.js als auch scrape-archon.js auf. Wird lokal manuell oder
 * automatisiert per GitHub Actions ausgeführt (siehe .github/workflows/scrape.yml).
 *
 * Benutzung:
 *   node scrape-all.js --list spec-list.json --outDir data-raw
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

function runScraper(scriptName, args, outFile, label) {
  try {
    execFileSync("node", [scriptName, ...args, "--out", outFile], {
      stdio: "inherit"
    });
    return true;
  } catch (err) {
    console.error(`⚠️  ${scriptName} fehlgeschlagen für ${label}: ${err.message}`);
    return false;
  }
}

function main() {
  const { list, outDir } = parseArgs();
  if (!list || !outDir) {
    console.error('Benutzung: node scrape-all.js --list "<spec-list.json>" --outDir "<data-raw>"');
    process.exit(1);
  }

  const specs = JSON.parse(fs.readFileSync(path.resolve(list), "utf-8"));
  fs.mkdirSync(path.resolve(outDir), { recursive: true });

  let successCount = 0;
  let failCount = 0;

  for (const spec of specs) {
    const outFile = path.join(outDir, `${spec.classToken}_${spec.specID}.json`);
    console.log(`\n=== ${spec.classToken} (Spec ${spec.specID}) ===`);

    if (spec.wowheadTalentsUrl || spec.wowheadStatsUrl || spec.wowheadRotationUrl || spec.wowheadGearUrl) {
      const args = [];
      if (spec.wowheadTalentsUrl) args.push("--talentsUrl", spec.wowheadTalentsUrl);
      if (spec.wowheadStatsUrl) args.push("--statsUrl", spec.wowheadStatsUrl);
      if (spec.wowheadRotationUrl) args.push("--rotationUrl", spec.wowheadRotationUrl);
      if (spec.wowheadGearUrl) args.push("--gearUrl", spec.wowheadGearUrl); // Add gearUrl if handled
      const ok = runScraper("scrape-wowhead.js", args, outFile, "wowhead");
      ok ? successCount++ : failCount++;
    }
    if (spec.archonUrl) {
      const ok = runScraper("scrape-archon.js", ["--url", spec.archonUrl], outFile, spec.archonUrl);
      ok ? successCount++ : failCount++;
    }
  }

  console.log(`\n✅ Fertig. Erfolgreich: ${successCount}, Fehlgeschlagen: ${failCount}`);
  if (failCount > 0) {
    console.log("Hinweis: Fehlgeschlagene Quellen behalten die zuletzt bekannten Daten (kein Datenverlust).");
  }
}

main();
