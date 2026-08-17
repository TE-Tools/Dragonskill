-- Dragon Skill - Boss Mechanics Core (v1.6.3)
-- Venomous Abyss + Tidebound Grotto Lair

local BossMechanics = DragonSkill:RegisterModule("BossMechanics", {
    Bosses = {},
    BossesByName = {},
    CurrentBoss = nil,
})

function BossMechanics:Init()
    self:RegisterEvents()
end

function BossMechanics:RegisterBoss(id, bossTable)
    self.Bosses[id] = bossTable
    if bossTable.Name then
        self.BossesByName[string.lower(bossTable.Name)] = bossTable
        local short = bossTable.Name:match("^([^%s,]+)")
        if short then
            self.BossesByName[string.lower(short)] = bossTable
        end
    end
    if bossTable.Aliases then
        for _, a in ipairs(bossTable.Aliases) do
            self.BossesByName[string.lower(a)] = bossTable
        end
    end
end

function BossMechanics:FindBoss(encounterID, encounterName)
    if encounterID and self.Bosses[encounterID] then
        return self.Bosses[encounterID]
    end
    if encounterName and self.BossesByName[string.lower(encounterName)] then
        return self.BossesByName[string.lower(encounterName)]
    end
    return nil
end

function BossMechanics:RegisterEvents()
    DragonSkill.Events:On("ENCOUNTER_START", function(encounterID, encounterName)
        local boss = self:FindBoss(encounterID, encounterName)
        if not boss then return end
        self.CurrentBoss = boss
        if boss.OnStart then boss:OnStart() end
        if DragonSkill.BossMechanicsUI then
            DragonSkill.BossMechanicsUI:OnBossStart(boss)
        end
        self:PlaySound("START")
    end)

    DragonSkill.Events:On("ENCOUNTER_END", function()
        if self.CurrentBoss then
            if self.CurrentBoss.OnEnd then self.CurrentBoss:OnEnd() end
            if DragonSkill.BossMechanicsUI then
                DragonSkill.BossMechanicsUI:OnBossEnd()
            end
            self.CurrentBoss = nil
        end
    end)

    DragonSkill.Events:On("COMBAT_LOG_EVENT_UNFILTERED", function()
        if self.CurrentBoss and self.CurrentBoss.OnCombatLogEvent then
            local ok, err = pcall(function()
                self.CurrentBoss:OnCombatLogEvent()
            end)
            if not ok then
                -- still und leise: kein Spam bei kaputten Boss-Handlern
            end
        end
    end)
end

function BossMechanics:Simulate(idOrName)
    local boss = self.Bosses[idOrName]
    if not boss and type(idOrName) == "string" then
        boss = self.BossesByName[string.lower(idOrName)]
    end
    if not boss then
        print("|cffff0000Dragon Skill:|r Boss nicht gefunden: " .. tostring(idOrName))
        self:ListBosses()
        return
    end
    print("|cff00ff00Dragon Skill:|r Test → " .. (boss.Name or tostring(idOrName)))
    self.CurrentBoss = boss
    if boss.OnStart then boss:OnStart() end
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:OnBossStart(boss)
    end
    self:PlaySound("START")
    if boss.SimulateStart then
        boss:SimulateStart()
    elseif boss.SimulateIntermission then
        boss:SimulateIntermission()
    end
end

-- Kompatibilitaet zu alten Slash-Tests
function BossMechanics:SimulateEntombedSentinels() self:Simulate(3010) end
function BossMechanics:SimulateNekzali() self:Simulate(3011) end
function BossMechanics:SimulateLostExplorers() self:Simulate(3012) end
function BossMechanics:SimulateVashnik() self:Simulate(3013) end
function BossMechanics:SimulateSszorak() self:Simulate(3014) end
function BossMechanics:SimulateTwinFangs() self:Simulate(3015) end
function BossMechanics:SimulateCoiledAltar() self:Simulate(3016) end
function BossMechanics:SimulateUlatek() self:Simulate(3017) end
function BossMechanics:SimulateNymrissa() self:Simulate(3101) end

function BossMechanics:ListBosses()
    print("|cff00ff00Dragon Skill – Bosses (Venomous Abyss + Lair):|r")
    local ordered = { 3011, 3010, 3013, 3012, 3014, 3015, 3016, 3017, 3101 }
    local count = 0
    for _, id in ipairs(ordered) do
        local b = self.Bosses[id]
        if b then
            print(string.format("  |cffffd100%d|r  %s", id, b.Name or "?"))
            count = count + 1
        end
    end
    -- Fallback: alle registrierten
    if count == 0 then
        for id, b in pairs(self.Bosses) do
            print(string.format("  |cffffd100%s|r  %s", tostring(id), b.Name or "?"))
            count = count + 1
        end
    end
    if count == 0 then
        print("  |cffffaa00Keine Bosse geladen (Boss-Dateien pruefen).|r")
    end
    print("  /ds boss <name|id>   ·  /ds boss list")
end

function BossMechanics:PlaySound(kind)
    local sounds = {
        START = 567478,
        INTERMISSION = 8959,
        WARNING = 876098,
        ALERT = 567482,
        DONE = 567499,
        CRITICAL = 1489541,
    }
    local id = sounds[kind]
    if id then PlaySound(id, "Master") end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    BossMechanics:Init()
end)
