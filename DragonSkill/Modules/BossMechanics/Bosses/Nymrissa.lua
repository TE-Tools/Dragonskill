-- Dragon Skill - Lair Boss: Nymrissa Wavecaller (Tidebound Grotto)
-- Patch 12.1 World-Boss-Lair

local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "Nymrissa Wavecaller",
    ID = 3101,
    Aliases = { "nymrissa", "tidebound", "grotto", "wavecaller" },
    phase = 1,
    adds = {},
}

function Boss:OnStart()
    self.phase = 1
    self.adds = {}
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdateStatus("Lair: Tidebound Grotto · Phase 1")
    end
end

function Boss:OnCombatLogEvent()
    local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID, spellName =
        CombatLogGetCurrentEventInfo()

    -- Tide / Wave casts – generische Namen + Placeholder-IDs
    local nameLower = spellName and string.lower(spellName) or ""
    if event == "SPELL_CAST_START" then
        if nameLower:find("tide") or nameLower:find("wave") or nameLower:find("drown")
            or spellID == 470001 or spellID == 470002 then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:ShowBigWarning("|cff66ccffTIDE INCOMING – MOVE!|r", 3)
                BossMechanics:PlaySound("ALERT")
            end
        end
        if nameLower:find("murloc") or nameLower:find("call of the deep") or spellID == 470010 then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:ShowBigWarning("|cffffff00ADDS: MURLOCS!|r", 3)
                BossMechanics:PlaySound("WARNING")
            end
        end
    end

    if event == "SPELL_SUMMON" then
        if destName then
            self.adds[destName] = true
            self:UpdateUI()
        end
    elseif event == "UNIT_DIED" and destName and self.adds[destName] then
        self.adds[destName] = nil
        self:UpdateUI()
    end
end

function Boss:UpdateUI()
    local list = {}
    local n = 0
    for name, _ in pairs(self.adds) do
        n = n + 1
        table.insert(list, { name = name, stacks = 0 })
    end
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdateStatus(
            string.format("Nymrissa · Adds aktiv: %d", n)
        )
        DragonSkill.BossMechanicsUI:UpdatePairs({}, list)
    end
end

function Boss:SimulateStart()
    self.adds = { ["Tidebound Murloc"] = true, ["Reef Guardian"] = true }
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("LAIR: NYMRISSA WAVECALLER", 5)
        BossMechanics:PlaySound("START")
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
