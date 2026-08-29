-- Dragon Skill - Main UI (v1.7.5)
-- Optimized Gear Assistant & Farm Planner for WoW 12.1.
-- High Stability Fix: Enhanced error handling and robust Minimap/Slash registration.

local L = DragonSkill.L or {}
local UI = {}
local currentTab = 1
local tabs = {
    "Dashboard",
    "Talente",
    "Farm Plan",
    "Upgrades",
    "BiS List",
    "Trinkets",
    "Bosse",
    "Assistant"
}

local TAB_DASHBOARD = 1
local TAB_TALENTS = 2
local TAB_FARM = 3
local TAB_UPGRADES = 4
local TAB_BIS = 5
local TAB_TRINKETS = 6
local TAB_BOSSES = 7
local TAB_ASSISTANT = 8

local CONTENT_WIDTH, FRAME_WIDTH, FRAME_HEIGHT, ROW_WIDTH = 600, 750, 600, 580
local cachedBuildData = nil

---------------------------------------------------------------------------
-- Minimap & Menu logic (Robust)
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

    if f.SetTitle then f:SetTitle("Dragon Skill v1.7.5") end
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
        row:SetSize(ROW_WIDTH, 26)
        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(22, 22)
        row.icon:SetPoint("LEFT", 0, 0)
        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
        row.text:SetJustifyH("LEFT")
        self.rows[index] = row
    end
    return self.rows[index]
end

function UI:ClearRows()
    for _, row in pairs(self.rows) do
        row:Hide()
        row:SetScript("OnEnter", nil)
        row:SetScript("OnClick", nil)
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

    self.text = self:EnsureText(content)

    -- Hide all children (buttons etc)
    for _, child in ipairs({ content:GetChildren() }) do
        if child ~= self.text then child:Hide() end
    end
    self:ClearRows()

    self.text:SetText("")
    self.text:Show()
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0

    local ok, err = pcall(function()
        if currentTab == TAB_DASHBOARD then self:DrawDashboard(content, class, specID)
        elseif currentTab == TAB_FARM then self:DrawFarm(content)
        elseif currentTab == TAB_UPGRADES then self:DrawUpgrades(content)
        elseif currentTab == TAB_ASSISTANT then self:DrawAssistant(content)
        elseif currentTab == TAB_BOSSES then self:DrawBosses(content)
        else
            local guideData = DragonSkill.Database:GetGuideData(class, specID)
            if not guideData then text:SetText("Keine Guide-Daten fuer diese Spezialisierung gefunden."); return end

            if currentTab == TAB_TALENTS then self:DrawTalents(content, guideData)
            elseif currentTab == TAB_BIS then self:DrawBiSList(content, guideData.bisGear and guideData.bisGear.wowhead, "BiS List (Wowhead)")
            elseif currentTab == TAB_TRINKETS then self:DrawBiSList(content, guideData.trinkets and guideData.trinkets.archon, "Top Trinkets (Archon)")
            end
        end
    end)

    if not ok then
        text:SetText("|cffff0000UI Fehler:|r " .. tostring(err))
    end
end

