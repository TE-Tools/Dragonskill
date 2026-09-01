-- Dragon Skill - Boss Mechanics Core (v2.3.7)
-- Substring/alias FindBoss, UNIT_AURA + optional CLEU for boss scripts.

local L = DragonSkill.L or {}

local BossMechanics = DragonSkill:RegisterModule("BossMechanics", {
    Bosses = {},
    BossesByName = {},
    CurrentBoss = nil,
})
DragonSkill.BossMechanics = BossMechanics

function BossMechanics:Init()
    self:RegisterEvents()
end

function BossMechanics:RegisterBoss(id, bossTable)
    self.Bosses[id] = bossTable
    if bossTable.Name then
        self.BossesByName[string.lower(bossTable.Name)] = bossTable
    end
    if bossTable.Aliases then
        for _, a in ipairs(bossTable.Aliases) do
            if a and a ~= "" then
                self.BossesByName[string.lower(a)] = bossTable
            end
        end
    end
end

function BossMechanics:FindBoss(encounterID, encounterName)
    if encounterID and self.Bosses[encounterID] then
        return self.Bosses[encounterID]
    end
    if not encounterName or encounterName == "" then return nil end

    local key = string.lower(encounterName)
    if self.BossesByName[key] then return self.BossesByName[key] end

    -- Substring match (pull names often differ slightly)
    for name, boss in pairs(self.BossesByName) do
        if key:find(name, 1, true) or name:find(key, 1, true) then
            return boss
        end
    end

    -- Token match on full boss Name
    for _, boss in pairs(self.Bosses) do
        if boss.Name then
            local bn = string.lower(boss.Name)
            if key:find(bn, 1, true) or bn:find(key, 1, true) then
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
        if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
        self:PlaySound("START")
    end)

    DragonSkill.Events:On("ENCOUNTER_END", function()
        if self.CurrentBoss then
            if self.CurrentBoss.OnEnd then self.CurrentBoss:OnEnd() end
            if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossEnd() end
            self.CurrentBoss = nil
        end
    end)

    DragonSkill.Events:On("UNIT_AURA", function(unit)
        if self.CurrentBoss and self.CurrentBoss.OnUnitAura then
            if unit and (unit == "player" or unit:find("raid", 1, true) or unit:find("party", 1, true)) then
                self.CurrentBoss:OnUnitAura(unit)
            end
        end
    end)

    -- Optional CLEU for bosses that implement OnCombatLogEvent (may fail silently on restricted realms)
    DragonSkill.Events:On("COMBAT_LOG_EVENT_UNFILTERED", function()
        if self.CurrentBoss and self.CurrentBoss.OnCombatLogEvent then
            self.CurrentBoss:OnCombatLogEvent()
        end
    end)
end

function BossMechanics:Simulate(idOrName)
    local boss = self.Bosses[idOrName] or self:FindBoss(nil, tostring(idOrName))
    if not boss then return end
    self.CurrentBoss = boss
    if boss.OnStart then boss:OnStart() end
    if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
    if boss.SimulateStart then boss:SimulateStart() end
end

function BossMechanics:PlaySound(kind)
    local sounds = {
        START = 567478,
        WARNING = 876098,
        ALERT = 876098,
        CRITICAL = 1489541,
        INTERMISSION = 567478,
    }
    local id = sounds[kind]
    if id then pcall(PlaySound, id, "Master") end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    BossMechanics:Init()
end)
