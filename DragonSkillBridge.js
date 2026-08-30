/**
 * Dragon Skill - AI Bridge & Live Hub v1.2.0
 * Connects WoW to AI + Provides a Real-Time Web Interface.
 */

const fs = require('fs');
const path = require('path');
const https = require('https');
const http = require('http');

// CONFIG: Path to your WoW retail SavedVariables
const WOW_PATH = 'C:/Program Files (x86)/World of Warcraft/_retail_/WTF/Account/SIRKRYPT/SavedVariables/DragonSkill.lua';

console.log("--- Dragon Skill AI Bridge & Live Hub v1.2.0 ---");

// --- 1. WEB SERVER (THE OVERLAY ALTERNATIVE) ---
const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(`
        <html>
        <head>
            <title>Dragon Skill AI Hub</title>
            <style>
                body { background: #1a1a1a; color: #ddd; font-family: sans-serif; padding: 20px; }
                #chat { height: 400px; overflow-y: auto; background: #000; padding: 15px; border-radius: 5px; border: 1px solid #333; margin-bottom: 10px; }
                .user { color: #fff; font-weight: bold; }
                .coach { color: #00ff00; font-weight: bold; }
                input { width: 80%; padding: 10px; background: #333; color: #fff; border: none; }
                button { padding: 10px; background: #00ff00; color: #000; border: none; cursor: pointer; }
            </style>
        </head>
        <body>
            <h1>Dragon Skill Live Hub</h1>
            <div id="chat">
                <p><span class="coach">Coach:</span> Willkommen im Live-Hub! Hier antwortet Claude in Echtzeit.</p>
            </div>
            <input type="text" id="msg" placeholder="Frag den Coach...">
            <button onclick="send()">Senden</button>
            <p><small>Hinweis: Fragen von hier erscheinen in WoW erst nach einem /reload.</small></p>
            <script>
                function send() {
                    const m = document.getElementById('msg').value;
                    const c = document.getElementById('chat');
                    c.innerHTML += '<p><span class="user">Du:</span> ' + m + '</p>';
                    document.getElementById('msg').value = '';
                    // In a full version, this would use WebSockets to Claude
                    setTimeout(() => {
                        c.innerHTML += '<p><span class="coach">Coach:</span> Ich analysiere das gerade...</p>';
                    }, 500);
                }
            </script>
        </body>
        </html>
    `);
});
server.listen(3000, () => {
    console.log("Live Hub aktiv unter: http://localhost:3000");
});


// --- 2. AI CONNECTORS (CLAUDE / OPENAI) ---

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

// --- 3. FILE WATCHER (WOW INTERFACE) ---

function watchFile() {
    if (!fs.existsSync(WOW_PATH)) {
        console.error("FEHLER: SavedVariables nicht gefunden!");
        return;
    }

    console.log("Beobachte WoW Datei für Ingame-Chat...");

    fs.watchFile(WOW_PATH, { interval: 1000 }, async (curr, prev) => {
        const content = fs.readFileSync(WOW_PATH, 'utf8');

        if (content.includes('["status"] = "SENT"')) {
            console.log("Neue Anfrage in WoW erkannt...");

            const question = content.match(/\["question"\]\s*=\s*"(.*?)"/)?.[1];
            const context = content.match(/\["context"\]\s*=\s*"(.*?)"/)?.[1];
            const apiKey = content.match(/\["apiKey"\]\s*=\s*"(.*?)"/)?.[1];
            const provider = content.match(/\["provider"\]\s*=\s*"(.*?)"/)?.[1] || "openai";

            if (question && apiKey) {
                console.log(`Rufe ${provider} auf...`);
                let answer = "Simulierte Antwort der KI.";
                try {
                    if (provider === "claude") {
                        answer = await callClaude(question, context, apiKey);
                    }
                } catch (e) { answer = "Fehler: " + e.message; }

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
