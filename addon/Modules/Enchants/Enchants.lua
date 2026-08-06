-- Dragon Skill - Modul: Enchants & Consumables

local Enchants = {}

function UI:DrawEnchants(content)
    local _, class = UnitClass("player")
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    local txt = "|cffffff00Empfohlene Verzauberungen:|r\n"
    local list = guideData and guideData.enchants and guideData.enchants.wowhead
    if list and #list > 0 then
        for _, v in ipairs(list) do txt = txt .. "- " .. v .. "\n" end
    else
        txt = txt .. "Keine Daten.\n"
    end

    txt = txt .. "\n|cffffff00Empfohlene Edelsteine:|r\n"
    list = guideData and guideData.gems and guideData.gems.wowhead
    if list and #list > 0 then
        for _, v in ipairs(list) do txt = txt .. "- " .. v .. "\n" end
    else
        txt = txt .. "Keine Daten.\n"
    end

    content.text:SetText(txt)
end

function UI:DrawConsumables(content)
    local _, class = UnitClass("player")
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    local txt = "|cffffff00Verbrauchsgegenstände (Fläschchen, Tränke, Bufffood):|r\n\n"
    local list = guideData and guideData.consumables and guideData.consumables.wowhead
    if list and #list > 0 then
        for _, v in ipairs(list) do txt = txt .. "- " .. v .. "\n" end
    else
        txt = txt .. "Keine Daten."
    end

    content.text:SetText(txt)
end

-- Hook in das UI
local oldUpdate = DragonSkill.UI.Update
DragonSkill.UI.Update = function(self)
    local content = self.frame.Content
    if currentTab == 4 then
        for _, child in ipairs({content:GetChildren()}) do child:Hide() end
        content.text:SetText("")
        UI:DrawEnchants(content)
    elseif currentTab == 5 then
        for _, child in ipairs({content:GetChildren()}) do child:Hide() end
        content.text:SetText("")
        UI:DrawConsumables(content)
    else
        oldUpdate(self)
    end
end

DragonSkill:RegisterModule("Enchants", Enchants)
