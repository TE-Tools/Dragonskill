const fs = require('fs');
const path = require('path');

const specListPath = path.resolve(__dirname, 'spec-list.json');
const specs = JSON.parse(fs.readFileSync(specListPath, 'utf8'));

specs.forEach(spec => {
    if (spec.wowheadTalentsUrl) {
        const base = spec.wowheadTalentsUrl.replace(/talent-builds-pve-(tank|healer|dps)$/, '');
        const role = spec.wowheadTalentsUrl.match(/pve-(tank|healer|dps)$/)[1];

        spec.wowheadRotationUrl = `${base}rotation-cooldowns-pve-${role}`;
        spec.wowheadGearUrl = `${base}bis-gear`; // Usually no suffix
        spec.wowheadStatsUrl = `${base}stat-priority-pve-${role}`;
    }
});

fs.writeFileSync(specListPath, JSON.stringify(specs, null, 2), 'utf8');
console.log('spec-list.json updated with corrected URLs.');
