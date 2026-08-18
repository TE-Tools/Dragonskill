-- Sszorak – Boss 5 Venomous Abyss (Encounter 3014)
-- Platform-Push-Fight. Rings / Edge-Management.

local Boss = {
    ID = 3014,
    Name = "Sszorak",
    Aliases = { "sszorak", "ssz" },
    Phase = "Platform – Edge Control",
    Tip = "Boss versucht die Raid von der Plattform zu schieben. Ringe springen (Achievement). Nicht am Rand stehen, wenn Knockback kommt.",
    Timers = {
        { key = "push", name = "Platform Push", duration = 30, r = 0.3, g = 0.6, b = 1 },
        { key = "rings", name = "Rings", duration = 45, r = 1, g = 0.8, b = 0.2 },
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
    print("|cff00ff00DS BossSim:|r Sszorak – Plattform-Push, Ringe springen.")
end

DragonSkill.BossMechanics:RegisterBoss(3014, Boss)
