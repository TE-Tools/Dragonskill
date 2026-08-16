-- Dragon Skill - Boss: The Lost Explorers (Venomous Abyss)
-- Possessed tortollans – interrupts / soaks

local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "The Lost Explorers",
    ID = 3012,
    Aliases = { "lost explorers", "explorers", "tortollan" },
    energy = 0,
    interruptTargets = {},
}

function Boss:OnStart()
    self.energy = 0
    self.interruptTargets = {}
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdateStatus("Lost Explorers · Mor'zahi Energy")
    end
end

function Boss:OnCombatLogEvent()
    local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID, spellName =
        CombatLogGetCurrentEventInfo()
    local nameLower = spellName and string.lower(spellName) or ""

    -- Casts die interrupted werden sollten
    if event == "SPELL_CAST_START" then
        if nameLower:find("icebone") or nameLower:find("flame") or nameLower:find("hex")
            or spellID == 462001 or spellID == 462002 then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:ShowBigWarning(
                    "|cffff6600INTERRUPT: " .. (spellName or "Cast") .. "|r", 2
                )
                BossMechanics:PlaySound("ALERT")
            end
            if sourceName then
                self.interruptTargets[sourceName] = spellName or "Cast"
                self:UpdateUI()
            end
        end
        if nameLower:find("mighty") or nameLower:find("soak") or spellID == 462010 then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:ShowBigWarning("|cff66ff66SOAK!|r", 3)
                BossMechanics:PlaySound("WARNING")
            end
        end
    end

    if event == "SPELL_INTERRUPT" or event == "SPELL_CAST_FAILED" then
        if sourceName and self.interruptTargets[sourceName] then
            self.interruptTargets[sourceName] = nil
            self:UpdateUI()
        end
    end
end

function Boss:UpdateUI()
    local list = {}
    for name, spell in pairs(self.interruptTargets) do
        table.insert(list, { name = "|cffff6600INT:|r " .. name .. " – " .. tostring(spell), stacks = 0 })
    end
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdatePairs({}, list)
    end
end

function Boss:SimulateStart()
    self.interruptTargets = { ["Possessed Explorer"] = "Icebone Flames" }
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdateStatus("Lost Explorers · Füttern / Interrupts")
        DragonSkill.BossMechanicsUI:ShowBigWarning("LOST EXPLORERS: INTERRUPTS + SOAKS!", 5)
        BossMechanics:PlaySound("INTERMISSION")
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
