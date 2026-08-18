-- The Coiled Altar – Boss 7 Venomous Abyss (Encounter 3016)
-- 3 Phasen + Intermission. Raumkontrolle + Heiler-Mana.

local Boss = {
    ID = 3016,
    Name = "The Coiled Altar",
    Aliases = { "coiled", "altar", "zuljan" },
    Phase = "Stufe 1 – Serpent's Bargain",
    Tip = "Toxic Deluge → Coalesced Venom. Guillotine/Sever beobachten. Phase 3 kombiniert alles – Raum und Mana managen. Unnerving Fixation fuer Achievement.",
    Timers = {
        { key = "deluge", name = "Toxic Deluge", duration = 32, r = 0.2, g = 0.9, b = 0.4 },
        { key = "guillotine", name = "Guillotine", duration = 20, r = 0.9, g = 0.1, b = 0.1 },
    },
}

function Boss:OnStart()
    self.Phase = "Stufe 1 – Serpent's Bargain"
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
end

function Boss:OnEnd() end

function Boss:OnCombatLogEvent()
    local _, subEvent, _, _, _, _, _, _, _, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
    if subEvent == "SPELL_CAST_SUCCESS" or subEvent == "SPELL_CAST_START" then
        if spellName and spellName:find("Soulbinding") then
            self.Phase = "Intermission – Soulbinding"
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
                DragonSkill.BossMechanicsUI:SetTip("Malacrass Soulbinding – Zul'jan wird wiederbelebt. Burn-Phase vorbereiten.")
            end
            DragonSkill.BossMechanics:PlaySound("INTERMISSION")
        end
    end
end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Coiled Altar – 3 Phasen, Raumkontrolle + Heiler-Mana.")
end

function Boss:SimulateIntermission()
    self.Phase = "Intermission – Soulbinding"
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:StartTimer("soulbind", "Soulbinding", 40, 0.8, 0.2, 0.8)
    end
end

DragonSkill.BossMechanics:RegisterBoss(3016, Boss)
