# Walkthrough - Dragon Skill v1.8.2 "Upgrade Matrix & Coach Logic"

Dieses Update liefert die detaillierte **Upgrade-Matrix** und macht den **AI Coach** deutlich gesprächiger und intelligenter.

## Wichtigste Neuerungen

### 1. Upgrade-Matrix (Detaillierte Analyse)
Der Reiter "Upgrades" wurde komplett umgebaut.
- **Prozentuale Bewertung**: Du siehst jetzt exakt, um wie viel Prozent (+X.X%) ein Item deinen Charakter verbessert.
- **Breaking News**: Der `GearManager` berechnet nun live die Differenz zwischen deinem aktuell ausgerüsteten Item und dem potenziellen Drop.
- **Pool-System**: Die Anzeige ist jetzt deutlich sauberer und zeigt Icons sowie interaktive Tooltips für jedes Upgrade-Ziel an.

### 2. Intelligenter Coach ("Warum?")
Die Chat-Engine wurde um logische Erklärungen erweitert.
- **Warum-Fragen**: Du kannst den Coach jetzt fragen: *"Warum ist dieses Item besser?"*. Er erklärt dir dann den prozentualen Gewinn und weist auf Set-Boni oder Sondereffekte hin.
- **Folgefragen**: Das Kontext-Gedächtnis wurde geschärft. Wenn ihr über ein Item sprecht, weiß der Coach bei der nächsten Frage ("Wo droppt das?"), welches Item gemeint ist.
- **Zeit-Planer**: Er berechnet nun noch präziser, was du in 30, 60 oder 120 Minuten am besten erledigen solltest.

### 3. Technische Stabilität (v1.7.8 Refined)
- **LUA-Sicherheit**: Alle UI-Aufrufe sind nun durch `pcall` geschützt. Das Addon wird nie wieder komplett abstürzen (kein "nil value" Error mehr).
- **Event-Sicherheit**: Die `ADDON_ACTION_FORBIDDEN` Fehler wurden durch einen neuen benannten Event-Frame final gestoppt.
- **Bereinigte Reiter**: Kein Text-Matsch mehr beim Wechseln der Tabs.

## Verifizierung
- [x] Dashboard: Zeigt Upgrades mit %-Werten an.
- [x] Upgrades: Zeigt die vollständige Matrix mit Icons und Tooltips.
- [x] Coach: Beantwortet "Warum?" Fragen basierend auf dem Gesprächsverlauf.
- [x] Kontext: "Wo droppt das?" bezieht sich korrekt auf das letzte Item.

## Installation
1. WoW beenden.
2. Alten `DragonSkill` Ordner löschen.
3. Neuen v1.8.2 Stand kopieren.
4. `/ds` nutzen und den Coach nach seinem Wissen fragen!
