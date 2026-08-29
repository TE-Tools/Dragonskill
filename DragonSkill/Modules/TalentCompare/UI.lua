-- Dragon Skill - Main UI (v1.7.2)
-- Finalized Gear Assistant & Farm Planner for WoW 12.1.
-- Restored Minimap Button and Fixed Slash Commands.

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

-- Minimap logic
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
        { text = "BiS Gear", notCheckable = true, func = function() UI:Open(TAB_BIS) end },
        { text = "Farm Plan", notCheckable = true, func = function() UI:Open(TAB_FARM) end },
        { text = "Minimap ausblenden", notCheckable = true, func = function() UI:ToggleMinimap() end },
    }
    EasyMenu(menu, minimapMenuFrame, "cursor", 0, 0, "MENU")
end

local function CreateMinimapButton()
    if minimapBtn then return end

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
        GameTooltip:AddLine("Linksklick: Fenster oeffnen", 1, 1, 1)
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

    if f.SetTitle then f:SetTitle("Dragon Skill v1.7.2") end
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
    self.listRows = {}
    self.talentBtns = {}
end

function UI:Open(tabId)
    self:Init()
    self.frame:Show()
    if tabId then self:SelectTab(tabId) else self:Update() end
end

function UI:Toggle()
    self:Init()
    if self.frame:IsShown() then self.frame:Hide() else self.frame:Show(); self:Update() end
end

function UI:SelectTab(id)
    currentTab = id
    PanelTemplates_SetTab(self.frame, id)
    self:Update()
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
    for _, child in ipairs({ content:GetChildren() }) do child:Hide() end
    if not self.text then
        self.text = self:EnsureText(content)
    end
    self.text:SetText("")
    self.text:Show()
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0

    if currentTab == TAB_DASHBOARD then self:DrawDashboard(content, class, specID)
    elseif currentTab == TAB_FARM then self:DrawFarm(content)
    elseif currentTab == TAB_UPGRADES then self:DrawUpgrades(content)
    elseif currentTab == TAB_ASSISTANT then self:DrawAssistant(content)
    elseif currentTab == TAB_BOSSES then self:DrawBosses(content)
    else
        local guideData = DragonSkill.Database:GetGuideData(class, specID)
        if not guideData then self.text:SetText("No guide data found."); return end

        if currentTab == TAB_TALENTS then self:DrawTalents(content, guideData)
        elseif currentTab == TAB_BIS then self:Helper_DrawListWithIcons(content, guideData.bisGear and guideData.bisGear.wowhead, "BiS List (Wowhead)")
        elseif currentTab == TAB_TRINKETS then self:Helper_DrawListWithIcons(content, guideData.trinkets and guideData.trinkets.archon, "Top Trinkets (Archon)")
        end
    end
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
    local txt = "|cffffff00" .. class .. ": " .. specName .. " Dashboard|r\n\n"

    local avgIlvl = select(2, GetAverageItemLevel())
    txt = txt .. string.format("Item Level: |cffffffff%.1f|r\n", avgIlvl)

    local upgrades = GM:GetBestUpgrades()
    txt = txt .. "\n|cffffd100NEXT UPGRADES:|r\n"
    for i=1, math.min(3, #upgrades) do
        local item = upgrades[i]
        txt = txt .. string.format("%d. %s (%s) - Prio: %d/10\n", i, item.name, item.slot, item.priority)
    end

    local plan = GM:GetFarmPlan()
    txt = txt .. "\n|cffffff00FARM PRIORITY:|r\n"
    if #plan > 0 then
        txt = txt .. "1. " .. plan[1].name .. " (Score: " .. plan[1].score .. ")\n"
    end

    self.text:SetText(txt)
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM:GetFarmPlan()
    local txt = "|cffffff00OPTIMAL FARM ROUTE|r\n\n"
    for i, d in ipairs(plan) do
        txt = txt .. string.format("|cffffd100%d. %s|r (Score: %d)\n", i, d.name, d.score)
    end
    self.text:SetText(txt)
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM:GetBestUpgrades()
    self:Helper_DrawListWithIcons(content, items, "BEST UPGRADES")
end

function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -45
    self.text:SetText(title)
    if not self.listRows then self.listRows = {} end
    for _, row in ipairs(self.listRows) do row:Hide() end
    if not items or #items == 0 then return end
    for i, item in ipairs(items) do
        local row = self.listRows[i]
        if not row then
            row = CreateFrame("Button", nil, content)
            row:SetSize(ROW_WIDTH, 26)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22); row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
            self.listRows[i] = row
        end
        row:SetPoint("TOPLEFT", 15, yOffset)
        local tex = "Interface\\Icons\\Inv_misc_questionmark"
        if item.itemId then tex = C_Item.GetItemIconByID(item.itemId) or tex end
        row.icon:SetTexture(tex)
        row.text:SetText((item.slot and "|cff00ff00"..item.slot..":|r " or "") .. (item.name or item.text or "Item"))
        row:Show()
        yOffset = yOffset - 28
    end
end

function UI:DrawTalents(content, guideData)
    local yOffset = -45
    for i, build in ipairs(guideData.talentBuilds or {}) do
        local btn = self.talentBtns[i]
        if not btn then
            btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            btn:SetSize(ROW_WIDTH, 30)
            self.talentBtns[i] = btn
        end
        btn:SetPoint("TOPLEFT", 15, yOffset)
        btn:SetText(build.label)
        btn:Show()
        yOffset = yOffset - 35
    end
end

function UI:DrawAssistant(content)
    self.text:SetText("|cffffff00AI Assistant|r\n\nAsk me about gear or farm targets.")
end

function UI:DrawBosses(content)
    local BM = DragonSkill:GetModule("BossMechanics")
    if not BM then return end
    local yOffset = -45
    for id, boss in pairs(BM.Bosses) do
        -- Button Logic
    end
end

SLASH_DS1 = "/ds"
SLASH_WEAR1 = "/wear"
SlashCmdList["DS"] = function(msg)
    local low = msg:lower()
    if low == "minimap" then
        UI:ToggleMinimap()
    elseif low == "bis" then
        UI:Open(TAB_BIS)
    elseif low == "farm" then
        UI:Open(TAB_FARM)
    else
        UI:Toggle()
    end
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
    CreateMinimapButton()
end)

DragonSkill.UI = UI
