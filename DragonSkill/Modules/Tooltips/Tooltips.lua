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
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    if not guideData then return end

    -- Check BiS Gear
    if guideData.bisGear then
        for provider, items in pairs(guideData.bisGear) do
            for _, item in ipairs(items) do
                -- Wowhead names items, Archon might use IDs. Simple check.
                if string.find(item.item:lower(), GetItemInfo(itemId):lower()) then
                    tooltip:AddLine(" ")
                    tooltip:AddLine("|cff00ff00Dragon Skill BiS (" .. provider .. "):|r " .. item.slot)
                end
            end
        end
    end

    -- Check Trinkets
    if guideData.trinkets then
        for provider, trinkets in pairs(guideData.trinkets) do
            for _, t in ipairs(trinkets) do
                if t.itemId == itemId or (t.name and string.find(t.name:lower(), GetItemInfo(itemId):lower())) then
                    tooltip:AddLine(" ")
                    tooltip:AddLine("|cff00ff00Dragon Skill Rank (" .. provider .. "):|r " .. (t.rank or "N/A"))
                end
            end
        end
    end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    Tooltips:Init()
end)
