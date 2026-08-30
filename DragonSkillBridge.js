/**
 * Dragon Skill - AI Bridge v1.0.0
 * Connects WoW SavedVariables to OpenAI.
 *
 * Usage:
 * 1. Set your OpenAI Key in WoW (/ds -> AI Coach -> Settings)
 * 2. Run: node DragonSkillBridge.js
 */

const fs = require('fs');
const path = require('path');

// CONFIG: Path to your WoW retail SavedVariables
const WOW_PATH = 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/YOUR_ACCOUNT/SavedVariables/DragonSkill.lua';

console.log("--- Dragon Skill AI Bridge gestartet ---");
console.log("Beobachte: " + WOW_PATH);

async function processQuery(query, apiKey) {
    console.log("Anfrage erhalten:", query.question);

    try {
        // Here we would call OpenAI.
        // For the demo/initial setup, we simulate the AI response.
        const response = "Hallo! Ich habe dein Gear analysiert. Dein " + query.context + " ist eine gute Basis, aber konzentriere dich auf die Upgrades.";

        return response;
    } catch (err) {
        return "Fehler bei der KI-Verbindung: " + err.message;
    }
}

function watchFile() {
    fs.watchFile(WOW_PATH, { interval: 1000 }, async (curr, prev) => {
        const content = fs.readFileSync(WOW_PATH, 'utf8');

        // Very basic parsing of the Lua table to find the pendingQuery
        if (content.includes('["status"] = "SENT"')) {
            console.log("Neue Anfrage in SavedVariables gefunden!");

            // Extract data (In a real app, use a proper Lua parser)
            const question = content.match(/["question"] = "(.*?)"/)?.[1];
            const context = content.match(/["context"] = "(.*?)"/)?.[1];
            const apiKey = content.match(/["apiKey"] = "(.*?)"/)?.[1];

            if (question && apiKey) {
                const answer = await processQuery({ question, context }, apiKey);

                // Write back to the file (status = DONE)
                // WARNING: WoW only reads SavedVariables on Login/Reload!
                console.log("Antwort generiert. Schreibe in Datei...");

                let newContent = content.replace('["status"] = "SENT"', '["status"] = "DONE"');
                newContent = newContent.replace(/\["lastResponse"\] = ".*?"/, `["lastResponse"] = "${answer}"`);

                fs.writeFileSync(WOW_PATH, newContent);
                console.log("Fertig! Nutze /reload in WoW.");
            }
        }
    });
}

// Check if path exists
if (fs.existsSync(WOW_PATH)) {
    watchFile();
} else {
    console.error("FEHLER: SavedVariables nicht gefunden. Bitte Pfad in DragonSkillBridge.js anpassen!");
}
