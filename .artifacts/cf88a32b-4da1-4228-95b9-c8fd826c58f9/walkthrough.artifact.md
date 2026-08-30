# Walkthrough - Dragon Skill v2.1.0 "The Local Expert"

Dieses Update verwandelt den AI Coach in einen echten WoW-Experten, der auch ohne Internetverbindung (lokal) deutlich mehr Fragen beantworten kann.

## Neue Kern-Funktionen

### 1. Massive Wissensdatenbank (Lokal)
Der Coach verfügt jetzt über eine integrierte Fakten-Datenbank für Patch 12.1 (Midnight), die sofort auf folgende Themen antwortet:
- **Dungeon-Taktiken**: Frag nach einem Dungeon (z.B. "Tipp für Murder Row") und erhalte sofort einen strategischen Hinweis für die Bosse.
- **Chemie & Food**: Der Coach weiß jetzt, welche Fläschchen und Buff-Food für deine Rolle (Tank, Heiler, DPS) am besten sind.
- **Berufe & Funken**: Erhalte Tipps zur Nutzung der "Funken der Erneuerung" (Spark of Omen) und Handwerksaufträgen.
- **Talente**: Der Coach empfiehlt dir jetzt aktiv die beste Skillung aus deinem Talente-Tab.
- **Währungen**: Tipps zur optimalen Nutzung von Wappen (Crests) wurden hinzugefügt.

### 2. Intelligente Intent-Erkennung
Die Engine versteht jetzt deutlich mehr Keywords. Du kannst natürlicher fragen:
- *"Was soll ich essen?"*
- *"Welche Skillung ist am besten?"*
- *"Was mache ich mit dem Funken?"*
- *"Hast du Tipps für Altar of Fangs?"*

### 3. Hybrid-Antworten
Wenn du die externe KI (Claude/OpenAI) aktiviert hast, erhältst du jetzt eine **Hybrid-Antwort**:
1. **Sofort**: Der lokale Coach gibt dir die harten Fakten aus der Datenbank.
2. **Parallel**: Die Anfrage wird an Claude gesendet, damit du per Knopfdruck ("KI-Antwort abholen") später noch eine tiefergehende, menschlichere Analyse bekommst.

## Verifizierung
- [x] Lokale Abfrage: "Was soll ich essen?" liefert rollenspezifische Empfehlungen.
- [x] Dungeon-Check: "Tipp für Zul'jan" (im Altar of Fangs) liefert Taktik-Hinweise.
- [x] Persistenz: Der gesamte Chatverlauf bleibt weiterhin über Reloads hinweg gespeichert.

## Installation
1. WoW beenden.
2. Alten `DragonSkill` Ordner löschen.
3. Neuen v2.1.0 Stand kopieren.
4. WoW starten und den Experten befragen!
