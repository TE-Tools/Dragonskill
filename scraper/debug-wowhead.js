const fetch = require('node-fetch');
function unescapeWowheadMarkup(html) {
  return html
    .replace(/\\r\\n/g, "\n")
    .replace(/\\n/g, "\n")
    .replace(/\\t/g, "\t")
    .replace(/\\\//g, "/")
    .replace(/\\"/g, '"');
}
async function main() {
    const res = await fetch('https://www.wowhead.com/guide/classes/warrior/protection/rotation-cooldowns-pve-tank');
    const html = await res.text();
    const unescaped = unescapeWowheadMarkup(html);
    const start = unescaped.indexOf('[ol]');
    if (start !== -1) {
        console.log(unescaped.slice(start - 200, start + 2000));
    } else {
        console.log("No [ol] found");
    }
}
main();
