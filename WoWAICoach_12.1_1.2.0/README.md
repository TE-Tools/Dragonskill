# WoWAICoach 1.2.0 – Midnight 12.1

Local expert coach for gear, inventory, upgrades, M+, route planning and next-step recommendations.

## Neu in 1.2
- separates Scanner / Analyzer / Planner / Engine / Database
- ranked upgrade candidates instead of only raw itemlevel comparison
- time-budget planning
- content model for M+, Delves, Open World, Raid and PvP
- season-2 M+ rotation data
- extension points for verified item, boss, loot, build and stat datasets
- no external AI/API required

## Commands
- `/wki`
- `/wowai`

## Example questions
- Welche Items sollte ich zuerst austauschen?
- Habe ich in den Taschen ein Upgrade?
- Welche Ini bringt mich weiter?
- Ich habe 30 Minuten – was soll ich machen?
- Welche Skillung soll ich nehmen?
- Welche Stats brauche ich?

## Design constraint
The addon does not automate combat and does not claim access to secret combat data. Midnight 12.1 introduced/continued API restrictions around secret values and combat information. The coach therefore focuses on character/item/UI data and local decision support.
