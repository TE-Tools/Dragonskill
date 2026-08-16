-- Dragon Skill - Boss: Sszorak (Wind Tunnel & Cysts)
local BossMechanics = DragonSkill:GetModule("BossMechanics")

local Boss = {
    Name = "Sszorak",
    ID = 3014,
    CystSpellID = 458000, -- Placeholder
    players = {},
    windOrder = {}
}

function Boss:OnStart()
    self.players = {}
    self.windOrder = {}
end

function Boss:OnCombatLogEvent(...)
    local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID = CombatLogGetCurrentEventInfo()

    if spellID == self.CystSpellID then
        if event == "SPELL_AURA_APPLIED" then
            self:AssignCyst(destName)
        end
    end
end

function Boss:AssignCyst(name)
    -- Logik: Weise Spieler einem Tunnel zu (1, 2 oder 3 Orbs)
    local tunnel = #self.players % 3 + 1
    self.players[name] = tunnel
    self:UpdateUI()
end

function Boss:UpdateUI()
    local list = {}
    for name, tunnel in pairs(self.players) do
        table.insert(list, { name = name .. " -> TUNNEL " .. tunnel, stacks = tunnel })
    end

    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:UpdatePairs({}, list)
    end
end

function Boss:SimulateStart()
    self.players = {
        ["Player1"] = 1,
        ["Player2"] = 2,
        ["Player3"] = 3
    }
    self:UpdateUI()
    if DragonSkill.BossMechanicsUI then
        DragonSkill.BossMechanicsUI:ShowBigWarning("SSZORAK: DROP CYSTS OPPOSITE WIND!", 5)
        BossMechanics:PlaySound("INTERMISSION")
    end
end

BossMechanics:RegisterBoss(Boss.ID, Boss)
