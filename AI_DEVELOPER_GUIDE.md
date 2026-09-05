# Dragon Skill - AI Developer Guide (v2.4.2)

This document is intended for AI agents (like Claude, GPT, etc.) to quickly understand the project architecture and the logic for WoW Patch 12.1 (Midnight Season 2).

## Core Architecture
- **Namespace**: Everything is under `DragonSkill`. Modules are registered via `DragonSkill:RegisterModule`.
- **Database**: `Core/Database.lua` handles SavedVariables (`DragonSkillDB`).
- **Gear Logic**: `Core/GearManager.lua` is the brain. It calculates scores and filters items.

## Patch 12.1 (Midnight Season 2) Logic
- **ItemID Purity**: Items with ID < 260,000 are blocked (Legacy/Season 1).
- **Mythic Target**: Standard ilvl for BiS is **639+**.
- **Class Filtering**: `GearManager.lua` contains `CLASS_WEAPON_CHECK` and `CLASS_ARMOR` tables. 
    - Druids cannot see Axes/Swords.
    - Paladins only see Plate.
    - Healers never see Agility/Strength trinkets.

## Key Files
- `Data/GearDatabase.lua`: Local registry of 12.1 items with localized names.
- `Data/GuideData.lua`: BiS lists for all 40 specializations.
- `Modules/TalentCompare/UI.lua`: The "Midnight Modern" design logic.

## GitHub Links
- **Repository**: [https://github.com/TE-Tools/Dragonskill](https://github.com/TE-Tools/Dragonskill)
- **Current Branch**: `claude/dragonskill-projekt-vorbereiten-xx8gho`
- **Main Guide**: [AI_DEVELOPER_GUIDE.md](https://github.com/TE-Tools/Dragonskill/blob/claude/dragonskill-projekt-vorbereiten-xx8gho/AI_DEVELOPER_GUIDE.md)

## Development Instructions
1. Always maintain the **Purity Check** (ID >= 260000).
2. Use **German names** in the registry for better UI presentation.
3. Don't touch `BossMechanics` - it was removed in v2.4.2 to reduce clutter.
