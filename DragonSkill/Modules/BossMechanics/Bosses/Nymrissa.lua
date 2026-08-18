-- Nymrissa Wavecaller – Tidebound Grotto Lair (Encounter 3101)
-- Erstes Lair (instanziierter World-Boss) in 12.1

local Boss = {
    ID = 3101,
    Name = "Nymrissa Wavecaller",
    Aliases = { "nymrissa", "nym", "lair", "tidebound", "grotto" },
    Phase = "Alluring Bubble Zyklus",
    Tip = "Murlocs (Bubblefin Shorerunner) VOR der Bubble killen/CC. Swirling Whirlpools von der Bubble wegziehen. Pop! Knockback → sofort neu positionieren. Mythic: Frostscales zuerst (Waterfog Shield 99% DR).",
    Timers = {
        { key = "bubble", name = "Alluring Bubble", duration = 40, r = 0.2, g = 0.7, b = 1 },
        { key = "whirl", name = "Swirling Whirlpools", duration = 22, r = 0.4, g = 0.8, b = 1 },
        { key = "rain", name = "Abyssal Rain", duration = 35, r = 0.3, g = 0.5, b = 0.9 },
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
        if spellName and spellName:find("Alluring Bubble") then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:StartTimer("bubble", "Alluring Bubble", 40, 0.2, 0.7, 1)
                DragonSkill.BossMechanicsUI:SetTip("Bubble aktiv – Murlocs sofort killen/CC, bevor sie reinlaufen!")
            end
            DragonSkill.BossMechanics:PlaySound("WARNING")
        elseif spellName and (spellName:find("Swirling Whirlpool") or spellName:find("Whirlpool")) then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:StartTimer("whirl", "Whirlpools → Bubble", 12, 0.4, 0.8, 1)
            end
            DragonSkill.BossMechanics:PlaySound("ALERT")
        elseif spellName and spellName:find("Abyssal Rain") then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:StartTimer("rain", "Abyssal Rain", 8, 0.3, 0.5, 0.9)
            end
        elseif spellName and spellName:find("Pop!") then
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:SetTip("Bubble geplatzt – Knockback! Sofort re-stacken und Berserker fokussieren.")
            end
            DragonSkill.BossMechanics:PlaySound("CRITICAL")
        end
    end
end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Nymrissa – Alluring Bubble Zyklus. Murlocs vor Bubble stoppen.")
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:StartTimer("bubble", "Alluring Bubble", 40, 0.2, 0.7, 1)
        DragonSkill.BossMechanicsUI:StartTimer("whirl", "Swirling Whirlpools", 22, 0.4, 0.8, 1)
    end
end

DragonSkill.BossMechanics:RegisterBoss(3101, Boss)
