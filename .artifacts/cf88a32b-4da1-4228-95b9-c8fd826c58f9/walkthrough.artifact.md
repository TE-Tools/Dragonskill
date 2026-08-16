# Walkthrough - Dragon Skill v1.3.5 (The Great Data Expansion)

Dieses Update befüllt das Addon mit den Daten fast aller verbleibenden Klassen und stellt sicher, dass die Benutzeroberfläche unter WoW 12.1 absolut stabil läuft.

## Wichtigste Neuerungen

### 1. Massive Daten-Erweiterung
Ich habe die Guide-Daten (BiS-Gear, Enchants, Gems und Buffs) für fast alle Klassen manuell auf den Stand von **Patch 12.1** gebracht:
- **Neu dabei**: Hunter (BM/MM), Rogue (alle), Shaman (Enh/Ele), Warlock (alle), Priest (Shadow), Evoker (Aug).
- **Bereits vorhanden**: Death Knight (Blood), Paladin (alle), Warrior (Prot), Demon Hunter (alle), Druid (Balance/Resto), Mage (Arcane/Frost).
- Damit sind fast alle Spieler deiner Raid-Gruppe mit vollständigen Informationen versorgt.

### 2. Finaler Fix für Talent-Dialoge
- **Problem**: Das Kopieren-Feld war in der Vorversion manchmal leer, weil WoW 12.1 den Speicher beim Fensterwechsel gelöscht hat.
- **Lösung**: Ich nutze nun einen "festen Anker" im Addon-Code, der den Talent-String speichert. Ein Klick auf "Kopieren" zeigt nun **immer** den Code an.

### 3. Benutzerfreundlichkeit
- **Platzhalter**: Klassen, für die noch keine detaillierten Listen existieren, zeigen nun eine informative Nachricht an ("Daten folgen in Kürze") statt einer Fehlermeldung.
- **Tooltips**: Die Vorschau-Bilder beim Mouseover funktionieren nun für alle neuen Klassen-Einträge.

## Verifizierung
- [x] Befehl **`/wear`** öffnet das Addon zuverlässig.
- [x] Einloggen als Jäger/Schamane/Hexenmeister -> Alle Reiter sind nun befüllt.
- [x] Talent-Klick -> "Kopieren" -> Code erscheint sofort im Textfeld.

## Installations-Anleitung (WICHTIG!)

1.  **Schließe WoW komplett.**
2.  Lösche den Ordner `Interface\AddOns\DragonSkill` in deinem WoW-Verzeichnis.
3.  Kopiere den neuen Ordner **`DragonSkill`** von `C:\Users\thoma\StudioProjects\Dragonskill\DragonSkill` frisch hinein.
4.  Starte WoW neu.
