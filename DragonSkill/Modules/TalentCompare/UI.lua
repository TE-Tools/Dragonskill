-- Dragon Skill - Main UI (v2.2.4)
-- Final Master UI Restoration & Safety Update.

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
local ROW_WIDTH = 560

function UI:Init()
    if self.frame then return end

    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
    f:SetPoint("CENTER")
    f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    if f.SetTitle then f:SetTitle("Dragon Skill v2.2.4") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end

    local credit = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    credit:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -10, 6); credit:SetText("Entwickelt von wear-alleria")

    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8); scrollFrame:SetPoint("BOTTOMRIGHT", -28, 8)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(CONTENT_WIDTH, 2000)
    scrollFrame:SetScrollChild(content)
    f.Content = content; f.ScrollFrame = scrollFrame

    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "DragonSkillTabBtn" .. i, f, "PanelTabButtonTemplate")
        tab:SetID(i); tab:SetText(name)
        tab:SetScript("OnClick", function(selfBtn) UI:SelectTab(selfBtn:GetID()) end)
        f.Tabs[i] = tab
        if i == 1 then tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 10, 1)
        else tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", -16, 0) end
    end
    PanelTemplates_SetNumTabs(f, #tabs); PanelTemplates_SetTab(f, 1)

    tinsert(UISpecialFrames, "DragonSkillMainFrame")
    f:Hide(); self.frame = f
    self.rows = {}; self.extraFS = {}; self.talentBtns = {}; self.bossBtns = {}
end

function UI:SelectTab(id)
    currentTab = id
    PanelTemplates_SetTab(self.frame, id)
    self:Update()
end

function UI:GetRow(index)
    if not self.rows[index] then
        local row = CreateFrame("Button", nil, self.frame.Content)
        row:SetSize(560, 28) -- Hardcoded width for safety
        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(24, 24); row.icon:SetPoint("LEFT", 0, 0)
        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
        row.val = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.val:SetPoint("RIGHT", -10, 0)
        self.rows[index] = row
    end
    return self.rows[index]
end

function UI:GetExtraFS(index, font)
    if not self.extraFS[index] then
        self.extraFS[index] = self.frame.Content:CreateFontString(nil, "OVERLAY", font or "GameFontHighlight")
    end
    self.extraFS[index]:SetFontObject(font or "GameFontHighlight")
    self.extraFS[index]:SetWidth(CONTENT_WIDTH - 20); self.extraFS[index]:SetJustifyH("LEFT")
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
        content.text:SetPoint("TOPLEFT", 15, -15); content.text:SetWidth(CONTENT_WIDTH - 40)
        content.text:SetJustifyH("LEFT"); content.text:SetSpacing(4)
    end
    return content.text
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content
    self:ClearContent()
    self.text = self:EnsureText(content); self.text:SetText(""); self.text:Show()
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0

    local ok, err = pcall(function()
        if currentTab == TAB_DASHBOARD then self:DrawDashboard(content, class, specID)
        elseif currentTab == TAB_COACH then DragonSkill.AICoachUI:Draw(content, 580)
        elseif currentTab == TAB_FARM then self:DrawFarm(content)
        elseif currentTab == TAB_UPGRADES then self:DrawUpgrades(content)
        elseif currentTab == TAB_RAIDGUIDES then self:DrawRaidGuides(content)
        elseif currentTab == TAB_BIS then self:DrawBiSList(content)
        elseif currentTab == TAB_TALENTS then
            local guideData = DragonSkill.Database:GetGuideData(class, specID)
            if guideData then self:DrawTalents(content, guideData) else self.text:SetText("Keine Guide-Daten.") end
        end
    end)
    if not ok then self.text:SetText("|cffff0000UI Fehler:|r " .. tostring(err)) end
end

function UI:AddInteractiveRow(index, itemData, yOffset, labelPrefix, valueText)
    if not itemData or not itemData.itemId then return index end
    local row = self:GetRow(index)
    row:SetParent(self.frame.Content); row:ClearAllPoints(); row:SetPoint("TOPLEFT", 15, yOffset)
    local iid = tonumber(itemData.itemId) or 0
    row.icon:SetTexture(C_Item.GetItemIconByID(iid) or "Interface\\Icons\\Inv_misc_questionmark")
    local name = tostring(itemData.name) or "Item "..iid
    row.text:SetText((labelPrefix or (itemData.slot and "|cff00ff00"..itemData.slot..":|r " or "")) .. name)
    if valueText then row.val:SetText(tostring(valueText)); row.val:Show() else row.val:Hide() end
    row:SetScript("OnEnter", function(s) GameTooltip:SetOwner(s, "ANCHOR_RIGHT"); GameTooltip:SetItemByID(iid); GameTooltip:Show() end)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end); row:Show()
    return index + 1
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
    self.text:SetText("|cffffff00" .. tostring(class) .. ": " .. tostring(specName) .. " Dashboard|r\n\n" .. string.format("Gegenstandsstufe: |cffffffff%.1f|r\n\n", select(2, GetAverageItemLevel())) .. "|cffffd100NÄCHSTE BESTE UPGRADES:|r")
    local upgrades = GM:GetBestUpgrades(); local yOffset = -85; local rowIndex = 1
    if upgrades then
        for i=1, math.min(3, #upgrades) do
            rowIndex = self:AddInteractiveRow(rowIndex, upgrades[i], yOffset, nil, "|cff00ff00+"..upgrades[i].percent.."%|r")
            yOffset = yOffset - 30
        end
    end
    local y = yOffset - 40; local gT = self:GetExtraFS(1000); gT:SetPoint("TOPLEFT", 15, y); gT:SetText("|cffffd100GILDE: DRAGON LORDS ALLERIA|r"); gT:Show(); y = y - 25
    local gW = self:GetExtraFS(1001, "GameFontHighlightSmall"); gW:SetPoint("TOPLEFT", 15, y); gW:SetText("Website: |cff00ccffhttps://guildsowow.com/dragon-lords|r"); gW:Show()
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM:GetFarmPlan()
    self.text:SetText("|cffffff00OPTIMALE FARM-ROUTE|r")
    local yOffset = -45
    if plan then
        for i, d in ipairs(plan) do
            local fs = self:GetExtraFS(i, "GameFontNormal"); fs:ClearAllPoints(); fs:SetPoint("TOPLEFT", 15, yOffset)
            fs:SetText(string.format("|cffffd100%d. %s|r (Score: %d/100)", i, d.name, d.score)); fs:Show(); yOffset = yOffset - 35
        end
    end
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM:GetBestUpgrades()
    self.text:SetText("|cffffff00UPGRADE MATRIX|r")
    local yOffset = -75; local rowIndex = 1
    for _, item in ipairs(items) do
        rowIndex = self:AddInteractiveRow(rowIndex, item, yOffset, nil, "|cff00ff00+"..item.percent.."%|r")
        yOffset = yOffset - 30
    end
end

function UI:DrawBiSList(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM:GetBiSList()
    self.text:SetText("|cffffff00BiS Gear List|r")
    local yOffset = -45; local rowIndex = 1
    for _, item in ipairs(items) do rowIndex = self:AddInteractiveRow(rowIndex + 200, item, yOffset); yOffset = yOffset - 30 end
end

function UI:DrawTalents(content, guideData)
    local yOffset = -45; self.text:SetText("|cffffff00Talent Builds|r")
    if guideData and guideData.talentBuilds then
        for i, build in ipairs(guideData.talentBuilds) do
            local btn = self.talentBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            self.talentBtns[i] = btn; btn:SetSize(560, 30); btn:SetPoint("TOPLEFT", 15, yOffset)
            btn:SetText(string.format("[%s] %s", tostring(build.provider):upper(), tostring(build.label)))
            btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, build.importString) end)
            btn:Show(); yOffset = yOffset - 35
        end
    end
