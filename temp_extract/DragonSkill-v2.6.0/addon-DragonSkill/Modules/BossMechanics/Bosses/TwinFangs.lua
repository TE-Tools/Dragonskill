-- The Twin Fangs – Boss 6 Venomous Abyss (Encounter 3015)
-- Zwei Bosse, Debuff-Management, Group-Soak, Add das stärker wird.

local Boss = {
    ID = 3015,
    Name = "The Twin Fangs",
    Aliases = { "twin", "fangs", "twins" },
    Phase = "Twin – Debuff + Soak",
    Tip = "Debuffs tracken. Group-Soak rechtzeitig. Add wird stärker je mehr Debuffs entfernt werden – timing beachten. Stationärer Fight.",
    Timers = {
        { key = "soak", name = "Group Soak", duration = 25, r = 0.9, g = 0.2, b = 0.5 },
        { key = "debuff", name = "Debuff Cycle", duration = 18, r = 0.6, g = 0.9, b = 0.2 },
    },
}

function Boss:OnStart()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
end

function Boss:OnEnd() end
function Boss:OnCombatLogEvent() end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Twin Fangs – Debuffs + Group-Soak, Add-Stärke beobachten.")
end

DragonSkill.BossMechanics:RegisterBoss(3015, Boss)
