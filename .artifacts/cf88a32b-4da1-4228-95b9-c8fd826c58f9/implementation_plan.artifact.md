# Implementation Plan - Emergency Repair & Slash Command Refactor (v1.3.2)

Dieses Update behebt den kritischen LUA-Fehler, der das Addon blockiert, und stellt die Funktionalität des Slash-Commands unter dem neuen Namen `/wear` wieder her.

## User Review Required

> [!IMPORTANT]
> **Neuer Slash-Befehl**: Das Addon öffnet sich ab jetzt mit **`/wear`** (statt `/ds`). Dies verhindert Konflikte mit WoW-Standard-Emotes wie `/danke`.
> [!IMPORTANT]
> **Forbidden Action Fix**: Die Fehlermeldung "Forbidden Action" wird behoben, indem wir für Events einen anonymen Frame nutzen. Blizzard erlaubt bei benannten Frames in 12.1 bestimmte Aktionen nicht mehr, wenn diese durch Addons modifiziert wurden.
> [!NOTE]
> **Syntax Fix**: Der Fehler `next_item` wird durch eine klassische Schleifen-Struktur ersetzt.

## Proposed Changes

### 1. Event System Fix (EventManager.lua)

#### [MODIFY] [EventManager.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Core/EventManager.lua)
- Wechsel von einem benannten Frame (`DragonSkillEventFrame`) zu einem **anonymen Frame**. Dies eliminiert die "ADDON_ACTION_FORBIDDEN" Fehler.

---

### 2. UI & Interaction (UI.lua)

#### [MODIFY] [UI.lua](file:///C:/Users/thoma/StudioProjects/Dragonskill/DragonSkill/Modules/TalentCompare/UI.lua)
- **Slash Command**: Umstellung von `/ds` auf **`/wear`**.
- **Syntax Repair**: Entfernen der `goto` Logik in `Helper_DrawListWithIcons`. Ersetzung durch eine saubere `if`-Bedingung.
- **Initialization**: Der `/wear` Befehl wird absolut ausführungssicher gemacht.

---

### 3. Data Integrity

- Ich werde die `GuideData.lua` im Zuge dieses Updates noch einmal mit einer robusteren Version überschreiben, um sicherzustellen, dass die Daten für Gear und Enchants geladen werden.

## Verification Plan

### Manual Verification
1. **Startup**: Steht "Dragon Skill v1.3.2 geladen!" im Chat?
2. **Slash Command**: Öffnet **`/wear`** das Addon? (Kein Emote mehr!)
3. **Error Check**: Erscheint die Fehlermeldung `forbidden action` noch? (Sollte weg sein).
4. **Data Check**: Sind die Tabs (Gear, Enchants) nun befüllt?
