-- Dragon Skill - Tooltips (v1.5.8)
-- BiS / Trinket / Enchant / Gem / Consumable Marker

local Tooltips = DragonSkill:RegisterModule("Tooltips", {})

local function CurrentGuide()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return nil end
    local specID = select(1, GetSpecializationInfo(specIndex))
    return DragonSkill.Database:GetGuideData(class, specID)
end

local function ListHasItemId(list, itemId)
    if not list then return false end
    for _, entry in ipairs(list) do
        if entry.itemId and entry.itemId == itemId then
            return true
        end
    end
    return false
end

function Tooltips:InitItem(guideData, itemId)
    local tags = {}

    if guideData.bisGear and ListHasItemId(guideData.bisGear.wowhead, itemId) then
        table.insert(tags, "|cffffd100Best-in-Slot|r")
    end

    if guideData.trinkets then
        local list = guideData.trinkets.archon or guideData.trinkets.wowhead
        if list then
            for _, t in ipairs(list) do
                if t.itemId == itemId then
                    local rank = t.rank and (" Rank " .. tostring(t.rank)) or ""
                    table.insert(tags, "|cff66ccffTrinket" .. rank .. "|r")
                    break
                end
            end
        end
    end

    if guideData.enchants and ListHasItemId(guideData.enchants.wowhead, itemId) then
        table.insert(tags, "|cff88ff88Guide-Enchant|r")
    end

    if guideData.gems and ListHasItemId(guideData.gems.wowhead, itemId) then
        table.insert(tags, "|cff88aaffGuide-Gem|r")
    end

    if guideData.consumables and ListHasItemId(guideData.consumables.wowhead, itemId) then
        table.insert(tags, "|cffffaa66Guide-Consumable|r")
    end

    return tags
end

function Tooltips:OnTooltipSetItem(tooltip, data)
    local itemId = data and data.id
    if not itemId then return end

    local guideData = CurrentGuide()
    if not guideData then return end

    local tags = self:ClassifyItem(guideData, itemId)
    if #tags == 0 then return end

    tooltip:AddLine(" ")
    tooltip:AddLine("|cffffd100Dragon Skill:|r " .. table.concat(tags, " · "))
end

function Tooltips:Init()
    if TooltipDataProcessor and Enum and Enum.TooltipDataType then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
            self:OnTooltipSetItem(tooltip, data)
        end)
    end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    Tooltips:Init()
end)
