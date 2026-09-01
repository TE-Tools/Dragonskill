-- Dragon Skill - Main UI (v2.3.10)
-- Gilden-Website Link, Dashboard BiS-Ziele, BiS empty-state.

local L = DragonSkill.L or {}
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

local COLOR_GOLD = "|cffffd100"
local COLOR_GREY = "|cffaaaaaa"
local COLOR_WHITE = "|cffffffff"
local DEFAULT_GUILD_URL = "https://guildsofwow.com/dragon-lords"

function UI:Init()
    if self.frame then return end
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "BackdropTemplate")
    f:SetSize(FRAME_WIDTH, FRAME_HEIGHT); f:SetPoint("CENTER"); f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton"); f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 20, insets = { left = 4, right = 4, top = 4, bottom = 4 } })
    f:SetBackdropColor(0.02, 0.02, 0.05, 0.95)
    f:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)

    local header = CreateFrame("Frame", nil, f, "BackdropTemplate")
    header:SetSize(FRAME_WIDTH - 28, 82)
    header:SetPoint("TOPLEFT", 14, -14)
    header:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", insets = { left = 0, right = 0, top = 0, bottom = 0 } })
    header:SetBackdropColor(0.1, 0.1, 0.1, 0.3)

    local name = UnitName("player") or "Player"
    local _, avgItemLevel = GetAverageItemLevel()
    local guildName = GetGuildInfo("player") or "Keine Gilde"
    local classColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))] or { r=1, g=1, b=1 }

    header.nameText = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    header.nameText:SetPoint("TOPLEFT", 15, -10)
    header.nameText:SetText(string.format("%s%s|r %s(%d)|r", "|cff"..string.format("%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255), name, COLOR_WHITE, math.floor(avgItemLevel or 0)))

    header.guildText = header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header.guildText:SetPoint("TOPLEFT", header.nameText, "BOTTOMLEFT", 0, -3)
    header.guildText:SetText(COLOR_GREY .. "Gilde:|r " .. COLOR_GOLD .. tostring(guildName) .. "|r")

    header.guildLink = header:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    header.guildLink:SetPoint("TOPLEFT", header.guildText, "BOTTOMLEFT", 0, -1)
    header.guildLink:SetText("|cff00aaff[Gilden-Website]|r")

    header.guildBtn = CreateFrame("Button", nil, header)
    header.guildBtn:SetPoint("TOPLEFT", header.guildLink, "TOPLEFT", -2, 2)
    header.guildBtn:SetPoint("BOTTOMRIGHT", header.guildLink, "BOTTOMRIGHT", 2, -2)
    header.guildBtn:SetScript("OnClick", function()
        local url = (DragonSkillDB and DragonSkillDB.guildUrl) or DEFAULT_GUILD_URL
        StaticPopupDialogs["DRAGONSKILL_URL"] = {
            text = "Gilden-Website (Strg+C zum Kopieren):",
            button1 = "OK", hasEditBox = 1,
            OnShow = function(self, data)
                if self.editBox then self.editBox:SetText(tostring(data or "")); self.editBox:HighlightText() end
            end,
            timeout = 0, whileDead = true, hideOnEscape = true,
        }
        StaticPopup_Show("DRAGONSKILL_URL", nil, nil, url)
    end)
    header.guildBtn:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        GameTooltip:SetText("Gilden-Website")
        GameTooltip:AddLine((DragonSkillDB and DragonSkillDB.guildUrl) or DEFAULT_GUILD_URL, 0.6, 0.8, 1)
        GameTooltip:Show()
    end)
    header.guildBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local line = header:CreateTexture(nil, "ARTWORK")
    line:SetSize(header:GetWidth() - 30, 1)
    line:SetPoint("BOTTOMLEFT", 15, 5)
    line:SetColorTexture(0.3, 0.3, 0.3, 0.5)
    f.Header = header

    local inset = CreateFrame("Frame", nil, f, "BackdropTemplate")
    inset:SetPoint("TOPLEFT", 14, -100); inset:SetPoint("BOTTOMRIGHT", -14, 55)
    inset:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 14, insets = { left = 3, right = 3, top = 3, bottom = 3 } })
    inset:SetBackdropColor(0.05, 0.05, 0.05, 0.6)
    inset:SetBackdropBorderColor(0.15, 0.15, 0.15, 1)
    f.Inset = inset

    local sf = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", 8, -8); sf:SetPoint("BOTTOMRIGHT", -28, 8)
    local content = CreateFrame("Frame", "DragonSkillContentFrame", sf)
    content:SetSize(CONTENT_WIDTH, 5000); sf:SetScrollChild(content)
    f.Content = content; f.ScrollFrame = sf

    f.Tabs = {}
    for i, tabName in ipairs(tabs) do
        local tab = CreateFrame("Button", "DragonSkillTabBtn" .. i, f, "BackdropTemplate")
        tab:SetSize((FRAME_WIDTH - 40) / #tabs, 32)
        tab:SetID(i)
        tab:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12, insets = { left = 2, right = 2, top = 2, bottom = 2 } })
        tab:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
        tab:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)
        tab.text = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        tab.text:SetPoint("CENTER")
        tab.text:SetText(tabName)
        tab:SetScript("OnClick", function(selfBtn) UI:SelectTab(selfBtn:GetID()) end)
        tab:SetScript("OnEnter", function(s) if currentTab ~= s:GetID() then s:SetBackdropColor(0.2, 0.2, 0.2, 1) end end)
        tab:SetScript("OnLeave", function(s) if currentTab == s:GetID() then s:SetBackdropColor(0.25, 0.18, 0, 1) else s:SetBackdropColor(0.1, 0.1, 0.1, 0.8) end end)
        f.Tabs[i] = tab
        if i == 1 then tab:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 15, 12) else tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", 2, 0) end
    end

    local cb = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    cb:SetPoint("TOPRIGHT", -4, -4); cb:SetSize(30, 30)
    tinsert(UISpecialFrames, "DragonSkillMainFrame")
    f:Hide(); self.frame = f; self.rows = {}; self.extraFS = {}; self.talentBtns = {}; self.bossBtns = {}; self.farmRows = {}
    self:SelectTab(1)
