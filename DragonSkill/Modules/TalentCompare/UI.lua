-- Dragon Skill - Main UI (v2.3.6)
-- Midnight Modern Design with Absolute Data Purity.

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

local FRAME_WIDTH, FRAME_HEIGHT = 800, 650
local CONTENT_WIDTH = 580

function UI:Init()
    if self.frame then return end
    -- "Midnight Modern" Base Frame
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "BackdropTemplate")
    f:SetSize(FRAME_WIDTH, FRAME_HEIGHT); f:SetPoint("CENTER"); f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton"); f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing)

    f:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    f:SetBackdropColor(0, 0, 0, 0.9)
    f:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)

    -- Integrated Close Button
    local cb = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    cb:SetPoint("TOPRIGHT", -2, -2)

    -- Character Header
    local header = CreateFrame("Frame", nil, f)
    header:SetSize(FRAME_WIDTH - 20, 60)
    header:SetPoint("TOPLEFT", 10, -10)

    local name = UnitName("player")
    local _, avgItemLevel = GetAverageItemLevel()
    local guildName = "Dragon Lords"

    header.nameText = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    header.nameText:SetPoint("TOPLEFT", 15, -5)
    header.nameText:SetText("|cFFD100" .. name .. "|r |cffffffff(" .. math.floor(avgItemLevel) .. ")|r")

    header.guildText = header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header.guildText:SetPoint("TOPLEFT", header.nameText, "BOTTOMLEFT", 0, -2)
    header.guildText:SetText("|cffaaaaaaGilde:|r |cFFD100" .. guildName .. "|r")

    f.Header = header

    -- Clean Inset replacement
    local inset = CreateFrame("Frame", nil, f, "BackdropTemplate")
    inset:SetPoint("TOPLEFT", 10, -70); inset:SetPoint("BOTTOMRIGHT", -10, 45)
    inset:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 14, insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    inset:SetBackdropColor(0.05, 0.05, 0.05, 0.5)
    inset:SetBackdropBorderColor(0.15, 0.15, 0.15, 1)
    f.Inset = inset

    local sf = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", 8, -8); sf:SetPoint("BOTTOMRIGHT", -28, 8)

    -- Clean ScrollBar Styling
    if sf.ScrollBar then
        for _, region in ipairs({sf.ScrollBar:GetRegions()}) do
            if region:GetObjectType() == "Texture" then
                region:SetDesaturated(true)
                region:SetVertexColor(0.4, 0.4, 0.4)
            end
        end
    end

    local content = CreateFrame("Frame", "DragonSkillContentFrame", sf)
    content:SetSize(CONTENT_WIDTH, 5000); sf:SetScrollChild(content)
    f.Content = content; f.ScrollFrame = sf

    -- Integrated Tabs
    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "DragonSkillTabBtn" .. i, f, "BackdropTemplate")
        tab:SetSize(100, 28)
        tab:SetID(i)
        tab:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 12, insets = { left = 2, right = 2, top = 2, bottom = 2 }
        })
        tab:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
        tab:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)

        tab.text = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        tab.text:SetPoint("CENTER")
        tab.text:SetText(name)

        tab:SetScript("OnClick", function(selfBtn) UI:SelectTab(selfBtn:GetID()) end)
        tab:SetScript("OnEnter", function(s)
            if currentTab ~= s:GetID() then
                s:SetBackdropColor(0.2, 0.2, 0.2, 1)
            end
        end)
        tab:SetScript("OnLeave", function(s)
            if currentTab == s:GetID() then
                s:SetBackdropColor(0.3, 0.2, 0, 1)
            else
                s:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
            end
        end)

        f.Tabs[i] = tab
        if i == 1 then tab:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 12, 10) else tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", 5, 0) end
    end

    tinsert(UISpecialFrames, "DragonSkillMainFrame")
    f:Hide(); self.frame = f; self.rows = {}; self.extraFS = {}; self.talentBtns = {}; self.bossBtns = {}; self.farmRows = {}
    self:SelectTab(1)
