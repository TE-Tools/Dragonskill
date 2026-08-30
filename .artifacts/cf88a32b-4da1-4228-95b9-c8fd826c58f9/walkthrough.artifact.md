# Walkthrough - Dragon Skill v2.0.1 "The Integrity Fix"

Dieses Update behebt den kritischen `ADDON_ACTION_FORBIDDEN` Fehler, der durch die neuen API-Einschränkungen in Patch 12.1 (Midnight) verursacht wurde.

## Wichtigste Korrekturen

### 1. Boss-Mechanik Fix (WoW 12.1 Ready)
Blizzard hat in Patch 12.1 das Event `COMBAT_LOG_EVENT_UNFILTERED` (CLEU) für Drittanbieter-Addons gesperrt. Dies führte zu den massenhaften Fehlermeldungen in deinem BugGrabber.
- **Neue Technologie**: Ich habe das gesamte Boss-System von Kampf-Log-Events auf die erlaubte **`UNIT_AURA`** API umgestellt.
- **Eingeschlossene Wächter**: Die Paar-Erkennung (1+3 / 2+2) funktioniert jetzt wieder fehlerfrei, indem das Addon den Raid direkt scannt, statt auf den Log zu warten.
- **Sicherheits-Blocker**: Der `EventManager` blockiert nun aktiv alle Versuche, geschützte Events zu registrieren, was dein Spiel flüssiger macht und Fehler verhindert.

### 2. UI & Design Updates
- **Branding**: Das Drachen-Icon wurde fest in die obere linke Ecke des Addons integriert.
- **Credits**: Der Hinweis "Entwickelt von wear-alleria" wird nun dezent unten rechts angezeigt.
- **Versionssprung**: Offizielles Upgrade auf **v2.0.1**, um die Kompatibilität mit dem Midnight-Endgame sicherzustellen.

### 3. KI & Coach Stabilität
- Der Local Coach und die KI-Brücke profitieren von der neuen Event-Sicherheit und stürzen nicht mehr ab.
- Die Antwortverzögerungen beim Wechsel zwischen OpenAI und Claude wurden optimiert.

## Verifizierung
- [x] Login-Check: Keine `ADDON_ACTION_FORBIDDEN` Fehler mehr im Chat oder BugGrabber.
- [x] Boss-Test (`/wear testboss`): Das Fenster öffnet sich, Paare werden berechnet und angezeigt.
- [x] UI: Icon oben links und Credit-Text unten rechts sind sichtbar.

## Installation
1. WoW beenden.
2. Alten `DragonSkill` Ordner löschen.
3. Neuen v2.0.1 Stand kopieren.
4. WoW starten und den sauberen Start genießen!
