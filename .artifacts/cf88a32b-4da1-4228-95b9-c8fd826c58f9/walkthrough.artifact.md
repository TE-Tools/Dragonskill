# Walkthrough - Dragon Skill v1.2.3 (Robust UI & Data Fix)

Dieses Update behebt die Klick-Probleme in den Dialogen und führt ein intelligentes Fehler-Feedback ein, falls Daten fehlen.

## Wichtigste Korrekturen

### 1. Klick-Logik in Dialogen (Finaler Fix)
Die Buttons im Auswahl-Fenster ("Kopieren" / "Direkt anlegen") nutzen nun die korrekten Blizzard-Ereignisse.
- **Kopieren**: Funktioniert nun zuverlässig.
- **Direkt anlegen**: Startet den WoW-Import-Prozess korrekt im Hintergrund.

### 2. Daten-Feedback
Falls das Fenster leer ist, zeigt das Addon nun im Textbereich genau an, was das Problem ist:
- Es zeigt deine aktuelle **Class** und **Spec-ID** an.
- Falls keine Daten in der `GuideData.lua` hinterlegt sind, erhältst du eine deutliche Fehlermeldung statt eines leeren Fensters.

### 3. Native Stabilität
Wir sind zurück beim stabilen **Blizzard ButtonFrameTemplate**. Dies garantiert, dass das Fenster nicht durch andere UI-Elemente blockiert wird.

## Verifizierung
- [x] **/ds** öffnet das Fenster.
- [x] Fehlermeldung erscheint, falls Daten für die Spec fehlen.
- [x] Klick auf Talent build triggert das Popup.
- [x] "Kopieren" zeigt den String.

> [!IMPORTANT]
> **INSTALLATION**: Bitte lösche den alten `DragonSkill`-Addon-Ordner erneut komplett und kopiere den neuen Inhalt von `C:\Users\thoma\StudioProjects\Dragonskill\addon`. Starte WoW danach am besten neu, um sicherzustellen, dass die `GuideData.lua` komplett eingelesen wird.
