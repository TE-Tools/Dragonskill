# Walkthrough - Dragon Skill v0.9.0 (Patch 12.1 Ready)

Dieses Update bereitet das Addon auf den **Patch 12.1 (Curse of Ula’tek)** vor und fügt neue Bossmechaniken hinzu.

## Wichtigste Änderungen

### 1. Patch 12.1 Kompatibilität
- **Interface Update**: Die `.toc` wurde auf `120100` hochgesetzt.
- **Multi-System Traits**: Die Talent-Logik wurde angepasst, um Blizzards neue System-IDs (Klassentalente vs. Hausbau etc.) korrekt zu unterscheiden.
- **Serialization V2**: Vorbereitung für das neue Talent-String-Format von 12.1.

### 2. Neuer Boss: Vashnik the Malignant
Das Bossmodul für den 4. Boss im Venomous Abyss wurde hinzugefügt.
- **Quadrant Tracking**: Überwachung der Gift-Bereiche im Raum.
- **Testmodus**: Simulierbar mit **`/ds testvashnik`**.

### 3. Boss Mechanics Polish
- **Lost Explorers**: Das Modul für den 3. Boss wurde vervollständigt und in die `.toc` aufgenommen.
- **Simulation Sync**: Alle Boss-Simulationen wurden stabilisiert und reagieren nun zuverlässig auf die neuen Slash-Commands.

## Verifizierung
- [x] Interface-Version `120100` wird von WoW erkannt.
- [x] Talent-Abgleich nutzt dynamische System-IDs.
- [x] `/ds testexplorers` und `/ds testvashnik` triggern die jeweiligen UIs.

> [!CAUTION]
> **WICHTIG**: Da Blizzard in 12.1 das Format der Talent-Strings geändert hat, funktionieren sehr alte gespeicherte Builds (von v0.6 und früher) möglicherweise nicht mehr perfekt, bis sie einmal neu importiert wurden.
