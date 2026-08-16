# Walkthrough - Dragon Skill v1.2.0 (The Grand Finale)

Dieses finale Update schließt den "Venomous Abyss" Raid ab, führt intelligente Tooltips ein und poliert die Benutzeroberfläche für den produktiven Einsatz.

## Wichtigste Neuerungen

### 1. Raid-Vollendung (Boss 7 & 8)
Alle Bosse des aktuellen Raids sind nun vollständig integriert:
- **The Coiled Altar**: Tracking von Gift-Orbs und Mind-Control-Warnungen.
- **Ula’tek (Finale)**: Überwachung der Phasen und der "Caustic Waves" (Eier-Management).
- **Neue Befehle**: Teste die Mechaniken mit `/ds testaltar` und `/ds testulatek`.

### 2. Intelligente BiS-Tooltips
Das Addon hilft dir jetzt direkt beim Looten:
- Wenn du über ein Item fährst, das in deiner **Best-in-Slot** Liste steht (Wowhead) oder ein **S/A-Tier Trinket** (Archon) ist, erscheint im Tooltip ein goldener Text:
  > **Dragon Skill: Best-in-Slot**
- Dies funktioniert im Inventar, im Abenteuerführer und sogar beim Looten im Raid.

### 3. Neuer Reiter: "Buffs"
Ein 8. Tab wurde hinzugefügt, der dir alle raid-relevanten Consumables anzeigt:
- **Food, Flasks, Potions & Runen**: Alles auf einen Blick, basierend auf den aktuellen WoWhead-Guides.

### 4. UI-Cleanup & Stabilität
- **Daten-Filter**: Unnötige Header-Zeilen (wie "Slot | Item") wurden aus den Listen entfernt.
- **8-Tab Support**: Das Menü am unteren Rand wurde für alle 8 Reiter optimiert.
- **Klick-Priorität**: Die Talent-Buttons reagieren nun noch präziser.

## Verifizierung
- [x] Tooltips zeigen "Best-in-Slot" korrekt an.
- [x] Reiter "Buffs" ist befüllt.
- [x] Gear-Liste zeigt keine "Slot"-Header mehr.
- [x] `/ds testulatek` triggert die Final-Boss Warnungen.

> [!TIP]
> **FINALE INSTALLATION**: Bitte lösche den alten `DragonSkill`-Addon-Ordner ein letztes Mal komplett und kopiere den neuen Inhalt von `C:\Users\thoma\StudioProjects\Dragonskill\addon` in dein WoW-Verzeichnis.
