-- Dragon Skill - Boss: Twin Fangs (Stack Management)
local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "Twin Fangs",
    ID = 3015,
    VenomSpellID = 459000, -- Placeholder for Eternal Venom
    stacks = {}
}

function Boss:OnStart()
    self.stacks = {}
    self:StartStackScanner()
end

function Boss:StartStackScanner()
    C_Timer.NewTicker(2, function()
        if BossMechanics.CurrentBoss ~= self then return end

        local unitPrefix = IsInRaid() and "raid" or "party"
        local num = GetNumGroupMembers()

        for i = 1, num do
            local unit = unitPrefix .. i
            local name = GetUnitName(unit, true)
            if name then
                local aura = C_UnitAuras.GetAuraDataBySpellID(unit, self.VenomSpellID)
                if aura then
                    self.stacks[name] = aura.applications or 0
                else
                    self.stacks[name] = 0
                end
            end
        end
        self:UpdateUI()
    end)
end

function Boss:UpdateUI()
    local highStacks = {}
    for name, count in pairs(self.stacks) do
        if count >= 7 then
            table.insert(highStacks, { name = name, stacks = count })
        end
    end

    table.sort(highStacks, function(a, b) return a.stacks > b.stacks end)

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdatePairs({}, highStacks)
        if #highStacks > 0 and highStacks[1].stacks >= 9 then
            DragonSkill.BossMechanicsUI:ShowBigWarning("CRITICAL STACKS: " .. highStacks[1].name:upper(), 2)
            BossMechanics:PlaySound("CRITICAL")
        end
    end
end

function Boss:SimulateStart()
    self.stacks = {
        ["Thomas"] = 9,
        ["Lisa"] = 4,
        ["Kevin"] = 7,
        ["Anna"] = 2
    }
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("TWIN FANGS: WATCH YOUR STACKS!", 5)
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
