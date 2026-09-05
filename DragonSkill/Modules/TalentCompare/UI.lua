-- Dragon Skill - Main UI (v2.5.0)
-- Modern flat/dark redesign: class-color accent throughout, hairline-bordered
-- cards instead of the classic beveled tooltip borders, underline tabs, and
-- icon-forward two-line item rows (name + slot/source) instead of single
-- plain text lines. All functional logic (module calls, popups, slash
-- commands) is unchanged from v2.3.11 - this is a visual-layer rewrite.

local L = DragonSkill.L or {}
local Theme = DragonSkill.Theme
local UI = {}
local currentTab = 1
local selectedBossIdx = 1
local tabs = {"Dashboard", "Talente", "AI Coach", "Farm Plan", "Upgrades", "BiS List", "Raid Guides"}

local TAB_DASHBOARD = 1
local TAB_TALENTS = 2
local TAB_COACH = 3
local TAB_FARM = 4
local TAB_UPGRADES = 5
local TAB_BIS = 6
local TAB_RAIDGUIDES = 7

local FRAME_WIDTH, FRAME_HEIGHT = 820, 680
local CONTENT_WIDTH = 590
local ROW_STEP = 44 -- vertical spacing between item rows (two-line cards)

local COLOR_WHITE = "|cffffffff"
local DEFAULT_GUILD_URL = "https://guildsofwow.com/dragon-lords"

local function ShowUrlPopup(title, url)
    StaticPopupDialogs["DRAGONSKILL_URL"] = {
        text = title,
        button1 = "OK",
        hasEditBox = true,
        editBoxWidth = 420,
        maxLetters = 0,
        preferredIndex = 3,
        OnShow = function(self)
            local u = tostring(self.data or "")
            local eb = self.editBox or self.EditBox
            if eb then
                if eb.SetMaxLetters then eb:SetMaxLetters(0) end
                eb:SetText(u)
                eb:HighlightText()
                eb:SetFocus()
            end
        end,
        EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
        timeout = 0, whileDead = true, hideOnEscape = true,
    }
    StaticPopup_Show("DRAGONSKILL_URL", nil, nil, url)
end

-- Small debug helper: turns GearManager's self-diagnosing lookup info
-- (see GetBiSList) into a one-line suffix so an empty-state message never
-- just says "nothing here" without saying why.
local function DiagSuffix(GM)
    local d = GM and GM.lastLookup
    if d and d.reason then
        return "\n" .. Theme:Hex(Theme.textMuted) .. "Debug: " .. tostring(d.reason) .. "|r"
    end
    return ""
end