end

function UI:SelectTab(id)
    currentTab = id
    for i, tab in ipairs(self.frame.Tabs) do
        if i == id then
            tab:SetBackdropColor(0.3, 0.2, 0, 1)
            tab:SetBackdropBorderColor(1, 0.82, 0, 1)
            tab.text:SetTextColor(1, 0.82, 0)
        else
            tab:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
            tab:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
            tab.text:SetTextColor(1, 1, 1)
        end
    end
    self:Update()
end

function UI:GetRow(index)
    if not self.rows[index] then
        local row = CreateFrame("Button", nil, self.frame.Content)
        row:SetSize(560, 28); row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(24, 24); row.icon:SetPoint("LEFT", 0, 0)
        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
        row.val = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.val:SetPoint("RIGHT", -10, 0); self.rows[index] = row
    end
    return self.rows[index]
end

function UI:GetExtraFS(index, font)
    if not self.extraFS[index] then
        self.extraFS[index] = self.frame.Content:CreateFontString(nil, "OVERLAY", font or "GameFontHighlight")
    end
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
        content.text:SetPoint("TOPLEFT", 15, -15); content.text:SetWidth(CONTENT_WIDTH - 40); content.text:SetJustifyH("LEFT"); content.text:SetSpacing(4)
    end
    return content.text
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content; self:ClearContent()
    self.text = self:EnsureText(content); self.text:SetText(""); self.text:Show()
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    local _, class = UnitClass("player"); local specID = GetSpecialization() and select(1, GetSpecializationInfo(GetSpecialization())) or 0
    local ok, err = pcall(function()
        if currentTab == TAB_DASHBOARD then self:DrawDashboard(content, class, specID)
        elseif currentTab == TAB_COACH then DragonSkill.AICoachUI:Draw(content, 580)
        elseif currentTab == TAB_FARM then self:DrawFarm(content)
        elseif currentTab == TAB_UPGRADES then self:DrawUpgrades(content)
        elseif currentTab == TAB_RAIDGUIDES then self:DrawRaidGuides(content)
        elseif currentTab == TAB_BIS then self:DrawBiSList(content)
        elseif currentTab == TAB_TALENTS then
            local gd = DragonSkill.Database:GetGuideData(class, specID); if gd then self:DrawTalents(content, gd) else self.text:SetText("Keine Guide-Daten.") end
        end
    end)
    if not ok then self.text:SetText("|cffff0000UI Fehler:|r " .. tostring(err)) end
end

