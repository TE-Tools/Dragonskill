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
    local boss = self.Bosses[3010]
    if boss then
        self:PlaySound("INTERMISSION")
        self.CurrentBoss = boss
        if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
        if boss.SimulateIntermission then boss:SimulateIntermission() end
    else
        print("|cffff0000Fehler:|r Boss 'Entombed Sentinels' nicht registriert.")
    end
end

function BossMechanics:SimulateNekzali()
    print("|cff00ff00Dragon Skill:|r Starte Test für Nek'zali...")
    local boss = self.Bosses[3011]
    if boss then
        self:PlaySound("START")
        self.CurrentBoss = boss
        if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
        if boss.SimulateStart then boss:SimulateStart() end
    else
        print("|cffff0000Fehler:|r Boss 'Nek'zali' nicht registriert.")
    end
end

function BossMechanics:SimulateLostExplorers()
    print("|cff00ff00Dragon Skill:|r Starte Test für The Lost Explorers...")
    local boss = self.Bosses[3012]
    if boss then
        self:PlaySound("START")
        self.CurrentBoss = boss
        if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
        if boss.SimulateStart then boss:SimulateStart() end
    else
        print("|cffff0000Fehler:|r Boss 'The Lost Explorers' nicht registriert.")
    end
end

function BossMechanics:SimulateVashnik()
    print("|cff00ff00Dragon Skill:|r Starte Test für Vashnik...")
    local boss = self.Bosses[3013]
    if boss then
        self:PlaySound("START")
        self.CurrentBoss = boss
        if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
        if boss.SimulateStart then boss:SimulateStart() end
    else
        print("|cffff0000Fehler:|r Boss 'Vashnik' nicht registriert.")
    end
end

function BossMechanics:SimulateSszorak()
    print("|cff00ff00Dragon Skill:|r Starte Test für Sszorak...")
    local boss = self.Bosses[3014]
    if boss then
        self:PlaySound("START")
        self.CurrentBoss = boss
        if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
        if boss.SimulateStart then boss:SimulateStart() end
    else
        print("|cffff0000Fehler:|r Boss 'Sszorak' nicht registriert.")
    end
end

function BossMechanics:SimulateTwinFangs()
    print("|cff00ff00Dragon Skill:|r Starte Test für Twin Fangs...")
    local boss = self.Bosses[3015]
    if boss then
        self:PlaySound("START")
        self.CurrentBoss = boss
        if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
        if boss.SimulateStart then boss:SimulateStart() end
    else
        print("|cffff0000Fehler:|r Boss 'Twin Fangs' nicht registriert.")
    end
end

function BossMechanics:PlaySound(type)
    local sounds = {
        START = 567478, -- Ready Check
        INTERMISSION = 8959, -- Raid Warning
        WARNING = 876098, -- Boss Whisper
        ALERT = 567482, -- Quest Progress
        DONE = 567499, -- Progress
        CRITICAL = 1489541, -- High resonance
    }
    local id = sounds[type]
    if id then
        PlaySound(id, "Master")
    end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    BossMechanics:Init()
end)
