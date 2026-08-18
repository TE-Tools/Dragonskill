-- Vashnik the Malignant – Boss 4 Venomous Abyss (Encounter 3013)
-- Altäre (Fire/Shadow/Blood). Position entscheidet, welche empowered werden.

local Boss = {
    ID = 3013,
    Name = "Vashnik the Malignant",
    Aliases = { "vashnik", "malignant" },
    Phase = "Altäre – Position steuern",
    Tip = "Boss zu den zwei gewünschten Altären positionieren. Nie denselben Altar 2x hintereinander. Adds vom Altar nicht ins Zentrum lassen.",
    Timers = {
        { key = "imbibe", name = "Imbibe / Empower", duration = 35, r = 0.9, g = 0.3, b = 0.1 },
        { key = "adds", name = "Altar-Adds", duration = 22, r = 0.7, g = 0.2, b = 0.8 },
    },
}

function Boss:OnStart()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
end

function Boss:OnEnd() end

function Boss:OnCombatLogEvent()
    local _, subEvent, _, _, _, _, _, _, _, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
    if subEvent == "SPELL_CAST_SUCCESS" or subEvent == "SPELL_CAST_START" then
        if spellName and (spellName:find("Imbibe") or spellName:find("Empower")) then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:StartTimer("imbibe", "Imbibe", 35, 0.9, 0.3, 0.1)
            end
            DragonSkill.BossMechanics:PlaySound("WARNING")
        end
    end
end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Vashnik – Altäre wechseln, Adds cleaven.")
end

DragonSkill.BossMechanics:RegisterBoss(3013, Boss)
