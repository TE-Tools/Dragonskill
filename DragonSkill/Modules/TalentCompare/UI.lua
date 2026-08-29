-- Dragon Skill - Main UI (v1.7.1)
-- Finalized Gear Assistant & Farm Planner for WoW 12.1.

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

    if f.SetTitle then f:SetTitle("Dragon Skill v1.7.1") end
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

function UI:SelectTab(id)
    currentTab = id
    PanelTemplates_SetTab(self.frame, id)
    self:Update()
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content
    for _, child in ipairs({ content:GetChildren() }) do child:Hide() end
    if not self.text then
        self.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        self.text:SetPoint("TOPLEFT", 15, -15)
        self.text:SetWidth(CONTENT_WIDTH - 40)
        self.text:SetJustifyH("LEFT")
        self.text:SetSpacing(4)
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
        if not guideData then self.text:SetText(L.NO_GUIDE_DATA or "No data."); return end

        if currentTab == TAB_TALENTS then self:DrawTalents(content, guideData)
        elseif currentTab == TAB_BIS then self:Helper_DrawListWithIcons(content, guideData.bisGear.wowhead, "Best-in-Slot Gear (Wowhead)")
        elseif currentTab == TAB_TRINKETS then self:Helper_DrawListWithIcons(content, guideData.trinkets.archon, "Top Trinkets (Archon)")
        end
    end
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
    local txt = "|cffffff00" .. class .. ": " .. specName .. " Dashboard|r\n\n"

    local avgIlvl = select(2, GetAverageItemLevel())
    txt = txt .. string.format("Gegenstandsstufe: |cffffffff%.1f|r\n", avgIlvl)

    local upgrades = GM:GetBestUpgrades()
    txt = txt .. "\n|cffffd100NÄCHSTE BESTE UPGRADES:|r\n"
    for i=1, math.min(3, #upgrades) do
        txt = txt .. string.format("%d. |cffffffff%s|r (%s) - Prio: |cff00ff00%d/10|r\n", i, upgrades[i].name, upgrades[i].slot, upgrades[i].priority)
    end

    local plan = GM:GetFarmPlan()
    txt = txt .. "\n|cffffff00WAS SOLL ICH HEUTE FARMEN?|r\n"
    if #plan > 0 then
        txt = txt .. "1. |cffffffff" .. plan[1].name .. "|r (Score: " .. plan[1].score .. ")\n"
    end

    txt = txt .. "\n|cffffd100CATALYST EMPFEHLUNG:|r\n"
    txt = txt .. (GM:GetCatalystRecommendation and GM:GetCatalystRecommendation() or "Brust oder Beine")

    self.text:SetText(txt)
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local plan = GM:GetFarmPlan()
    local txt = "|cffffff00OPTIMALE FARM-ROUTE (Dungeons)|r\n\n"
    for i, d in ipairs(plan) do
        txt = txt .. string.format("|cffffd100%d. %s|r (Score: %d)\n", i, d.name, d.score)
        local dData = DragonSkillGearData.dungeons[d.name]
        for _, boss in ipairs(dData.bosses) do
            for _, itemId in ipairs(boss.loot) do
                local item = DragonSkillGearData.items[itemId]
                if item and GM:GetUpgradeScore(item.slot, itemId) > 0 then
                    txt = txt .. "   - |cffffffff" .. item.name .. "|r (" .. boss.name .. ")\n"
                end
            end
        end
        txt = txt .. "\n"
    end
    self.text:SetText(txt)
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM:GetBestUpgrades()
    self:Helper_DrawListWithIcons(content, items, "DEINE NÄCHSTEN UPGRADES (Priority 1-10)")
end

function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -45
    self.text:SetText(title)

    if not self.listRows then self.listRows = {} end
    for _, row in ipairs(self.listRows) do row:Hide() end

    if not items or #items == 0 then
        self.text:SetText(title .. "\n\n|cffffaa00Keine Upgrades gefunden.|r")
        return
    end

    for i, item in ipairs(items) do
        local row = self.listRows[i]
        if not row then
            row = CreateFrame("Button", nil, content)
            row:SetSize(ROW_WIDTH, 26)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22) row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
            self.listRows[i] = row
        end
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 15, yOffset)

        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        if item.itemId then texture = C_Item.GetItemIconByID(item.itemId) or texture end
        row.icon:SetTexture(texture)
        local prio = item.priority and (" |cff00ff00(Prio "..item.priority..")|r") or ""
        row.text:SetText((item.slot and "|cff00ff00"..item.slot..":|r " or "") .. (item.name or item.text or "Item") .. prio)

        row:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
            if item.itemId then GameTooltip:SetItemByID(item.itemId) else GameTooltip:SetText(item.name or "Item") end
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row:Show()
        yOffset = yOffset - 28
    end