end

function UI:DrawRaidGuides(content)
    local guides = DragonSkillRaidGuides
    local listWidth, y, fsIdx = 180, -50, 500
    for i, guide in ipairs(guides) do
        local btn = self.bossBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        self.bossBtns[i] = btn; btn:SetSize(listWidth, 35); btn:SetPoint("TOPLEFT", 10, -50 - (i-1)*38)
        btn:SetText(guide.name); btn:SetScript("OnClick", function() selectedBossIdx = i; self:Update() end); btn:Show()
    end
    local guide = guides[selectedBossIdx]
    if not guide then return end
    local title = self:GetExtraFS(fsIdx); title:SetPoint("TOPLEFT", listWidth + 25, y); title:SetText("|cffffd100" .. guide.name .. "|r"); title:Show(); fsIdx = fsIdx + 1; y = y - 30
    for _, phase in ipairs(guide.phases) do
        local phT = self:GetExtraFS(fsIdx); phT:SetPoint("TOPLEFT", listWidth + 25, y); phT:SetText("|cffffff00" .. phase.name .. "|r"); phT:Show(); fsIdx = fsIdx + 1; y = y - 20
        local phD = self:GetExtraFS(fsIdx, "GameFontHighlightSmall"); phD:SetPoint("TOPLEFT", listWidth + 35, y); phD:SetText(phase.desc); phD:Show(); fsIdx = fsIdx + 1; y = y - 30
        for _, mech in ipairs(phase.mechanics) do
            local mT = self:GetExtraFS(fsIdx, "GameFontHighlightSmall"); mT:SetPoint("TOPLEFT", listWidth + 45, y); mT:SetText("|cffffd100" .. mech.name .. ":|r " .. mech.tip); mT:Show(); fsIdx = fsIdx + 1; y = y - 35
        end
        y = y - 10
    end
    local rT = self:GetExtraFS(fsIdx); rT:SetPoint("TOPLEFT", listWidth + 25, y); rT:SetText("|cffffff00Rollen-Tipps|r"); rT:Show(); fsIdx = fsIdx + 1; y = y - 25
    local rX = self:GetExtraFS(fsIdx, "GameFontHighlightSmall"); rX:SetPoint("TOPLEFT", listWidth + 35, y); rX:SetText(string.format("|cff00ccffTank:|r %s\n\n|cff00ff00Healer:|r %s\n\n|cffffffffDPS:|r %s", guide.roles.tank, guide.roles.heal, guide.roles.dps)); rX:Show(); fsIdx = fsIdx + 1; y = y - 120
    local pT = self:GetExtraFS(fsIdx); pT:SetPoint("TOPLEFT", listWidth + 25, y); pT:SetText("|cffffff00Positionierung|r"); pT:Show(); fsIdx = fsIdx + 1; y = y - 25
    local pX = self:GetExtraFS(fsIdx, "GameFontHighlightSmall"); pX:SetPoint("TOPLEFT", listWidth + 35, y); pX:SetText(guide.position); pX:Show(); fsIdx = fsIdx + 1
    content:SetHeight(math.abs(y) + 300)
end

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Build-String kopieren (Strg+C):", button1 = "Fertig", hasEditBox = 1,
    OnShow = function(self, data) if data then self.editBox:SetText(tostring(data)) self.editBox:HighlightText() end end,
    timeout = 0, whileDead = true, hideOnEscape = true,
}

function UI:Toggle() self:Init(); if self.frame:IsShown() then self.frame:Hide() else self.frame:Show(); self:Update() end end
SLASH_DRAGONSKILL1 = "/ds"; SlashCmdList["DRAGONSKILL"] = function() UI:Toggle() end
DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end); if IsLoggedIn() then UI:Init() end
DragonSkill.UI = UI
