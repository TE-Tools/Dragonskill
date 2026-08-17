-- Dragon Skill - Modul: Rotation (v1.5.3)
-- Reine Anzeige – keine automatische Rotation / keine Secure Actions.

local Rotation = {}

function Rotation:GetForCurrentSpec()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return {} end
    local specID = select(1, GetSpecializationInfo(specIndex))
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    return self:GetList(guideData)
end

function Rotation:GetList(guideData)
    if not guideData or not guideData.rotation then return {} end
    return guideData.rotation.wowhead or guideData.rotation.archon or {}
end

DragonSkill:RegisterModule("Rotation", Rotation)
