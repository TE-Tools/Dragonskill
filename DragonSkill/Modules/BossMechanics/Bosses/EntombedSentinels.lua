-- Entombed Sentinels – Boss 2 Venomous Abyss (Encounter 3010)
-- Zwei Golems: Breath of Ula'tek + Blood of Ula'tek. 40y Abstand halten!

local Boss = {
    ID = 3010,
    Name = "Entombed Sentinels",
    Aliases = { "sentinels", "entombed", "golems" },
    Phase = "Split – 40y Abstand",
    Tip = "Raid halbieren. Bosse >40y auseinander halten (sonst 99% DR). Helical Toxins: Stacks auf genau 4 bringen (1+3 oder 2+2).",
    Timers = {
        { key = "stasis", name = "Vitriolic Stasis", duration = 55, r = 0.2, g = 0.9, b = 0.3 },
        { key = "marks", name = "Mark of Acid/Blood", duration = 20, r = 0.9, g = 0.6, b = 0.1 },
    },
}

function Boss:OnStart()
    self.Phase = "Split – 40y Abstand"
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
end

function Boss:OnEnd() end

function Boss:OnCombatLogEvent()
    local _, subEvent, _, _, _, _, _, _, _, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
    if subEvent == "SPELL_CAST_SUCCESS" or subEvent == "SPELL_CAST_START" then
        if spellName and (spellName:find("Vitriolic Stasis") or spellName:find("Stasis")) then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:StartTimer("stasis", "Vitriolic Stasis", 30, 0.2, 0.9, 0.3)
                DragonSkill.BossMechanicsUI:SetTip("Stasis aktiv – schwaecheren Golem heilen lassen, Helical Toxins auf 4 Stacks bringen!")
            end
            DragonSkill.BossMechanics:PlaySound("INTERMISSION")
        end
    end
end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Entombed Sentinels – Split-Raid, 40y Abstand.")
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:StartTimer("stasis", "Vitriolic Stasis", 55, 0.2, 0.9, 0.3)
    end
end

DragonSkill.BossMechanics:RegisterBoss(3010, Boss)
