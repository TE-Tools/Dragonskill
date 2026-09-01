-- Dragon Skill - Character Engine (v2.3.7)
-- Equipped gear with dual Ring/Trinket slots + inventory upgrade scan.

local Character = DragonSkill:RegisterModule("Character", {})

local SLOTS = {
    "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot",
    "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot",
    "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
    "MainHandSlot", "SecondaryHandSlot"
}

local SLOT_MAP = {
    HeadSlot = "Head", NeckSlot = "Neck", ShoulderSlot = "Shoulder", BackSlot = "Back",
    ChestSlot = "Chest", WristSlot = "Wrist", HandsSlot = "Hands", WaistSlot = "Waist",
    LegsSlot = "Legs", FeetSlot = "Feet",
    Finger0Slot = "Ring", Finger1Slot = "Ring2",
    Trinket0Slot = "Trinket", Trinket1Slot = "Trinket2",
    MainHandSlot = "MainHand", SecondaryHandSlot = "OffHand"
}

function Character:GetCurrentGear()
    local gear = {}
    for _, slotName in ipairs(SLOTS) do
        local slotID = GetInventorySlotInfo(slotName)
        if slotID then
            local itemLink = GetInventoryItemLink("player", slotID)
            if itemLink then
                local itemID = GetInventoryItemID("player", slotID)
                local ilvl = select(4, GetItemInfo(itemLink)) or 0
                local key = SLOT_MAP[slotName]
                if key then
                    gear[key] = {
                        itemId = itemID,
                        ilvl = ilvl,
                        link = itemLink,
                    }
                end
            end
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
    if not GM then return {} end
    local upgrades = {}

    for bag = 0, 4 do
        local numSlots = C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerNumSlots(bag) or 0
        for slot = 1, numSlots do
            local itemID = C_Container.GetContainerItemID(bag, slot)
            if itemID then
                local itemLink = C_Container.GetContainerItemLink(bag, slot)
                local _, _, _, ilvl, _, _, _, _, equipSlot = GetItemInfo(itemLink or itemID)
                if equipSlot and equipSlot ~= "" and equipSlot ~= "INVTYPE_NON_EQUIP_IGNORE" then
                    local score = GM:GetUpgradeScore(equipSlot, itemID, ilvl)
                    if score and score > 0 then
                        table.insert(upgrades, {
                            itemId = itemID,
                            link = itemLink,
                            score = score,
                            slot = equipSlot,
                        })
                    end
                end
            end
        end
    end
    table.sort(upgrades, function(a, b) return (a.score or 0) > (b.score or 0) end)
    return upgrades
end

function Character:GetActiveTierInfo()
    local gear = self:GetCurrentGear()
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    if not DragonSkillGearData or not DragonSkillGearData.specs then return 0, "None" end
    local specData = DragonSkillGearData.specs[specID]

    if not specData or not specData.tierSet or not specData.tierSet.pieces then
        return 0, "None"
    end

    local count = 0
    local setPieces = {}
    for _, id in ipairs(specData.tierSet.pieces) do
        setPieces[id] = true
    end

    for _, item in pairs(gear) do
        if item.itemId and setPieces[item.itemId] then
            count = count + 1
        end
    end

    return count, specData.tierSet.name or "Tier"
end
