# Walkthrough - Dragon Skill v2.0.8 "Persistent AI Coach"

Dieses Update löst das Problem des verschwindenden Chat-Verlaufs bei einem Neuladen des Interfaces.

## Wichtigste Neuerungen

### 1. Permanenter Chat-Verlauf (Reload-Safe)
Bisher wurde der Chat-Verlauf beim Klicken auf "Antwort abholen" (Reload) gelöscht.
- **Lösung**: Der gesamte Chat-Verlauf wird jetzt in der Datenbank (`DragonSkillDB.history`) gespeichert.
- **Vorteil**: Wenn du die KI-Antwort abholst und WoW neulädt, bleiben deine Frage und alle vorherigen Nachrichten **vollständig erhalten**. Du kannst die Antwort der KI jetzt also ganz in Ruhe lesen.

### 2. Optimierter Synchronisations-Prozess
Der Workflow für die externe KI (Claude/OpenAI) ist jetzt absolut sicher:
1. Frage im Addon stellen.
2. Kurz warten, bis das Desktop-Programm "Fertig" meldet.
3. In WoW auf **"KI-Antwort abholen"** klicken.
4. Nach dem automatischen Reload ist die Antwort der KI **direkt im Chat-Fenster** sichtbar.

### 3. Local Engine Stabilität
- Der interne Coach antwortet weiterhin sofort und ohne Verzögerung auf alle Gear-bezogenen Fakten.
- Die Nachrichten werden nun in Echtzeit in den permanenten Speicher geschrieben.

## Verifizierung
- [x] Chat-Test: Nachricht schreiben -> `/reload` -> Nachricht ist noch da.
- [x] KI-Test: Anfrage an Claude senden -> Reload -> KI-Antwort erscheint im Verlauf.
- [x] Limitierung: Der Verlauf speichert die letzten 10 Nachrichten, um die Datenbank klein zu halten.

## Installation
1. WoW beenden.
2. Alten `DragonSkill` Ordner löschen.
3. Neuen v2.0.8 Stand kopieren.
4. WoW starten und den dauerhaften Chat genießen!
