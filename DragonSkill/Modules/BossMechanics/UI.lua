-- Dragon Skill - Boss Mechanics UI (v1.6.3)
-- Leichtes Overlay: Boss-Name, Phase, Ability-Liste, Timer-Bars, Tips

local UI = {}
DragonSkill.BossMechanicsUI = UI

local frame, title, phaseText, abilityScroll, tipText
local timerBars = {}
local MAX_TIMERS = 6
local activeBoss = nil

local function CreateTimerBar(parent, index)
    local bar = CreateFrame("StatusBar", nil, parent, "BackdropTemplate")
    bar:SetSize(260, 18)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetStatusBarColor(0.2, 0.7, 1.0)
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    bar:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, -70 - (index - 1) * 24)
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
    frame:SetSize(300, 280)
    frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -40, -180)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 14,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0.05, 0.05, 0.1, 0.92)
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

    tipText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    tipText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 12, 14)
    tipText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 14)
    tipText:SetJustifyH("LEFT")
    tipText:SetJustifyV("BOTTOM")
    tipText:SetWordWrap(true)
    tipText:SetTextColor(0.85, 0.85, 0.7)

    -- Schliessen-X (explizit sichtbar, ueber Inhalt)
    local close = CreateFrame("Button", "DragonSkillBossCloseBtn", frame, "UIPanelCloseButton")
    close:SetSize(24, 24)
    close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 2)
    close:SetFrameLevel(frame:GetFrameLevel() + 10)
    close:EnableMouse(true)
    close:RegisterForClicks("AnyUp")
    close:SetScript("OnClick", function()
        frame:Hide()
        if activeBoss then
            activeBoss = nil
        end
    end)
    close:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("Schliessen", 1, 1, 1)
        GameTooltip:AddLine("ESC oder X", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    close:SetScript("OnLeave", function() GameTooltip:Hide() end)
    frame.closeButton = close

    -- ESC schliesst das Boss-Fenster
    tinsert(UISpecialFrames, "DragonSkillBossFrame")

    frame:SetScript("OnUpdate", function(self, elapsed)
        UI:OnUpdate(elapsed)
    end)
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
    if frame then frame:Hide() end
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
