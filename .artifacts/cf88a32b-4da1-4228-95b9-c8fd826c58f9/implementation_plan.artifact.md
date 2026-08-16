# Implementation Plan - The Grand Finale (v1.2.0)

Dieses Update schließt den "Venomous Abyss" Raid ab, führt intelligente Tooltips ein und bereinigt die Datenanzeige für ein professionelles Erlebnis.

## User Review Required

> [!IMPORTANT]
> **Raid-Abschluss (Boss 7 & 8)**: Wir fügen die Module für "The Coiled Altar" und "Ula’tek" hinzu.
> - **Ula’tek (Finaler Boss)**: Beinhaltet Tracking für Eier-Management (Devourer’s Spawn) und Plattform-Verlust.
> - **Coiled Altar**: Beinhaltet Tracking für Gift-Orbs (Coalesced Venom) und Mind-Control-Shields.

> [!IMPORTANT]
> **BiS-Tooltips**: Wenn du über ein Item fährst, das in deiner BiS-Liste (Wowhead) steht, zeigt das Addon nun automatisch einen goldenen Text: **"Dragon Skill: Best-in-Slot"**.

> [!NOTE]
> **Neuer Tab: Buffs**: Wir fügen einen 8. Reiter hinzu, der Food, Flasks, Potions und Runen übersichtlich auflistet.

## Proposed Changes

### 1. Boss Mechanics (Finale)

#### [NEW] [CoiledAltar.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/CoiledAltar.lua)
- Tracking von Gift-Orbs und deren Ablegeplätzen.
- Warnung bei Mind Control (Dreadmarch).

#### [NEW] [Ulatek.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Bosses/Ulatek.lua)
- Überwachung der Gift-Wellen (Caustic Waves).
- Timer für den Plattform-Verlust in Phase 3.

#### [MODIFY] [Core.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/BossMechanics/Core.lua)
- Hinzufügen der neuen Slash-Commands: `/ds testaltar` und `/ds testulatek`.

---

### 2. UI & Features

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/TalentCompare/UI.lua)
- **Buffs-Tab**: Integration der Consumables aus den Guide-Daten.
- **Data Cleanup**: Automatisches Filtern von Header-Zeilen ("Slot", "Item") in der Gear-Liste.
- **Scroll-Anpassung**: Der Scroll-Inhalt wird automatisch auf die richtige Höhe gesetzt.

#### [MODIFY] [Tooltips.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/Modules/Tooltips/Tooltips.lua)
- Implementierung des BiS-Scanners: Gleicht die `itemId` des Tooltips mit der `bisGear` Liste deiner aktuellen Spec ab.

---

### 3. Metadata

#### [MODIFY] [DragonSkill.toc](file:///C:/Users/thoma/StudioProjects/Dragonskill/addon/DragonSkill.toc)
- Version auf `1.2.0` anheben.
- Registrierung aller neuen Dateien.

## Verification Plan

### Manual Verification
1. **/ds** -> Neuen Tab "Buffs" prüfen.
2. **Gear-Tab** -> Prüfen, ob die Zeile "Slot | Item | Source" verschwunden ist.
3. **Item-Hover** -> Im Abenteuerführer oder Inventar ein BiS-Item anschauen -> Goldener Text muss erscheinen.
4. **/ds testulatek** -> Test der Final-Boss Logik.
