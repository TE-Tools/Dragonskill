-- Dragon Skill - Character Engine (v1.7.0)
-- Reads equipped items, item levels, and stats.

local Character = DragonSkill:RegisterModule("Character", {})

local SLOTS = {
    "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot",
    "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot",
    "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
    "MainHandSlot", "SecondaryHandSlot"
}

-- Map slot name to our DB slot name
local SLOT_MAP = {
    HeadSlot = "Head", NeckSlot = "Neck", ShoulderSlot = "Shoulder", BackSlot = "Back",
    ChestSlot = "Chest", WristSlot = "Wrist", HandsSlot = "Hands", WaistSlot = "Waist",
    LegsSlot = "Legs", FeetSlot = "Feet", Finger0Slot = "Ring", Finger1Slot = "Ring",
    Trinket0Slot = "Trinket", Trinket1Slot = "Trinket",
    MainHandSlot = "MainHand", SecondaryHandSlot = "OffHand"
}

function Character:GetCurrentGear()
    local gear = {}
    for _, slotName in ipairs(SLOTS) do
        local slotID = GetInventorySlotInfo(slotName)
        local itemLink = GetInventoryItemLink("player", slotID)
        if itemLink then
            local itemID = GetInventoryItemID("player", slotID)
            local ilvl = select(4, GetItemInfo(itemLink)) or 0
            gear[SLOT_MAP[slotName]] = {
                itemId = itemID,
                ilvl = ilvl,
                link = itemLink
            }
        end
    end
    return gear
end

function Character:GetStatPriority()
    local SP = DragonSkill:GetModule("StatPriority")
    if SP then return SP:GetForCurrentSpec() end
    return nil
end
