-- Nek'zali the Soulcoiler – Boss 1 Venomous Abyss
-- Adds zum Well stoppen. 50% Intermission. Energie = Enrage.

local Boss = {
    ID = 3011,
    Name = "Nek'zali the Soulcoiler",
    Aliases = { "nekzali", "nek", "soulcoiler", "nek'zali" },
    Phase = "Stufe 1 – Soulcoil Well",
    Tip = "Restless Amani NIEMALS zum Soulcoil Well. Essence Rend raus + dispellen. Bei 50%: Echoes of Jawae + Tethers. Energie voll = Uncoiled Rage (Wipe).",
    SpellIDs = {
        soulcoilWell = 1284032,
        soulcoilRite = 1284033,
        uncoiledRage = 1284034,
        soulcoilIgnition = 1285681,
        essenceRend = 1287426,
        restlessAmani = 1295397,
        graveboundAdvance = 1287533,
        possessionBarrage = 1284103,
        tetherOfAwakening = 1289696,
        hungeringPyre = 1289855,
        ritualBurn = 1297624,
        invoke = 1299673,
        soulcoiled = 1290361,
    },
    NpcIDs = {
        boss = 253563,
    },
    Timers = {
        { key = "ignition", name = "Soulcoil Ignition", duration = 28, r = 0.6, g = 0.2, b = 0.9 },
        { key = "adds", name = "Restless Amani", duration = 35, r = 0.9, g = 0.4, b = 0.2 },
        { key = "rend", name = "Essence Rend", duration = 22, r = 0.8, g = 0.3, b = 0.9 },
    },
}

function Boss:OnStart()
    self.Phase = "Stufe 1 – Soulcoil Well"
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

    if spellId == S.soulcoilIgnition or (spellName and spellName:find("Soulcoil Ignition")) then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:StartTimer("ignition", "Soulcoil Ignition", 28, 0.6, 0.2, 0.9)
            DragonSkill.BossMechanicsUI:SetTip("Ignition – Rite-Damage! Adds vom Well halten!")
        end
        if DragonSkill.BossMechanics then DragonSkill.BossMechanics:PlaySound("WARNING") end

    elseif spellId == S.soulcoilRite or (spellName and spellName:find("Soulcoil Rite")) then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:StartTimer("rite", "Soulcoil Rite", 24, 0.7, 0.1, 0.8)
            DragonSkill.BossMechanicsUI:ShowBigWarning("Soulcoil Rite – Raid-Damage!", 2)
        end
        if DragonSkill.BossMechanics then DragonSkill.BossMechanics:PlaySound("ALERT") end

    elseif spellId == S.uncoiledRage or (spellName and spellName:find("Uncoiled Rage")) then
        self.Phase = "ENRAGE – Uncoiled Rage"
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
            DragonSkill.BossMechanicsUI:SetTip("UNCOILED RAGE – Boss enraged (Energie voll)!")
            DragonSkill.BossMechanicsUI:ShowBigWarning("UNCOILED RAGE!", 5)
        end
        if DragonSkill.BossMechanics then DragonSkill.BossMechanics:PlaySound("CRITICAL") end

    elseif spellId == S.essenceRend or (spellName and spellName:find("Essence Rend")) then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:StartTimer("rend", "Essence Rend", 15, 0.8, 0.3, 0.9)
            DragonSkill.BossMechanicsUI:SetTip("Essence Rend – rauslaufen, dann dispellen (Latent Cultist)!")
        end

    elseif spellId == S.restlessAmani or (spellName and spellName:find("Restless Amani")) then
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:StartTimer("adds", "Restless Amani → Well", 20, 0.9, 0.4, 0.2)
            DragonSkill.BossMechanicsUI:ShowBigWarning("ADDS – Well blocken!", 2)
        end
        if DragonSkill.BossMechanics then DragonSkill.BossMechanics:PlaySound("WARNING") end

    elseif spellId == S.hungeringPyre or (spellName and spellName:find("Hungering Pyre")) then
        self.Phase = "Intermission – Ritual of Awakening"
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
            DragonSkill.BossMechanicsUI:StartTimer("pyre", "Hungering Pyre", 12, 1, 0.4, 0.1)
            DragonSkill.BossMechanicsUI:SetTip("Intermission: Echoes killen, Pyre soaken, Tethers trennen!")
        end
        if DragonSkill.BossMechanics then DragonSkill.BossMechanics:PlaySound("INTERMISSION") end

    elseif spellId == S.invoke or (spellName and spellName:find("Invoke")) then
        self.Phase = "Stufe 2 – Uncoiling"
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
            DragonSkill.BossMechanicsUI:SetTip("Stufe 2: Invoke + Rite. Boss killen bevor Energie voll!")
            DragonSkill.BossMechanicsUI:StartTimer("invoke", "Invoke", 25, 0.5, 0.2, 0.9)
        end
    end
end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Nek'zali – Stufe 1. Adds vom Well fernhalten.")
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:StartTimer("ignition", "Soulcoil Ignition", 28, 0.6, 0.2, 0.9)
        DragonSkill.BossMechanicsUI:StartTimer("adds", "Restless Amani", 35, 0.9, 0.4, 0.2)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
end

function Boss:SimulateIntermission()
    self.Phase = "Intermission – Ritual of Awakening"
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip("Echoes of Jawae → Tethers. Hungering Pyre soaken.")
        DragonSkill.BossMechanicsUI:StartTimer("pyre", "Hungering Pyre", 12, 1, 0.4, 0.1)
        DragonSkill.BossMechanicsUI:ShowBigWarning("INTERMISSION!", 3)
    end
    if DragonSkill.BossMechanics then DragonSkill.BossMechanics:PlaySound("INTERMISSION") end
end

DragonSkill.BossMechanics:RegisterBoss(3011, Boss)
