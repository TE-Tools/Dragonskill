-- Dragon Skill - Boss: Entombed Sentinels (v2.0.1)
-- 12.1 Ready: Using C_UnitAuras instead of restricted Combat Log.

local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    ID = 3010,
    Name = "Entombed Sentinels",
    -- Spell-IDs aus Patch 12.1
    ToxinID = 1284590,      -- Helical Toxins (Heroic)
    PrototoxinID = 1296880,  -- Unstetes Protogift (Mythic)
    MiasmaID = 1288260,      -- Instabiles Miasma (Soak)

    helicalPlayers = {},
    protoPlayers = {},
    miasmaPlayers = {}
}

function Boss:OnStart()
    self.helicalPlayers = {}
    self.protoPlayers = {}
    self.miasmaPlayers = {}
end

-- WoW 12.1 Fix: Wir scannen die Auren der Einheit bei jedem UNIT_AURA Event
function Boss:OnUnitAura(unit)
    local name = GetUnitName(unit, true)
    if not name then return end

    -- Reset status for this player
    self.helicalPlayers[name] = nil
    self.protoPlayers[name] = nil
    self.miasmaPlayers[name] = nil

    -- Scan for 12.1 Boss Auras
    for i = 1, 40 do
        local aura = C_UnitAuras.GetAuraDataByIndex(unit, i, "HARMFUL")
        if not aura then break end

        if aura.spellId == self.ToxinID then
            self.helicalPlayers[name] = aura.applications or 1
        elseif aura.spellId == self.PrototoxinID then
            self.protoPlayers[name] = GetTime() -- Store timestamp for pairing
        elseif aura.spellId == self.MiasmaID then
            self.miasmaPlayers[name] = true
            if name == GetUnitName("player", true) then
                DragonSkill.BossMechanicsUI:ShowBigWarning("|cffff0000MIASMA AUF DIR!|r", 3)
            end
        end
    end

    self:UpdateUI()
end

function Boss:UpdateUI()
    local pairsList = {}
    local open = {}

    -- 1. Helical Pairing (Heroic 1+3 / 2+2)
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

    -- 2. Mythic Prototoxin Pairing
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

    -- 3. Open Warnungen
    for name, _ in pairs(self.miasmaPlayers) do
        table.insert(open, { name = "|cffff8000SOAK:|r " .. name, stacks = "MIASMA" })
    end

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdatePairs(pairsList, open)
    end
end

function Boss:SimulateStart()
    self:OnStart()
    self.protoPlayers = { ["Thomas"] = GetTime(), ["Lisa"] = GetTime() }
    self.miasmaPlayers = { ["Markus"] = true }
    self:UpdateUI()
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
