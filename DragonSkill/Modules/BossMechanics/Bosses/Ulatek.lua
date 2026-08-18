-- Ula'tek – Final Boss Venomous Abyss (Encounter 3017)

local Boss = {
    ID = 3017,
    Name = "Ula'tek",
    Aliases = { "ulatek", "ula", "final" },
    Phase = "Caustic Waves + Eggs",
    Tip = "Caustic Waves → Eggs (Devourer's Spawn) nicht in Venom laufen lassen. Spectral Coils soaken (mehr Spieler = weniger Schaden). Slithering Clutch zerstoeren. Mythic: hoehere Prioritaet auf Hatch-Control.",
    Timers = {
        { key = "waves", name = "Caustic Waves", duration = 28, r = 0.3, g = 0.9, b = 0.3 },
        { key = "coils", name = "Spectral Coils", duration = 35, r = 0.7, g = 0.3, b = 0.9 },
        { key = "clutch", name = "Slithering Clutch", duration = 50, r = 0.9, g = 0.5, b = 0.1 },
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
        if spellName and spellName:find("Caustic Waves") then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:StartTimer("waves", "Caustic Waves", 28, 0.3, 0.9, 0.3)
            end
            DragonSkill.BossMechanics:PlaySound("WARNING")
        elseif spellName and spellName:find("Spectral Coils") then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:StartTimer("coils", "Spectral Coils", 12, 0.7, 0.3, 0.9)
            end
            DragonSkill.BossMechanics:PlaySound("ALERT")
        end
    end
end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Ula'tek – Eggs aus Venom halten, Coils soaken, Clutch killen.")
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:StartTimer("waves", "Caustic Waves", 28, 0.3, 0.9, 0.3)
        DragonSkill.BossMechanicsUI:StartTimer("coils", "Spectral Coils", 35, 0.7, 0.3, 0.9)
    end
end

DragonSkill.BossMechanics:RegisterBoss(3017, Boss)
