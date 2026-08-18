-- Entombed Sentinels – Boss 2 Venomous Abyss (Encounter 3010)
-- Zwei Golems. Helical Toxins: Stacks 1+3 oder 2+2 zusammenlaufen.

local Boss = {
    ID = 3010,
    Name = "Entombed Sentinels",
    Aliases = { "sentinels", "entombed", "golems" },
    Phase = "Split – 40y Abstand",
    Tip = "Raid halbieren, Bosse >40y (sonst Ula'teks Dominanz 99% DR). Helical Toxins: genau 4 Stacks (1+3 / 2+2). Spell 1284590.",
    -- Offizielle Spell-IDs (warcraft.wiki.gg / Wowhead 12.1)
    ToxinSpellIDs = {
        [1284590] = true, -- Helical Toxins (Debuff)
        [1284588] = true, -- Vitriolic Stasis
        [1284941] = true, -- Cultivated Burst
    },
    SpellIDs = {
        helicalToxins = 1284590,
        vitriolicStasis = 1284588,
        cultivatedBurst = 1284941,
        ulateksDominance = 1290193,
        markOfAcid = 1284494,
        markOfBlood = 1284503,
    },
    NpcIDs = {
        breath = 258557, -- Breath of Ula'tek
        blood = 258558,  -- Blood of Ula'tek
    },
    Timers = {
        { key = "stasis", name = "Vitriolic Stasis", duration = 30, r = 0.2, g = 0.9, b = 0.3 },
        { key = "marks", name = "Helical Toxins", duration = 28, r = 0.9, g = 0.6, b = 0.1 },
    },
    players = {},
}

local function IsToxinSpell(spellId, spellName)
    if spellId and Boss.ToxinSpellIDs[spellId] then
        return true
    end
    if spellName then
        local n = spellName:lower()
        if n:find("helical") or n:find("toxin") or n:find("helikale") then
            return true
        end
    end
    return false
end

local function UnitTokenByName(playerName)
    if not playerName then return nil end
    local short = playerName:match("^([^-]+)") or playerName
    if UnitName("player") == short or UnitName("player") == playerName then
        return "player"
    end
    if IsInRaid() then
        for i = 1, 40 do
            local u = "raid" .. i
            local n = GetUnitName(u, true)
            if n == playerName or n == short or (n and (n:match("^([^-]+)") == short)) then
                return u
            end
        end
    elseif IsInGroup() then
        for i = 1, 4 do
            local u = "party" .. i
            local n = GetUnitName(u, true)
            if n == playerName or n == short or (n and (n:match("^([^-]+)") == short)) then
                return u
            end
        end
    end
    return nil
end

function Boss:OnStart()
    self.players = {}
    self.Phase = "Split – 40y Abstand"
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
        if DragonSkill.BossMechanicsUI.ClearPairs then
            DragonSkill.BossMechanicsUI:ClearPairs()
        end
    end
end

function Boss:OnEnd()
    self.players = {}
    if DragonSkill.BossMechanicsUI and DragonSkill.BossMechanicsUI.ClearPairs then
        DragonSkill.BossMechanicsUI:ClearPairs()
    end
end

function Boss:UpdatePlayer(name, stacks)
    if not name then return end
    if stacks and stacks > 0 then
        self.players[name] = stacks
    else
        self.players[name] = nil
    end
    self:CalculatePairs()
end

function Boss:CalculatePairs()
    local s1, s2, s3 = {}, {}, {}
    for name, stacks in pairs(self.players) do
        local p = { name = name, stacks = stacks }
        if stacks == 1 then table.insert(s1, p)
        elseif stacks == 2 then table.insert(s2, p)
        elseif stacks == 3 then table.insert(s3, p)
        end
    end

    local pairsList = {}
    local open = {}

    while #s1 > 0 and #s3 > 0 do
        local p1 = table.remove(s1, 1)
        local p3 = table.remove(s3, 1)
        table.insert(pairsList, { p1 = p1, p2 = p3, done = false, sum = 4 })
    end

    while #s2 >= 2 do
        local a = table.remove(s2, 1)
        local b = table.remove(s2, 1)
        table.insert(pairsList, { p1 = a, p2 = b, done = false, sum = 4 })
    end

    for _, p in ipairs(s1) do table.insert(open, p) end
    for _, p in ipairs(s2) do table.insert(open, p) end
    for _, p in ipairs(s3) do table.insert(open, p) end

    if DragonSkill.BossMechanicsUI and DragonSkill.BossMechanicsUI.UpdatePairs then
        DragonSkill.BossMechanicsUI:UpdatePairs(pairsList, open)
    end

    self:ApplyRaidMarkers(pairsList)
