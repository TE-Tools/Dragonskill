-- Dragon Skill - Boss Mechanics Core (v1.6.3)
-- Venomous Abyss + Tidebound Grotto Lair

local L = DragonSkill.L or {}

local BossMechanics = DragonSkill:RegisterModule("BossMechanics", {
    Bosses = {},
    BossesByName = {},
    CurrentBoss = nil,
})
DragonSkill.BossMechanics = BossMechanics

function BossMechanics:Init()
    -- Die Events werden jetzt sofort beim Laden der Datei registriert,
    -- um ADDON_ACTION_FORBIDDEN Fehler in 12.1 zu vermeiden.
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
    if encounterName then
        local key = string.lower(encounterName)
        if self.BossesByName[key] then
            return self.BossesByName[key]
        end
        for name, boss in pairs(self.BossesByName) do
            if key:find(name, 1, true) or name:find(key, 1, true) then
                return boss
            end
        end
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
            pcall(function() self.CurrentBoss:OnCombatLogEvent() end)
        end
    end)
end

function BossMechanics:Simulate(idOrName)
    local boss = self.Bosses[idOrName]
    if not boss and type(idOrName) == "string" then
        boss = self:FindBoss(nil, idOrName)
    end
    if not boss then
        print("|cffff0000Dragon Skill:|r " .. string.format(L.BOSS_NOT_FOUND or "Boss nicht gefunden: %s", tostring(idOrName)))
        self:ListBosses()
        return
    end
    print("|cff00ff00Dragon Skill:|r " .. (L.TEST_PREFIX or "Test → ") .. (boss.Name or tostring(idOrName)))
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

function BossMechanics:ListBosses()
    print("|cff00ff00" .. (L.BOSS_LIST_TITLE or "Dragon Skill – Bosse:") .. "|r")
    local ordered = { 3011, 3010, 3013, 3012, 3014, 3015, 3016, 3017, 3101 }
    local count = 0
    for _, id in ipairs(ordered) do
        local b = self.Bosses[id]
        if b then
            print(string.format("  |cffffd100%d|r  %s", id, b.Name or "?"))
            count = count + 1
        end
    end
    if count == 0 then
        for id, b in pairs(self.Bosses) do
            print(string.format("  |cffffd100%s|r  %s", tostring(id), b.Name or "?"))
            count = count + 1
        end
    end
    if count == 0 then
        print("  |cffffaa00" .. (L.NO_BOSSES_LOADED or "Keine Bosse geladen.") .. "|r")
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

-- Registrierung der Events sofort beim Laden der Datei (WoW 12.1 Sicherheit)
BossMechanics:RegisterEvents()

DragonSkill.Events:On("PLAYER_LOGIN", function()
    BossMechanics:Init()
end)
