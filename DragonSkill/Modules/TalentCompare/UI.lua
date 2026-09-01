-- Dragon Skill - Main UI (v2.3.0)
-- Master UI with Professional Raid Guides & Absolute Stability Fixes.

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
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(FRAME_WIDTH, FRAME_HEIGHT); f:SetPoint("CENTER"); f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton"); f:SetScript("OnDragStart", f.StartMoving); f:SetScript("OnDragStop", f.StopMovingOrSizing)
    if f.SetTitle then f:SetTitle("Dragon Skill v2.3.0") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end

    local sf = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    sf:SetPoint("TOPLEFT", 8, -8); sf:SetPoint("BOTTOMRIGHT", -28, 8)
    local content = CreateFrame("Frame", "DragonSkillContentFrame", sf)
    content:SetSize(CONTENT_WIDTH, 3000); sf:SetScrollChild(content)
    f.Content = content; f.ScrollFrame = sf

    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "DragonSkillTabBtn" .. i, f, "PanelTabButtonTemplate")
        tab:SetID(i); tab:SetText(name); tab:SetScript("OnClick", function(selfBtn) UI:SelectTab(selfBtn:GetID()) end)
        f.Tabs[i] = tab
        if i == 1 then tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 10, 1) else tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", -16, 0) end
    end
    PanelTemplates_SetNumTabs(f, #tabs); PanelTemplates_SetTab(f, 1)

    tinsert(UISpecialFrames, "DragonSkillMainFrame")
    f:Hide(); self.frame = f; self.rows = {}; self.extraFS = {}; self.talentBtns = {}; self.bossBtns = {}
end

function UI:SelectTab(id)
    currentTab = id; PanelTemplates_SetTab(self.frame, id); self:Update()
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
    row.icon:SetTexture(C_Item.GetItemIconByID(iid) or "Interface\\Icons\\Inv_misc_questionmark")
    local name = tostring(itemData.name) or "Item "..iid
    row.text:SetText((labelPrefix or (itemData.slot and "|cff00ff00"..itemData.slot..":|r " or "")) .. name)
    if valueText then row.val:SetText(tostring(valueText)); row.val:Show() else row.val:Hide() end
    row:SetScript("OnEnter", function(s) GameTooltip:SetOwner(s, "ANCHOR_RIGHT"); if iid > 0 then GameTooltip:SetItemByID(iid) else GameTooltip:SetText(name) end; GameTooltip:Show() end)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end); row:Show()
    return index + 1
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = specID > 0 and select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
    self.text:SetText("|cffffff00" .. tostring(class) .. ": " .. tostring(specName) .. " Dashboard|r\n\n" .. string.format("Gegenstandsstufe: |cffffffff%.1f|r\n\n", select(2, GetAverageItemLevel())) .. "|cffffd100NÄCHSTE BESTE UPGRADES (Mythic 639):|r")
    local ups = GM:GetBestUpgrades(); local y = -85; local ri = 1
    if ups and #ups > 0 then for i=1, math.min(3, #ups) do ri = self:AddInteractiveRow(ri, ups[i], y, nil, string.format("|cff00ff00+%.1f%%|r", ups[i].percent or 0)); y = y - 30 end
    else local fs = self:GetExtraFS(50); fs:SetPoint("TOPLEFT", 25, y); fs:SetText("|cffaaaaaaDu hast bereits das beste Mythisch-Gear an!|r"); fs:Show(); y = y - 30 end
    y = y - 40; local gT = self:GetExtraFS(1000); gT:SetPoint("TOPLEFT", 15, y); gT:SetText("|cffffd100GILDE: DRAGON LORDS ALLERIA|r"); gT:Show(); y = y - 25
    local gW = self:GetExtraFS(1001, "GameFontHighlightSmall"); gW:SetPoint("TOPLEFT", 15, y); gW:SetText("Website: |cff00ccffhttps://guildsowow.com/dragon-lords|r"); gW:Show()
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM:GetFarmPlan(); self.text:SetText("|cffffff00OPTIMALE FARM-ROUTE (12.1 Mythic Targets)|r")
    local y = -45; local fsIdx = 300
    if plan and #plan > 0 then for i, d in ipairs(plan) do
        local fs = self:GetExtraFS(fsIdx, "GameFontNormal"); fs:ClearAllPoints(); fs:SetPoint("TOPLEFT", 15, y)
        fs:SetText(string.format("|cffffd100%d. %s|r (Score: %d)", i, d.name, d.score)); fs:Show(); y = y - 20; fsIdx = fsIdx + 1
        local itemText = "   Items: "
        for j, item in ipairs(d.items) do itemText = itemText .. "|cff00ff00" .. item.name .. "|r (" .. item.boss .. ")" .. (j < #d.items and ", " or "") end
        local is = self:GetExtraFS(fsIdx, "GameFontHighlightSmall"); is:SetPoint("TOPLEFT", 15, y); is:SetText(itemText); is:Show(); y = y - 35; fsIdx = fsIdx + 1
    end else self.text:SetText(self.text:GetText() .. "\n\nKeine Upgrades in Dungeons gefunden.") end
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager"); local items = GM:GetBestUpgrades()
    self.text:SetText("|cffffff00UPGRADE MATRIX (Vergleich mit Mythic 639)|r"); local y = -75; local ri = 1
    if #items > 0 then for _, item in ipairs(items) do ri = self:AddInteractiveRow(ri, item, y, nil, string.format("|cff00ff00+%.1f%%|r", item.percent or 0)); y = y - 30 end
    else local fs = self:GetExtraFS(60); fs:SetPoint("TOPLEFT", 25, y); fs:SetText("|cffaaaaaaKeine Upgrades verfügbar.|r"); fs:Show() end
end

function UI:DrawBiSList(content)
    local GM = DragonSkill:GetModule("GearManager"); local items = GM:GetBiSList()
    self.text:SetText("|cffffff00MYTHIC BIS LIST (Midnight Season 2 - 639+)|r"); local y = -45; local ri = 1
    for _, item in ipairs(items) do
        local ilvlStr = "|cffa335ee" .. (item.ilvl or 639) .. "|r"
        ri = self:AddInteractiveRow(ri + 200, item, y, nil, ilvlStr); y = y - 30
    end
end

function UI:DrawTalents(content, gd)
    local y = -45; self.text:SetText("|cffffff00Talent Builds|r")
    if gd.talentBuilds then for i, b in ipairs(gd.talentBuilds) do
        local btn = self.talentBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        self.talentBtns[i] = btn; btn:SetSize(560, 30); btn:SetPoint("TOPLEFT", 15, y); btn:SetText(string.format("[%s] %s", tostring(b.provider):upper(), tostring(b.label)))
        btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, b.importString) end); btn:Show(); y = y - 35
    end end
