-- Dragon Skill - Main UI (v1.8.2)
-- Dashboard & Upgrade Matrix (v1.3) with Full Tooltip Support.

local L = DragonSkill.L or {}
local UI = {}
local currentTab = 1
local tabs = {
    "Dashboard",
    "Talente",
    "AI Coach",
    "Farm Plan",
    "Upgrades",
    "BiS List",
    "Trinkets",
    "Bosse",
    "Assistant"
}

local TAB_DASHBOARD = 1
local TAB_TALENTS = 2
local TAB_COACH = 3
local TAB_FARM = 4
local TAB_UPGRADES = 5
local TAB_BIS = 6
local TAB_TRINKETS = 7
local TAB_BOSSES = 8
local TAB_ASSISTANT = 9

local CONTENT_WIDTH, FRAME_WIDTH, FRAME_HEIGHT, ROW_WIDTH = 620, 780, 620, 600
local cachedBuildData = nil

function UI:Init()
    if self.frame then return end

    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    if f.SetTitle then f:SetTitle("Dragon Skill v1.8.2") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end

    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 8)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(CONTENT_WIDTH, 2000)
    scrollFrame:SetScrollChild(content)
    f.Content = content
    f.ScrollFrame = scrollFrame

    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "DragonSkillTabBtn" .. i, f, "PanelTabButtonTemplate")
        tab:SetID(i)
        tab:SetText(name)
        tab:SetScript("OnClick", function(selfBtn) UI:SelectTab(selfBtn:GetID()) end)
        f.Tabs[i] = tab
        if i == 1 then tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 10, 1)
        else tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", -16, 0) end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)

    tinsert(UISpecialFrames, "DragonSkillMainFrame")
    f:Hide()
    self.frame = f
    self.rows = {}
    self.extraFS = {}
    self.talentBtns = {}
end

function UI:SelectTab(id)
    currentTab = id
    PanelTemplates_SetTab(self.frame, id)
    self:Update()
end

function UI:GetRow(index)
    if not self.rows[index] then
        local row = CreateFrame("Button", nil, self.frame.Content)
        row:SetSize(ROW_WIDTH, 28)
        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(24, 24)
        row.icon:SetPoint("LEFT", 0, 0)
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
    return self.extraFS[index]
end

function UI:ClearContent()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content
    for _, child in ipairs({ content:GetChildren() }) do
        if child ~= self.text then child:Hide() end
    end
    for _, region in ipairs({ content:GetRegions() }) do
        if region ~= self.text then region:Hide() end
    end
    for _, row in pairs(self.rows) do row:Hide() end
    for _, fs in pairs(self.extraFS) do fs:Hide() end
end

function UI:EnsureText(content)
    if not content.text then
        content.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        content.text:SetPoint("TOPLEFT", 15, -15)
        content.text:SetWidth(CONTENT_WIDTH - 40)
        content.text:SetJustifyH("LEFT")
        content.text:SetSpacing(4)
    end
    return content.text
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content
    self:ClearContent()

    self.text = self:EnsureText(content)
    self.text:SetText("")
    self.text:Show()
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0

    local ok, err = pcall(function()
        if currentTab == TAB_DASHBOARD then self:DrawDashboard(content, class, specID)
        elseif currentTab == TAB_COACH then DragonSkill.AICoachUI:Draw(content, CONTENT_WIDTH)
        elseif currentTab == TAB_FARM then self:DrawFarm(content)
        elseif currentTab == TAB_UPGRADES then self:DrawUpgrades(content)
        elseif currentTab == TAB_ASSISTANT then self:DrawAssistant(content)
        elseif currentTab == TAB_BOSSES then self:DrawBosses(content)
        else
            local guideData = DragonSkill.Database:GetGuideData(class, specID)
            if not guideData then self.text:SetText("No guide data."); return end
            if currentTab == TAB_TALENTS then self:DrawTalents(content, guideData)
            elseif currentTab == TAB_BIS then self:DrawBiSList(content, guideData.bisGear and guideData.bisGear.wowhead)
            elseif currentTab == TAB_TRINKETS then self:DrawBiSList(content, guideData.trinkets and guideData.trinkets.archon, "Top Trinkets")
            end
        end
    end)

    if not ok then self.text:SetText("|cffff0000UI Fehler:|r " .. tostring(err)) end
end

