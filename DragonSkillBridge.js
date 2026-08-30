/**
 * Dragon Skill - AI Bridge v1.2.1
 * Connects WoW to Claude/OpenAI.
 */

const fs = require('fs');
const path = require('path');
const https = require('https');

// KONFIGURATION: Pfad zu deiner WoW retail SavedVariables Datei
const WOW_PATH = 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/SIRKRYPT/SavedVariables/DragonSkill.lua';

console.log("--- Dragon Skill AI Bridge v1.2.1 gestartet ---");

async function callClaude(question, context, apiKey) {
    const data = JSON.stringify({
        model: "claude-3-5-sonnet-20240620",
        max_tokens: 1024,
        system: "Du bist ein WoW Expert Coach. Kontext: " + context,
        messages: [{ role: "user", content: question }]
    });

    return new Promise((resolve, reject) => {
        const options = {
            hostname: 'api.anthropic.com',
            port: 443,
            path: '/v1/messages',
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'x-api-key': apiKey,
                'anthropic-version': '2023-06-01'
            }
        };
        const req = https.request(options, (res) => {
            let body = '';
            res.on('data', (d) => body += d);
            res.on('end', () => {
                try {
                    const json = JSON.parse(body);
                    resolve(json.content[0].text);
                } catch (e) { resolve("Fehler beim Parsen der Claude Antwort."); }
            });
        });
        req.on('error', (e) => reject(e));
        req.write(data);
        req.end();
    });
}

function watchFile() {
    if (!fs.existsSync(WOW_PATH)) {
        console.error("FEHLER: SavedVariables nicht gefunden: " + WOW_PATH);
        return;
    }

    console.log("Beobachte WoW Datei: " + WOW_PATH);

    fs.watchFile(WOW_PATH, { interval: 1000 }, async (curr, prev) => {
        const content = fs.readFileSync(WOW_PATH, 'utf8');

        if (content.includes('["status"] = "SENT"')) {
            console.log("Neue Anfrage erkannt...");

            const question = content.match(/\["question"\]\s*=\s*"(.*?)"/)?.[1];
            const context = content.match(/\["context"\]\s*=\s*"(.*?)"/)?.[1];
            const apiKey = content.match(/\["apiKey"\]\s*=\s*"(.*?)"/)?.[1];
            const provider = content.match(/\["provider"\]\s*=\s*"(.*?)"/)?.[1] || "openai";

            if (question && apiKey) {
                console.log(`Rufe ${provider} auf...`);
                let answer = "Simulierte Antwort.";
                if (provider === "claude") {
                    answer = await callClaude(question, context, apiKey);
                }

                console.log("Antwort erhalten. Schreibe in Datei...");
                const escapedAnswer = answer.replace(/"/g, '\\"').replace(/\n/g, '\\n');

                let newContent = content.replace(/\["status"\] = "SENT"/, '["status"] = "DONE"');
                newContent = newContent.replace(/\["lastResponse"\] = ".*?"/, `["lastResponse"] = "${escapedAnswer}"`);

                fs.writeFileSync(WOW_PATH, newContent);
                console.log("Fertig! Nutze 'Synchronisieren' in WoW.");
            }
        }
    });
}

watchFile();
