-- Dragon Skill - Boss: Vashnik the Malignant
local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "Vashnik the Malignant",
    ID = 3013, -- Placeholder for Patch 12.1
    quadrants = {
        ["TOPLEFT"] = "Clear",
        ["TOPRIGHT"] = "Clear",
        ["BOTTOMLEFT"] = "Clear",
        ["BOTTOMRIGHT"] = "Clear"
    }
}

function Boss:OnStart()
    self.quadrants = {
        ["TOPLEFT"] = "Clear",
        ["TOPRIGHT"] = "Clear",
        ["BOTTOMLEFT"] = "Clear",
        ["BOTTOMRIGHT"] = "Clear"
    }
end

function Boss:OnCombatLogEvent(...)
    local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID = CombatLogGetCurrentEventInfo()

    -- "Toxic Distillation" logic (Example SpellIDs)
    if spellID == 457001 then -- Acid Distillation
        self:UpdateQuadrant("TOPLEFT", "Acid")
    elseif spellID == 457002 then -- Blood Distillation
        self:UpdateQuadrant("TOPRIGHT", "Blood")
    end
end

function Boss:UpdateQuadrant(name, type)
    self.quadrants[name] = type
    self:UpdateUI()
end

function Boss:UpdateUI()
    local list = {}
    for q, t in pairs(self.quadrants) do
        local color = "|cffffffff"
        if t == "Acid" then color = "|cff00ff00"
        elseif t == "Blood" then color = "|cffff0000" end
        table.insert(list, { name = q .. ": " .. color .. t .. "|r", stacks = 0 })
    end

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdatePairs({}, list)
    end
end

function Boss:SimulateStart()
    self.quadrants["TOPLEFT"] = "Acid"
    self.quadrants["BOTTOMRIGHT"] = "Blood"
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("VASHNIK: WATCH THE QUADRANTS!", 5)
        BossMechanics:PlaySound("INTERMISSION")
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