function UI:AddInteractiveRow(index, itemData, yOffset, labelPrefix, valueText)
    if not itemData then return index end
    local row = self:GetRow(index)
    row:SetParent(self.frame.Content)
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", 15, yOffset)

    local texture = "Interface\\Icons\\Inv_misc_questionmark"
    if itemData.itemId then texture = C_Item.GetItemIconByID(itemData.itemId) or texture end
    row.icon:SetTexture(texture)

    local prefix = labelPrefix or (itemData.slot and "|cff00ff00"..itemData.slot..":|r " or "")
    row.text:SetText(prefix .. (itemData.name or itemData.text or "Item"))

    if valueText then
        row.val:SetText(valueText)
        row.val:Show()
    else
        row.val:Hide()
    end

    row:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        if itemData.itemId then GameTooltip:SetItemByID(itemData.itemId) else GameTooltip:SetText(itemData.name or "Item") end
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end)
    row:Show()
    return index + 1
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
    local avgIlvl = select(2, GetAverageItemLevel())

    local txt = "|cffffff00" .. class .. ": " .. specName .. " Dashboard|r\n\n"
    txt = txt .. string.format("Gegenstandsstufe: |cffffffff%.1f|r\n\n", avgIlvl)
    txt = txt .. "|cffffd100NÄCHSTE BESTE UPGRADES:|r"
    self.text:SetText(txt)

    local upgrades = GM:GetBestUpgrades()
    local yOffset = -85
    local rowIndex = 1
    if upgrades and #upgrades > 0 then
        for i=1, math.min(3, #upgrades) do
            rowIndex = self:AddInteractiveRow(rowIndex, upgrades[i], yOffset, nil, "|cff00ff00+"..upgrades[i].percent.."%|r")
            yOffset = yOffset - 30
        end
    end
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM:GetFarmPlan()
    self.text:SetText("|cffffff00OPTIMALE FARM-ROUTE (Dungeons)|r")
    local yOffset = -45
    local rowIndex = 1
    if plan then
        for i, d in ipairs(plan) do
            local fs = self:GetExtraFS(i, "GameFontNormal")
            fs:SetPoint("TOPLEFT", 15, yOffset)
            fs:SetText(string.format("|cffffd100%d. %s|r (Farm Score: %d/100)", i, d.name, d.score))
            fs:Show()
            yOffset = yOffset - 35
        end
    end
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM:GetBestUpgrades()
    self.text:SetText("|cffffff00UPGRADE MATRIX (Best Potential Targets)|r")

    local head = self:GetExtraFS(100, "GameFontNormal")
    head:SetPoint("TOPLEFT", 15, -45)
    head:SetText("Slot               Upgrade Item                         Verbesserung")
    head:Show()

    local yOffset = -75
    local rowIndex = 1
    for _, item in ipairs(items) do
        local valStr = string.format("|cff00ff00+%.1f%%|r", item.percent)
        rowIndex = self:AddInteractiveRow(rowIndex, item, yOffset, nil, valStr)
        yOffset = yOffset - 30
    end
end

function UI:DrawBiSList(content, items, title)
    self.text:SetText("|cffffff00" .. (title or "BiS Gear List") .. "|r")
    local yOffset = -45
    local rowIndex = 1
    if not items then return end
    for _, item in ipairs(items) do
        rowIndex = self:AddInteractiveRow(rowIndex, item, yOffset)
        yOffset = yOffset - 28
    end
end

function UI:DrawTalents(content, guideData)
    local yOffset = -45
    self.text:SetText("|cffffff00Talent Builds (Match %)|r")
    for i, build in ipairs(guideData.talentBuilds or {}) do
        local btn = self.talentBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        self.talentBtns[i] = btn
        btn:SetSize(ROW_WIDTH, 30); btn:SetPoint("TOPLEFT", 15, yOffset)
        btn:SetText(string.format("[%s] %s", build.provider:upper(), build.label))
        btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, build.importString) end)
        btn:Show()
        yOffset = yOffset - 35
    end
end

function UI:Toggle()
    self:Init()
    if self.frame:IsShown() then self.frame:Hide() else self.frame:Show(); self:Update() end
end

function UI:Open(tabId)
    self:Init()
    self.frame:Show()
    self:SelectTab(tabId)
end

SLASH_DRAGONSKILL1 = "/ds"
SLASH_DRAGONSKILL2 = "/wear"
SlashCmdList["DRAGONSKILL"] = function(msg)
    local low = msg:lower()
    if low == "bis" then UI:Open(TAB_BIS)
    elseif low == "farm" then UI:Open(TAB_FARM)
    elseif low == "today" then UI:Open(TAB_DASHBOARD)
    else UI:Toggle() end
end

DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init(); CreateMinimapButton() end)
if IsLoggedIn() then UI:Init(); CreateMinimapButton() end

DragonSkill.UI = UI
