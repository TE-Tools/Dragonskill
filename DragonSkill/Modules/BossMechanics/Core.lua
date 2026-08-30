-- Dragon Skill - Boss Mechanics Core (v2.0.1)
-- Patch 12.1 Ready: Using UNIT_AURA instead of restricted CLEU.

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
end

function BossMechanics:FindBoss(encounterID, encounterName)
    if encounterID and self.Bosses[encounterID] then return self.Bosses[encounterID] end
    if encounterName then
        local key = string.lower(encounterName)
        if self.BossesByName[key] then return self.BossesByName[key] end
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

    -- WoW 12.1 Fix: Nutze UNIT_AURA fuer Boss-Mechaniken (CLEU ist verboten)
    DragonSkill.Events:On("UNIT_AURA", function(unit)
        if self.CurrentBoss and self.CurrentBoss.OnUnitAura then
            -- Wir filtern hier auf Gruppe/Raid fuer Performance
            if unit:find("raid") or unit:find("party") or unit == "player" then
                self.CurrentBoss:OnUnitAura(unit)
            end
        end
    end)
end

function BossMechanics:Simulate(idOrName)
    local boss = self.Bosses[idOrName] or self:FindBoss(nil, idOrName)
    if not boss then return end
    self.CurrentBoss = boss
    if boss.OnStart then boss:OnStart() end
    if DragonSkill.BossMechanicsUI then DragonSkill.BossMechanicsUI:OnBossStart(boss) end
    if boss.SimulateStart then boss:SimulateStart() end
end

function BossMechanics:PlaySound(kind)
    local sounds = { START = 567478, WARNING = 876098, CRITICAL = 1489541 }
    local id = sounds[kind]
    if id then PlaySound(id, "Master") end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    BossMechanics:Init()
end)