end

function UI:DrawTalents(content, guideData)
    local yOffset = -45
    self.text:SetText("Talent Builds (Match %)")
    for i, build in ipairs(guideData.talentBuilds or {}) do
        local btn = self.talentBtns[i]
        if not btn then
            btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            btn:SetSize(ROW_WIDTH, 30)
            self.talentBtns[i] = btn
        end
        btn:ClearAllPoints()
        btn:SetPoint("TOPLEFT", 15, yOffset)
        btn:SetText(string.format("[%s] %s", build.provider:upper(), build.label))
        btn:SetScript("OnClick", function()
            local TC = DragonSkill:GetModule("TalentCompare")
            if TC then TC:ImportToWoW(build.importString, build.label) end
        end)
        btn:Show()
        yOffset = yOffset - 35
    end
end

function UI:DrawBosses(content)
    local BM = DragonSkill:GetModule("BossMechanics")
    if not BM or not BM.Bosses then return end
    local yOffset = -45
    self.text:SetText("Raid Boss Mechanics & Simulator")
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
        btn:SetText(boss.Name .. " (Test)")
        btn:SetScript("OnClick", function() BM:Simulate(id) end)
        btn:Show()
        yOffset = yOffset - 35
        idx = idx + 1
    end
end

function UI:DrawAssistant(content)
    self.text:SetText("|cffffff00AI Assistant|r\n\nFrag mich: 'Farmen', 'Nächstes Upgrade', 'Catalyst'")
    if not self.searchBox then
        local eb = CreateFrame("EditBox", nil, content, "InputBoxTemplate")
        eb:SetSize(300, 30) eb:SetPoint("TOPLEFT", 15, -60)
        eb:SetAutoFocus(false)
        eb:SetScript("OnEnterPressed", function(s) self:HandleAssistantQuery(s:GetText():lower()); s:ClearFocus() end)
        self.searchBox = eb
    end
    self.searchBox:Show()
    if not self.answerText then
        self.answerText = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        self.answerText:SetPoint("TOPLEFT", 15, -100)
        self.answerText:SetWidth(CONTENT_WIDTH - 40)
        self.answerText:SetJustifyH("LEFT")
        self.answerText:SetSpacing(4)
    end
    self.answerText:Show()
end

function UI:HandleAssistantQuery(q)
    local GM = DragonSkill:GetModule("GearManager")
    local res = ""
    if q:find("farm") or q:find("ini") then
        local p = GM:GetFarmPlan()
        res = p[1] and ("Laufe |cffffd100" .. p[1].name .. "|r für deine größten Upgrades.") or "Keine Inis nötig."
    elseif q:find("upgrad") or q:find("besser") then
        local u = GM:GetBestUpgrades()
        res = u[1] and ("Dein Ziel ist |cffffd100" .. u[1].name .. "|r (" .. u[1].slot .. ").") or "Keine Upgrades."
    elseif q:find("cata") then
        res = GM:GetCatalystRecommendation()
    else
        res = "Ich verstehe das nicht ganz. Frag nach 'Farmen' oder 'Upgrade'."
    end
    self.answerText:SetText("|cff00ff00Assistent:|r " .. res)
end

SLASH_DS1 = "/ds"
SLASH_WEAR1 = "/wear"
SlashCmdList["DS"] = function(msg)
    UI:Init()
    UI.frame:Show()
    local low = msg:lower()
    if low == "today" or low == "farm" then UI:SelectTab(TAB_FARM)
    elseif low == "bis" then UI:SelectTab(TAB_BIS)
    else UI:Update() end
end

DragonSkill.UI = UI
