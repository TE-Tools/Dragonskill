-- The Lost Explorers – Boss 3 Venomous Abyss (Encounter 3012)
-- Council: zwei tankbare + ein Caster. Empowerment steuern.

local Boss = {
    ID = 3012,
    Name = "The Lost Explorers",
    Aliases = { "explorers", "lost", "hoji" },
    Phase = "Council – Empower steuern",
    Tip = "Zwei Mobs tanken, Caster wandert. Raid entscheidet, welcher Boss zuerst empowered wird und seine Ultimate bekommt.",
    Timers = {
        { key = "empower", name = "Empowerment", duration = 40, r = 0.8, g = 0.5, b = 0.1 },
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
    print("|cff00ff00DS BossSim:|r Lost Explorers – Council-Fight. Empowerment kontrollieren.")
end

DragonSkill.BossMechanics:RegisterBoss(3012, Boss)
