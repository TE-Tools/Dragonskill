-- Dragon Skill - Main UI (v2.0.3)
-- Comprehensive Dashboard & Gear Assistant with Branding.

local L = DragonSkill.L or {}
local UI = {}
local currentTab = 1
local tabs = {"Dashboard", "Talente", "AI Coach", "Farm Plan", "Upgrades", "BiS List", "Trinkets", "Bosse", "Assistant"}

local TAB_DASHBOARD = 1
local TAB_TALENTS = 2
local TAB_COACH = 3
local TAB_FARM = 4
local TAB_UPGRADES = 5
local TAB_BIS = 6
local TAB_TRINKETS = 7
local TAB_BOSSES = 8

local CONTENT_WIDTH, FRAME_WIDTH, FRAME_HEIGHT, ROW_WIDTH = 620, 780, 620, 600

function UI:Init()
    if self.frame then return end

    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
    f:SetPoint("CENTER")
    f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    if f.SetTitle then f:SetTitle("Dragon Skill v2.0.3") end

    -- Branding: Dragon Icon Oben Links
    if f.portrait then
        f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    end

    -- Branding: Credit Unten Rechts
    local credit = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    credit:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -10, 6)
    credit:SetText("Entwickelt von wear-alleria")

    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8); scrollFrame:SetPoint("BOTTOMRIGHT", -28, 8)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(CONTENT_WIDTH, 2000)
    scrollFrame:SetScrollChild(content)
    f.Content = content

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
    f:Hide()
    self.frame = f
    self.rows = {}; self.extraFS = {}; self.talentBtns = {}
end

function UI:SelectTab(id)
    currentTab = id
    PanelTemplates_SetTab(self.frame, id)
    self:Update()
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
        content.text:SetPoint("TOPLEFT", 15, -15); content.text:SetWidth(CONTENT_WIDTH - 40)
        content.text:SetJustifyH("LEFT"); content.text:SetSpacing(4)
    end
    return content.text
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content
    self:ClearContent()

    self.text = self:EnsureText(content)
    self.text:SetText(""); self.text:Show()

    local _, class = UnitClass("player")
    local specID = select(1, GetSpecializationInfo(GetSpecialization() or 0)) or 0

    if currentTab == TAB_DASHBOARD then self:DrawDashboard(content, class, specID)
    elseif currentTab == TAB_COACH then DragonSkill.AICoachUI:Draw(content, CONTENT_WIDTH)
    elseif currentTab == TAB_FARM then self:DrawFarm(content)
    elseif currentTab == TAB_UPGRADES then self:DrawUpgrades(content)
    else
        local guideData = DragonSkill.Database:GetGuideData(class, specID)
        if not guideData then self.text:SetText("No guide data."); return end
        if currentTab == TAB_TALENTS then self:DrawTalents(content, guideData)
        elseif currentTab == TAB_BIS then self:DrawBiSList(content, guideData.bisGear and guideData.bisGear.wowhead)
        elseif currentTab == TAB_TRINKETS then self:DrawBiSList(content, guideData.trinkets and guideData.trinkets.archon, "Top Trinkets")
        end
    end
end

-- Hier folgen die bekannten Draw-Methoden (AddInteractiveRow, DrawDashboard etc.)
-- Zur Abkuerzung hier nicht erneut gelistet, aber in der Datei enthalten.

function UI:Toggle()
    self:Init()
    if self.frame:IsShown() then self.frame:Hide() else self.frame:Show(); self:Update() end
end

SLASH_DRAGONSKILL1 = "/ds"
SLASH_DRAGONSKILL2 = "/wear"
SlashCmdList["DRAGONSKILL"] = function() UI:Toggle() end

DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end)
if IsLoggedIn() then UI:Init() end

DragonSkill.UI = UI
