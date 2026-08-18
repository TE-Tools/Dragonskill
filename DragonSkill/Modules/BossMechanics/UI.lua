-- Dragon Skill - Boss Mechanics UI (v1.6.3)
-- Overlay: Timer + Helical-Toxins-Paare (1+3 / 2+2) mit farbigen Zeichen

local UI = {}
DragonSkill.BossMechanicsUI = UI

local frame, title, phaseText, tipText
local pairsTitle, pairsContainer, openTitle, openContainer
local timerBars = {}
local pairFrames = {}
local openFrames = {}
local MAX_TIMERS = 6
local activeBoss = nil
local warningFrame

local symbolColors = {
    [1] = { r = 1.00, g = 0.92, b = 0.00 },
    [2] = { r = 1.00, g = 0.50, b = 0.00 },
    [3] = { r = 0.80, g = 0.20, b = 1.00 },
    [4] = { r = 0.20, g = 0.80, b = 0.20 },
    [5] = { r = 0.40, g = 0.70, b = 1.00 },
    [6] = { r = 0.20, g = 0.90, b = 0.90 },
    [7] = { r = 1.00, g = 0.20, b = 0.20 },
    [8] = { r = 0.90, g = 0.90, b = 0.95 },
}

local function CreateTimerBar(parent, index)
    local bar = CreateFrame("StatusBar", nil, parent, "BackdropTemplate")
    bar:SetSize(250, 16)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetStatusBarColor(0.2, 0.7, 1.0)
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    bar:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, -55 - (index - 1) * 20)
    bar:Hide()

    local bg = bar:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.1, 0.1, 0.1, 0.7)

    local label = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("LEFT", bar, "LEFT", 4, 0)
    label:SetJustifyH("LEFT")
    bar.label = label

    local timeLabel = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    timeLabel:SetPoint("RIGHT", bar, "RIGHT", -4, 0)
    bar.timeLabel = timeLabel

    bar.duration = 0
    bar.expires = 0
    bar.key = nil
    return bar
end