function UI:Init()
    if self.frame then return end
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent)
    f:SetSize(FRAME_WIDTH, FRAME_HEIGHT); f:SetPoint("CENTER"); f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton"); f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetFrameStrata("HIGH")

    local skin = Theme:Panel(f, Theme.bgDeep, Theme.hairlineStrong)
    skin:SetAllPoints(f)
    f.Skin = skin

    -- Thin accent strip across the very top - the one recurring "brand"
    -- element that ties the whole window to the player's class color.
    -- NOTE: must be drawn on `skin` (not `f`), because WoW stacks whole
    -- child frames by frame level - `skin` is a higher-level child of `f`
    -- with an opaque full-frame background, so anything textured directly
    -- on `f` itself would render underneath it and never be visible.
    local accentBar = skin:CreateTexture(nil, "OVERLAY")
    accentBar:SetPoint("TOPLEFT", 1, -1); accentBar:SetPoint("TOPRIGHT", -1, -1); accentBar:SetHeight(3)
    accentBar:SetColorTexture(Theme:GetAccent())
    f.AccentBar = accentBar

    local header = Theme:Panel(f, Theme.bgPanel, Theme.hairline)
    header:SetSize(FRAME_WIDTH - 28, 78)
    header:SetPoint("TOPLEFT", 14, -18)

    local name = UnitName("player") or "Player"
    local _, avgItemLevel = GetAverageItemLevel()
    local guildName = GetGuildInfo("player") or "Keine Gilde"
    local classColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))] or { r = 1, g = 1, b = 1 }

    header.nameText = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    header.nameText:SetPoint("TOPLEFT", 16, -12)
    header.nameText:SetText(string.format("%s%s|r", "|cff" .. string.format("%02x%02x%02x", classColor.r * 255, classColor.g * 255, classColor.b * 255), name))

    -- Item-level badge: a small tinted pill next to the name instead of a
    -- plain "(639)" suffix.
    header.ilvlBadge = Theme:Panel(header, { 0, 0, 0, 0.001 }, Theme.hairlineStrong)
    header.ilvlBadge:SetHeight(20)
    header.ilvlBadge:SetPoint("LEFT", header.nameText, "RIGHT", 8, 1)
    header.ilvlBadge.text = header.ilvlBadge:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    header.ilvlBadge.text:SetPoint("CENTER", 0, 0)

    header.guildText = header:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    header.guildText:SetPoint("TOPLEFT", header.nameText, "BOTTOMLEFT", 0, -6)
    header.guildText:SetText(Theme:Hex(Theme.textSecondary) .. "Gilde:|r " .. COLOR_WHITE .. tostring(guildName) .. "|r")

    header.guildLink = header:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    header.guildLink:SetPoint("TOPLEFT", header.guildText, "BOTTOMLEFT", 0, -4)
    header.guildLink:SetText(Theme:GetAccentHex() .. "Gilden-Website ›|r")

    header.guildBtn = CreateFrame("Button", nil, header)
    header.guildBtn:SetPoint("TOPLEFT", header.guildLink, "TOPLEFT", -2, 2)
    header.guildBtn:SetPoint("BOTTOMRIGHT", header.guildLink, "BOTTOMRIGHT", 2, -2)
    header.guildBtn:SetScript("OnClick", function()
        local url = (DragonSkillDB and DragonSkillDB.guildUrl) or DEFAULT_GUILD_URL
        ShowUrlPopup("Gilden-Website (Strg+C zum Kopieren):", url)
    end)
    header.guildBtn:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        GameTooltip:SetText("Gilden-Website")
        GameTooltip:AddLine((DragonSkillDB and DragonSkillDB.guildUrl) or DEFAULT_GUILD_URL, 0.6, 0.8, 1)
        GameTooltip:Show()
    end)
    header.guildBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    f.Header = header

    -- Underline-style tabs: no boxed backdrop, just text + a colored
    -- underline segment for the active tab, sitting on one shared baseline.
    local TAB_Y = -18 - 78 - 10
    f.Tabs = {}
    local tabWidth = (FRAME_WIDTH - 40) / #tabs
    for i, tabName in ipairs(tabs) do
        local tab = CreateFrame("Button", "DragonSkillTabBtn" .. i, f)
        tab:SetSize(tabWidth, 30)
        tab:SetID(i)
        tab.text = tab:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        tab.text:SetPoint("CENTER")
        tab.text:SetText(tabName)
        tab.underline = tab:CreateTexture(nil, "OVERLAY")
        tab.underline:SetPoint("BOTTOMLEFT", 6, 0)
        tab.underline:SetPoint("BOTTOMRIGHT", -6, 0)
        tab.underline:SetHeight(2)
        tab.underline:Hide()
        tab:SetScript("OnClick", function(selfBtn) UI:SelectTab(selfBtn:GetID()) end)
        tab:SetScript("OnEnter", function(s) if currentTab ~= s:GetID() then s.text:SetTextColor(unpack(Theme.textPrimary)) end end)
        tab:SetScript("OnLeave", function(s) if currentTab ~= s:GetID() then s.text:SetTextColor(unpack(Theme.textSecondary)) end end)
        f.Tabs[i] = tab
        if i == 1 then tab:SetPoint("TOPLEFT", f, "TOPLEFT", 14, TAB_Y) else tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", 0, 0) end
    end
    local baseline = skin:CreateTexture(nil, "BORDER") -- same reason as accentBar above
    baseline:SetColorTexture(unpack(Theme.hairline))
    baseline:SetPoint("TOPLEFT", f.Tabs[1], "BOTTOMLEFT", 0, 0)
    baseline:SetPoint("TOPRIGHT", f.Tabs[#tabs], "BOTTOMRIGHT", 0, 0)
    baseline:SetHeight(1)

    local inset = Theme:Panel(f, Theme.bgPanelAlt, Theme.hairline)
    inset:SetPoint("TOPLEFT", 14, TAB_Y - 40); inset:SetPoint("BOTTOMRIGHT", -14, 16)
    f.Inset = inset

    local sf = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", 8, -8); sf:SetPoint("BOTTOMRIGHT", -28, 8)
    local content = CreateFrame("Frame", "DragonSkillContentFrame", sf)
    content:SetSize(CONTENT_WIDTH, 5000); sf:SetScrollChild(content)
    f.Content = content; f.ScrollFrame = sf

    local cb = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    cb:SetPoint("TOPRIGHT", -4, -4); cb:SetSize(30, 30)
    tinsert(UISpecialFrames, "DragonSkillMainFrame")
    f:Hide(); self.frame = f; self.rows = {}; self.extraFS = {}; self.talentBtns = {}; self.bossBtns = {}; self.farmRows = {}
    self:SelectTab(1)
end

function UI:SelectTab(id)
    currentTab = id
    local r, g, b = Theme:GetAccent()
    for i, tab in ipairs(self.frame.Tabs) do
        if i == id then
            tab.text:SetTextColor(r, g, b)
            tab.underline:SetColorTexture(r, g, b, 1)
            tab.underline:Show()
        else
            tab.text:SetTextColor(unpack(Theme.textSecondary))
            tab.underline:Hide()
        end
    end
    self:Update()
end

-- Icon-forward, two-line item row: icon (with a hairline frame) on the
-- left, item name on top, slot/source as a small muted subtitle below it,
-- and an optional colored value tag on the right.
function UI:GetRow(index)
    if not self.rows[index] then
        local row = CreateFrame("Button", nil, self.frame.Content)
        row:SetSize(566, 40)

        local iconBorder = row:CreateTexture(nil, "BORDER")
        iconBorder:SetSize(34, 34); iconBorder:SetPoint("LEFT", 2, 0)
        iconBorder:SetColorTexture(1, 1, 1, 0.08)
        row.iconBorder = iconBorder

        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(30, 30); row.icon:SetPoint("CENTER", iconBorder, "CENTER", 0, 0)

        row.title = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.title:SetPoint("BOTTOMLEFT", iconBorder, "RIGHT", 10, 2)
        row.title:SetJustifyH("LEFT")

        row.subtitle = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        row.subtitle:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -3)
        row.subtitle:SetJustifyH("LEFT")
        row.subtitle:SetTextColor(unpack(Theme.textSecondary))

        row.val = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.val:SetPoint("RIGHT", -8, 0)

        local sep = row:CreateTexture(nil, "BORDER")
        sep:SetColorTexture(unpack(Theme.hairline)); sep:SetHeight(1)
        sep:SetPoint("BOTTOMLEFT", 2, -4); sep:SetPoint("BOTTOMRIGHT", -2, -4)
        row.sep = sep

        local bg = row:CreateTexture(nil, "BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(0, 0, 0, 0); row.bg = bg
        self.rows[index] = row
    end
    return self.rows[index]
end

function UI:GetExtraFS(index, font)
    if not self.extraFS[index] then self.extraFS[index] = self.frame.Content:CreateFontString(nil, "OVERLAY", font or "GameFontHighlight") end
    self.extraFS[index]:SetFontObject(font or "GameFontHighlight")
    self.extraFS[index]:SetWidth(CONTENT_WIDTH - 40); self.extraFS[index]:SetJustifyH("LEFT")
    return self.extraFS[index]
end

function UI:ClearContent()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content
    for _, child in ipairs({ content:GetChildren() }) do if child ~= self.text and child ~= self.title then child:Hide() end end
    for _, region in ipairs({ content:GetRegions() }) do if region ~= self.text and region ~= self.title then region:Hide() end end
    for _, row in pairs(self.rows) do row:Hide() end
    for _, fs in pairs(self.extraFS) do fs:Hide() end
end

function UI:EnsureText(content)
    if not content.title then
        content.title = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        content.title:SetPoint("TOPLEFT", 15, -14); content.title:SetWidth(CONTENT_WIDTH - 40); content.title:SetJustifyH("LEFT")
    end
    if not content.text then
        content.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        -- Anchored BELOW the title (not on top of it - content.title sits at
        -- -14 with a large font, so a hardcoded -15 here used to draw the
        -- subtitle directly on top of the title text, garbling both).
        content.text:SetPoint("TOPLEFT", content.title, "BOTTOMLEFT", 0, -6)
        content.text:SetWidth(CONTENT_WIDTH - 40); content.text:SetJustifyH("LEFT"); content.text:SetSpacing(5)
    end
    return content.text
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content; self:ClearContent()
    self.text = self:EnsureText(content); self.text:SetText(""); self.text:Show()
    self.title = content.title; self.title:SetText(""); self.title:Hide()
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    if self.frame.Header then
        local h = self.frame.Header
        local name = UnitName("player") or "Player"
        local _, avgItemLevel = GetAverageItemLevel()
        local guildName = GetGuildInfo("player") or "Keine Gilde"
        local classColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))] or { r = 1, g = 1, b = 1 }
        if h.nameText then
            h.nameText:SetText(string.format("%s%s|r", "|cff" .. string.format("%02x%02x%02x", classColor.r * 255, classColor.g * 255, classColor.b * 255), name))
        end
        if h.ilvlBadge then
            local r, g, b = Theme:GetAccent()
            h.ilvlBadge.bg:SetColorTexture(r, g, b, 0.14)
            h.ilvlBadge:SetBorderColor(r, g, b, 0.4)
            h.ilvlBadge.text:SetText(string.format("%sILVL %d|r", Theme:GetAccentHex(), math.floor(avgItemLevel or 0)))
            h.ilvlBadge:SetWidth(h.ilvlBadge.text:GetStringWidth() + 16)
        end
        if h.guildText then
            h.guildText:SetText(Theme:Hex(Theme.textSecondary) .. "Gilde:|r " .. COLOR_WHITE .. tostring(guildName) .. "|r")
        end
    end

    local _, class = UnitClass("player")
    local specID = GetSpecialization() and select(1, GetSpecializationInfo(GetSpecialization())) or 0
    local ok, err = pcall(function()
        if currentTab == TAB_DASHBOARD then self:DrawDashboard(content, class, specID)
        elseif currentTab == TAB_COACH then if DragonSkill.AICoachUI then DragonSkill.AICoachUI:Draw(content, 580) end
        elseif currentTab == TAB_FARM then self:DrawFarm(content)
        elseif currentTab == TAB_UPGRADES then self:DrawUpgrades(content)
        elseif currentTab == TAB_RAIDGUIDES then self:DrawRaidGuides(content)
        elseif currentTab == TAB_BIS then self:DrawBiSList(content)
        elseif currentTab == TAB_TALENTS then
            local gd = DragonSkill.Database and DragonSkill.Database:GetGuideData(class, specID)
            if gd then self:DrawTalents(content, gd) else self:SetHeader("Talente", "Keine Guide-Daten.") end
        end
    end)
    if not ok then self:SetHeader("Fehler", nil); self.text:SetText(Theme:Hex(Theme.danger) .. "UI Fehler:|r " .. tostring(err)) end

    if UIFrameFadeIn then UIFrameFadeIn(content, 0.15, 0, 1) end