function UI:AddInteractiveRow(index, itemData, yOffset, labelPrefix, valueText)
    if not itemData or not (itemData.itemId or itemData.text) then return index end
    local row = self:GetRow(index); row:SetParent(self.frame.Content); row:ClearAllPoints(); row:SetPoint("TOPLEFT", 15, yOffset)
    local iid = tonumber(itemData.itemId) or 0

    local name = itemData.name or itemData.text or "Item "..iid
    local texture = C_Item.GetItemIconByID(iid) or "Interface\\Icons\\Inv_misc_questionmark"
    row.icon:SetTexture(texture)

    local prefix = tostring(labelPrefix) or (itemData.slot and "|cff00ff00"..tostring(itemData.slot)..":|r " or "")
    row.text:SetText(prefix .. name)

    if valueText then row.val:SetText(tostring(valueText)); row.val:Show() else row.val:Hide() end
    row:SetScript("OnEnter", function(s) GameTooltip:SetOwner(s, "ANCHOR_RIGHT"); if iid > 0 then GameTooltip:SetItemByID(iid) else GameTooltip:SetText(name) end; GameTooltip:Show() end)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end); row:Show()
    return index + 1
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = specID > 0 and select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
    self.text:SetText("|cFFD100" .. tostring(class) .. ": " .. tostring(specName) .. " Dashboard|r\n\n" .. string.format("Gegenstandsstufe: |cffffffff%.1f|r\n\n", select(2, GetAverageItemLevel())) .. "|cFFD100NÄCHSTE BESTE UPGRADES (Mythic 639):|r")
    local ups = GM:GetBestUpgrades(); local y, ri = -85, 1
    if ups and #ups > 0 then for i=1, math.min(3, #ups) do ri = self:AddInteractiveRow(ri, ups[i], y, nil, string.format("|cff00ff00+%.1f%%|r", ups[i].percent or 0)); y = y - 30 end
    else local fs = self:GetExtraFS(50); fs:SetPoint("TOPLEFT", 25, y); fs:SetText("|cffaaaaaaKeine Upgrades gefunden.|r"); fs:Show(); y = y - 30 end
    y = y - 40; local gT = self:GetExtraFS(1000); gT:SetPoint("TOPLEFT", 15, y); gT:SetText("|cFFD100GILDE: DRAGON LORDS|r"); gT:Show(); y = y - 25
    local gW = self:GetExtraFS(1001, "GameFontHighlightSmall"); gW:SetPoint("TOPLEFT", 15, y); gW:SetText("Status: |cff00ccffBereit für Midnight Raid|r"); gW:Show()
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM:GetFarmPlan(); self.text:SetText("|cFFD100OPTIMALE FARM-ROUTE (Season 12.1 Targets)|r")
    local y, fsIdx, rowIndex = -45, 300, 1000
    if plan and #plan > 0 then for i, d in ipairs(plan) do
        local fs = self:GetExtraFS(fsIdx, "GameFontNormal"); fs:SetPoint("TOPLEFT", 15, y); fs:SetText(string.format("|cFFD100%d. %s|r (Upgrade Score: %d)", i, d.name, d.score)); fs:Show(); y = y - 25; fsIdx = fsIdx + 1
        for _, item in ipairs(d.items) do
            local prefix = "   |cffaaaaaaBoss: "..tostring(item.boss)..":|r "
            rowIndex = self:AddInteractiveRow(rowIndex, item, y, prefix)
            y = y - 28; rowIndex = rowIndex + 1
        end
        y = y - 10
    end else self.text:SetText(self.text:GetText() .. "\n\nKeine Upgrades in Dungeons gefunden.") end
    content:SetHeight(math.abs(y) + 500)
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager"); local items = GM:GetBestUpgrades()
    self.text:SetText("|cFFD100UPGRADE MATRIX (Ziel: Mythic 639)|r"); local y, ri = -75, 2000
    if #items > 0 then for _, item in ipairs(items) do ri = self:AddInteractiveRow(ri, item, y, nil, string.format("|cff00ff00+%.1f%%|r", item.percent or 0)); y = y - 30 end
    else local fs = self:GetExtraFS(60); fs:SetPoint("TOPLEFT", 25, y); fs:SetText("|cffaaaaaaKeine Upgrades verfügbar.|r"); fs:Show() end
end

function UI:DrawBiSList(content)
    local GM = DragonSkill:GetModule("GearManager"); local items = GM:GetBiSList()
    self.text:SetText("|cFFD100MYTHIC BIS LIST (Season 12.1 - 639+)|r"); local y, ri = -45, 3000
    for _, item in ipairs(items) do
        local ilvlStr = "|cffa335ee" .. (item.ilvl or 639) .. "|r"
        ri = self:AddInteractiveRow(ri, item, y, nil, ilvlStr); y = y - 30; ri = ri + 1
    end
    content:SetHeight(math.abs(y) + 500)
end

function UI:DrawTalents(content, gd)
    local y = -45; self.text:SetText("|cFFD100Talent Builds|r")
    if gd.talentBuilds then for i, b in ipairs(gd.talentBuilds) do
        local btn = self.talentBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        self.talentBtns[i] = btn; btn:SetSize(560, 30); btn:SetPoint("TOPLEFT", 15, y)
        btn:SetText(string.format("[%s] %s", tostring(b.provider):upper(), tostring(b.label)))
        btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, b.importString) end); btn:Show(); y = y - 35
    end end
end

