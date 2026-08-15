-- Dragon Skill - Boss Mechanics UI
local UI = {}
DragonSkill.BossMechanicsUI = UI

local symbolColors = {
    [1] = {r=0, g=1, b=0},    -- Green
    [2] = {r=0.5, g=0, b=0.5}, -- Purple
    [3] = {r=0, g=0, b=1},    -- Blue
    [4] = {r=1, g=0.5, b=0},  -- Orange
    [5] = {r=1, g=1, b=0},    -- Yellow
    [6] = {r=0, g=1, b=1},    -- Cyan
    [7] = {r=1, g=0, b=0}     -- Red
}

function UI:Init()
    if self.frame then return end

    local f = CreateFrame("Frame", "DragonSkillBossMechanicsFrame", UIParent, "BackdropTemplate")
    f:SetSize(400, 300)
    f:SetPoint("CENTER", 300, 0)
    f:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    f:SetBackdropColor(0, 0, 0, 0.8)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self) self:StartMoving() end)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    f:Hide()

    self.frame = f

    f.Title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    f.Title:SetPoint("TOP", 0, -10)
    f.Title:SetText("Boss Mechanics - RaidLead Assistant")

    f.PairsContainer = CreateFrame("Frame", nil, f)
    f.PairsContainer:SetPoint("TOPLEFT", 10, -40)
    f.PairsContainer:SetPoint("BOTTOMRIGHT", -120, 10)

    f.OpenPlayersContainer = CreateFrame("Frame", nil, f)
    f.OpenPlayersContainer:SetPoint("TOPRIGHT", -10, -40)
    f.OpenPlayersContainer:SetSize(100, 250)

    f.OpenPlayersTitle = f.OpenPlayersContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.OpenPlayersTitle:SetPoint("TOP", 0, 0)
    f.OpenPlayersTitle:SetText("Offen")

    -- Center warning
    local w = CreateFrame("Frame", "DragonSkillBossWarning", UIParent)
    w:SetSize(600, 100)
    w:SetPoint("TOP", 0, -150)
    w.Text = w:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    w.Text:SetPoint("CENTER")
    w:Hide()
    self.warningFrame = w
end

function UI:OnBossStart(boss)
    self:Init()
    self.frame:Show()
    self.frame.Title:SetText("Boss: " .. (boss.Name or "Unknown"))
end

function UI:OnBossEnd()
    if self.frame then self.frame:Hide() end
    if self.warningFrame then self.warningFrame:Hide() end
end

function UI:UpdatePairs(pairs, openPlayers)
    if not self.frame then self:Init() end

    -- Clear previous
    if not self.pairFrames then self.pairFrames = {} end
    for _, rf in ipairs(self.pairFrames) do rf:Hide() end

    if not self.openFrames then self.openFrames = {} end
    for _, of in ipairs(self.openFrames) do of:Hide() end

    local yOffset = 0
    for i, pair in ipairs(pairs) do
        local row = self.pairFrames[i]
        if not row then
            row = CreateFrame("Frame", nil, self.frame.PairsContainer)
            row:SetSize(270, 30)

            row.symbol = row:CreateTexture(nil, "ARTWORK")
            row.symbol:SetSize(16, 16)
            row.symbol:SetPoint("LEFT", 0, 0)
            row.symbol:SetColorTexture(1, 1, 1)

            row.p1Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.p1Text:SetPoint("LEFT", 25, 0)

            row.p2Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.p2Text:SetPoint("LEFT", 140, 0)

            row.check = row:CreateTexture(nil, "OVERLAY")
            row.check:SetSize(16, 16)
            row.check:SetPoint("RIGHT", -10, 0)
            row.check:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")

            self.pairFrames[i] = row
        end

        row:SetPoint("TOPLEFT", 0, yOffset)
        local c = symbolColors[i] or {r=1, g=1, b=1}
        row.symbol:SetVertexColor(c.r, c.g, c.b)

        row.p1Text:SetText(pair.p1.name .. " (" .. pair.p1.stacks .. ")")
        row.p2Text:SetText(pair.p2.name .. " (" .. pair.p2.stacks .. ")")

        if pair.done then
            row.p1Text:SetTextColor(0.5, 0.5, 0.5)
            row.p2Text:SetTextColor(0.5, 0.5, 0.5)
            row.symbol:SetAlpha(0.3)
            row.check:Show()
        else
            row.p1Text:SetTextColor(1, 1, 1)
            row.p2Text:SetTextColor(1, 1, 1)
            row.symbol:SetAlpha(1)
            row.check:Hide()
        end

        row:Show()
        yOffset = yOffset - 35
    end

    yOffset = -20
    for i, player in ipairs(openPlayers) do
        local pText = self.openFrames[i]
        if not pText then
            pText = self.frame.OpenPlayersContainer:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            self.openFrames[i] = pText
        end
        pText:SetPoint("TOPLEFT", 0, yOffset)
        pText:SetText(player.name .. " (" .. player.stacks .. ")")
        pText:Show()
        yOffset = yOffset - 15
    end
end

function UI:ShowBigWarning(text, duration)
    if not self.warningFrame then self:Init() end
    self.warningFrame.Text:SetText(text)
    self.warningFrame:Show()
    C_Timer.After(duration or 3, function() self.warningFrame:Hide() end)
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
end)
