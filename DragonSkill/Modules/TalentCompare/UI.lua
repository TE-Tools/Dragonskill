-- Dragon Skill - Main UI (v2.1.6)
-- Full Restoration & New Raid Guides Tab.

local L = DragonSkill.L or {}
local UI = {}
local currentTab = 1
local tabs = {"Dashboard", "Talente", "AI Coach", "Farm Plan", "Upgrades", "BiS List", "Raid Guides", "Bosse"}

local TAB_DASHBOARD = 1
local TAB_TALENTS = 2
local TAB_COACH = 3
local TAB_FARM = 4
local TAB_UPGRADES = 5
local TAB_BIS = 6
local TAB_RAIDGUIDES = 7
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

    if f.SetTitle then f:SetTitle("Dragon Skill v2.1.6") end

    if f.portrait then
        f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    end

    local credit = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    credit:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -10, 6)
    credit:SetText("Entwickelt von wear-alleria")

    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8); scrollFrame:SetPoint("BOTTOMRIGHT", -28, 8)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(CONTENT_WIDTH, 2000)
    scrollFrame:SetScrollChild(content)
    f.Content = content
    f.ScrollFrame = scrollFrame

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

function UI:GetRow(index)
    if not self.rows[index] then
        local row = CreateFrame("Button", nil, self.frame.Content)
        row:SetSize(ROW_WIDTH, 28)
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
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0

    local ok, err = pcall(function()
        if currentTab == TAB_DASHBOARD then self:DrawDashboard(content, class, specID)
        elseif currentTab == TAB_COACH then DragonSkill.AICoachUI:Draw(content, CONTENT_WIDTH)
        elseif currentTab == TAB_FARM then self:DrawFarm(content)
        elseif currentTab == TAB_UPGRADES then self:DrawUpgrades(content)
        elseif currentTab == TAB_RAIDGUIDES then self:DrawRaidGuides(content)
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
            local row = self:GetRow(rowIndex)
            row:SetParent(content); row:ClearAllPoints(); row:SetPoint("TOPLEFT", 15, yOffset)
            local texture = "Interface\\Icons\\Inv_misc_questionmark"
            if upgrades[i].itemId then texture = C_Item.GetItemIconByID(upgrades[i].itemId) or texture end
            row.icon:SetTexture(texture)
            row.text:SetText("|cff00ff00"..upgrades[i].slot..":|r " .. upgrades[i].name)
            row.val:SetText("|cff00ff00+"..upgrades[i].percent.."%|r"); row.val:Show()
            row:SetScript("OnEnter", function(s)
                GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
                GameTooltip:SetItemByID(upgrades[i].itemId); GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
            row:Show(); yOffset = yOffset - 30; rowIndex = rowIndex + 1
        end
    end
end

function UI:DrawRaidGuides(content)
    self.text:SetText("|cffffff00VENOMOUS ABYSS RAID GUIDES|r")
    local yOffset = -45
    local fsIdx = 200
    for key, guide in pairs(DragonSkillRaidGuides) do
        local title = self:GetExtraFS(fsIdx, "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 15, yOffset); title:SetText("|cffffd100" .. guide.name .. "|r"); title:Show()
        yOffset = yOffset - 25; fsIdx = fsIdx + 1

        local pText = ""
        for _, p in ipairs(guide.phases) do pText = pText .. "• " .. p .. "\n" end
        local phases = self:GetExtraFS(fsIdx, "GameFontHighlightSmall")
        phases:SetPoint("TOPLEFT", 25, yOffset); phases:SetText(pText); phases:Show()
        yOffset = yOffset - (20 * #guide.phases) - 10; fsIdx = fsIdx + 1

        local roles = self:GetExtraFS(fsIdx, "GameFontHighlightSmall")
        roles:SetPoint("TOPLEFT", 25, yOffset)
        roles:SetText(string.format("|cff00ccffTank:|r %s\n|cff00ff00Heal:|r %s\n|cffffffffDPS:|r %s", guide.roles.tank or "-", guide.roles.heal or "-", guide.roles.dps or "-"))
        roles:Show(); yOffset = yOffset - 60; fsIdx = fsIdx + 1

        yOffset = yOffset - 20
    end
end

-- Re-implementing simplified versions of other tabs for space
function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM:GetFarmPlan()
    self.text:SetText("|cffffff00OPTIMALE FARM-ROUTE|r")
    local yOffset = -45
    if plan then
        for i, d in ipairs(plan) do
            local fs = self:GetExtraFS(i, "GameFontNormal")
            fs:ClearAllPoints(); fs:SetPoint("TOPLEFT", 15, yOffset)
            fs:SetText(string.format("|cffffd100%d. %s|r (Score: %d/100)", i, d.name, d.score))
            fs:Show(); yOffset = yOffset - 35
        end
    end
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM:GetBestUpgrades()
    self.text:SetText("|cffffff00UPGRADE MATRIX|r")
    local yOffset = -75; local rowIndex = 1
    for _, item in ipairs(items) do
        local row = self:GetRow(rowIndex)
        row:SetParent(content); row:ClearAllPoints(); row:SetPoint("TOPLEFT", 15, yOffset)
        local texture = C_Item.GetItemIconByID(item.itemId) or "Interface\\Icons\\Inv_misc_questionmark"
        row.icon:SetTexture(texture); row.text:SetText("|cff00ff00"..item.slot..":|r " .. item.name)
        row.val:SetText("|cff00ff00+"..item.percent.."%|r"); row.val:Show()
        row:SetScript("OnEnter", function(s) GameTooltip:SetOwner(s, "ANCHOR_RIGHT"); GameTooltip:SetItemByID(item.itemId); GameTooltip:Show() end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end); row:Show()
        yOffset = yOffset - 30; rowIndex = rowIndex + 1
    end
end

function UI:DrawBiSList(content, items, title)
    self.text:SetText("|cffffff00" .. (title or "BiS Gear List") .. "|r")
    local yOffset = -45; local rowIndex = 1
    if not items then return end
    for _, item in ipairs(items) do
        local row = self:GetRow(rowIndex + 50)
        row:SetParent(content); row:ClearAllPoints(); row:SetPoint("TOPLEFT", 15, yOffset)
        row.text:SetText(item.name or "Item"); row:Show(); yOffset = yOffset - 28; rowIndex = rowIndex + 1
    end
end

function UI:DrawTalents(content, guideData)
    local yOffset = -45; self.text:SetText("|cffffff00Talent Builds|r")
    if guideData and guideData.talentBuilds then
        for i, build in ipairs(guideData.talentBuilds) do
            local btn = self.talentBtns[i] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            self.talentBtns[i] = btn
            btn:SetSize(ROW_WIDTH, 30); btn:SetPoint("TOPLEFT", 15, yOffset)
            btn:SetText(string.format("[%s] %s", (build.provider or "Guide"):upper(), build.label or "Build"))
            btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, build.importString) end)
            btn:Show(); yOffset = yOffset - 35
        end
    end
end

function UI:DrawBosses(content)
    local BM = DragonSkill:GetModule("BossMechanics")
    if not BM or not BM.Bosses then return end
    self.text:SetText("|cffffff00Boss Mechanics|r")
    local yOffset = -45; local idx = 1
    for id, boss in pairs(BM.Bosses) do
        local btn = self.talentBtns[idx + 100] or CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        self.talentBtns[idx + 100] = btn
        btn:SetSize(ROW_WIDTH, 30); btn:SetPoint("TOPLEFT", 15, yOffset)
        btn:SetText(boss.Name or "Unbekannt")
        btn:SetScript("OnClick", function() BM:Simulate(id) end)
        btn:Show(); yOffset = yOffset - 35; idx = idx + 1
    end
end

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
