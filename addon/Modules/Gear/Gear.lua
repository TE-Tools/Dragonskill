-- Dragon Skill - Modul: Gear
-- Zeigt Best-in-Slot Gear Empfehlungen.

local Gear = {}

function UI:DrawGear(content)
    local _, class = UnitClass("player")
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    local txt = "|cffffff00Best-in-Slot Gear (Wowhead):|r\n\n"
    local gear = guideData and guideData.bisGear and guideData.bisGear.wowhead
    if gear and #gear > 0 then
        for _, item in ipairs(gear) do
            txt = txt .. string.format("|cff00ff00%s:|r %s\n|cff888888Quelle: %s|r\n\n", item.slot, item.item, item.source)
        end
    else
        txt = txt .. "Keine Gear-Daten verfügbar."
    end

    content.text:SetText(txt)
end

-- Hook in das UI
local oldUpdate = DragonSkill.UI.Update
DragonSkill.UI.Update = function(self)
    if currentTab == 3 then
        local content = self.frame.Content
        for _, child in ipairs({content:GetChildren()}) do child:Hide() end
        content.text:SetText("")
        UI:DrawGear(content)
    else
        oldUpdate(self)
    end
end

DragonSkill:RegisterModule("Gear", Gear)
