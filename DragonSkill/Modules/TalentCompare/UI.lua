-- Dragon Skill - Haupt UI (v1.7.0)
-- Dashboard + Gear Farm + Upgrade Assistant
-- Expansion: Midnight | Season 2 (12.1)

local L = DragonSkill.L or {}
local UI = {}
local currentTab = 1
local tabs = {
    L.TAB_DASHBOARD or "Dashboard",
    L.TAB_TALENTS or "Talente",
    L.TAB_FARM or "Farm",
    L.TAB_UPGRADES or "Upgrades",
    L.TAB_GEAR or "BiS Gear",
    L.TAB_TRINKETS or "Schmuck",
    L.TAB_CATALYST or "Catalyst",
    L.TAB_ENCHANTS or "Verzauberungen",
    L.TAB_ROTATION or "Rotation",
    L.TAB_BOSSES or "Bosse",
    "Assistant",
}

local TAB_DASHBOARD = 1
local TAB_TALENTS = 2
local TAB_FARM = 3
local TAB_UPGRADES = 4
local TAB_GEAR = 5
local TAB_TRINKETS = 6
local TAB_CATALYST = 7
local TAB_ENCHANTS = 8
local TAB_ROTATION = 9
local TAB_BOSSES = 10
local TAB_ASSISTANT = 11

local cachedBuildData = nil
local CONTENT_WIDTH, FRAME_WIDTH, FRAME_HEIGHT, ROW_WIDTH = 600, 720, 600, 580

-- Standard Helper
local function IsJunkItem(item)
    local name = string.lower(tostring(item.text or item.name or ""))
    if name == "" or name == "unbekannt" then return true end
    if not item.itemId and not item.spellId and not item.slot and #name < 12 then return true end
    return false
end

local function FilterItems(items)
    if not items then return {} end
    local out, seen = {}, {}
    for _, item in ipairs(items) do
        if not IsJunkItem(item) then
            local key = tostring(item.itemId or "") .. "|" .. tostring(item.text or item.name or "")
            if not seen[key] then seen[key] = true; table.insert(out, item) end
        end
    end
    return out
end

-- Popups (Copy Fix)
StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = L.COPY_HINT or "Strg+C zum Kopieren:", button1 = L.DONE or "Fertig", hasEditBox = 1, editBoxWidth = 320,
    OnShow = function(self, data)
        local code = type(data) == "table" and (data.importString or "") or tostring(data or "")
        local eb = self.EditBox or self.editBox
        if eb then eb:SetText(code); eb:HighlightText(); eb:SetFocus() end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true,
}

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

    if f.SetTitle then f:SetTitle("Dragon Skill v1.7.0") end

    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 8)
    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(CONTENT_WIDTH, 2000)
    scrollFrame:SetScrollChild(content)
    f.Content = content

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
    self.talentBtns = {}
    self.listRowsByTab = {}
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
    local text = self:EnsureText(content)
    text:SetText("")

    local _, class = UnitClass("player")
    local specID = select(1, GetSpecializationInfo(GetSpecialization() or 0)) or 0

    if currentTab == TAB_DASHBOARD then self:DrawDashboard(content, class, specID)
    elseif currentTab == TAB_FARM then self:DrawFarm(content)
    elseif currentTab == TAB_UPGRADES then self:DrawUpgrades(content)
    elseif currentTab == TAB_CATALYST then self:DrawCatalyst(content)
    elseif currentTab == TAB_ASSISTANT then self:DrawAssistant(content)
    else
        -- Fallback zu alten Guides
        local guideData = DragonSkill.Database:GetGuideData(class, specID)
        if not guideData then text:SetText(L.NO_GUIDE_DATA); return end

        if currentTab == TAB_TALENTS then self:DrawTalents(content, guideData)
        elseif currentTab == TAB_GEAR then self:Helper_DrawListWithIcons(content, MergeProviderLists(guideData.bisGear), L.BIS_HEADER)
        elseif currentTab == TAB_TRINKETS then self:Helper_DrawListWithIcons(content, MergeProviderLists(guideData.trinkets), L.TOP_TRINKETS)
        elseif currentTab == TAB_ENCHANTS then self:Helper_DrawListWithIcons(content, MergeProviderLists(guideData.enchants), L.ENCHANTS_HEADER)
        elseif currentTab == TAB_ROTATION then self:Helper_DrawListWithIcons(content, guideData.rotation.wowhead, L.PRIORITY)
        elseif currentTab == TAB_BOSSES then self:DrawBosses(content)
        end
    end
end

