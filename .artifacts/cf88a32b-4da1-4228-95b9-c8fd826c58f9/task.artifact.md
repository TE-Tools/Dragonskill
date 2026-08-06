# Task: Dragon Skill Expansion (v0.3)

## Preparation & Core
- [x] Fix Spec-ID for Devourer Demon Hunter in `spec-list.json`
- [x] Refactor `Database:CreateSkilling` for better naming (Provider, Timestamp)

## Scraper Enhancements
- [x] Update `scrape-wowhead.js` (BiS Gear, Enchants, Gems, Consumables)
- [x] Update `scrape-archon.js` (Stat Averages/Percentages)
- [x] Update `build-data.js` (Export new fields to Lua)

## UI & Modules Reconstruction
- [x] Rebuild `Modules/TalentCompare/UI.lua` (Main Frame, Tabs, Slash-Commands)
- [x] Implement Detailed Talent Diff (using `GetImportConfigSlotMap`)
- [x] Implement Stat Comparison (Current vs. Guide Averages)
- [x] Create `Modules/Gear/Gear.lua`
- [x] Create `Modules/Enchants/Enchants.lua`

## Verification
- [x] Run Scraper & Verify JSON Output
- [x] Verify `GuideData.lua` generation
- [ ] Manual In-Game UI check (User task)
