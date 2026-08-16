# Implementation Plan - Talent Import & Data Pipeline Recovery (v1.2.6)

Dieses Update behebt den kritischen Fehler beim Talent-Import ("Blizzard API nicht gefunden") und repariert die Daten-Extraktion für Verzauberungen, Buffs und Trinkets.

## User Review Required

> [!IMPORTANT]
> **Talent-Import Fix**: Blizzard hat in 12.1 die Struktur des Talent-Fensters geändert. Ich habe den Pfad zur Import-Funktion angepasst (`ClassTalentFrame.TalentsTab` -> `ClassTalentFrame`), damit "Neu anlegen" wieder funktioniert.
> [!IMPORTANT]
> **Daten-Reparatur**: Ich habe die Suchmuster für Wowhead komplett überarbeitet. Überschriften für Enchants, Gems und Consumables werden nun auch gefunden, wenn sie in farbigem Text oder neuen Überschriften-Tags (`[h2]`, `[h3]`) stehen.

## Proposed Changes

### 1. Talent Interaction (UI.lua & TalentCompare.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- **Dialog-Fix**: Korrektur der Datenübergabe im `StaticPopup`. Wir stellen sicher, dass das `build` Objekt korrekt an die "Kopieren" und "Importieren" Boxen weitergereicht wird.
- **Header-Filter**: Aggressiverer Filter für Tabellen-Header ("Slot", "Item", "Source" etc. in allen Schreibweisen), damit die Gear-Listen sauber sind.

#### [MODIFY] [TalentCompare.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/TalentCompare.lua)
- **API-Fallback**: Hinzufügen von Fallbacks für den Blizzard-Import. Wenn `TalentsTab` nicht gefunden wird, probieren wir es direkt über das Hauptframe oder die neue 12.1 `ImportLoadout` Schnittstelle.

---

### 2. Scraper & Data Pipeline

#### [MODIFY] [scrape-wowhead.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-wowhead.js)
- **Regex Update**: Unterstützung für verschachtelte BBCodes in Überschriften (z.B. `[h3][b]Best Enchants[/b][/h3]`).
- **Trinket Extraction**: Neue Logik zum Finden von Trinket-Tabellen auf Wowhead, falls Archon keine Daten liefert.

#### [MODIFY] [scrape-archon.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/scraper/scrape-archon.js)
- Fix der Komponentennamen für das Trinket-Tracking (Unterstützung für `BuildsRecommendationSection`).

## Verification Plan

### Manual Verification
1. **/ds** -> Tab "Talente".
2. **Klick auf Build** -> "Kopieren" wählen -> Prüfen, ob der String im Feld erscheint.
3. **Klick auf Build** -> "Neu anlegen" wählen -> Prüfen, ob der neue Slot im WoW-Talentbaum erscheint.
4. **Gear-Check**: Prüfen, ob die Listen nun keine "Slot/Item" Header mehr enthalten.
5. **Daten-Check**: Prüfen, ob "Enchants" und "Buffs" nun befüllt sind (erfordert Neukopieren der `GuideData.lua`).
