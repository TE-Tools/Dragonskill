# Release notes — post-merge/improvements

Version: post-merge patch (no tag)

Summary:
- Feature: "Auto create skilling" — Create an importable skilling string from a guide/build.
- Improvement: Stat normalization utility (NormalizeStatName) for better parsing of stat priorities.
- Improvement: Talent diff summarizer + tooltip support for clearer comparisons.

Files added/changed (high level):
- addon/Modules/TalentCompare/UI.lua (Create Skilling UI & popup)
- addon/Modules/TalentCompare/diff_summary.lua (diff summarizer + tooltip)
- addon/Modules/Stats/normalize.lua (stat normalization/mappings)

Testing:
- See TESTING/FEATURE-auto-create-skilling-detailed-stats.md for manual test steps.

Next steps:
- Add additional stat synonyms and edge-case parsing improvements.
- Add automated unit tests for NormalizeStatName and diff summarizer.
- Consider adding a Percent-Diff toggle in the diff UI as a follow-up PR.
