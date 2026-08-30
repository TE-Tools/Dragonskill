# Walkthrough - Dragon Skill v1.8.1 "Contextual AI Coach"

Dieses Update erweitert den **AI Coach** um intelligentes Kontext-Bewusstsein, Zeit-Optimierung und die Vorbereitung für externe KI-Anbindungen.

## Neue Kern-Funktionen

### 1. Kontext-Bewusstsein (Contextual Memory)
Der Coach merkt sich jetzt, worüber ihr gerade sprecht.
- **Beispiel**:
  - *Du*: "Was ist mein größtes Upgrade?"
  - *Coach*: "Das ist [Item X] aus Dungeon Y."
  - *Du*: "Wo ist das?"
  - *Coach*: "Dungeon Y befindet sich in..."
- Das System merkt sich das zuletzt erwähnte Item und den Dungeon, um Folgefragen präzise zu beantworten.

### 2. Zeit-Optimierung (Planner v1.2)
Du kannst den Coach jetzt nach Zeitvorgaben fragen:
- *"Ich habe nur 30 Minuten, was soll ich machen?"*
- *"Welche Route ist am effektivsten für eine Stunde?"*
- Der Coach berechnet basierend auf dem `GearManager` die effizienteste Aktivität für dein Zeitfenster.

### 3. KI-Einstellungen (Mode 2)
In Vorbereitung auf die externe KI-Integration (OpenAI) gibt es jetzt einen Button **"KI Einstellungen"** im Coach-Tab.
- Nutzer können dort ihren eigenen **API-Key** hinterlegen.
- Das System ist so vorbereitet, dass es zukünftig die lokale Fakten-Engine mit der Sprachgewalt von OpenAI kombiniert.

### 4. Visuelle Verbesserungen
- **Chat-Layout**: Das Chat-Fenster wurde optisch aufgewertet (dunkler Hintergrund, bessere Abstände).
- **Tooltips**: Die interaktiven Reihen im Dashboard und Farm-Plan wurden weiter stabilisiert.

## Verifizierung
- [x] Kontext-Check: "Wo droppt das?" nach Item-Anfrage funktioniert.
- [x] Zeit-Check: Empfehlungen ändern sich je nach Minutenangabe (30 vs 60 min).
- [x] Taschen-Scanner: Erkennt weiterhin Upgrades im Inventar.
- [x] API-Key Popup: Speichert den Schlüssel sicher in der `SavedVariables`.

## Installation
1. WoW beenden.
2. Alten Ordner löschen.
3. Neuen v1.8.1 Stand kopieren.
4. `/ds` -> Tab "AI Coach" nutzen.
