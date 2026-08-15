# Task: Dragon Skill v1.0.0 - Coordination Update

## Metadata & Core
- [ ] Update `DragonSkill.toc` to v1.0.0 and add new files
- [ ] Update `Modules/BossMechanics/Core.lua` with new simulation commands and sound triggers

## Sszorak Module
- [ ] Create `Modules/BossMechanics/Bosses/Sszorak.lua`
- [ ] Implement Wind Tunnel orb tracking logic
- [ ] Implement Cyst placement assignment

## Twin Fangs Module
- [ ] Create `Modules/BossMechanics/Bosses/TwinFangs.lua`
- [ ] Implement Eternal Venom stack monitoring (UnitAura scanner)
- [ ] Implement priority list for Ravenous Feast

## UI & Visuals
- [ ] Update `Modules/BossMechanics/UI.lua` with Glow support and stack indicators
- [ ] Add sound files or Blizzard sound triggers for critical events

## Final Verification
- [ ] Test `/ds testsszorak`
- [ ] Test `/ds testfangs`
- [ ] Verify stack-based color coding in UI
