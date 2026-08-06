## Testing checklist — Dragonskill feature/auto-create-skilling-detailed-stats

Manual test steps (in-game):

1) Vorbereitung
   - Checkout branch: post-merge/improvements (oder die gemergte Ziel-Branch)
   - Reload UI oder restart WoW
   - Öffne das Addon: /dragonskill

2) Create Skilling (Talent tab)
   - Öffne einen Guide / Build im Talent-Tab
   - Klicke „Anlage erstellen" (Create Skilling)
   - Erwartet: Popup erscheint mit dem Import-String
   - Falls der Client SetClipboard erlaubt: Import-String ist in der Zwischenablage
   - Überprüfe SavedVariables (SavedVariables/DragonSkillDB.lua): ein neuer Eintrag in DragonSkillDB.favorites mit importString, provider, label, context, createdAt

3) Diff‑Zusammenfassung (Talent Compare)
   - Wähle zwei Builds zum Vergleichen
   - Erwartet: die Diff-Übersicht zeigt eine kurze Zusammenfassung: "X Abweichungen — Positionen: a,b,c, +N more"
   - Tooltip (hover) zeigt bis zu 20 Positionen oder eine detaillierte Liste

4) Stats‑Parsing
   - Öffne Stats-Tab für einen Guide mit Stat-Priorities (z. B. "Crit > Haste > Mastery")
   - Erwartet: erkannte Stat-Namen (CriticalStrike, Haste, Mastery, ...) und die aktuellen Char-Werte daneben oder "n/a"

5) Changelog & Release Notes
   - Prüfe RELEASE_NOTES.md im Repo

Example SavedVariables snippet (für Reviewer):

DragonSkillDB = {
  profileKeys = { ["Player - Server"] = "Default" },
  favorites = {
    ["AutoSkilling-1"] = {
       importString = "SOMEIMPORTSTRING",
       provider = "GuideProvider",
       label = "Guide Label",
       context = { guideId = 12345 },
       createdAt = 1691300000
    }
  }
}

Notes:
- If clipboard doesn't work on your client, the popup still contains the import-string which you can copy manually.
- If you find parsing mismatches, copy a sample guide-text here and I'll refine the mapping.
