-- Dragon Skill - Boss: Ula’tek, the Serpent Mother (Final)

local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "Ula'tek",
    ID = 3017,
    Aliases = { "ulatek", "ula'tek", "serpent mother" },
    phase = 1,
    eggs = {},
}

function Boss:OnStart()
    self.phase = 1
    self.eggs = {}
    self:UpdateUI()
end

function Boss:OnCombatLogEvent()
    local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID, spellName =
        CombatLogGetCurrentEventInfo()
    local nameLower = spellName and string.lower(spellName) or ""

    -- Phase-Hinweise
    if event == "SPELL_CAST_SUCCESS" or event == "SPELL_CAST_START" then
        if nameLower:find("shatter") or nameLower:find("ascension") or spellID == 461000 then
            self.phase = 3
            self:UpdateUI()
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:ShowBigWarning("|cffff0000PHASE 3: ASCENSION – BURN!|r", 5)
                BossMechanics:PlaySound("CRITICAL")
            end
        elseif nameLower:find("children") or nameLower:find("brood") or spellID == 461005 then
            if self.phase < 2 then
                self.phase = 2
                self:UpdateUI()
                if DragonSkill.BossMechanicsUI then
                    DragonSkill.BossMechanicsUI:ShowBigWarning("|cffffff00PHASE 2: CHILDREN OF DOOM|r", 4)
                    BossMechanics:PlaySound("INTERMISSION")
                end
            end
        end

        if nameLower:find("caustic") or nameLower:find("egg") or spellID == 461001 then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:ShowBigWarning("|cff00ff00MOVE THE EGGS!|r", 3)
                BossMechanics:PlaySound("ALERT")
            end
        end
    end

    if event == "SPELL_SUMMON" and destName then
        if nameLower:find("egg") or nameLower:find("hatch") or destName:lower():find("egg") then
            self.eggs[destName] = true
            self:UpdateUI()
        end
    elseif event == "UNIT_DIED" and destName and self.eggs[destName] then
        self.eggs[destName] = nil
        self:UpdateUI()
    end
end

function Boss:UpdateUI()
    local status = "Phase 1: Serpent Mother"
    if self.phase == 2 then status = "Phase 2: Children of Doom"
    elseif self.phase == 3 then status = "Phase 3: ASCENSION (Burn!)" end

    local eggList = {}
    local n = 0
    for name, _ in pairs(self.eggs) do
        n = n + 1
        table.insert(eggList, { name = "|cff88ff88Egg:|r " .. name, stacks = 0 })
    end

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdateStatus(status .. (n > 0 and (" · Eier: " .. n) or ""))
        DragonSkill.BossMechanicsUI:UpdatePairs({}, eggList)
    end
end

function Boss:SimulateStart()
    self.phase = 1
    self.eggs = { ["Greasy Hatchling"] = true }
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("FINAL BOSS: ULA'TEK!", 5)
        BossMechanics:PlaySound("START")
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