function UI:DrawRaidGuides(content)
    local guides = DragonSkillRaidGuides; local lw, y, fi = 180, -50, 4000
    if not guides then return end
    for i, g in ipairs(guides) do
        local btn = self.bossBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        self.bossBtns[i] = btn; btn:SetSize(lw, 35); btn:SetPoint("TOPLEFT", 10, -50 - (i-1)*38); btn:SetText(g.name or "Boss"); btn:SetScript("OnClick", function() selectedBossIdx = i; self:Update() end); btn:Show()
    end
    local g = guides[selectedBossIdx]; if not g then return end
    local ti = self:GetExtraFS(fi); ti:SetPoint("TOPLEFT", lw + 25, y); ti:SetText("|cFFD100" .. tostring(g.name) .. "|r"); ti:Show(); fi = fi + 1; y = y - 30
    for _, p in ipairs(g.phases or {}) do
        local pt = self:GetExtraFS(fi); pt:SetPoint("TOPLEFT", lw + 25, y); pt:SetText("|cffffff00" .. tostring(p.name) .. "|r"); pt:Show(); fi = fi + 1; y = y - 20
        local pd = self:GetExtraFS(fi, "GameFontHighlightSmall"); pd:SetPoint("TOPLEFT", lw + 35, y); pd:SetText(tostring(p.desc)); pd:Show(); fi = fi + 1; y = y - 30
        for _, m in ipairs(p.mechanics or {}) do
            local mt = self:GetExtraFS(fi, "GameFontHighlightSmall"); mt:SetPoint("TOPLEFT", lw + 45, y)
            mt:SetText("|cFFD100" .. tostring(m.name) .. ":|r " .. tostring(m.tip)); mt:Show(); fi = fi + 1; y = y - 35
        end
        y = y - 10
    end
    local rt = self:GetExtraFS(fi); rt:SetPoint("TOPLEFT", lw + 25, y); rt:SetText("|cffffff00Rollen-Tipps|r"); rt:Show(); fi = fi + 1; y = y - 25
    local rx = self:GetExtraFS(fi, "GameFontHighlightSmall"); rx:SetPoint("TOPLEFT", lw + 35, y)
    rx:SetText(string.format("|cff00ccffTank:|r %s\n\n|cff00ff00Healer:|r %s\n\n|cffffffffDPS:|r %s", tostring(g.roles and g.roles.tank or "-"), tostring(g.roles and g.roles.heal or "-"), tostring(g.roles and g.roles.dps or "-")))
    rx:Show(); fi = fi + 1; y = y - 120; local post = self:GetExtraFS(fi); post:SetPoint("TOPLEFT", lw + 25, y); post:SetText("|cffffff00Positionierung|r"); post:Show(); fi = fi + 1; y = y - 25
    local pxt = self:GetExtraFS(fi, "GameFontHighlightSmall"); pxt:SetPoint("TOPLEFT", lw + 35, y); pxt:SetText(tostring(g.position)); pxt:Show(); fi = fi + 1
    content:SetHeight(math.abs(y) + 500)
end

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Build-String kopieren (Strg+C):", button1 = "Fertig", hasEditBox = 1,
    OnShow = function(self, data) if data then self.editBox:SetText(tostring(data)) self.editBox:HighlightText() end end,
    timeout = 0, whileDead = true, hideOnEscape = true,
}

function UI:Toggle() self:Init(); if self.frame:IsShown() then self.frame:Hide() else self.frame:Show(); self:Update() end end

-- --- Slash Commands ---
local function SlashHandler(msg)
    if msg == "minimap" then
        if DragonSkill.Minimap then DragonSkill.Minimap:Toggle() end
    else
        UI:Toggle()
    end
end

SLASH_DRAGONSKILL1 = "/ds"
SLASH_DRAGONSKILL2 = "/wear"
SLASH_DRAGONSKILL3 = "/dragonskill"
SlashCmdList["DRAGONSKILL"] = SlashHandler

DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end); if IsLoggedIn() then UI:Init() end
DragonSkill.UI = UI
