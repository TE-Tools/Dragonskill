# Walkthrough - Dragon Skill v1.9.0 "The Real AI Bridge"

Dieses Update schaltet die Anbindung an echte KIs (wie OpenAI) frei, indem es eine Brücke zwischen World of Warcraft und deinem Desktop schlägt.

## Neue Kern-Funktionen

### 1. Echte KI-Anbindung (Mode 2 & 3)
Da WoW-Addons nicht direkt mit dem Internet sprechen können, habe ich eine "AI Bridge" entwickelt.
- **Addon-Seite**: Wenn du einen API-Key in den Einstellungen hinterlegst, sendet der Coach deine Fragen an einen speziellen Speicherbereich in der `DragonSkill.lua` (SavedVariables).
- **Desktop-Seite**: Ich habe das Skript `DragonSkillBridge.js` erstellt. Dieses kleine Programm läuft auf deinem PC, liest die Fragen aus WoW aus, schickt sie an OpenAI und schreibt die Antwort zurück in das Spiel.

### 2. Hybrid-Engine (Fakten + Intelligenz)
- **Lokale Engine**: Beantwortet weiterhin sofort alle Fragen zu Dungeons, BiS und Upgrades (Fakten-Basis).
- **Real-AI**: Übernimmt, sobald komplexere Fragen gestellt werden, und nutzt die lokalen Fakten als Kontext, um dir eine menschenähnliche Antwort zu geben.

### 3. Desktop Bridge App
Ich habe die Datei [DragonSkillBridge.js](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkillBridge.js) in deinem Projektordner erstellt.
- **Anleitung**:
  1. Setze deinen OpenAI Key in WoW unter `/ds -> AI Coach -> KI-Key setzen`.
  2. Starte die Bridge auf deinem PC (Befehl: `node DragonSkillBridge.js`).
  3. Stelle eine Frage im Spiel.
  4. Die Bridge verarbeitet die Antwort und du erhältst sie im Spiel (nach einem kurzen `/reload`).

### 4. Inventar-Scan & Kontext
- Der Coach scannt weiterhin deine Taschen nach Upgrades.
- Er merkt sich den Gesprächsverlauf, um auf "Warum?" oder "Wo?" reagieren zu können.

## Verifizierung
- [x] AI Bridge Logik: Exportiert Kontext (Klasse, Spec, Upgrades) an die SavedVariables.
- [x] UI: Neuer Button "KI-Key setzen" und Kennzeichnung von "Real-AI" Antworten.
- [x] Datenbank: Vorbereitung der `ai` Tabelle in der `SavedVariables`.

## Installation
1. WoW beenden.
2. Alten Ordner löschen und v1.9.0 kopieren.
3. **Optional**: `DragonSkillBridge.js` im Projektordner mit deinem WoW-Pfad konfigurieren und starten.
