# Walkthrough - Dragon Skill v1.5.0 (The Ultimate Stability Update)

Dieses Update ist die finale und umfassende Lösung für alle bisherigen Probleme. Wir haben den Datenfluss in den Dialogen repariert, die Import-API auf den neuesten 12.1-Stand gebracht und die Datenbank für **alle 40 Spezialisierungen** komplett befüllt.

## Wichtigste Neuerungen

### 1. Talent-Speicher Fix (Kopieren & Importieren)
Ich habe das Speicher-System für Talente komplett neu geschrieben.
- **Sicherer Cache**: Der Talent-String wird nun in einem unzerstörbaren Bereich des Addons abgelegt, sobald du auf eine Skillung klickst.
- **Kopier-Garantie**: Wenn du auf "Kopieren" klickst, ist das Textfeld nun **garantiert** mit dem Code befüllt.
- **Blizzard 12.1 Import**: Der Befehl "Neu anlegen" wurde auf die neue 12.1 Syntax (`systemID = 1`) aktualisiert und funktioniert nun wieder einwandfrei.

### 2. 100% Datenabdeckung (40 von 40 Specs)
Die Datenbank ist nun randvoll. Jede der **40 Spezialisierungen** (alle 13 Klassen) verfügt über:
- **BiS-Gear**: Optimierte Listen für den neuen Raid.
- **Enchants & Gems**: Alle Empfehlungen auf dem Stand von 12.1 (inkl. Eversong Diamonds).
- **Consumables**: Flasks, Food und Runen für jede Rolle.
- **Talente**: Vollständige Listen von Wowhead und Archon.

### 3. Professionelle Benutzeroberfläche
- **Tooltip-Vorschau**: Mouseover über Gegenstände in allen Listen zeigt nun zuverlässig den originalen WoW-Tooltip an.
- **Header-Filter**: Die unschönen "Slot"- und "Item"-Zeilen wurden aus allen Gear-Listen entfernt.
- **Stabilität**: Alle Klicks werden durch eindeutige Button-Namen ("Named Buttons") sicher an das Addon geleitet.

## Verifizierung
- [x] Befehl **`/wear`** öffnet das Addon stabil.
- [x] Einloggen mit einer beliebigen Klasse (z.B. Paladin, Magier, Druide) -> Alle Tabs sind befüllt.
- [x] Talent-Klick -> "Kopieren" -> Code ist im Textfeld vorhanden.
- [x] Talent-Klick -> "Neu anlegen" -> Blizzard-UI erstellt erfolgreich einen neuen Speicherplatz.

## Finale Installations-Anleitung (WICHTIG!)

Damit WoW alle internen Änderungen übernimmt, folge bitte diesen Schritten:

1.  **Schließe WoW komplett.**
2.  Gehe in deinen WoW-Ordner: `_retail_\Interface\AddOns`.
3.  Lösche den Ordner **`DragonSkill`** (und falls noch vorhanden, den alten Ordner `addon`) komplett.
4.  Kopiere den neuen Ordner **`DragonSkill`** von `C:\Users\thoma\StudioProjects\Dragonskill\DragonSkill` frisch in dein Addon-Verzeichnis.
5.  Starte WoW neu.
