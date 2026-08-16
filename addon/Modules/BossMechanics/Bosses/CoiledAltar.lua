-- Dragon Skill - Boss: The Coiled Altar
local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "The Coiled Altar",
    ID = 3016, -- Placeholder for Penalultimate Boss
    orbs = 0,
    mcPlayers = {}
}

function Boss:OnStart()
    self.orbs = 0
    self.mcPlayers = {}
end

function Boss:OnCombatLogEvent(...)
    local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID = CombatLogGetCurrentEventInfo()

    -- "Coalesced Venom" (Green Orbs)
    if event == "SPELL_SUMMON" and spellID == 460001 then
        self.orbs = self.orbs + 1
        self:UpdateUI()
    elseif event == "UNIT_DIED" and sourceName == "Coalesced Venom" then
        self.orbs = math.max(0, self.orbs - 1)
        self:UpdateUI()
    end

    -- "Dreadmarch" (Mind Control)
    if spellID == 460002 then
        if event == "SPELL_AURA_APPLIED" then
            self.mcPlayers[destName] = true
            self:UpdateUI()
        elseif event == "SPELL_AURA_REMOVED" then
            self.mcPlayers[destName] = nil
            self:UpdateUI()
        end
    end
end

function Boss:UpdateUI()
    local mcList = {}
    for name, _ in pairs(self.mcPlayers) do
        table.insert(mcList, { name = "|cffff0000MC:|r " .. name, stacks = 0 })
    end

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdateStatus(string.format("Aktive Gift-Orbs: %d", self.orbs))
        DragonSkill.BossMechanicsUI:UpdatePairs({}, mcList)

        if self.orbs >= 5 then
            DragonSkill.BossMechanicsUI:ShowBigWarning("ZU VIELE ORBS! DURCH DIE STACKS CLEAVEN!", 2)
            BossMechanics:PlaySound("WARNING")
        end
    end
end

function Boss:SimulateStart()
    self.orbs = 3
    self.mcPlayers = { ["Player1"] = true }
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("COILED ALTAR: HANDLE THE ORBS!", 5)
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