function UI:AddInteractiveRow(index, itemData, yOffset, labelPrefix)
    if not itemData then return index end
    local row = self:GetRow(index)
    row:SetParent(self.frame.Content)
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", 15, yOffset)

    local name = itemData.name or itemData.text or "Unbekanntes Item"
    local slot = itemData.slot or ""
    local prefix = labelPrefix or (slot ~= "" and "|cff00ff00"..slot..":|r " or "")

    local texture = "Interface\\Icons\\Inv_misc_questionmark"
    if itemData.itemId then
        local tex = C_Item.GetItemIconByID(itemData.itemId)
        if tex then texture = tex end
    end

    row.icon:SetTexture(texture)
    row.text:SetText(prefix .. name .. (itemData.priority and " |cff00ff00(Prio "..itemData.priority..")|r" or ""))

    row:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        if itemData.itemId then
            GameTooltip:SetItemByID(itemData.itemId)
        else
            GameTooltip:SetText(name)
        end
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end)
    row:Show()
    return index + 1
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = specID > 0 and select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"

    local titleTxt = "|cffffff00" .. class .. ": " .. specName .. " Dashboard|r\n\n"
    local avgIlvl = select(2, GetAverageItemLevel())
    titleTxt = titleTxt .. string.format("Gegenstandsstufe: |cffffffff%.1f|r\n\n", avgIlvl)
    titleTxt = titleTxt .. "|cffffd100NÄCHSTE BESTE UPGRADES:|r"
    self.text:SetText(titleTxt)

    local upgrades = GM:GetBestUpgrades()
    local yOffset = -85
    local rowIndex = 1

    if upgrades and #upgrades > 0 then
        for i=1, math.min(3, #upgrades) do
            rowIndex = self:AddInteractiveRow(rowIndex, upgrades[i], yOffset)
            yOffset = yOffset - 28
        end
    else
        yOffset = yOffset - 10
    end

    yOffset = yOffset - 20
    local farmTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    farmTitle:SetPoint("TOPLEFT", 15, yOffset)
    farmTitle:SetText("|cffffff00WAS SOLL ICH HEUTE FARMEN?|r")
    farmTitle:Show()
    yOffset = yOffset - 25

    local plan = GM:GetFarmPlan()
    if plan and #plan > 0 then
        local dungeonTxt = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        dungeonTxt:SetPoint("TOPLEFT", 15, yOffset)
        dungeonTxt:SetText("1. |cffffffff" .. plan[1].name .. "|r (Score: " .. plan[1].score .. ")")
        dungeonTxt:Show()
        yOffset = yOffset - 30
    end

    local catTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    catTitle:SetPoint("TOPLEFT", 15, yOffset)
    catTitle:SetText("|cffffd100CATALYST EMPFEHLUNG:|r")
    catTitle:Show()
    yOffset = yOffset - 25

    local catTxt = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    catTxt:SetPoint("TOPLEFT", 15, yOffset)
    catTxt:SetWidth(CONTENT_WIDTH - 40)
    catTxt:SetJustifyH("LEFT")
    catTxt:SetText(GM.GetCatalystRecommendation and GM:GetCatalystRecommendation() or "Brust oder Beine")
    catTxt:Show()
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM:GetFarmPlan()
    self.text:SetText("|cffffff00OPTIMALE FARM-ROUTE (Dungeons)|r")

    local yOffset = -45
    local rowIndex = 1

    if plan then
        for i, d in ipairs(plan) do
            local dTitle = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            dTitle:SetPoint("TOPLEFT", 15, yOffset)
            dTitle:SetText(string.format("|cffffd100%d. %s|r (Score: %d)", i, d.name, d.score))
            dTitle:Show()
            yOffset = yOffset - 20

            local dData = DragonSkillGearData.dungeons[d.name]
            if dData then
                for _, boss in ipairs(dData.bosses) do
                    for _, itemId in ipairs(boss.loot) do
                        if GM:GetUpgradeScore(nil, itemId) > 0 then
                            local item = DragonSkillGearData.items[itemId]
                            if item then
                                rowIndex = self:AddInteractiveRow(rowIndex, item, yOffset, "   - ")
                                yOffset = yOffset - 26
                            end
                        end
                    end
                end
            end
            yOffset = yOffset - 10
        end
    end
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM:GetBestUpgrades()
    self:DrawBiSList(content, items, "DEINE NÄCHSTEN UPGRADES (Priority 1-10)")
end

function UI:DrawBiSList(content, items, title)
    self.text:SetText(title or "BiS Gear List")
    local yOffset = -45
    local rowIndex = 1
    if not items or #items == 0 then return end
    for _, item in ipairs(items) do
        rowIndex = self:AddInteractiveRow(rowIndex, item, yOffset)
        yOffset = yOffset - 28
    end
end

function UI:DrawTalents(content, guideData)
    local yOffset = -45
    self.text:SetText("Talent Builds (12.1)")
    if guideData and guideData.talentBuilds then
        for i, build in ipairs(guideData.talentBuilds) do
            local btn = self.talentBtns[i]
            if not btn then
                btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
                btn:SetSize(ROW_WIDTH, 30)
                self.talentBtns[i] = btn
            end
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", 15, yOffset)
            btn:SetText(string.format("[%s] %s", (build.provider or "Guide"):upper(), build.label or "Build"))
            btn:SetScript("OnClick", function()
                StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, build.importString)
            end)
            btn:Show()
            yOffset = yOffset - 35
        end
    end
end

function UI:DrawBosses(content)
    local BM = DragonSkill:GetModule("BossMechanics")
    if not BM or not BM.Bosses then return end
    self.text:SetText("Raid Boss Simulator")
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
-- Slash Commands (Global)
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

-- Falls der Login bereits vorbei ist (Manual Reload)
if IsLoggedIn() then
    UI:Init()
    CreateMinimapButton()
end

DragonSkill.UI = UI