end

function UI:DrawRaidGuides(content)
    local guides = DragonSkillRaidGuides; local lw, y, fi = 180, -50, 500
    if not guides or #guides == 0 then return end
    for i, g in ipairs(guides) do
        local btn = self.bossBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        self.bossBtns[i] = btn; btn:SetSize(lw, 35); btn:SetPoint("TOPLEFT", 10, -50 - (i-1)*38); btn:SetText(g.name or "Boss"); btn:SetScript("OnClick", function() selectedBossIdx = i; self:Update() end); btn:Show()
    end
    local g = guides[selectedBossIdx]; if not g then return end
    local ti = self:GetExtraFS(fi); ti:SetPoint("TOPLEFT", lw + 25, y); ti:SetText("|cffffd100" .. tostring(g.name) .. "|r"); ti:Show(); fi = fi + 1; y = y - 30
    for _, p in ipairs(g.phases or {}) do
        local pt = self:GetExtraFS(fi); pt:SetPoint("TOPLEFT", lw + 25, y); pt:SetText("|cffffff00" .. tostring(p.name) .. "|r"); pt:Show(); fi = fi + 1; y = y - 20
        local pd = self:GetExtraFS(fi, "GameFontHighlightSmall"); pd:SetPoint("TOPLEFT", lw + 35, y); pd:SetText(tostring(p.desc)); pd:Show(); fi = fi + 1; y = y - 30
        for _, m in ipairs(p.mechanics or {}) do
            local mt = self:GetExtraFS(fi, "GameFontHighlightSmall"); mt:SetPoint("TOPLEFT", lw + 45, y); mt:SetText("|cffffd100" .. tostring(m.name) .. ":|r " .. tostring(m.tip)); mt:Show(); fi = fi + 1; y = y - 35
        end
        y = y - 10
    end
    local rt = self:GetExtraFS(fi); rt:SetPoint("TOPLEFT", lw + 25, y); rt:SetText("|cffffff00Rollen-Tipps|r"); rt:Show(); fi = fi + 1; y = y - 25
    local rx = self:GetExtraFS(fi, "GameFontHighlightSmall"); rx:SetPoint("TOPLEFT", lw + 35, y)
    rx:SetText(string.format("|cff00ccffTank:|r %s\n\n|cff00ff00Healer:|r %s\n\n|cffffffffDPS:|r %s", tostring(g.roles.tank), tostring(g.roles.heal), tostring(g.roles.dps)))
    rx:Show(); fi = fi + 1; y = y - 120; local post = self:GetExtraFS(fi); post:SetPoint("TOPLEFT", lw + 25, y); post:SetText("|cffffff00Positionierung|r"); post:Show(); fi = fi + 1; y = y - 25
    local pxt = self:GetExtraFS(fi, "GameFontHighlightSmall"); pxt:SetPoint("TOPLEFT", lw + 35, y); pxt:SetText(tostring(g.position)); pxt:Show(); fi = fi + 1
    content:SetHeight(math.abs(y) + 300)
end

function UI:Toggle() self:Init(); if self.frame:IsShown() then self.frame:Hide() else self.frame:Show(); self:Update() end end
SLASH_DRAGONSKILL1 = "/ds"; SlashCmdList["DRAGONSKILL"] = function() UI:Toggle() end
DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end); if IsLoggedIn() then UI:Init() end
DragonSkill.UI = UI
