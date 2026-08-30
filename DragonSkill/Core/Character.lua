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

function Character:GetInventoryUpgrades()
    local GM = DragonSkill:GetModule("GearManager")
    local upgrades = {}

    for bag = 0, 4 do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local itemID = C_Container.GetContainerItemID(bag, slot)
            if itemID then
                local itemLink = C_Container.GetContainerItemLink(bag, slot)
                local _, _, _, ilvl, _, _, _, _, slotName = GetItemInfo(itemLink)

                -- Nur Rüstung und Waffen
                if slotName and slotName ~= "" then
                    local upgrade = GM:GetUpgradeScore(nil, itemID, ilvl)
                    if upgrade > 0 then
                        table.insert(upgrades, { itemId = itemID, link = itemLink, score = upgrade })
                    end
                end
            end
        end
    end
    return upgrades
end

function Character:GetActiveTierInfo()
    local gear = self:GetCurrentGear()
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local specData = DragonSkillGearData.specs[specID]

    if not specData or not specData.tierSet then return 0, "None" end

    local count = 0
    local setPieces = {}
    for _, id in ipairs(specData.tierSet.pieces) do
        setPieces[id] = true
    end

    for _, item in pairs(gear) do
        if setPieces[item.itemId] then
            count = count + 1
        end
    end

    return count, specData.tierSet.name
end
