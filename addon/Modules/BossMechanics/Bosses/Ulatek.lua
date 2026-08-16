-- Dragon Skill - Boss: Ula’tek, the Serpent Mother
local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "Ula’tek",
    ID = 3017, -- Final Boss
    phase = 1,
    eggs = {}
}

function Boss:OnStart()
    self.phase = 1
    self.eggs = {}
end

function Boss:OnCombatLogEvent(...)
    local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID = CombatLogGetCurrentEventInfo()

    -- Phase Detection (Example HP thresholds via Boss Emotes or specific spells)
    if spellID == 461000 then -- "The Shattering"
        self.phase = 3
        self:UpdateUI()
    end

    -- "Caustic Waves" warning
    if spellID == 461001 and event == "SPELL_CAST_START" then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:ShowBigWarning("|cff00ff00MOVE THE EGGS!|r", 3)
            BossMechanics:PlaySound("ALERT")
        end
    end
end

function Boss:UpdateUI()
    local status = "Phase 1: Serpent Mother"
    if self.phase == 2 then status = "Phase 2: Children of Doom"
    elseif self.phase == 3 then status = "Phase 3: ASCENSION (Burn!)" end

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdateStatus(status)
    end
end

function Boss:SimulateStart()
    self.phase = 1
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("FINAL BOSS: ULA'TEK!", 5)
        BossMechanics:PlaySound("START")
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