end

function UI:SelectTab(id)
    currentTab = id
    for i, tab in ipairs(self.frame.Tabs) do
        if i == id then tab:SetBackdropColor(0.25, 0.18, 0, 1); tab:SetBackdropBorderColor(1, 0.82, 0, 1); tab.text:SetTextColor(1, 0.82, 0)
        else tab:SetBackdropColor(0.1, 0.1, 0.1, 0.8); tab:SetBackdropBorderColor(0.2, 0.2, 0.2, 1); tab.text:SetTextColor(0.8, 0.8, 0.8) end
    end
    self:Update()
end

function UI:GetRow(index)
    if not self.rows[index] then
        local row = CreateFrame("Button", nil, self.frame.Content)
        row:SetSize(570, 30)
        row.icon = row:CreateTexture(nil, "ARTWORK"); row.icon:SetSize(26, 26); row.icon:SetPoint("LEFT", 5, 0)
        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); row.text:SetPoint("LEFT", row.icon, "RIGHT", 10, 0)
        row.val = row:CreateFontString(nil, "OVERLAY", "GameFontNormal"); row.val:SetPoint("RIGHT", -10, 0)
        local bg = row:CreateTexture(nil, "BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(1, 1, 1, 0.03); row.bg = bg
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
    for _, child in ipairs({ content:GetChildren() }) do if child ~= self.text then child:Hide() end end
    for _, region in ipairs({ content:GetRegions() }) do if region ~= self.text then region:Hide() end end
    for _, row in pairs(self.rows) do row:Hide() end
    for _, fs in pairs(self.extraFS) do fs:Hide() end
end

function UI:EnsureText(content)
    if not content.text then
        content.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        content.text:SetPoint("TOPLEFT", 15, -15); content.text:SetWidth(CONTENT_WIDTH - 40); content.text:SetJustifyH("LEFT"); content.text:SetSpacing(5)
    end
    return content.text
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content; self:ClearContent()
    self.text = self:EnsureText(content); self.text:SetText(""); self.text:Show()
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    if self.frame.Header then
        local h = self.frame.Header
        local name = UnitName("player") or "Player"
        local _, avgItemLevel = GetAverageItemLevel()
        local guildName = GetGuildInfo("player") or "Keine Gilde"
        local classColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))] or { r=1, g=1, b=1 }
        if h.nameText then
            h.nameText:SetText(string.format("%s%s|r %s(%d)|r", "|cff"..string.format("%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255), name, COLOR_WHITE, math.floor(avgItemLevel or 0)))
        end
        if h.guildText then
            h.guildText:SetText(COLOR_GREY .. "Gilde:|r " .. COLOR_GOLD .. tostring(guildName) .. "|r")
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
            if gd then self:DrawTalents(content, gd) else self.text:SetText("Keine Guide-Daten.") end
        end
    end)
    if not ok then self.text:SetText("|cffff0000UI Fehler:|r " .. tostring(err)) end
end

function UI:AddInteractiveRow(index, itemData, yOffset, labelPrefix, valueText)
    if not itemData or not itemData.itemId then return index end
    local row = self:GetRow(index); row:SetParent(self.frame.Content); row:ClearAllPoints(); row:SetPoint("TOPLEFT", 10, yOffset)
    local iid = tonumber(itemData.itemId) or 0
    local name = itemData.name or ("Item " .. iid)
    local texture = (C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(iid)) or "Interface\\Icons\\Inv_misc_questionmark"
    row.icon:SetTexture(texture)
    local prefix = labelPrefix or (itemData.slot and ("|cff00ff00" .. tostring(itemData.slot) .. ":|r ") or "")
    row.text:SetText(tostring(prefix) .. tostring(name))
    if valueText then row.val:SetText(tostring(valueText)); row.val:Show() else row.val:Hide() end
    row:SetScript("OnEnter", function(s)
        s.bg:SetColorTexture(1, 0.82, 0, 0.1)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        if iid > 0 then GameTooltip:SetItemByID(iid) else GameTooltip:SetText(name) end
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", function(s) s.bg:SetColorTexture(1, 1, 1, 0.03); GameTooltip:Hide() end)
    row:Show()
    return index + 1
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = specID > 0 and select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
    local gUrl = (DragonSkillDB and DragonSkillDB.guildUrl) or DEFAULT_GUILD_URL
    self.text:SetText(COLOR_GOLD .. tostring(class) .. ": " .. tostring(specName) .. " Overview|r\n\n"
        .. COLOR_GREY .. "Gilde:|r " .. COLOR_GOLD .. (GetGuildInfo("player") or "–") .. "|r\n"
        .. "|cffffffffNÄCHSTE SCHRITTE (Season 2 Fokus):|r")

    local ups = GM and GM:GetBestUpgrades() or {}
    local y, ri = -100, 1
    if ups and #ups > 0 then
        for i = 1, math.min(5, #ups) do
            ri = self:AddInteractiveRow(ri, ups[i], y, nil, string.format("|cff00ff00+%.1f%%|r", ups[i].percent or 0))
            y = y - 35
        end
    else
        local bis = GM and GM:GetBiSList() or {}
        if bis and #bis > 0 then
            local fs = self:GetExtraFS(50); fs:SetPoint("TOPLEFT", 15, y)
            fs:SetText(COLOR_GREY .. "Top BiS-Ziele:|r"); fs:Show(); y = y - 25
            for i = 1, math.min(5, #bis) do
                ri = self:AddInteractiveRow(ri, bis[i], y, nil, "|cffa335ee639|r")
                y = y - 35
            end
        else
            local fs = self:GetExtraFS(50); fs:SetPoint("TOPLEFT", 25, y)
            fs:SetText(COLOR_GREY .. "Kein BiS-Datenstand geladen.|r"); fs:Show(); y = y - 35
        end
    end

    y = y - 20
    local gT = self:GetExtraFS(1000, "GameFontNormalLarge")
    gT:SetPoint("TOPLEFT", 15, y)
    gT:SetText(COLOR_GOLD .. "STATUS: BEREIT FÜR RAID|r")
    gT:Show()

    y = y - 40
    local webBtn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    webBtn:SetSize(200, 28)
    webBtn:SetPoint("TOPLEFT", 15, y)
    webBtn:SetText("Gilden-Website")
    webBtn:SetScript("OnClick", function()
        StaticPopupDialogs["DRAGONSKILL_URL"] = {
            text = "Gilden-Website (Strg+C):",
            button1 = "OK", hasEditBox = 1,
            OnShow = function(self, data)
                if self.editBox then self.editBox:SetText(tostring(data or "")); self.editBox:HighlightText() end
            end,
            timeout = 0, whileDead = true, hideOnEscape = true,
        }
        StaticPopup_Show("DRAGONSKILL_URL", nil, nil, gUrl)
    end)
    webBtn:Show()
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM and GM:GetFarmPlan() or {}
    self.text:SetText(COLOR_GOLD .. "OPTIMALE FARM-ROUTE (Mythic 12.1 Targets)|r")
    local y, fsIdx, rowIndex = -50, 300, 1000
    if plan and #plan > 0 then
        for i, d in ipairs(plan) do
            local fs = self:GetExtraFS(fsIdx, "GameFontNormal")
            fs:SetPoint("TOPLEFT", 15, y)
            fs:SetText(string.format(COLOR_GOLD .. "%d. %s|r (Score: %d)", i, d.name, d.score))
            fs:Show(); y = y - 30; fsIdx = fsIdx + 1
            for _, item in ipairs(d.items or {}) do
                rowIndex = self:AddInteractiveRow(rowIndex, item, y, "   " .. COLOR_GREY .. "Boss: " .. tostring(item.boss) .. ":|r ")
                y = y - 32
            end
            y = y - 10
        end
    else
        self.text:SetText(self.text:GetText() .. "\n\n" .. COLOR_GREY .. "Keine Dungeon-Loot-Daten geladen.|r")
    end
    content:SetHeight(math.abs(y) + 500)
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM and GM:GetBestUpgrades() or {}
    self.text:SetText(COLOR_GOLD .. "UPGRADE MATRIX (Vergleich vs. Mythic 639)|r")
    local y, ri = -80, 2000
    if #items > 0 then
        for _, item in ipairs(items) do
            ri = self:AddInteractiveRow(ri, item, y, nil, string.format("|cff00ff00+%.1f%%|r", item.percent or 0))
            y = y - 35
        end
    else
        local bis = GM and GM:GetBiSList() or {}
        if #bis > 0 then
            local fs = self:GetExtraFS(60); fs:SetPoint("TOPLEFT", 15, y)
            fs:SetText(COLOR_GREY .. "Keine Score-Upgrades – BiS-Liste:|r"); fs:Show(); y = y - 30
            for _, item in ipairs(bis) do
                ri = self:AddInteractiveRow(ri, item, y, nil, "|cffa335ee639|r")
                y = y - 35
            end
        else
            local fs = self:GetExtraFS(60); fs:SetPoint("TOPLEFT", 25, y); fs:SetText(COLOR_GREY .. "Keine Upgrades verfügbar.|r"); fs:Show()
        end
    end
end

function UI:DrawBiSList(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM and GM:GetBiSList() or {}
    self.text:SetText(COLOR_GOLD .. "MYTHIC BIS LIST (Midnight Season 2 - 639+)|r")
    local y, ri = -50, 3000
    if not items or #items == 0 then
        local fs = self:GetExtraFS(80)
        fs:SetPoint("TOPLEFT", 15, y)
        fs:SetText(COLOR_GREY .. "Keine BiS-Einträge geladen.\nGuideData / GearDatabase prüfen.|r")
        fs:Show()
        return
    end
    for _, item in ipairs(items) do
        ri = self:AddInteractiveRow(ri, item, y, nil, "|cffa335ee639|r")
        y = y - 35
    end
    content:SetHeight(math.abs(y) + 500)
end

function UI:DrawTalents(content, gd)
    local y = -50
    self.text:SetText(COLOR_GOLD .. "Optimierte Talent Builds|r\n" .. COLOR_GREY .. "Linksklick = Import-String kopieren (Strg+C)|r")
    for _, btn in pairs(self.talentBtns or {}) do btn:Hide() end
    if gd and gd.talentBuilds and #gd.talentBuilds > 0 then
        for i, b in ipairs(gd.talentBuilds) do
            local btn = self.talentBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            self.talentBtns[i] = btn; btn:SetSize(560, 32); btn:SetPoint("TOPLEFT", 15, y)
            local label = string.format("[%s] %s", tostring(b.provider or "?"):upper(), tostring(b.label or "Build"))
            btn:SetText(label)
            local importStr = b.importString
            btn:SetScript("OnClick", function()
                if importStr and importStr ~= "" then StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, importStr)
                else print("|cffff0000Dragon Skill:|r Kein Import-String.") end
            end)
            btn:Show(); y = y - 40
        end
        content:SetHeight(math.abs(y) + 80)
    else
        local fs = self:GetExtraFS(70)
        fs:SetPoint("TOPLEFT", 15, y)
        fs:SetText(COLOR_GREY .. "Keine Talent-Builds für diese Spec.|r")
        fs:Show()
    end
end

function UI:DrawRaidGuides(content)
    local guides = DragonSkillRaidGuides
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
    local ti = self:GetExtraFS(fi); ti:SetPoint("TOPLEFT", lw + 25, -55); ti:SetText(COLOR_GOLD .. tostring(g.name) .. "|r"); ti:Show(); fi = fi + 1; y = -85
    for _, p in ipairs(g.phases or {}) do
        local pt = self:GetExtraFS(fi); pt:SetPoint("TOPLEFT", lw + 25, y); pt:SetText("|cffffff00" .. tostring(p.name) .. "|r"); pt:Show(); fi = fi + 1; y = y - 25
        local pd = self:GetExtraFS(fi, "GameFontHighlightSmall"); pd:SetPoint("TOPLEFT", lw + 35, y); pd:SetText(tostring(p.desc)); pd:Show(); fi = fi + 1; y = y - 35
        for _, m in ipairs(p.mechanics or {}) do
            local mt = self:GetExtraFS(fi, "GameFontHighlightSmall"); mt:SetPoint("TOPLEFT", lw + 45, y)
            mt:SetText(COLOR_GOLD .. tostring(m.name) .. ":|r " .. tostring(m.tip)); mt:Show(); fi = fi + 1; y = y - 40
        end
        y = y - 10
    end
    content:SetHeight(math.abs(y) + 500)
end

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Build-String kopieren (Strg+C):",
    button1 = "Fertig", hasEditBox = 1,
    OnShow = function(self, data)
        local str = data
        if type(data) == "table" then str = data.importString or data[1] or "" end
        if self.editBox and str then self.editBox:SetText(tostring(str)); self.editBox:HighlightText() end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true,
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
