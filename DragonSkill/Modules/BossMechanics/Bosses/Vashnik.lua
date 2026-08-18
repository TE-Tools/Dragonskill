-- Vashnik the Malignant – Boss Venomous Abyss
-- Imbibe: 2 naechste Brunnen. Adds vor Cavity killen.

local Boss = {
    ID = 3013,
    Name = "Vashnik the Malignant",
    Aliases = { "vashnik", "malignant", "vash" },
    Phase = "Brunnen – Position steuern",
    Tip = "Boss zwischen 2 gewuenschte Brunnen stellen. Imbibe = Living Venoms zum Cavity killen. Adaptive Infection: rauslaufen (Exploding = Abstand!).",
    SpellIDs = {
        imbibe = 1283164,
        toxicVapor = 1284561,
        malignantBurst = 1280189,
        malignantCatalyst = 1282525,
        adaptiveInfection = 1282117,
        drippingFangs = 1280935,
        catalyticBile = 1282601,
        explodingInfection = 1295173,
        siphoningInfection = 1299941,
        stygianInfection = 1294994,
    },
    Timers = {
        { key = "imbibe", name = "Imbibe", duration = 35, r = 0.9, g = 0.3, b = 0.1 },
        { key = "adds", name = "Living Venoms", duration = 22, r = 0.7, g = 0.2, b = 0.8 },
        { key = "infection", name = "Adaptive Infection", duration = 28, r = 1, g = 0.5, b = 0.2 },
    },
}

function Boss:OnStart()
    self.Phase = "Brunnen – Position steuern"
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
end

function Boss:OnEnd() end

function Boss:OnCombatLogEvent()
    local _, subEvent, _, _, _, _, _, _, destName, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
    local S = self.SpellIDs
    if subEvent ~= "SPELL_CAST_SUCCESS" and subEvent ~= "SPELL_CAST_START"
        and subEvent ~= "SPELL_AURA_APPLIED" then
        return
    end

    if spellId == S.imbibe or (spellName and spellName:find("Imbibe")) then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:StartTimer("imbibe", "Imbibe", 35, 0.9, 0.3, 0.1)
            DragonSkill.BossMechanicsUI:StartTimer("adds", "Living Venoms → Cavity", 18, 0.7, 0.2, 0.8)
            DragonSkill.BossMechanicsUI:SetTip("Imbibe! Adds vor Cavity killen. Naechste 2 Brunnen beachten.")
            DragonSkill.BossMechanicsUI:ShowBigWarning("IMBIBE – Adds!", 2)
        end
        if DragonSkill.BossMechanics then DragonSkill.BossMechanics:PlaySound("WARNING") end

    elseif spellId == S.malignantBurst or (spellName and spellName:find("Malignant Burst")) then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:ShowBigWarning("Malignant Burst – Add am Cavity!", 3)
            DragonSkill.BossMechanicsUI:SetTip("Burst: Add hat Cavity erreicht – mehr Raid-Damage!")
        end
        if DragonSkill.BossMechanics then DragonSkill.BossMechanics:PlaySound("CRITICAL") end

    elseif spellId == S.malignantCatalyst or (spellName and spellName:find("Malignant Catalyst")) then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:StartTimer("catalyst", "Catalytic Bile", 8, 0.3, 0.9, 0.3)
            DragonSkill.BossMechanicsUI:SetTip("Catalyst – Bile soaken (mindestens 1 Spieler pro Spot)!")
        end

    elseif spellId == S.adaptiveInfection or spellId == S.explodingInfection
        or (spellName and (spellName:find("Adaptive Infection") or spellName:find("Exploding Infection"))) then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:StartTimer("infection", "Infection – raus!", 10, 1, 0.4, 0.1)
            DragonSkill.BossMechanicsUI:ShowBigWarning("INFECTION – Abstand!", 2)
            DragonSkill.BossMechanicsUI:SetTip("Infection: bei Exploding weit weg vom Raid. Siphoning = Heilen reduziert.")
        end
        if DragonSkill.BossMechanics then DragonSkill.BossMechanics:PlaySound("ALERT") end

    elseif spellId == S.toxicVapor or (spellName and spellName:find("Toxic Vapor")) then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:SetTip("Toxic Vapor Stacks steigen mit jedem Imbibe – Heiler aufpassen!")
        end
    end
end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Vashnik – Brunnen wechseln, Adds cleaven.")
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:StartTimer("imbibe", "Imbibe", 35, 0.9, 0.3, 0.1)
        DragonSkill.BossMechanicsUI:StartTimer("adds", "Living Venoms", 22, 0.7, 0.2, 0.8)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
end

DragonSkill.BossMechanics:RegisterBoss(3013, Boss)
