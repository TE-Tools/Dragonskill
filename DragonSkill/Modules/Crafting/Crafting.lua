-- Dragon Skill - Modul: Crafting (v1.5.3)

local Crafting = {}

function Crafting:GetEmbellishments(guideData)
    if not guideData or not guideData.crafting then return {} end
    local wh = guideData.crafting.wowhead
    if not wh then return {} end
    return wh.embellishments or {}
end

function Crafting:GetForCurrentSpec()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return {} end
    local specID = select(1, GetSpecializationInfo(specIndex))
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    return self:GetEmbellishments(guideData)
end

function Crafting:FormatText(guideData)
    local list = self:GetEmbellishments(guideData)
    if #list == 0 then return "Keine Crafting-Daten." end
    local txt = "|cffffff00Embellishments (Wowhead):|r\n"
    for _, emb in ipairs(list) do
        txt = txt .. "- " .. tostring(emb) .. "\n"
    end
    return txt
end

DragonSkill:RegisterModule("Crafting", Crafting)
