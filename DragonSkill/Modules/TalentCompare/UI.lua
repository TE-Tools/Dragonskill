-- Dragon Skill - Main UI (v1.9.3)
-- Comprehensive Dashboard & Gear Assistant with Restored Minimap & Slash Commands.

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

---------------------------------------------------------------------------
-- Minimap & Menu logic (Restored)
---------------------------------------------------------------------------

local minimapBtn
local minimapMenuFrame

local function UpdateMinimapPosition()
    if not minimapBtn or not DragonSkillDB then return end
    local angle = (DragonSkillDB.minimap and DragonSkillDB.minimap.angle) or 220
    local rad = math.rad(angle)
    minimapBtn:SetPoint("CENTER", Minimap, "CENTER", math.cos(rad) * 80, math.sin(rad) * 80)
end

local function ShowMinimapMenu()
    if not minimapMenuFrame then
        minimapMenuFrame = CreateFrame("Frame", "DragonSkillMinimapMenu", UIParent, "UIDropDownMenuTemplate")
    end

    local menu = {
        { text = "Dragon Skill", isTitle = true, notCheckable = true },
        { text = "Dashboard", notCheckable = true, func = function() UI:Open(TAB_DASHBOARD) end },
        { text = "AI Coach", notCheckable = true, func = function() UI:Open(TAB_COACH) end },
        { text = "Farm Plan", notCheckable = true, func = function() UI:Open(TAB_FARM) end },
        { text = "BiS List", notCheckable = true, func = function() UI:Open(TAB_BIS) end },
        { text = "Minimap ausblenden", notCheckable = true, func = function() UI:ToggleMinimap() end },
    }
    EasyMenu(menu, minimapMenuFrame, "cursor", 0, 0, "MENU")
end

local function CreateMinimapButton()
    if minimapBtn then minimapBtn:Show(); return end

    local btn = CreateFrame("Button", "DragonSkillMinimapButton", Minimap)
    btn:SetSize(32, 32)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)
    btn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", 0, 1)
    icon:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    btn.icon = icon

    local border = btn:CreateTexture(nil, "OVERLAY")
    border:SetSize(54, 54)
    border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    btn:RegisterForDrag("LeftButton")

    btn:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            UI:Toggle()
        elseif button == "RightButton" then
            ShowMinimapMenu()
        end
    end)

    btn:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            cx, cy = cx / scale, cy / scale
            if not DragonSkillDB.minimap then DragonSkillDB.minimap = {} end
            DragonSkillDB.minimap.angle = math.deg(math.atan2(cy - my, cx - mx))
            UpdateMinimapPosition()
        end)
    end)
    btn:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("|cffffd100Dragon Skill|r")
        GameTooltip:AddLine("Linksklick: Dashboard oeffnen", 1, 1, 1)
        GameTooltip:AddLine("Rechtsklick: Menue", 1, 1, 1)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    minimapBtn = btn
    UpdateMinimapPosition()

    if DragonSkillDB and DragonSkillDB.minimap and DragonSkillDB.minimap.hide then
        btn:Hide()
    else
        btn:Show()
    end
end

function UI:ToggleMinimap()
    if not DragonSkillDB then return end
    DragonSkillDB.minimap = DragonSkillDB.minimap or {}
    DragonSkillDB.minimap.hide = not DragonSkillDB.minimap.hide
    if not minimapBtn then CreateMinimapButton() end
    if DragonSkillDB.minimap.hide then
        minimapBtn:Hide()
        print("|cff00ff00Dragon Skill:|r Minimap aus - /ds minimap zum Einblenden")
    else
        minimapBtn:Show()
        print("|cff00ff00Dragon Skill:|r Minimap an")
    end
end

---------------------------------------------------------------------------
-- Core UI logic
---------------------------------------------------------------------------

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

    if f.SetTitle then f:SetTitle("Dragon Skill v1.9.7") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end

    -- Footer Credit
    local footer = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    footer:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -10, 6)
    footer:SetText("Entwickelt von wear-alleria")

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
    self.talentBtns = {}
    self.extraFS = {}
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

    -- Hide Pooled rows
    for _, row in pairs(self.rows) do
        row:Hide()
        row:SetScript("OnEnter", nil)
    end

    -- Hide Pooled Extra FontStrings
    for _, fs in pairs(self.extraFS) do
        fs:Hide()
    end

    -- Hide all other children/regions except main text
    for _, child in ipairs({ content:GetChildren() }) do
        if child ~= self.text then child:Hide() end
    end
    for _, region in ipairs({ content:GetRegions() }) do
        if region ~= self.text then region:Hide() end
    end
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
            if not guideData then self.text:SetText("Keine Guide-Daten gefunden."); return end

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
    local specName = specID > 0 and select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
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
    if plan then
        for i, d in ipairs(plan) do
            local fs = self:GetExtraFS(i, "GameFontNormal")
            fs:ClearAllPoints()
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
    head:ClearAllPoints()
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
    if guideData and guideData.talentBuilds then
        for i, build in ipairs(guideData.talentBuilds) do
            local btn = self.talentBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            self.talentBtns[i] = btn
            btn:SetSize(ROW_WIDTH, 30); btn:SetPoint("TOPLEFT", 15, yOffset)
            btn:SetText(string.format("[%s] %s", (build.provider or "Guide"):upper(), build.label or "Build"))
            btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, build.importString) end)
            btn:Show()
            yOffset = yOffset - 35
        end
    end
end

function UI:DrawBosses(content)
    local BM = DragonSkill:GetModule("BossMechanics")
    if not BM or not BM.Bosses then return end
    self.text:SetText("|cffffff00Raid Boss Simulator|r")
    local yOffset = -45
    local idx = 1
    for id, boss in pairs(BM.Bosses) do
        local btn = self.talentBtns[idx + 100]
        if not btn then
            btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            btn:SetSize(ROW_WIDTH, 30)
            self.talentBtns[idx + 100] = btn
        end
        btn:ClearAllPoints()
        btn:SetPoint("TOPLEFT", 15, yOffset)
        btn:SetText(boss.Name or "Unbekannt")
        btn:SetScript("OnClick", function() BM:Simulate(id) end)
        btn:Show()
        yOffset = yOffset - 35
        idx = idx + 1
    end
end

function UI:DrawAssistant(content)
    self.text:SetText("|cffffff00AI Assistant|r\n\nFrag mich nach 'Farmen' oder 'Upgrades'.")
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

---------------------------------------------------------------------------
-- Slash Commands (Robust)
---------------------------------------------------------------------------

SLASH_DRAGONSKILL1 = "/ds"
SLASH_DRAGONSKILL2 = "/dragonskill"
SLASH_DRAGONSKILL3 = "/wear"
SlashCmdList["DRAGONSKILL"] = function(msg)
    local low = msg:lower()
    if low == "minimap" then
        UI:ToggleMinimap()
    elseif low == "bis" then
        UI:Open(TAB_BIS)
    elseif low == "farm" then
        UI:Open(TAB_FARM)
    elseif low == "today" then
        UI:Open(TAB_DASHBOARD)
    else
        UI:Toggle()
    end
end

---------------------------------------------------------------------------
-- Events & Boot
---------------------------------------------------------------------------

DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
    CreateMinimapButton()
end)

if IsLoggedIn() then
    UI:Init()
    CreateMinimapButton()
end

DragonSkill.UI = UI
