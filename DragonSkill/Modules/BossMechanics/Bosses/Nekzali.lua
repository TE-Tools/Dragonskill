-- Dragon Skill - Boss: Nek'zali the Soulcoiler
local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "Nek'zali the Soulcoiler",
    ID = 3011,
    EnergySpellID = 456000, -- Placeholder
    adds = {}
}

function Boss:OnStart()
    self.adds = {}
    self:StartEnergyTracking()
end

function Boss:StartEnergyTracking()
    C_Timer.NewTicker(1, function()
        if BossMechanics.CurrentBoss ~= self then return end

        -- In Midnight raids, energy is often tracked via UnitPower("boss1", 10)
        local power = UnitPower("boss1", 10)
        if power == 0 and self.simulatedPower then
            power = self.simulatedPower
            self.simulatedPower = math.min(100, self.simulatedPower + 2)
        end

        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:UpdateStatus(string.format("Soulcoil Well: %d%%", power))
            if power >= 90 then
                DragonSkill.BossMechanicsUI:ShowBigWarning("|cffff0000WARNING: SOULCOIL WELL FULL!|r", 2)
                BossMechanics:PlaySound("WARNING")
            end
        end
    end)
end

function Boss:OnCombatLogEvent(...)
    local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID = CombatLogGetCurrentEventInfo()

    -- Example: Tracking raised adds
    if event == "SPELL_SUMMON" then
        self.adds[destName] = true
        self:UpdateUI()
    elseif event == "UNIT_DIED" then
        self.adds[destName] = nil
        self:UpdateUI()
    end
end

function Boss:UpdateUI()
    local addList = {}
    for name, _ in pairs(self.adds) do
        table.insert(addList, {name = name, stacks = 0})
    end

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdatePairs({}, addList) -- Use open list for adds
    end
end

function Boss:SimulateStart()
    self.adds = { ["Amani Brute"] = true, ["Amani Shaman"] = true }
    self.simulatedPower = 40
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("NEK'ZALI: PROTECT THE WELL!", 5)
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
