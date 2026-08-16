# Task: Dragon Skill v1.5.1 - Final Emergency Repair

## Core & Events
- [ ] Refactor `EventManager.lua`: Use anonymous frame to fix `RegisterEvent` error
- [ ] Update `Namespace.lua` to v1.5.1

## Talent Logic
- [ ] Update `TalentCompare.lua`: Replace `UIParentLoadAddOn` with `C_AddOns.LoadAddOn`
- [ ] Refine 12.1 `ImportLoadout` call with better safety

## UI & Dialogs
- [ ] Update `UI.lua`: Fix `editBox` nil error in popups
- [ ] Ensure data persistence between dialogs
- [ ] Fix tab population logic (Check for missing Trinkets key)

## Database Recovery
- [ ] Rebuild `GuideData.lua` with 100% coverage for all 40 specs
- [ ] Include BiS, Trinkets, and Enchants for every role

## Finalization
- [ ] Commit & Push
- [ ] Final instructions