end

function Boss:ApplyRaidMarkers(pairsList)
    if not IsInGroup() then return end
    if not (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
        return
    end
    for name in pairs(self.players) do
        local u = UnitTokenByName(name)
        if u then SetRaidTarget(u, 0) end
    end
    for i, pair in ipairs(pairsList) do
        local icon = ((i - 1) % 8) + 1
        for _, side in ipairs({ pair.p1, pair.p2 }) do
            local u = UnitTokenByName(side.name)
            if u then SetRaidTarget(u, icon) end
        end
    end
end

function Boss:OnCombatLogEvent()
    local _, subEvent, _, _, _, _, _, _, destName, _, _, spellId, spellName, _, amount =
        CombatLogGetCurrentEventInfo()

    if not IsToxinSpell(spellId, spellName) then
        if subEvent == "SPELL_CAST_SUCCESS" or subEvent == "SPELL_CAST_START" then
            if spellId == 1284588 or (spellName and (spellName:find("Vitriolic Stasis") or spellName:find("Stasis"))) then
                if DragonSkill.BossMechanicsUI then
                    DragonSkill.BossMechanicsUI:StartTimer("stasis", "Vitriolic Stasis", 30, 0.2, 0.9, 0.3)
                    DragonSkill.BossMechanicsUI:SetTip("Stasis – schwaecheren Golem heilen, Toxins auf 4 Stacks!")
                end
                if DragonSkill.BossMechanics and DragonSkill.BossMechanics.PlaySound then
                    DragonSkill.BossMechanics:PlaySound("INTERMISSION")
                end
            end
        end
        return
    end

    -- Helical Toxins stacks (1284590)
    if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_APPLIED_DOSE" then
        local stacks = amount or 1
        if subEvent == "SPELL_AURA_APPLIED_DOSE" and amount then
            stacks = amount
        end
        self:UpdatePlayer(destName, stacks)
        if DragonSkill.BossMechanicsUI and DragonSkill.BossMechanicsUI.ShowBigWarning then
            DragonSkill.BossMechanicsUI:ShowBigWarning("Helical Toxins – Paare checken!", 2)
        end
    elseif subEvent == "SPELL_AURA_REMOVED" then
        self:UpdatePlayer(destName, 0)
    elseif subEvent == "SPELL_AURA_REMOVED_DOSE" and amount then
        self:UpdatePlayer(destName, amount)
    end
end

function Boss:SimulateStart()
    print("|cff00ff00DS BossSim:|r Entombed Sentinels – Helical Toxins Paar-Test.")
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:StartTimer("stasis", "Vitriolic Stasis", 30, 0.2, 0.9, 0.3)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
    self:SimulateIntermission()
end

function Boss:SimulateIntermission()
    local dummy = {}
    local num = GetNumGroupMembers() or 0
    if num > 0 then
        local prefix = IsInRaid() and "raid" or "party"
        local maxI = IsInRaid() and num or math.min(num, 4)
        local me = GetUnitName("player", true)
        if me then dummy[me] = math.random(1, 3) end
        for i = 1, maxI do
            local name = GetUnitName(prefix .. i, true)
            if name then dummy[name] = math.random(1, 3) end
            if i >= 10 then break end
        end
    else
        dummy = {
            ["Spieler1"] = 1, ["Spieler2"] = 3, ["Spieler3"] = 2,
            ["Spieler4"] = 2, ["Spieler5"] = 1, ["Spieler6"] = 3,
            ["Spieler7"] = 1, ["Spieler8"] = 3,
        }
    end
    self.players = dummy
    self:CalculatePairs()
    if DragonSkill.BossMechanicsUI and DragonSkill.BossMechanicsUI.ShowBigWarning then
        DragonSkill.BossMechanicsUI:ShowBigWarning("TEST: HELICAL TOXINS – Paare!", 4)
    end
    print("|cff00ff00DS BossSim:|r Paare berechnet (1+3 / 2+2). Siehe Overlay.")
end

DragonSkill.BossMechanics:RegisterBoss(3010, Boss)
