local Tooltips = DragonSkill:RegisterModule("Tooltips", {})

function Tooltips:Init()
    if TooltipDataProcessor then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
            self:OnTooltipSetItem(tooltip, data)
        end)
    end
end

function Tooltips:OnTooltipSetItem(tooltip, data)
    local itemId = data.id
    if not itemId then return end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local spec = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    if not guideData then return end

    -- Check BiS Gear
    local isBiS = false
    if guideData.bisGear and guideData.bisGear.wowhead then
        for _, item in ipairs(guideData.bisGear.wowhead) do
            if item.itemId == itemId then
                isBiS = true
                break
            end
        end
    end

    -- Check Trinkets (Rank S/A are also BiS)
    if not isBiS and guideData.trinkets and guideData.trinkets.archon then
        for _, t in ipairs(guideData.trinkets.archon) do
            if t.itemId == itemId and (t.rank == "S" or t.rank == "A") then
                isBiS = true
                break
            end
        end
    end

    if isBiS then
        tooltip:AddLine(" ")
        tooltip:AddLine("|cffffd100Dragon Skill: Best-in-Slot|r")
    end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    Tooltips:Init()
end)
