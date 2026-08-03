-- Dragon Skill - Modul: StatPriority
-- Zeigt die von Wowhead/Archon gescrapten Stat-Prioritäten für die aktuelle Spec an.
-- Reine Anzeige, kein Auto-Gearcheck in v0.1.

local StatPriority = {}

function StatPriority:GetForCurrentSpec()
    local _, classToken = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return nil, "Keine Spezialisierung gewählt." end

    local specID = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(classToken, specID)
    if not guideData or not guideData.statPriority then
        return nil, "Keine Stat-Daten geladen für diese Spec."
    end

    return guideData.statPriority
end

DragonSkill:RegisterModule("StatPriority", StatPriority)
