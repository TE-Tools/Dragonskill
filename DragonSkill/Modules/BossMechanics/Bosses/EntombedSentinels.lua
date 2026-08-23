-- Dragon Skill - Boss: Entombed Sentinels (Eingeschlossene Wächter)
-- Update v1.6.4: Vollständiger 12.1 Support (Heroic & Mythic)
-- IDs: Helical Toxins (1284590), Protogift (1296880), Miasma (1288260)

local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    ID = 3010,
    Name = "Entombed Sentinels",
    Aliases = { "sentinels", "entombed", "golems" },
    Phase = "Split – 40y Abstand",
    Tip = "Heroic: Helical Toxins (1+3 / 2+2). Mythic: Unstetes Protogift – Partner finden!",

    -- Spell-IDs aus Patch 12.1
    ToxinID = 1284590,     -- Helical Toxins (Heroic)
    PrototoxinID = 1296880, -- Unstetes Protogift (Mythic)
    MiasmaID = 1288260,     -- Instabiles Miasma (Soak)

    helicalPlayers = {},    -- [Name] = Stacks (1-3)
    protoPlayers = {},      -- [Name] = Timestamp
    miasmaPlayers = {}      -- [Name] = true
}

function Boss:OnStart()
    self.helicalPlayers = {}
    self.protoPlayers = {}
    self.miasmaPlayers = {}
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:SetPhase(self.Phase)
        DragonSkill.BossMechanicsUI:SetTip(self.Tip)
    end
end

function Boss:OnCombatLogEvent(...)
    local _, event, _, _, _, _, _, _, destName, _, _, spellID, _, _, amount = CombatLogGetCurrentEventInfo()

    -- 1. Helical Toxins (Heroic)
    if spellID == self.ToxinID then
        if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_APPLIED_DOSE" then
            self.helicalPlayers[destName] = amount or 1
            self:UpdateUI()
        elseif event == "SPELL_AURA_REMOVED" then
            self.helicalPlayers[destName] = nil
            self:UpdateUI()
        end
    end

    -- 2. Unstetes Protogift (Mythic)
    if spellID == self.PrototoxinID then
        if event == "SPELL_AURA_APPLIED" then
            self.protoPlayers[destName] = GetTime()
            self:UpdateUI()
        elseif event == "SPELL_AURA_REMOVED" then
            self.protoPlayers[destName] = nil
            self:UpdateUI()
        end
    end

    -- 3. Instabiles Miasma (Soak)
    if spellID == self.MiasmaID then
        if event == "SPELL_AURA_APPLIED" then
            self.miasmaPlayers[destName] = true
            if destName == GetUnitName("player", true) then
                DragonSkill.BossMechanicsUI:ShowBigWarning("|cffff0000MIASMA AUF DIR! SOAKEN!|r", 5)
                BossMechanics:PlaySound("CRITICAL")
            end
            self:UpdateUI()
        elseif event == "SPELL_AURA_REMOVED" then
            self.miasmaPlayers[destName] = nil
            self:UpdateUI()
        end
    end
end

function Boss:UpdateUI()
    local pairsList = {}
    local open = {}

    -- A. Helical Pairing (1+3 / 2+2)
    local s1, s2, s3 = {}, {}, {}
    for name, stacks in pairs(self.helicalPlayers) do
        local p = { name = name, stacks = stacks }
        if stacks == 1 then table.insert(s1, p)
        elseif stacks == 2 then table.insert(s2, p)
        elseif stacks == 3 then table.insert(s3, p) end
    end
    while #s1 > 0 and #s3 > 0 do
        table.insert(pairsList, { p1 = table.remove(s1, 1), p2 = table.remove(s3, 1) })
    end
    while #s2 >= 2 do
        table.insert(pairsList, { p1 = table.remove(s2, 1), p2 = table.remove(s2, 1) })
    end

    -- B. Mythic Prototoxin Pairing (Zeit-basiert)
    local sortedProto = {}
    for name, t in pairs(self.protoPlayers) do
        table.insert(sortedProto, {name = name, time = t})
    end
    table.sort(sortedProto, function(a, b) return a.time < b.time end)
    while #sortedProto >= 2 do
        local p1 = table.remove(sortedProto, 1)
        local p2 = table.remove(sortedProto, 1)
        table.insert(pairsList, {
            p1 = { name = p1.name, stacks = "GIFT" },
            p2 = { name = p2.name, stacks = "GIFT" }
        })
    end

    -- C. Offene Listen & Miasma
    for _, p in ipairs(s1) do table.insert(open, p) end
    for _, p in ipairs(s2) do table.insert(open, p) end
    for _, p in ipairs(s3) do table.insert(open, p) end
    for _, p in ipairs(sortedProto) do table.insert(open, { name = p.name, stacks = "GIFT" }) end
    for name, _ in pairs(self.miasmaPlayers) do
        table.insert(open, { name = "|cffff8000SOAK:|r " .. name, stacks = "MIASMA" })
    end

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdatePairs(pairsList, open)
    end
end

function Boss:SimulateStart()
    self:OnStart()
    self.protoPlayers = {
        ["Thomas"] = GetTime(),
        ["Lisa"] = GetTime() + 0.1,
        ["Kevin"] = GetTime() + 0.2,
        ["Anna"] = GetTime() + 0.3
    }
    self.miasmaPlayers = { ["Markus"] = true }
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("TEST: ENCHANTED SENTINELS PAARE!", 5)
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
