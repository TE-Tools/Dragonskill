-- Dragon Skill - Modul: Trinkets (v1.5.3)

local Trinkets = {}

function Trinkets:GetForCurrentSpec()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return {} end
    local specID = select(1, GetSpecializationInfo(specIndex))
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if not guideData or not guideData.trinkets then return {} end
    return guideData.trinkets.archon or guideData.trinkets.wowhead or {}
end

function Trinkets:GetList(guideData)
    if not guideData or not guideData.trinkets then return {} end
    return guideData.trinkets.archon or guideData.trinkets.wowhead or {}
end

DragonSkill:RegisterModule("Trinkets", Trinkets)
