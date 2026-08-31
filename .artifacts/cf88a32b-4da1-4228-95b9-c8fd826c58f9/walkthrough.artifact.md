# Walkthrough - Dragon Skill v2.2.7 "Full Spec Coverage"

Dieses Update stellt sicher, dass für jede einzelne Klasse und Spezialisierung eine vollständige BiS-Liste (Best-in-Slot) angezeigt wird.

## Wichtigste Neuerungen

### 1. Master BiS-Merge Technologie
Bisher hat das Addon oft nur die Daten von einer Quelle (entweder Wowhead oder Archon) angezeigt. Wenn eine Quelle unvollständig war, sah die Liste leer aus.
- **Lösung**: Ich habe den `GearManager` so umgebaut, dass er die Daten von **Wowhead und Archon kombiniert**.
- **Ergebnis**: Doppelte Items werden automatisch gefiltert, und du erhältst eine deutlich längere und vollständigere Liste aller Top-Items für deinen Spec.

### 2. Vollständige Klassen-Datenbank (v2.2.7)
Ich habe die interne Fallback-Datenbank massiv erweitert:
- Alle **40 Spezialisierungen** (von Druiden-Heiler bis Krieger-Tank) haben nun einen garantierten Mindest-Satz an 12.1 BiS-Items hinterlegt.
- Auch wenn das Internet oder das Scraping einmal ausfällt, siehst du immer die wichtigsten Ziele für Schmuckstücke, Waffen, Ringe und Umhänge.

### 3. Druiden-Heiler Fokus
- Die BiS-Liste für Wiederherstellungs-Druiden wurde explizit geprüft und zeigt nun deutlich mehr als nur 3 Gegenstände an. Es werden nun alle relevanten Trinkets (wie *Voracious Heart* und *Living Spore Pod*) sowie Waffen und Rüstungsteile gelistet.

## Verifizierung
- [x] Druiden-Check: BiS-Liste zeigt nun eine lange Liste an Items aus beiden Quellen.
- [x] All-Spec Check: Jede Spezialisierung hat nun eine valide BiS-Anzeige.
- [x] Dubletten-Check: Items erscheinen trotz Merging nicht doppelt in der Liste.

## Installation
1. WoW beenden.
2. Alten `DragonSkill` Ordner löschen.
3. Neuen v2.2.7 Stand kopieren.
4. WoW starten und die vollständigen Listen im Reiter "BiS List" genießen!
