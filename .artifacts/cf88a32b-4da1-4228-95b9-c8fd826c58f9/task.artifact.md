# Task: Dragon Skill v1.2.4 - Absolute Stability & Data Fix

## Data Pipeline Fix
- [ ] Fix BiS Gear extraction in `scraper/scrape-wowhead.js` (improved regex)
- [ ] Fix data merging logic in `scraper/build-data.js` (ensure lists are not lost)
- [ ] Run full scrape and regenerate `addon/Data/GuideData.lua`

## UI & Interaction
- [ ] Implement named buttons in `addon/Modules/TalentCompare/UI.lua`
- [ ] Set explicit `FrameLevel` for scroll content and list rows
- [ ] Wrap `UI:Update` and `OnClick` handlers in `pcall` for better error reporting

## Talent Logic
- [ ] Verify `ImportToWoW` logic and add "Build applied" confirmation

## Finalization
- [ ] Push to Git
- [ ] Final instructions for clean reinstall
