const fetch = require('node-fetch');

async function check(url) {
    try {
        const res = await fetch(url, { headers: { "User-Agent": "Mozilla/5.0" } });
        console.log(`${res.status} - ${url}`);
    } catch (e) {
        console.log(`ERR - ${url}`);
    }
}

const urls = [
    "https://www.wowhead.com/guide/classes/warrior/protection/bis-gear",
    "https://www.wowhead.com/guide/classes/warrior/protection/bis-gear-pve-tank",
    "https://www.wowhead.com/guide/classes/warrior/protection/rotation-cooldowns",
    "https://www.wowhead.com/guide/classes/warrior/protection/rotation-cooldowns-pve-tank",
    "https://www.wowhead.com/guide/classes/warrior/protection/stat-priority-pve-tank"
];

urls.forEach(check);