end

-- Sets the tab's bold accent-colored title line and an optional muted
-- subtitle line beneath it, replacing the old single hardcoded-gold block
-- of text every Draw* function used to build by hand.
function UI:SetHeader(title, subtitle)
    self.title:SetText(Theme:GetAccentHex() .. tostring(title) .. "|r")
    self.title:Show()
    if subtitle and subtitle ~= "" then
        self.text:SetText(Theme:Hex(Theme.textSecondary) .. subtitle .. "|r")
    else
        self.text:SetText("")
    end
end

function UI:AddInteractiveRow(index, itemData, yOffset, subtitleOverride, valueText)
    if not itemData or not itemData.itemId then return index end
    local row = self:GetRow(index); row:SetParent(self.frame.Content); row:ClearAllPoints(); row:SetPoint("TOPLEFT", 10, yOffset)
    local iid = tonumber(itemData.itemId) or 0
    local name = itemData.name or ("Item " .. iid)
    local texture = (C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(iid)) or "Interface\\Icons\\Inv_misc_questionmark"
    row.icon:SetTexture(texture)

    row.title:SetText(name)
    local sub = subtitleOverride
    if not sub then
        sub = tostring(itemData.slot or "")
        if itemData.source and itemData.source ~= "" then
            sub = sub .. (sub ~= "" and "  ·  " or "") .. tostring(itemData.source)
        end
    end
    row.subtitle:SetText(sub)

    if valueText then row.val:SetText(tostring(valueText)); row.val:Show() else row.val:Hide() end
    row:SetScript("OnEnter", function(s)
        local r, g, b = Theme:GetAccent()
        s.bg:SetColorTexture(r, g, b, 0.08)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        if iid > 0 then GameTooltip:SetItemByID(iid) else GameTooltip:SetText(name) end
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", function(s) s.bg:SetColorTexture(0, 0, 0, 0); GameTooltip:Hide() end)
    row:Show()
    return index + 1
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = specID > 0 and select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
    local gUrl = (DragonSkillDB and DragonSkillDB.guildUrl) or DEFAULT_GUILD_URL
    self:SetHeader(tostring(class) .. " · " .. tostring(specName), "Nächste Schritte (Season 2 Fokus)")

    local ups = GM and GM:GetBestUpgrades() or {}
    local y, ri = -55, 1
    if ups and #ups > 0 then
        for i = 1, math.min(5, #ups) do
            ri = self:AddInteractiveRow(ri, ups[i], y, nil, string.format(Theme:Hex(Theme.success) .. "+%.1f%%|r", ups[i].percent or 0))
            y = y - ROW_STEP
        end
    else
        local bis = GM and GM:GetBiSList() or {}
        if bis and #bis > 0 then
            local fs = self:GetExtraFS(50); fs:SetPoint("TOPLEFT", 15, y)
            fs:SetText(Theme:Hex(Theme.textSecondary) .. "Top BiS-Ziele:|r"); fs:Show(); y = y - 24
            for i = 1, math.min(5, #bis) do
                ri = self:AddInteractiveRow(ri, bis[i], y, nil, Theme:Hex(Theme.bis) .. "BiS|r")
                y = y - ROW_STEP
            end
        else
            local fs = self:GetExtraFS(50); fs:SetPoint("TOPLEFT", 15, y)
            fs:SetText(Theme:Hex(Theme.textMuted) .. "Kein BiS-Datenstand geladen.|r" .. DiagSuffix(GM)); fs:Show(); y = y - ROW_STEP
        end
    end

    y = y - 16
    local gT = self:GetExtraFS(1000, "GameFontNormalLarge")
    gT:SetPoint("TOPLEFT", 15, y)
    gT:SetText(Theme:Hex(Theme.success) .. "STATUS: BEREIT FÜR RAID|r")
    gT:Show()

    y = y - 40
    local webBtn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    webBtn:SetSize(200, 28)
    webBtn:SetPoint("TOPLEFT", 15, y)
    webBtn:SetText("Gilden-Website")
    webBtn:SetScript("OnClick", function()
        ShowUrlPopup("Gilden-Website (Strg+C):", gUrl)
    end)
    webBtn:Show()
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM and GM:GetFarmPlan() or {}
    self:SetHeader("Optimale Farm-Route", "Mythic 12.1 Targets, gruppiert nach Quelle")
    local y, fsIdx, rowIndex = -55, 300, 1000
    if plan and #plan > 0 then
        for i, d in ipairs(plan) do
            local fs = self:GetExtraFS(fsIdx, "GameFontNormal")
            fs:SetPoint("TOPLEFT", 15, y)
            fs:SetText(string.format("%s%d. %s|r  %s(%d Items)|r", Theme:GetAccentHex(), i, d.name, Theme:Hex(Theme.textMuted), #d.items))
            fs:Show(); y = y - 26; fsIdx = fsIdx + 1
            for _, item in ipairs(d.items or {}) do
                rowIndex = self:AddInteractiveRow(rowIndex, item, y, nil, nil)
                y = y - ROW_STEP
            end
            y = y - 12
        end
    else
        self.text:SetText(self.text:GetText() .. "\n" .. Theme:Hex(Theme.textMuted) .. "Keine Farm-Daten geladen.|r" .. DiagSuffix(GM))
    end
    content:SetHeight(math.abs(y) + 500)
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM and GM:GetBestUpgrades() or {}
    self:SetHeader("Upgrade Matrix", "Vergleich gegen Mythic 639")
    local y, ri = -55, 2000
    if #items > 0 then
        for _, item in ipairs(items) do
            ri = self:AddInteractiveRow(ri, item, y, nil, string.format(Theme:Hex(Theme.success) .. "+%.1f%%|r", item.percent or 0))
            y = y - ROW_STEP
        end
    else
        local bis = GM and GM:GetBiSList() or {}
        if #bis > 0 then
            local fs = self:GetExtraFS(60); fs:SetPoint("TOPLEFT", 15, y)
            fs:SetText(Theme:Hex(Theme.textSecondary) .. "Keine Score-Upgrades – BiS-Liste:|r"); fs:Show(); y = y - 26
            for _, item in ipairs(bis) do
                ri = self:AddInteractiveRow(ri, item, y, nil, Theme:Hex(Theme.bis) .. "BiS|r")
                y = y - ROW_STEP
            end
        else
            local fs = self:GetExtraFS(60); fs:SetPoint("TOPLEFT", 15, y); fs:SetText(Theme:Hex(Theme.textMuted) .. "Keine Upgrades verfügbar.|r" .. DiagSuffix(GM)); fs:Show()
        end
    end
    content:SetHeight(math.abs(y) + 500)
end

function UI:DrawBiSList(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM and GM:GetBiSList() or {}
    self:SetHeader("Mythic BiS List", "Midnight Season 2 · Ziel 639+")
    local y, ri = -55, 3000
    if not items or #items == 0 then
        local fs = self:GetExtraFS(80)
        fs:SetPoint("TOPLEFT", 15, y)
        fs:SetText(Theme:Hex(Theme.textMuted) .. "Keine BiS-Einträge geladen.\nGuideData / GearDatabase prüfen.|r" .. DiagSuffix(GM))
        fs:Show()
        return
    end
    for _, item in ipairs(items) do
        ri = self:AddInteractiveRow(ri, item, y, nil, Theme:Hex(Theme.bis) .. "BiS|r")
        y = y - ROW_STEP
    end
    content:SetHeight(math.abs(y) + 500)
end

function UI:DrawTalents(content, gd)
    local y = -55
    self:SetHeader("Optimierte Talent Builds", "Linksklick = Import-String kopieren (Strg+C)")
    for _, btn in pairs(self.talentBtns or {}) do btn:Hide() end
    if gd and gd.talentBuilds and #gd.talentBuilds > 0 then
        for i, b in ipairs(gd.talentBuilds) do
            local btn = self.talentBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            self.talentBtns[i] = btn; btn:SetSize(560, 32); btn:SetPoint("TOPLEFT", 15, y)
            local label = string.format("[%s] %s", tostring(b.provider or "?"):upper(), tostring(b.label or "Build"))
            btn:SetText(label)
            local importStr = tostring(b.importString or "")
            btn.importString = importStr
            btn:SetScript("OnClick", function(selfBtn)
                local s = selfBtn.importString or importStr or ""
                if s ~= "" then
                    print("|cffffd100Dragon Skill:|r Import-String kopieren (Strg+C im Popup):")
                    print(s)
                    StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, s)
                else
                    print("|cffff0000Dragon Skill:|r Kein Import-String hinterlegt.")
                end
            end)
            btn:Show(); y = y - 40
        end
        content:SetHeight(math.abs(y) + 80)
    else
        local fs = self:GetExtraFS(70)
        fs:SetPoint("TOPLEFT", 15, y)
        fs:SetText(Theme:Hex(Theme.textMuted) .. "Keine Talent-Builds für diese Spec.|r")
        fs:Show()
    end
end

function UI:DrawRaidGuides(content)
    local guides = DragonSkillRaidGuides
    self:SetHeader("Raid Guides", nil)
    local lw, y, fi = 180, -55, 4000
    if not guides then return end
    for i, g in ipairs(guides) do
        local btn = self.bossBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        self.bossBtns[i] = btn
        btn:SetSize(lw, 38)
        btn:SetPoint("TOPLEFT", 10, -55 - (i - 1) * 42)
        btn:SetText(g.name or "Boss")
        btn:SetScript("OnClick", function() selectedBossIdx = i; self:Update() end)
        btn:Show()
    end
    local g = guides[selectedBossIdx]
    if not g then return end
    local ti = self:GetExtraFS(fi); ti:SetPoint("TOPLEFT", lw + 25, -55); ti:SetText(Theme:GetAccentHex() .. tostring(g.name) .. "|r"); ti:Show(); fi = fi + 1; y = -85
    for _, p in ipairs(g.phases or {}) do
        local pt = self:GetExtraFS(fi); pt:SetPoint("TOPLEFT", lw + 25, y); pt:SetText(Theme:Hex(Theme.warn) .. tostring(p.name) .. "|r"); pt:Show(); fi = fi + 1; y = y - 25
        local pd = self:GetExtraFS(fi, "GameFontHighlightSmall"); pd:SetPoint("TOPLEFT", lw + 35, y); pd:SetText(tostring(p.desc)); pd:Show(); fi = fi + 1; y = y - 35
        for _, m in ipairs(p.mechanics or {}) do
            local mt = self:GetExtraFS(fi, "GameFontHighlightSmall"); mt:SetPoint("TOPLEFT", lw + 45, y)
            mt:SetText(Theme:GetAccentHex() .. tostring(m.name) .. ":|r " .. tostring(m.tip)); mt:Show(); fi = fi + 1; y = y - 40
        end
        y = y - 10
    end
    content:SetHeight(math.abs(y) + 500)
end

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Build-String kopieren (Strg+C):",
    button1 = "Fertig",
    hasEditBox = true,
    editBoxWidth = 420,
    maxLetters = 0,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnShow = function(self)
        local data = self.data
        local str = data
        if type(data) == "table" then
            str = data.importString or data[1] or tostring(data)
        end
        str = tostring(str or "")
        local eb = self.editBox or self.EditBox
        if eb then
            if eb.SetMaxLetters then eb:SetMaxLetters(0) end
            eb:SetText(str)
            eb:HighlightText()
            eb:SetFocus()
        end
        if str ~= "" then
            print("|cffffd100Dragon Skill:|r Talent-String (falls Feld leer – manuell markieren):")
            print(str)
        end
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
}

function UI:Toggle()
    self:Init()
    if self.frame:IsShown() then self.frame:Hide() else self.frame:Show(); self:Update() end
end

local function SlashHandler(msg)
    msg = strtrim(tostring(msg or ""):lower())
    if msg == "minimap" then if DragonSkill.Minimap then DragonSkill.Minimap:Toggle() end
    elseif msg == "help" then
        print("|cffffd100Dragon Skill|r Commands:")
        print("  /ds | /wear | /dragonskill  – Fenster")
        print("  /ds minimap                – Minimap an/aus")
        print("  Guild-URL setzen: /run DragonSkillDB.guildUrl='https://...' ")
    else UI:Toggle() end
end
SLASH_DRAGONSKILL1 = "/ds"
SLASH_DRAGONSKILL2 = "/wear"
SLASH_DRAGONSKILL3 = "/dragonskill"
SlashCmdList["DRAGONSKILL"] = SlashHandler

DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end)
if IsLoggedIn and IsLoggedIn() then UI:Init() end
DragonSkill.UI = UI
