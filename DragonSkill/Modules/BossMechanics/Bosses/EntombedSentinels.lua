-- Dragon Skill - Boss: Entombed Sentinels
local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "Entombed Sentinels",
    ID = 3010, -- Placeholder
    ToxinSpellID = 456789, -- Placeholder
    players = {}
}

function Boss:OnStart()
    self.players = {}
end

function Boss:OnCombatLogEvent(...)
    local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, amount = CombatLogGetCurrentEventInfo()

    if spellID == self.ToxinSpellID then
        if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_APPLIED_DOSE" then
            self:UpdatePlayer(destName, amount or 1)
        elseif event == "SPELL_AURA_REMOVED" then
            self:UpdatePlayer(destName, 0)
        end
    end
end

function Boss:UpdatePlayer(name, stacks)
    if stacks > 0 then
        self.players[name] = stacks
    else
        self.players[name] = nil
    end
    self:CalculatePairs()
end

function Boss:CalculatePairs()
    local s1, s2, s3 = {}, {}, {}
    for name, stacks in pairs(self.players) do
        local p = {name = name, stacks = stacks}
        if stacks == 1 then table.insert(s1, p)
        elseif stacks == 2 then table.insert(s2, p)
        elseif stacks == 3 then table.insert(s3, p)
        end
    end

    local pairsList = {}
    local open = {}

    -- Pair 1 + 3
    while #s1 > 0 and #s3 > 0 do
        local p1 = table.remove(s1, 1)
        local p3 = table.remove(s3, 1)
        table.insert(pairsList, {p1 = p1, p2 = p3, done = false})
    end

    -- Pair 2 + 2
    while #s2 >= 2 do
        local p2a = table.remove(s2, 1)
        local p2b = table.remove(s2, 1)
        table.insert(pairsList, {p1 = p2a, p2 = p2b, done = false})
    end

    -- Remaining
    for _, p in ipairs(s1) do table.insert(open, p) end
    for _, p in ipairs(s2) do table.insert(open, p) end
    for _, p in ipairs(s3) do table.insert(open, p) end

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdatePairs(pairsList, open)
    end
end

function Boss:SimulateIntermission()
    local dummyPlayers = {}
    local num = GetNumGroupMembers()

    if num > 0 then
        -- Nutze echte Gruppennamen
        local unitPrefix = IsInRaid() and "raid" or "party"
        for i = 1, num do
            local name = GetUnitName(unitPrefix..i, true)
            if name then
                dummyPlayers[name] = math.random(1, 3)
            end
            if i >= 10 then break end -- Max 10 für den Test
        end
    else
        -- Fallback Dummy Spieler
        dummyPlayers = {
            ["Player1"] = 1, ["Player2"] = 3, ["Player3"] = 2,
            ["Player4"] = 2, ["Player5"] = 1, ["Player6"] = 1, ["Player7"] = 3
        }
    end

    self.players = dummyPlayers
    self:CalculatePairs()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("TEST: HELICAL TOXINS!", 5)
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