function UI:CreateFrame()
    if frame then return end

    frame = CreateFrame("Frame", "DragonSkillBossFrame", UIParent, "BackdropTemplate")
    frame:SetSize(360, 420)
    frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -40, -160)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 14,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0.05, 0.05, 0.1, 0.94)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:Hide()

    title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -12)
    title:SetTextColor(1, 0.82, 0)

    phaseText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    phaseText:SetPoint("TOP", title, "BOTTOM", 0, -4)
    phaseText:SetTextColor(0.6, 0.9, 1)

    for i = 1, MAX_TIMERS do
        timerBars[i] = CreateTimerBar(frame, i)
    end

    pairsTitle = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    pairsTitle:SetPoint("TOPLEFT", frame, "TOPLEFT", 14, -175)
    pairsTitle:SetText("|cffffd100Paare (1+3 / 2+2)|r")
    pairsTitle:Hide()

    pairsContainer = CreateFrame("Frame", nil, frame)
    pairsContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -195)
    pairsContainer:SetSize(230, 160)

    openTitle = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    openTitle:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -18, -175)
    openTitle:SetText("|cffaaaaaaOffen|r")
    openTitle:Hide()

    openContainer = CreateFrame("Frame", nil, frame)
    openContainer:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -12, -195)
    openContainer:SetSize(110, 160)

    tipText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    tipText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 12, 12)
    tipText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 12)
    tipText:SetJustifyH("LEFT")
    tipText:SetJustifyV("BOTTOM")
    tipText:SetWordWrap(true)
    tipText:SetTextColor(0.85, 0.85, 0.7)

    local close = CreateFrame("Button", "DragonSkillBossCloseBtn", frame, "UIPanelCloseButton")
    close:SetSize(24, 24)
    close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 2)
    close:SetFrameLevel(frame:GetFrameLevel() + 10)
    close:EnableMouse(true)
    close:RegisterForClicks("AnyUp")
    close:SetScript("OnClick", function()
        frame:Hide()
        activeBoss = nil
        UI:ClearPairs()
    end)
    close:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("Schliessen", 1, 1, 1)
        GameTooltip:AddLine("ESC oder X", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    close:SetScript("OnLeave", function() GameTooltip:Hide() end)
    frame.closeButton = close

    tinsert(UISpecialFrames, "DragonSkillBossFrame")

    frame:SetScript("OnUpdate", function(self, elapsed)
        UI:OnUpdate(elapsed)
    end)

    local w = CreateFrame("Frame", "DragonSkillBossWarning", UIParent)
    w:SetSize(700, 80)
    w:SetPoint("TOP", UIParent, "TOP", 0, -140)
    w:SetFrameStrata("FULLSCREEN_DIALOG")
    w.Text = w:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    w.Text:SetPoint("CENTER")
    w.Text:SetTextColor(1, 0.3, 0.2)
    w:Hide()
    warningFrame = w
end

function UI:OnBossStart(boss)
    self:CreateFrame()
    activeBoss = boss
    title:SetText(boss.Name or "Boss")
    phaseText:SetText(boss.Phase or "Phase 1")
    tipText:SetText(boss.Tip or "")
    for i = 1, MAX_TIMERS do
        timerBars[i]:Hide()
        timerBars[i].key = nil
    end
    self:ClearPairs()
    if boss.Timers then
        for i, t in ipairs(boss.Timers) do
            if i > MAX_TIMERS then break end
            local bar = timerBars[i]
            bar.key = t.key or t.name
            bar.duration = t.duration or 30
            bar.expires = GetTime() + bar.duration
            bar.label:SetText(t.name or "?")
            bar:SetStatusBarColor(t.r or 0.2, t.g or 0.7, t.b or 1)
            bar:SetMinMaxValues(0, bar.duration)
            bar:SetValue(bar.duration)
            bar:Show()
        end
    end
    frame:Show()
end

function UI:OnBossEnd()
    activeBoss = nil
    self:ClearPairs()
    if frame then frame:Hide() end
    if warningFrame then warningFrame:Hide() end
end

function UI:SetPhase(text)
    if phaseText then phaseText:SetText(text or "") end
end

function UI:SetTip(text)
    if tipText then tipText:SetText(text or "") end
end

function UI:StartTimer(key, name, duration, r, g, b)
    if not frame or not frame:IsShown() then return end
    local bar
    for i = 1, MAX_TIMERS do
        if timerBars[i].key == key then
            bar = timerBars[i]
            break
        end
    end
    if not bar then
        for i = 1, MAX_TIMERS do
            if not timerBars[i]:IsShown() then
                bar = timerBars[i]
                break
            end
        end
    end
    if not bar then return end
    bar.key = key
    bar.duration = duration or 10
    bar.expires = GetTime() + bar.duration
    bar.label:SetText(name or key)
    bar:SetStatusBarColor(r or 0.2, g or 0.7, b or 1)
    bar:SetMinMaxValues(0, bar.duration)
    bar:SetValue(bar.duration)
    bar:Show()
end

function UI:OnUpdate(elapsed)
    if not activeBoss then return end
    local now = GetTime()
    for i = 1, MAX_TIMERS do
        local bar = timerBars[i]
        if bar:IsShown() and bar.expires then
            local remaining = bar.expires - now
            if remaining <= 0 then
                bar:Hide()
                bar.key = nil
            else
                bar:SetValue(remaining)
                bar.timeLabel:SetText(string.format("%.1f", remaining))
            end
        end
    end
end

function UI:ClearPairs()
    for _, row in ipairs(pairFrames) do row:Hide() end
    for _, fs in ipairs(openFrames) do fs:Hide() end
    if pairsTitle then pairsTitle:Hide() end
    if openTitle then openTitle:Hide() end
end

function UI:UpdatePairs(pairs, openPlayers)
    self:CreateFrame()
    if not frame:IsShown() then frame:Show() end

    pairs = pairs or {}
    openPlayers = openPlayers or {}

    pairsTitle:Show()
    openTitle:Show()

    for _, row in ipairs(pairFrames) do row:Hide() end
    for _, fs in ipairs(openFrames) do fs:Hide() end

    local y = 0
    for i, pair in ipairs(pairs) do
        local row = pairFrames[i]
        if not row then
            row = CreateFrame("Frame", nil, pairsContainer)
            row:SetSize(220, 28)

            row.symbol = row:CreateTexture(nil, "ARTWORK")
            row.symbol:SetSize(14, 14)
            row.symbol:SetPoint("LEFT", 0, 0)
            row.symbol:SetColorTexture(1, 1, 1)

            row.iconText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            row.iconText:SetPoint("LEFT", 18, 0)

            row.p1Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            row.p1Text:SetPoint("LEFT", 36, 0)
            row.p1Text:SetWidth(85)
            row.p1Text:SetJustifyH("LEFT")

            row.arrow = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            row.arrow:SetPoint("LEFT", 120, 0)
            row.arrow:SetText("|cff66ff66+|r")

            row.p2Text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            row.p2Text:SetPoint("LEFT", 135, 0)
            row.p2Text:SetWidth(85)
            row.p2Text:SetJustifyH("LEFT")

            pairFrames[i] = row
        end

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", pairsContainer, "TOPLEFT", 0, y)

        local c = symbolColors[i] or { r = 1, g = 1, b = 1 }
        row.symbol:SetColorTexture(c.r, c.g, c.b, 1)
        row.iconText:SetText(tostring(i))

        local n1 = pair.p1 and pair.p1.name or "?"
        local s1 = pair.p1 and pair.p1.stacks or "?"
        local n2 = pair.p2 and pair.p2.name or "?"
        local s2 = pair.p2 and pair.p2.stacks or "?"
        n1 = tostring(n1):match("^([^-]+)") or n1
        n2 = tostring(n2):match("^([^-]+)") or n2
        row.p1Text:SetText(string.format("%s |cffaaaaaa(%s)|r", n1, tostring(s1)))
        row.p2Text:SetText(string.format("%s |cffaaaaaa(%s)|r", n2, tostring(s2)))

        if pair.done then
            row.p1Text:SetTextColor(0.5, 0.5, 0.5)
            row.p2Text:SetTextColor(0.5, 0.5, 0.5)
            row.symbol:SetAlpha(0.35)
        else
            row.p1Text:SetTextColor(1, 1, 1)
            row.p2Text:SetTextColor(1, 1, 1)
            row.symbol:SetAlpha(1)
        end

        row:Show()
        y = y - 30
    end

    y = 0
    for i, player in ipairs(openPlayers) do
        local fs = openFrames[i]
        if not fs then
            fs = openContainer:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            openFrames[i] = fs
        end
        fs:ClearAllPoints()
        fs:SetPoint("TOPLEFT", openContainer, "TOPLEFT", 0, y)
        local n = tostring(player.name or "?"):match("^([^-]+)") or player.name
        fs:SetText(string.format("%s (%s)", n, tostring(player.stacks or "?")))
        fs:SetTextColor(1, 0.6, 0.4)
        fs:Show()
        y = y - 16
    end

    if #pairs == 0 and #openPlayers == 0 then
        pairsTitle:Hide()
        openTitle:Hide()
    end
end

function UI:ShowBigWarning(text, duration)
    self:CreateFrame()
    if not warningFrame then return end
    warningFrame.Text:SetText(text or "")
    warningFrame:Show()
    if C_Timer and C_Timer.After then
        C_Timer.After(duration or 3, function()
            if warningFrame then warningFrame:Hide() end
        end)
    end
end

function UI:Toggle()
    self:CreateFrame()
    if frame:IsShown() then
        frame:Hide()
    else
        if activeBoss then
            frame:Show()
        else
            print("|cff00ff00Dragon Skill:|r Kein aktiver Boss. /ds boss list")
        end
    end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:CreateFrame()
end)
