-- Dragon Skill - Boss Mechanics Core
local BossMechanics = DragonSkill:RegisterModule("BossMechanics", {
    Bosses = {},
    CurrentBoss = nil
})

function BossMechanics:Init()
    self:RegisterEvents()
end

function BossMechanics:RegisterBoss(id, bossTable)
    self.Bosses[id] = bossTable
end

function BossMechanics:RegisterEvents()
    DragonSkill.Events:On("ENCOUNTER_START", function(encounterID)
        if self.Bosses[encounterID] then
            self.CurrentBoss = self.Bosses[encounterID]
            if self.CurrentBoss.OnStart then self.CurrentBoss:OnStart() end
            if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(self.CurrentBoss) end
        end
    end)

    DragonSkill.Events:On("ENCOUNTER_END", function()
        if self.CurrentBoss then
            if self.CurrentBoss.OnEnd then self.CurrentBoss:OnEnd() end
            if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossEnd() end
            self.CurrentBoss = nil
        end
    end)

    DragonSkill.Events:On("COMBAT_LOG_EVENT_UNFILTERED", function(...)
        if self.CurrentBoss and self.CurrentBoss.OnCombatLogEvent then
            self.CurrentBoss:OnCombatLogEvent(...)
        end
    end)
end

function BossMechanics:SimulateEntombedSentinels()
    print("|cff00ff00Dragon Skill:|r Starte Test für Entombed Sentinels...")
    local boss = self.Bosses[3010] -- Placeholder ID
    if boss then
        self.CurrentBoss = boss
        if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
        if boss.SimulateIntermission then boss:SimulateIntermission() end
    else
        print("|cffff0000Fehler:|r Boss 'Entombed Sentinels' nicht registriert.")
    end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    BossMechanics:Init()
end)
