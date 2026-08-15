# Task: Dragon Skill UI Final Reconstruction (v0.6.6)

## UI Overhaul
- [ ] Rewrite `UI:Init` in `UI.lua` using custom Backdrop frame
- [ ] Implement robust Tab system at the bottom (outside main content area)
- [ ] Set `FrameStrata("DIALOG")` for the main window and `FULLSCREEN_DIALOG` for buttons
- [ ] Ensure `ScrollFrame` correctly passes mouse events to children

## Logic Robustness
- [ ] Add `pcall` protection to `TalentCompare:Compare` and `TC:GetDetailedDiff`
- [ ] Add debug print on every button click in `UI.lua`

## Boss Mechanics
- [ ] Ensure Boss UI is also on a high strata to prevent overlap issues

## Finalization
- [ ] Commit & Push to Git
- [ ] Provide final copy instructions