function UI:DrawDashboard(content, class, specID)
    local GM = DragonSkill:GetModule("GearManager")
    local specName = select(2, GetSpecializationInfo(GetSpecialization() or 0)) or "Spec"
    local txt = "|cffffff00" .. class .. ": " .. specName .. " Dashboard|r\n\n"

    local avgIlvl = GetAverageItemLevel()
    txt = txt .. string.format("Item Level: %.1f\n", avgIlvl)

    local upgrades = GM:GetBestUpgrades()
    txt = txt .. "\n|cffffd100" .. (L.NEXT_UPGRADES or "Next Upgrades:") .. "|r\n"
    for i=1, math.min(3, #upgrades) do
        txt = txt .. string.format("%d. %s (%s) - Priority %d/10\n", i, upgrades[i].name, upgrades[i].slot, upgrades[i].farmPriority)
    end

    txt = txt .. "\n|cffffff00Today's Farm Priority:|r\n"
    local route = GM:GetFarmRoute()
    if #route > 0 then
        txt = txt .. "1. " .. route[1].name .. " (Score: " .. route[1].score .. ")\n"
    else
        txt = txt .. "No specific dungeon recommended today.\n"
    end

    txt = txt .. "\n|cffffd100" .. (L.CATALYST_REC or "Catalyst:") .. "|r\n"
    txt = txt .. GM:GetCatalystRecommendation()

    content.text:SetText(txt)
end

function UI:DrawFarm(content)
    local GM = DragonSkill:GetModule("GearManager")
    local route = GM:GetFarmRoute()
    local txt = "|cffffff00" .. (L.FARM_ROUTE_TITLE or "Optimal Farm Route:") .. "|r\n\n"
    for i, d in ipairs(route) do
        txt = txt .. string.format("|cffffffff%d. %s|r (Score: %d)\n", i, d.name, d.score)
        for _, item in ipairs(d.items) do
            txt = txt .. "   - " .. item.name .. " (" .. item.slot .. ") |cff00ff00Prio " .. item.farmPriority .. "|r\n"
        end
        txt = txt .. "\n"
    end
    content.text:SetText(txt)
end

function UI:DrawUpgrades(content)
    local GM = DragonSkill:GetModule("GearManager")
    local items = GM:GetBestUpgrades()
    self:Helper_DrawListWithIcons(content, items, L.NEXT_UPGRADES)
end

function UI:DrawCatalyst(content)
    local GM = DragonSkill:GetModule("GearManager")
    local specData = GM:GetSpecData()
    local txt = "|cffffff00Catalyst & Tier Set Helper|r\n\n"
    if specData and specData.tierSet then
        txt = txt .. "Tier Set: |cffffd100" .. specData.tierSet.name .. "|r\n"
        txt = txt .. "2pc: " .. specData.tierSet.bonuses[2] .. "\n"
        txt = txt .. "4pc: " .. specData.tierSet.bonuses[4] .. "\n\n"
    end
    txt = txt .. "|cffffd100" .. (L.CATALYST_REC or "Recommendation:") .. "|r\n"
    txt = txt .. GM:GetCatalystRecommendation()
    content.text:SetText(txt)
end

-- Re-using existing List with Icons helper
function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -40
    local text = self:EnsureText(content)
    text:SetText(title or "")

    items = FilterItems(items)
    self.listRowsByTab[currentTab] = self.listRowsByTab[currentTab] or {}
    local rows = self.listRowsByTab[currentTab]
    for _, row in ipairs(rows) do row:Hide() end

    if not items or #items == 0 then
        text:SetText((title or "") .. "\n\n|cffffaa00" .. (L.NO_DATA or "No data available.") .. "|r")
        return
    end

    for i, item in ipairs(items) do
        local row = rows[i]
        if not row then
            row = CreateFrame("Button", nil, content)
            row:SetSize(ROW_WIDTH, 26)
            row:EnableMouse(true)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22) row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
            rows[i] = row
        end
        row:SetParent(content)
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 15, yOffset)

        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        if item.itemId then texture = C_Item.GetItemIconByID(item.itemId) or texture end
        row.icon:SetTexture(texture)
        row.text:SetText((item.slot and "|cff00ff00"..item.slot..":|r " or "") .. (item.name or item.text or "Unknown"))

        row:SetScript("OnEnter", function(selfRow)
            GameTooltip:SetOwner(selfRow, "ANCHOR_RIGHT")
            if item.itemId then GameTooltip:SetItemByID(item.itemId) else GameTooltip:SetText(item.name or "Item") end
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row:Show()
        yOffset = yOffset - 28
    end
end

-- Add missing functions for DrawTalents and DrawBosses if not present
function UI:DrawTalents(content, guideData)
    -- Simplified version for v1.7.0 integration
    local yOffset = -40
    self:EnsureText(content):SetText(L.GUIDE_BUILDS or "=== Talents ===")
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
        btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, build.importString) end)
        btn:Show()
        yOffset = yOffset - 35
    end
