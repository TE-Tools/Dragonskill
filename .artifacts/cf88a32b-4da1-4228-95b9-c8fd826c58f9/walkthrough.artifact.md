# Walkthrough - Dragon Skill v1.4.3 (Boss Tests & Druid Restoration)

Dieses Update aktiviert die Boss-Mechanik-Tests und befüllt den Heiler-Druiden sowie diverse Rotations-Listen.

## Wichtigste Änderungen

### 1. Boss-Simulationen aktiv
Du kannst nun die Boss-Warnungen und Mechaniken jederzeit testen.
- **Befehl**: Nutze `/wear <testname>`.
- **Beispiele**:
    - `/wear testulatek` (Finaler Boss)
    - `/wear testfangs` (Stack-Management bei den Twin Fangs)
    - `/wear testsszorak` (Windtunnel-Tracking)
    - `/wear testexplorers` (Schildkröten-Rat)

### 2. Restoration Druid (Heiler)
Der Heal-Druide ist nun komplett:
- **Talente**: Inklusive 12.1 "Everbloom" und "Abundance" Builds.
- **Rotation**: Detaillierte Prioritätsliste (Lifebloom-Management, Swiftmend-Trigger etc.).
- **Gear**: BiS-Trinkets und Enchants.

### 3. Rotation-Tab befüllt
Der Reiter "Rotation" zeigt nun für folgende Klassen echte Prio-Listen an:
- **Blut-Todesritter**
- **Schutz-Paladin**
- **Wächter-Druide**
- **Wiederherstellung-Druide**

## Verifizierung
- [x] `/wear testulatek` öffnet das Boss-Fenster und zeigt Warnungen.
- [x] Einloggen als Druide (Heil-Spec) -> Talente und Rotation sind da.
- [x] `/wear` ohne Argument öffnet weiterhin das Hauptfenster.

> [!IMPORTANT]
> **REINSTALL**: Bitte lösche den Ordner `Interface\AddOns\DragonSkill` ein letztes Mal und kopiere ihn neu aus deinem Projektverzeichnis. Starte WoW danach neu!
