# Implementation Plan - Integration: WoW AI Coach (v1.8.0)

Dieses Update integriert das "WoW AI Coach" System als eigenständiges Modul in Dragon Skill. Der Coach fungiert als intelligentes Interface für die bereits bestehende Gear- und Farm-Engine.

## User Review Required

> [!IMPORTANT]
> **Neuer Tab "AI Coach"**: Ich füge einen interaktiven Chat-Tab hinzu, der die "Local Engine" nutzt.
> [!IMPORTANT]
> **Local Engine Integration**: Der Coach greift direkt auf den `GearManager` und `Character` Scanner zu, um Fakten-basierte Antworten zu geben (keine Halluzinationen).
> [!NOTE]
> **API-Key Support**: Vorbereitung der UI für die optionale Eingabe eines OpenAI-Keys (Mode 2 der Spezifikation).

## Proposed Changes

### 1. New Module: AICoach
Ich erstelle einen neuen Ordner `Modules/AICoach/` mit den Kernkomponenten:
- **Engine.lua**: Die Logik zur Interpretation von Fragen (Intents wie "farmen", "upgrade", "stats").
- **ChatUI.lua**: Das interaktive Interface innerhalb des Dragon Skill Fensters.

---

### 2. UI Integration (Modules/TalentCompare/UI.lua)
- **Tab Erweiterung**: Hinzufügen des Reiters "AI Coach" (ersetzt oder erweitert den rudimentären Assistant).
- **Chat Layout**: Implementierung einer scrollbaren Historie und eines Eingabefeldes.

---

### 3. Core Engine Enhancements
- **Scanner Update**: Erweiterung des `Character.lua` Scanners um die Taschen-Überprüfung (Inventory Scanner), um Upgrades "in der Tasche" zu finden.
- **Database Linkage**: Verknüpfung der `GearDatabase.lua` mit der Chat-Engine.

## Verification Plan

### Manual Verification
1. **Interaktion**: Tab "AI Coach" öffnen -> Frage eingeben: "Was soll ich farmen?" -> Coach muss den `GearManager` fragen und antworten.
2. **Taschen-Check**: Ein besseres Item in die Tasche legen -> Coach fragen: "Habe ich was Besseres in der Tasche?" -> Er muss das Item finden.
3. **Kontext**: Frage stellen -> Folgefrage stellen (z.B. "Und danach?") -> Coach muss den Kontext behalten.