end

function UI:DrawBosses(content)
    local BM = DragonSkill:GetModule("BossMechanics")
    if not BM then return end
    local yOffset = -40
    self:EnsureText(content):SetText(L.BOSS_GUIDES or "=== Bosses ===")
    local idx = 1
    for id, boss in pairs(BM.Bosses) do
        local btn = self.talentBtns[idx + 100] -- Offset for boss buttons
        if not btn then
            btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            btn:SetSize(ROW_WIDTH, 30)
            self.talentBtns[idx + 100] = btn
        end
        btn:ClearAllPoints()
        btn:SetPoint("TOPLEFT", 15, yOffset)
        btn:SetText(boss.Name)
        btn:SetScript("OnClick", function() BM:Simulate(id) end)
        btn:Show()
        yOffset = yOffset - 35
        idx = idx + 1
    end
end

function UI:DrawAssistant(content)
    local text = self:EnsureText(content)
    text:SetText("|cffffff00Dragon Skill AI Assistant|r\n\nFrag mich etwas (z.B. 'Brust', 'farmen', 'trinket'):")

    if not self.searchBox then
        local eb = CreateFrame("EditBox", "DragonSkillSearchBox", content, "InputBoxTemplate")
        eb:SetSize(250, 30)
        eb:SetPoint("TOPLEFT", 15, -60)
        eb:SetAutoFocus(false)
        eb:SetScript("OnEnterPressed", function(selfEb)
            local query = selfEb:GetText():lower()
            UI:HandleAssistantQuery(query)
            selfEb:ClearFocus()
        end)
        self.searchBox = eb
    end
    self.searchBox:Show()

    if not self.answerText then
        local fs = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        fs:SetPoint("TOPLEFT", 15, -100)
        fs:SetWidth(CONTENT_WIDTH - 40)
        fs:SetJustifyH("LEFT")
        fs:SetSpacing(4)
        self.answerText = fs
    end
    self.answerText:Show()
end

function UI:HandleAssistantQuery(query)
    local GM = DragonSkill:GetModule("GearManager")
    local specData = GM:GetSpecData()
    if not specData then self.answerText:SetText("Keine Daten gefunden."); return end

    local ans = ""
    if query:find("brust") or query:find("chest") then
        local item = specData.items[specData.bisProfiles.overall.chest]
        ans = "Deine BiS Brust ist |cffffd100" .. item.name .. "|r aus |cff00ff00" .. (item.dungeonName or item.sourceName) .. "|r."
    elseif query:find("farmen") or query:find("farm") then
        local route = GM:GetFarmRoute()
        ans = "Du solltest heute |cffffd100" .. route[1].name .. "|r farmen. Dort gibt es " .. #route[1].items .. " Upgrades für dich."
    elseif query:find("trinket") or query:find("schmuck") then
        ans = "Deine BiS Trinkets sind |cffffd100Seal of the Venom-Lord|r und |cffffd100Living Spore Pod|r."
    else
        ans = "Ich habe keine direkte Antwort gefunden. Probiere Begriffe wie 'Brust', 'farmen' oder 'Werte'."
    end

    self.answerText:SetText("|cff00ff00Assistent:|r " .. ans)
end

SLASH_DS1 = "/ds"
SLASH_DS2 = "/wear"
SlashCmdList["DS"] = function(msg)
    local low = msg:lower()
    if low == "farm" or low == "today" then
        UI:Init()
        UI:SelectTab(TAB_FARM)
        UI.frame:Show()
    elseif low == "bis" then
        UI:Init()
        UI:SelectTab(TAB_GEAR)
        UI.frame:Show()
    else
        UI:Init()
        UI.frame:Show()
        UI:Update()
    end
end

DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end)
DragonSkill.UI = UI

-- Helper to merge Archon/Wowhead lists (stub)
function MergeProviderLists(providerTable)
    local out = {}
    if not providerTable then return out end
    if providerTable.wowhead then for _, v in ipairs(providerTable.wowhead) do table.insert(out, v) end end
    if providerTable.archon then for _, v in ipairs(providerTable.archon) do table.insert(out, v) end end
    return out
end
