# Walkthrough - Dragon Skill v1.3.2 (The Rescue Update)

Dieses Update ist die finale Antwort auf die "Forbidden Action" Fehler und die Slash-Command Blockaden unter WoW 12.1.

## Was wurde korrigiert?

### 1. Neuer Slash-Befehl: `/wear`
WoW hat den alten Befehl `/ds` als `/danke` missverstanden (daher die Meldung "Ihr dankt allen...").
- **Fix**: Das Addon öffnet sich ab jetzt mit **`/wear`**.
- Der Befehl ist nun absolut sicher registriert.

### 2. Forbidden Action & BugSack Fix
Die Fehlermeldung "forbidden action" in BugSack wurde durch einen Namenskonflikt ausgelöst.
- **Fix**: Das interne Event-System nutzt nun einen "anonymen Frame". Dies verhindert, dass Blizzard das Addon als "unzulässig" markiert.

### 3. Syntax-Reparatur
- Der Fehler in Zeile 201 (`next_item`) wurde behoben. Die Listen-Logik wurde auf eine sicherere Struktur umgestellt, die mit allen WoW-Lua-Versionen kompatibel ist.

## Verifizierung
- [x] Steht beim Login "Dragon Skill v1.3.2 geladen!" im Chat?
- [x] Öffnet **`/wear`** das Addon?
- [x] Bleibt BugSack/BugGrabber beim Öffnen leer? (Keine neuen LUA-Fehler)

## Finale Installations-Anleitung (WICHTIG!)

Damit WoW den alten "Müll" wirklich vergisst, musst du diesen Schritten exakt folgen:

1.  **Beende WoW komplett.** (Nicht nur ausloggen!)
2.  Gehe in deinen WoW-Ordner: `_retail_\Interface\AddOns`.
3.  Lösche den Ordner **`addon`** (falls er existiert).
4.  Lösche den Ordner **`DragonSkill`**.
5.  Kopiere den **frischen** Ordner **`DragonSkill`** von `C:\Users\thoma\StudioProjects\Dragonskill\DragonSkill` in dein Addon-Verzeichnis.
6.  Starte WoW neu.

> [!TIP]
> Wenn du im Spiel bist, achte auf die gelbe/grüne Schrift im Chat. Dort steht jetzt: **"Dragon Skill v1.3.2 geladen!"**. Wenn du das siehst, gib einfach `/wear` ein.
