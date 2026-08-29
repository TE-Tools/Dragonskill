-- Dragon Skill - Character Engine (v1.7.0)
local Character = DragonSkill:RegisterModule("Character", {})

local SLOTS = {
    "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot",
    "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot",
    "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
    "MainHandSlot", "SecondaryHandSlot"
}

function Character:GetCurrentGear()
    local gear = {}
    for _, slotName in ipairs(SLOTS) do
        local id = GetInventorySlotInfo(slotName)
        local itemID = GetInventoryItemID("player", id)
        if itemID then
            gear[slotName] = {
                itemId = itemID,
                ilvl = select(4, GetItemInfo(itemID)) or 0
            }
        end
    end
    return gear
end

function Character:GetGearScore()
    local gear = self:GetCurrentGear()
    local totalIlvl = 0
    local count = 0
    for _, data in pairs(gear) do
        totalIlvl = totalIlvl + data.ilvl
        count = count + 1
    end
    if count == 0 then return 0 end
    return totalIlvl / count
end
