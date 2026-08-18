-- Nek'zali the Soulcoiler – Boss 1 Venomous Abyss (Encounter 3011)

local Boss = {
    ID = 3011,
    Name = "Nek'zali the Soulcoiler",
    Aliases = { "nekzali", "nek", "soulcoiler" },
    Phase = "Stufe 1 – Soulcoiler",
    Tip = "Restless Amani NICHT zum Soulcoil Well laufen lassen. Bei 50% Intermission: Echoes of Jawae killen → Tethers trennen.",
    Timers = {
        { key = "rite", name = "Soulcoil Rite", duration = 28, r = 0.6, g = 0.2, b = 0.9 },
        { key = "adds", name = "Restless Amani", duration = 35, r = 0.9, g = 0.4, b = 0.2 },
    },
}

function Boss:OnStart()
    self.Phase = "Stufe 1 – Soulcoiler"
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
end

function Boss:OnEnd() end

function Boss:OnCombatLogEvent()
    local _, subEvent, _, _, _, _, _, _, destName, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
    if subEvent == "SPELL_CAST_SUCCESS" or subEvent == "SPELL_CAST_START" then
        if spellId == 1284033 or (spellName and spellName:find("Soulcoil Rite")) then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:StartTimer("rite", "Soulcoil Rite", 28, 0.6, 0.2, 0.9)
            end
            DragonSkill.BossMechanics:PlaySound("WARNING")
        elseif spellId == 1284034 or (spellName and spellName:find("Uncoiled Rage")) then
            self.Phase = "Stufe 2 – Uncoiling (BURN)"
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
                DragonSkill.BossMechanicsUI:SetTip("Uncoiled Rage aktiv – maximaler DPS, Taunt-Immunitaet beachten!")
            end
            DragonSkill.BossMechanics:PlaySound("CRITICAL")
        end
    end
end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Nek'zali – Stufe 1. Amani vom Well fernhalten.")
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:StartTimer("rite", "Soulcoil Rite", 28, 0.6, 0.2, 0.9)
        DragonSkill.BossMechanicsUI:StartTimer("adds", "Restless Amani", 35, 0.9, 0.4, 0.2)
    end
end

function Boss:SimulateIntermission()
    self.Phase = "Intermission – Ritual of Awakening"
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip("Echoes of Jawae toeten → Tethers of Awakening trennen. Hungering Pyre soaken.")
        DragonSkill.BossMechanicsUI:StartTimer("inter", "Ritual of Awakening", 45, 1, 0.3, 0.3)
    end
    DragonSkill.BossMechanics:PlaySound("INTERMISSION")
end

DragonSkill.BossMechanics:RegisterBoss(3011, Boss)
