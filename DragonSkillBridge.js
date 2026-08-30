/**
 * Dragon Skill - AI Bridge v1.1.0
 * Connects WoW SavedVariables to OpenAI or Anthropic (Claude).
 *
 * Usage:
 * 1. Set your API Key and Provider in WoW (/ds -> AI Coach -> Settings)
 * 2. Run: node DragonSkillBridge.js
 */

const fs = require('fs');
const path = require('path');
const https = require('https');

// CONFIG: Path to your WoW retail SavedVariables
// Example: 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/12345678#1/SavedVariables/DragonSkill.lua'
const WOW_PATH = 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/YOUR_ACCOUNT/SavedVariables/DragonSkill.lua';

console.log("--- Dragon Skill AI Bridge v1.1.0 gestartet ---");

async function callOpenAI(question, context, apiKey) {
    const data = JSON.stringify({
        model: "gpt-4o",
        messages: [
            { role: "system", content: "Du bist ein WoW Expert Coach. Nutze diesen Kontext: " + context },
            { role: "user", content: question }
        ]
    });

    return new Promise((resolve, reject) => {
        const options = {
            hostname: 'api.openai.com',
            port: 443,
            path: '/v1/chat/completions',
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + apiKey
            }
        };

        const req = https.request(options, (res) => {
            let body = '';
            res.on('data', (d) => body += d);
            res.on('end', () => {
                try {
                    const json = JSON.parse(body);
                    resolve(json.choices[0].message.content);
                } catch (e) { resolve("Fehler beim Parsen der OpenAI Antwort."); }
            });
        });
        req.on('error', (e) => reject(e));
        req.write(data);
        req.end();
    });
}

async function callClaude(question, context, apiKey) {
    const data = JSON.stringify({
        model: "claude-3-5-sonnet-20240620",
        max_tokens: 1024,
        system: "Du bist ein WoW Expert Coach für den Dragon Skill Addon Nutzer. Kontext: " + context,
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

async function processQuery(query, apiKey, provider) {
    console.log(`[${provider.toUpperCase()}] Anfrage:`, query.question);

    try {
        if (provider === "anthropic" || provider === "claude") {
            return await callClaude(query.question, query.context, apiKey);
        } else {
            return await callOpenAI(query.question, query.context, apiKey);
        }
    } catch (err) {
        return "Fehler bei der KI-Verbindung: " + err.message;
    }
}

function watchFile() {
    if (!fs.existsSync(WOW_PATH)) {
        console.error("FEHLER: Datei nicht gefunden: " + WOW_PATH);
        console.log("Bitte passe den Pfad in DragonSkillBridge.js an!");
        return;
    }

    console.log("Beobachte WoW Datei: " + WOW_PATH);

    fs.watchFile(WOW_PATH, { interval: 1000 }, async (curr, prev) => {
        const content = fs.readFileSync(WOW_PATH, 'utf8');

        if (content.includes('["status"] = "SENT"')) {
            console.log("Neue Anfrage erkannt...");

            const question = content.match(/\["question"\] = "(.*?)"/)?.[1];
            const context = content.match(/\["context"\] = "(.*?)"/)?.[1];
            const apiKey = content.match(/\["apiKey"\] = "(.*?)"/)?.[1];
            const provider = content.match(/\["provider"\] = "(.*?)"/)?.[1] || "openai";

            if (question && apiKey) {
                const answer = await processQuery({ question, context }, apiKey, provider);

                console.log("Antwort erhalten. Aktualisiere SavedVariables...");

                // Escape simple quotes for Lua
                const escapedAnswer = answer.replace(/"/g, '\\"').replace(/\n/g, '\\n');

                let newContent = content.replace(/\["status"\] = "SENT"/, '["status"] = "DONE"');
                newContent = newContent.replace(/\["lastResponse"\] = ".*?"/, `["lastResponse"] = "${escapedAnswer}"`);

                fs.writeFileSync(WOW_PATH, newContent);
                console.log("Fertig! Bitte nutze /reload in WoW.");
            }
        }
    });
}

watchFile();
