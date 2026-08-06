# Pull request: feat: auto-create skilling + detailed stats UI

This PR implements automatic creation of "skilling" favorites from guide talent builds and improves the stats UI.

Summary
- Database: add CreateSkilling(name, data) and GenerateAutoSkillingName() to save auto-created skilling entries in DragonSkillDB.favorites.
- Talent UI: replace the old "Copy" button with "Create Skilling". Clicking creates a favorite, copies the import-string to the clipboard (if available), and shows a popup with the import string.
- Stats UI: parse stat-priority text from guide data and display recognized stat names and the player's current values where available.

Testing steps
1. Checkout the feature branch:
   git fetch origin feature/auto-create-skilling-detailed-stats && git checkout feature/auto-create-skilling-detailed-stats
2. Reload the UI in-game or restart WoW.
3. Open the addon: /dragonskill
4. Talents tab: click "Create Skilling" for a build. Confirm that a popup appears and the import-string is shown. The import-string should also be in your clipboard (if the client supports SetClipboard).
5. Verify the SavedVariables: DragonSkillDB.favorites contains a new entry with createdAt, importString and metadata.
6. Stats tab: check that stat priorities are listed and show current values (or n/a if not available).

Notes
- This PR focuses on UI/UX and saved-data flow. No external APIs are called.
- Further improvements planned in followups: better stat parsing/normalization, richer diff UI for talents, optional PR creation to upstream (if desired).

