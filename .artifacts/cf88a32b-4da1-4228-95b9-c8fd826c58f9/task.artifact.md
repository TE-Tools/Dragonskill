# Task: Talent Management & Data Fix (v1.1.0)

## Data Fix (Enchants, BiS, etc.)
- [ ] Investigate why `enchants`, `bisGear`, and `crafting` are empty in `GuideData.lua`
- [ ] Improve `scrape-wowhead.js` parsing for these sections
- [ ] Regenerate `GuideData.lua`

## Talent Management (v1.1.0)
- [ ] Implement `TalentCompare:ImportToWoW` helper
- [ ] Update `UI:ShowImportDialog` with three options (Copy, Create New, Cancel)
- [ ] Add combat check for "Create New" option
- [ ] Ensure `Blizzard_ClassTalentUI` is loaded when needed

## Finalization
- [ ] Manual test of the new workflow
- [ ] Verify data population in all tabs
- [ ] Git push & Final instructions
