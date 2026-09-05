# Dragon Skill - AI Developer Guide (v2.5.0)

This document is intended for AI agents (like Claude, GPT, etc.) to quickly understand the project architecture and the logic for WoW Patch 12.1 (Midnight Season 2).

## Core Architecture
- **Namespace**: Everything is under `DragonSkill`. Modules are registered via `DragonSkill:RegisterModule`.
- **Database**: `Core/Database.lua` handles SavedVariables (`DragonSkillDB`).
- **Gear Logic**: `Core/GearManager.lua` reads the real per-spec BiS data and exposes `GetBiSList()`, `GetFarmPlan()`, `GetBestUpgrades()`.

## v2.5.0: Real per-spec BiS data (this update)
Previous versions (up to 2.4.2) had a critical bug: `Data/GuideData.lua` was **hand-written** with only 4 generic buckets (`healer` / `tank` / `melee` / `caster`), and every spec sharing a role got the **exact same ~9-16 items** regardless of class or weapon type (e.g. Hunters — a ranged class — were shown a fist weapon; every melee spec from Rogue to DK to Warrior saw identical gear). On top of that, `GearManager.lua` hard-blocked any item with `itemId < 260000`, which incorrectly filtered out legitimate current-patch crafted items (e.g. Blacksmithing/Leatherworking BiS pieces have IDs as low as ~237000-244000).

This has been replaced:
- `Data/GuideData.lua` is now **auto-generated** by `scraper/build-data.js` from `scraper/data-raw/<CLASS>_<SPECID>.json` — one real BiS list per spec (all 40 specs, including the new Devourer Demon Hunter spec 1480), scraped directly from each class+spec's own German Wowhead `bis-gear` guide page (slot, item name, item ID, and **source** — which boss/dungeon/crafting profession it comes from).
- `Core/GearManager.lua` no longer re-guesses armor type, weapon type, or item-ID range in Lua. `IsItemValidForSpec` is now just a sanity check (`itemId > 0`). We trust the per-spec source data because Wowhead's own guide for that class+spec is already correct.
- `GetFarmPlan()` no longer uses a small hand-maintained dungeon/boss loot table. It groups the player's own real per-spec BiS list by the `source` field Wowhead gave each item (e.g. "Ula'tek", "The Coiled Altar", "Crafting"), so "what do I need to farm" is always in sync with the actual BiS list.
- Fixed a latent bug where `Character:GetInventoryUpgrades()` called `GearManager:GetUpgradeScore(...)`, a method that never existed — added it.

### Re-running the scraper
```
cd scraper
node scrape-all.js --list spec-list.json --outDir data-raw   # (optional refresh from live Wowhead, if network access is available)
node build-data.js --dataDir data-raw --out ../DragonSkill/Data/GuideData.lua
```
Note: the sandboxed cloud dev environment used to build this update could **not** reach wowhead.com directly via a shell/curl (egress-blocked), but the `WebFetch` tool and a real browser (claude-in-chrome) could. The `data-raw/*.json` files were populated by scraping the live German Wowhead guide pages that way, one per spec, then run through `build-data.js` as normal. If you re-run the Node scraper (`scrape-wowhead.js`/`scrape-archon.js`) from a machine with normal internet access, it should work directly.

## Patch 12.1 (Midnight Season 2) Logic
- **Mythic Target**: Standard ilvl for BiS is **639+** (Wowhead's guide pages did not expose an ilvl column at scrape time, so `GetItemScore` still defaults to 639 when no ilvl is known).
- **Class Filtering**: no longer done in Lua — each spec's `bisGear.wowhead` list already only contains items valid for that class+spec, because it was scraped from that class+spec's own Wowhead guide.
- **Slot names**: `GearManager:NormalizeSlot` maps both German and English slot labels (Wowhead renders some pages' slot column in English even on the DE locale) to the canonical keys used by `Character:GetCurrentGear()` (Head/Neck/Shoulder/Back/Chest/Wrist/Hands/Waist/Legs/Feet/Ring/Trinket/MainHand/OffHand).

## UI Theme (v2.5.0)
`Core/Theme.lua` is a small shared module (`DragonSkill.Theme` / `DragonSkill:GetModule("Theme")`) used by `Modules/TalentCompare/UI.lua` and `Modules/AICoach/ChatUI.lua` for a consistent modern flat/dark look: the player's class color as a single accent used everywhere (top accent bar, active tab underline, header name, hover states, "BiS"/upgrade tags), flat hairline-bordered "card" panels (`Theme:Panel(parent, bgColor, borderColor)`) instead of the classic beveled tooltip border, and icon-forward two-line item rows (name on top, slot/source as a muted subtitle) instead of single plain text lines. No bundled art assets are required - it's built entirely from `CreateTexture`/`SetColorTexture` and existing Blizzard font objects.

Important gotcha if you touch this: WoW stacks whole child frames by frame level, not by texture layer across frames - a texture drawn directly on a frame that has an opaque higher-level child covering it (like the main window's `f` vs. its `skin` background child) will render underneath and never be visible. Any decorative texture meant to sit "on top of the background" (the accent bar, the tab baseline) must be created on `skin` (or another frame at or above its level), not on `f` directly. See the comments in `UI:Init()` for the concrete example.

## Key Files
- `Core/Theme.lua`: shared UI theme/skin helpers (colors, `Panel()`, class-color accent).
- `scraper/spec-list.json`: the 40 class/spec entries with their Wowhead guide URLs.
- `scraper/data-raw/<CLASS>_<SPECID>.json`: raw scraped BiS data per spec (slot, name, itemId, source). Regenerate GuideData.lua from these with `build-data.js`.
- `Data/GuideData.lua`: **auto-generated**, do not hand-edit — real per-spec BiS lists.
- `Data/GearDatabase.lua`: legacy item-name registry + a generic 4-role fallback (`DragonSkillGearData.specs[id].bis.overall`), only used if a spec has zero real data.
- `Core/GearManager.lua`: `GetBiSList()`, `GetFarmPlan()`, `GetBestUpgrades()`.
- `Modules/TalentCompare/UI.lua`: renders the BiS list / farm plan / upgrade matrix tabs.

## GitHub Links
- **Repository**: [https://github.com/TE-Tools/Dragonskill](https://github.com/TE-Tools/Dragonskill)
- **Current Branch**: `claude/dragonskill-projekt-vorbereiten-xx8gho`

## Development Instructions
1. Don't hand-edit `Data/GuideData.lua` — it's generated. Edit `scraper/data-raw/*.json` and re-run `build-data.js`, or re-run the scraper.
2. Use **German names** in the registry for better UI presentation (matches how the addon displays item names).
3. Don't touch `BossMechanics` - it was removed in v2.4.2 to reduce clutter.
4. When adding a new spec/class (e.g. a future new hero spec), add it to `scraper/spec-list.json`, scrape its `bis-gear` guide page, drop the result into `scraper/data-raw/<CLASS>_<SPECID>.json`, and re-run `build-data.js`.
