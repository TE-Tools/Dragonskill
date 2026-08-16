-- Dragon Skill - Haupt UI (v1.6.0)
-- Minimap: L = BiS-Übersicht, R = Guide-Menü

local UI = {}
local currentTab = 1
-- Index: 1 Talente … 6 Gear(BiS) … 9 Buffs
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants", "Gems", "Buffs"}
local TAB_GEAR = 6

local cachedBuildData = nil

local CONTENT_WIDTH = 600
local FRAME_WIDTH = 680
local FRAME_HEIGHT = 560
local ROW_WIDTH = 580

local JUNK_NAMES = {
    ["cheat sheet"] = true, ["talent builds"] = true, ["talent build"] = true,
    ["rotation"] = true, ["bis gear"] = true, ["consumables"] = true,
    ["consumable"] = true, ["overview"] = true, ["basics"] = true,
    ["abilities"] = true, ["guide"] = true, ["macros"] = true,
    ["weak auras"] = true, ["faq"] = true,
}

local function IsJunkItem(item)
    local name = string.lower(tostring(item.text or item.name or ""))
    if name == "" or name == "unbekannt" then return true end
    if JUNK_NAMES[name] then return true end
    if not item.itemId and not item.spellId and not item.slot and #name < 18 then return true end
    return false
end

local function FilterItems(items)
    if not items then return {} end
    local out, seen = {}, {}
    for _, item in ipairs(items) do
        if not IsJunkItem(item) then
            local key = tostring(item.itemId or "") .. "|" .. tostring(item.spellId or "") .. "|" .. tostring(item.text or item.name or "")
            if not seen[key] then seen[key] = true; table.insert(out, item) end
        end
    end
    return out
end

---------------------------------------------------------------------------
-- Popups (kurz)
---------------------------------------------------------------------------

StaticPopupDialogs["DRAGONSKILL_ACTION"] = {
    text = "Build: %s\nMatch: %d%%\n\nLinks: Kopieren / Anlegen\nRechtsklick: Node-Diff",
    button1 = "Kopieren", button2 = "Anlegen + Import", button3 = "Abbrechen",
    OnAccept = function()
        if cachedBuildData then StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, cachedBuildData) end
    end,
    OnCancel = function(_, _, reason)
        if reason ~= "clicked" or not cachedBuildData then return end
        local build = cachedBuildData
        local _, class = UnitClass("player")
        local specIndex = GetSpecialization()
        local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or nil
        local savedName = DragonSkill.Database:CreateSkilling(nil, {
            importString = build.importString, provider = build.provider, label = build.label,
            class = class, specID = specID,
        })
        print("|cff00ff00Dragon Skill:|r Skilling '|cffffd100" .. tostring(savedName) .. "|r' gespeichert.")
        local TC = DragonSkill:GetModule("TalentCompare")
        if TC then TC:ImportToWoW(build.importString, build.label or savedName) end
        if DragonSkill.UI and DragonSkill.UI.frame and DragonSkill.UI.frame:IsShown() then DragonSkill.UI:Update() end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Strg+C zum Kopieren:", button1 = "Fertig", hasEditBox = 1, editBoxWidth = 320,
    OnShow = function(self, data)
        local build = data or cachedBuildData
        local code = type(build) == "table" and (build.importString or "") or tostring(build or "")
        local function apply()
            local eb = self.EditBox or self.editBox
            if eb then eb:SetText(code); eb:HighlightText(); eb:SetFocus() end
        end
        apply()
        if C_Timer and C_Timer.After then C_Timer.After(0, apply); C_Timer.After(0.05, apply) end
    end,
    OnAccept = function(self) local eb = self.EditBox or self.editBox; if eb then eb:ClearFocus() end end,
    EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
    EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_DELETE"] = {
    text = "Skilling '%s' wirklich löschen?", button1 = "Löschen", button2 = "Abbrechen",
    OnAccept = function(_, data)
        if data and DragonSkill.Database:DeleteSkilling(data) then
            print("|cff00ff00Dragon Skill:|r '" .. tostring(data) .. "' gelöscht.")
            if DragonSkill.UI and DragonSkill.UI.frame and DragonSkill.UI.frame:IsShown() then DragonSkill.UI:Update() end
        end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_DIFF"] = {
    text = "%s", button1 = "OK", button2 = "Kopieren",
    OnCancel = function(_, _, reason)
        if reason == "clicked" and cachedBuildData then StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, cachedBuildData) end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

local function MatchResult(TC, importString)
    if not TC or not importString then return { similarity = 0 } end
    if TC.CompareBuild then return TC:CompareBuild(importString) end
    return TC:Compare(importString, TC:GetCurrentBuildString())
end

local function SpecTitleSuffix()
    local specIndex = GetSpecialization()
    if not specIndex then return "" end
    local _, name = GetSpecializationInfo(specIndex)
    return (name and name ~= "") and (" — " .. name) or ""
end

---------------------------------------------------------------------------
-- Öffnen mit Tab (BiS = Gear)
---------------------------------------------------------------------------

function UI:Open(tabId)
    if not self.frame then self:Init() end
    self.frame:Show()
    if tabId then
        self:SelectTab(tabId)
    else
        self:Update()
    end
end

function UI:OpenBiS()
    self:Open(TAB_GEAR)
end

function UI:Toggle()
    if not self.frame then self:Init() end
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self:Open(currentTab)
    end
end

---------------------------------------------------------------------------
-- Minimap
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
        { text = "Dragon Skill – Guides", isTitle = true, notCheckable = true },
        {
            text = "|cffffd100BiS Gear (Übersicht)|r",
            notCheckable = true,
            func = function() UI:OpenBiS() end,
        },
        {
            text = "Trinkets",
            notCheckable = true,
            func = function() UI:Open(3) end,
        },
        {
            text = "Talente / Skillungen",
            notCheckable = true,
            func = function() UI:Open(1) end,
        },
        {
            text = "Stats",
            notCheckable = true,
            func = function() UI:Open(2) end,
        },
        {
            text = "Enchants",
            notCheckable = true,
            func = function() UI:Open(7) end,
        },
        {
            text = "Gems",
            notCheckable = true,
            func = function() UI:Open(8) end,
        },
        {
            text = "Buffs / Consumables",
            notCheckable = true,
            func = function() UI:Open(9) end,
        },
        {
            text = "Rotation",
            notCheckable = true,
            func = function() UI:Open(5) end,
        },
        {
            text = "Crafting",
            notCheckable = true,
            func = function() UI:Open(4) end,
        },
        { text = "", disabled = true, notCheckable = true },
        {
            text = "Fenster schließen",
            notCheckable = true,
            func = function()
                if UI.frame then UI.frame:Hide() end
            end,
        },
        {
            text = "Minimap-Button ausblenden",
            notCheckable = true,
            func = function() UI:ToggleMinimap() end,
        },
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
    -- Gear/BiS-ähnliches Icon, fällt auf Drachenkopf zurück
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
            -- Direkt BiS-Übersicht (Gear-Tab)
            if UI.frame and UI.frame:IsShown() and currentTab == TAB_GEAR then
                UI.frame:Hide()
            else
                UI:OpenBiS()
            end
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
        GameTooltip:AddLine("BiS- & Guide-Übersicht", 0.9, 0.9, 0.9)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("|cffaaaaaaLinksklick:|r BiS Gear öffnen/schließen", 1, 1, 1)
        GameTooltip:AddLine("|cffaaaaaaRechtsklick:|r Guide-Menü (Tabs)", 1, 1, 1)
        GameTooltip:AddLine("|cffaaaaaaZiehen:|r Position am Minimap-Rand", 1, 1, 1)
        local _, class = UnitClass("player")
        local specIndex = GetSpecialization()
        if specIndex then
            local _, specName = GetSpecializationInfo(specIndex)
            if specName then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("Spec: |cffffffff" .. specName .. "|r", 0.7, 0.7, 0.7)
            end
        end
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
        print("|cff00ff00Dragon Skill:|r Minimap-Button aus – wieder an mit /ds minimap")
    else
        minimapBtn:Show()
        print("|cff00ff00Dragon Skill:|r Minimap-Button an")
    end
end

---------------------------------------------------------------------------
-- Frame
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

    if f.SetTitle then
        f:SetTitle("Dragon Skill v" .. (DragonSkill.version or "1.6.0") .. SpecTitleSuffix())
    end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end

    if f.Inset then
        f.Inset:ClearAllPoints()
        f.Inset:SetPoint("TOPLEFT", 4, -60)
        f.Inset:SetPoint("BOTTOMRIGHT", -6, 28)
    end

    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 8)
    scrollFrame:EnableMouse(true)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(CONTENT_WIDTH, 2000)
    content:EnableMouse(true)
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
        if i == 1 then
            tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 8, 1)
        else
            tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", -16, 0)
        end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)

    if f.EnableKeyboard then
        f:EnableKeyboard(true)
        f:SetPropagateKeyboardInput(true)
        f:SetScript("OnKeyDown", function(selfFrame, key)
            if key == "ESCAPE" then
                selfFrame:SetPropagateKeyboardInput(false)
                selfFrame:Hide()
            else
                selfFrame:SetPropagateKeyboardInput(true)
            end
        end)
    end

    tinsert(UISpecialFrames, "DragonSkillMainFrame")

    f:Hide()
    self.frame = f
    self.talentBtns = {}
    self.favBtns = {}
    self.listRowsByTab = {}
end

function UI:SelectTab(id)
    currentTab = id
    if self.frame then PanelTemplates_SetTab(self.frame, id) end
    self:Update()
end

function UI:ClearContent(content)
    for _, child in ipairs({ content:GetChildren() }) do child:Hide() end
    if content.extraFS then
        for _, fs in ipairs(content.extraFS) do fs:Hide() end
        wipe(content.extraFS)
    end
    if content.text then content.text:SetText(""); content.text:Show() end
end

function UI:EnsureText(content)
    if not content.text then
        content.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        content.text:SetPoint("TOPLEFT", 10, -10)
        content.text:SetWidth(CONTENT_WIDTH - 30)
        content.text:SetJustifyH("LEFT")
        content.text:SetSpacing(3)
    else
        content.text:SetWidth(CONTENT_WIDTH - 30)
    end
    return content.text
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    if self.frame.SetTitle then
        self.frame:SetTitle("Dragon Skill v" .. (DragonSkill.version or "1.6.0") .. SpecTitleSuffix())
    end

    local content = self.frame.Content
    self:ClearContent(content)
    self:EnsureText(content)
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local guideData = DragonSkill.Database:GetGuideData(class, specID)

    if not guideData then
        content.text:SetText("|cffff0000DATEN-FEHLER:|r Keine Guide-Daten für diese Spec.\nScrape/GuideData prüfen.")
        return
    end

    if currentTab == 1 then self:DrawTalents(content, guideData)
    elseif currentTab == 2 then self:DrawStats(content, guideData)
    elseif currentTab == 3 then self:DrawTrinkets(content, guideData)
    elseif currentTab == 4 then self:DrawCrafting(content, guideData)
    elseif currentTab == 5 then self:DrawRotation(content, guideData)
    elseif currentTab == 6 then self:DrawGear(content, guideData)
    elseif currentTab == 7 then self:DrawEnchants(content, guideData)
    elseif currentTab == 8 then self:DrawGems(content, guideData)
    elseif currentTab == 9 then self:DrawBuffs(content, guideData)
    end
end

local function ShowDiffForBuild(build, TC)
    if not build or not build.importString or not TC then return end
    cachedBuildData = build
    local match = MatchResult(TC, build.importString)
    local summary = TC:FormatDiffSummary(build.importString, 18)
    local modeHint = ""
    if match.mode == "nodes" and match.total then
        modeHint = string.format("|cff888888Match %d%% · %d/%d Nodes|r\n\n",
            match.similarity or 0, (match.total or 0) - (match.diffCount or 0), match.total or 0)
    elseif match.mode then
        modeHint = string.format("|cff888888Match %d%% (%s)|r\n\n", match.similarity or 0, match.mode)
    end
    StaticPopup_Show("DRAGONSKILL_DIFF",
        string.format("|cffffff00Diff: %s|r\n\n%s%s", tostring(build.label or "Build"), modeHint, summary))
end

function UI:DrawTalents(content, guideData)
    local TC = DragonSkill:GetModule("TalentCompare")
    local yOffset = -10
    content.extraFS = content.extraFS or {}
    local scraped = guideData.scrapedAt and ("  |cff666666Daten: " .. tostring(guideData.scrapedAt):sub(1, 10) .. "|r") or ""
    content.text:SetText("|cffffff00=== Guide-Builds ===|r  |cff888888(Match-Sort · L/R)|r" .. scraped)
    content.text:Show()
    yOffset = -28

    for _, btn in pairs(self.talentBtns) do btn:Hide() end
    for _, btn in pairs(self.favBtns) do btn:Hide() end

    local raw = guideData.talentBuilds or {}
    local builds, seen = {}, {}
    for _, build in ipairs(raw) do
        local key = build.importString or ""
        if key ~= "" and not seen[key] then
            seen[key] = true
            local r = MatchResult(TC, build.importString)
            table.insert(builds, {
                importString = build.importString,
                provider = build.provider,
                label = build.label,
                _sim = r.similarity or 0,
            })
        end
    end
    table.sort(builds, function(a, b)
        if a._sim == b._sim then return tostring(a.label or "") < tostring(b.label or "") end
        return a._sim > b._sim
    end)

    if #builds == 0 then
        content.text:SetText("|cffffff00=== Guide-Builds ===|r\n\n|cffffaa00Keine Guide-Talente.|r")
    else
        for i, build in ipairs(builds) do
            local btn = self.talentBtns[i]
            if not btn then
                btn = CreateFrame("Button", "DragonSkillTalentBtn_" .. i, content, "UIPanelButtonTemplate")
                btn:SetSize(ROW_WIDTH, 32)
                btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
                self.talentBtns[i] = btn
            end
            btn:SetParent(content)
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", 10, yOffset)
            local sim = build._sim or 0
            local simColor = sim >= 90 and "00ff00" or (sim >= 70 and "ffff00" or "ff6666")
            local star = (i == 1 and sim >= 90) and "★ " or ""
            btn:SetText(string.format("%s[%s] %s  |cff%s%d%%|r",
                star, string.upper(tostring(build.provider or "Guide")),
                tostring(build.label or ("Build " .. i)), simColor, sim))
            btn:SetScript("OnClick", function(_, mouseButton)
                cachedBuildData = build
                if mouseButton == "RightButton" then ShowDiffForBuild(build, TC)
                else StaticPopup_Show("DRAGONSKILL_ACTION", build.label or "Build", sim) end
            end)
            btn:Show()
            yOffset = yOffset - 36
        end
    end

    yOffset = yOffset - 12
    local favHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    favHeader:SetPoint("TOPLEFT", 10, yOffset)
    favHeader:SetText("|cffffff00=== Meine Skillungen (diese Spec) ===|r")
    favHeader:Show()
    table.insert(content.extraFS, favHeader)
    yOffset = yOffset - 22

    local skillings = DragonSkill.Database:GetSkillings(true) or {}
    if #skillings == 0 then
        local empty = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        empty:SetPoint("TOPLEFT", 10, yOffset)
        empty:SetWidth(ROW_WIDTH)
        empty:SetJustifyH("LEFT")
        empty:SetText("|cff888888Keine Skillungen für diese Spec.|r")
        empty:Show()
        table.insert(content.extraFS, empty)
        yOffset = yOffset - 40
    else
        for i, entry in ipairs(skillings) do
            local name, data = entry.name, entry.data or {}
            local btn = self.favBtns[i]
            if not btn then
                btn = CreateFrame("Button", "DragonSkillFavBtn_" .. i, content, "UIPanelButtonTemplate")
                btn:SetSize(ROW_WIDTH - 70, 28)
                btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
                self.favBtns[i] = btn
            end
            btn:SetParent(content)
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", 10, yOffset)
            local r = MatchResult(TC, data.importString)
            local sim = r.similarity or 0
            local provider = data.provider and ("[" .. string.upper(tostring(data.provider)) .. "] ") or ""
            btn:SetText(string.format("%s%s  (%d%%)", provider, tostring(data.label or name), sim))
            btn:SetScript("OnClick", function(_, mouseButton)
                local build = {
                    importString = data.importString,
                    provider = data.provider or "saved",
                    label = data.label or name,
                }
                cachedBuildData = build
                if mouseButton == "RightButton" then ShowDiffForBuild(build, TC)
                else StaticPopup_Show("DRAGONSKILL_ACTION", build.label, sim) end
            end)
            btn:Show()

            local delKey = "del_" .. i
            if not self.favBtns[delKey] then
                self.favBtns[delKey] = CreateFrame("Button", "DragonSkillFavDel_" .. i, content, "UIPanelButtonTemplate")
                self.favBtns[delKey]:SetSize(60, 28)
            end
            local del = self.favBtns[delKey]
            del:SetParent(content)
            del:ClearAllPoints()
            del:SetPoint("LEFT", btn, "RIGHT", 4, 0)
            del:SetText("X")
            del:SetScript("OnClick", function()
                StaticPopup_Show("DRAGONSKILL_DELETE", name, nil, name)
            end)
            del:Show()
            yOffset = yOffset - 32
        end
    end
    content:SetHeight(math.max(2000, math.abs(yOffset) + 80))
end

function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -10
    self:EnsureText(content)
    items = FilterItems(items)
    if title then
        content.text:SetText(title)
        content.text:Show()
        yOffset = -30
    end

    self.listRowsByTab[currentTab] = self.listRowsByTab[currentTab] or {}
    local rows = self.listRowsByTab[currentTab]
    for _, row in ipairs(rows) do
        row:Hide()
        row:SetScript("OnEnter", nil)
        row:SetScript("OnLeave", nil)
    end
    for tabId, otherRows in pairs(self.listRowsByTab) do
        if tabId ~= currentTab then
            for _, row in ipairs(otherRows) do row:Hide() end
        end
    end

    if not items or #items == 0 then
        content.text:SetText((title or "") .. "\n\n|cffffaa00Keine Daten verfügbar.|r")
        return
    end

    for i, item in ipairs(items) do
        local itemName = item.text or item.name or "Unbekannt"
        local row = rows[i]
        if not row then
            row = CreateFrame("Button", nil, content)
            row:SetSize(ROW_WIDTH, 26)
            row:EnableMouse(true)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22)
            row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
            row.text:SetJustifyH("LEFT")
            row.text:SetWidth(ROW_WIDTH - 40)
            rows[i] = row
        end
        row:SetParent(content)
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 10, yOffset)
        row:SetFrameLevel(content:GetFrameLevel() + 5)

        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        if item.itemId and C_Item and C_Item.GetItemIconByID then
            texture = C_Item.GetItemIconByID(item.itemId) or texture
        elseif item.spellId and C_Spell and C_Spell.GetSpellTexture then
            texture = C_Spell.GetSpellTexture(item.spellId) or texture
        end
        row.icon:SetTexture(texture)
        row.text:SetText((item.slot and ("|cff00ff00" .. item.slot .. ":|r ") or "") .. itemName)

        local captured, capturedName = item, itemName
        row:SetScript("OnEnter", function(selfRow)
            GameTooltip:SetOwner(selfRow, "ANCHOR_RIGHT")
            if captured.itemId then GameTooltip:SetItemByID(captured.itemId)
            elseif captured.spellId then GameTooltip:SetSpellByID(captured.spellId)
            else GameTooltip:SetText(capturedName) end
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row:Show()
        yOffset = yOffset - 28
    end
    content:SetHeight(math.max(400, math.abs(yOffset) + 40))
end

function UI:DrawStats(content, guideData)
    local SP = DragonSkill:GetModule("StatPriority")
    local txt = "|cffffff00=== Deine Werte ===|r\n" .. string.format(
        "Tempo: %.1f%%\nKritisch: %.1f%%\nMeisterschaft: %.1f%%\nVielseitigkeit: %.1f%%\n",
        GetHaste(), GetCritChance(), GetMasteryEffect(),
        GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE))
    local prio = guideData.statPriority
    if SP and SP.GetForCurrentSpec then
        local spData = SP:GetForCurrentSpec()
        if spData then prio = spData end
    end
    if prio then
        txt = txt .. "\n|cffffff00=== Empfehlung ===|r\n"
        txt = txt .. "|cffffd100Wowhead:|r " .. (prio.wowhead or "N/A") .. "\n"
        if prio.archon then txt = txt .. "|cffffd100Archon:|r " .. prio.archon .. "\n" end
    end
    content.text:SetText(txt)
end

function UI:DrawTrinkets(content, guideData)
    local mod = DragonSkill:GetModule("Trinkets")
    self:Helper_DrawListWithIcons(content, (mod and mod.GetList and mod:GetList(guideData)) or {},
        "|cffffff00Top Trinkets (Archon):|r")
end

function UI:DrawCrafting(content, guideData)
    local mod = DragonSkill:GetModule("Crafting")
    content.text:SetText((mod and mod.FormatText and mod:FormatText(guideData)) or "Keine Crafting-Daten.")
end

function UI:DrawRotation(content, guideData)
    local mod = DragonSkill:GetModule("Rotation")
    self:Helper_DrawListWithIcons(content, (mod and mod.GetList and mod:GetList(guideData)) or {},
        "|cffffff00Priorität (Wowhead):|r\n|cff888888Nur Anzeige.|r")
end

function UI:DrawGear(content, guideData)
    local items = (guideData.bisGear and guideData.bisGear.wowhead) or {}
    local n = #FilterItems(items)
    local header = string.format(
        "|cffffd100=== BiS-Übersicht (aktuelle Spec) ===|r\n|cff888888%d Slot-Empfehlungen · Hover = Item-Tooltip|r",
        n
    )
    self:Helper_DrawListWithIcons(content, items, header)
end

function UI:DrawEnchants(content, guideData)
    self:Helper_DrawListWithIcons(content, (guideData.enchants and guideData.enchants.wowhead) or {},
        "|cffffff00Verzauberungen:|r")
end

function UI:DrawGems(content, guideData)
    self:Helper_DrawListWithIcons(content, (guideData.gems and guideData.gems.wowhead) or {},
        "|cffffff00Gems:|r")
end

function UI:DrawBuffs(content, guideData)
    self:Helper_DrawListWithIcons(content, (guideData.consumables and guideData.consumables.wowhead) or {},
        "|cffffff00Buffs / Consumables:|r")
end

---------------------------------------------------------------------------
-- Slash
---------------------------------------------------------------------------

local function PrintHelp()
    print("|cff00ff00Dragon Skill v" .. (DragonSkill.version or "?") .. "|r")
    print("  Minimap: |cffffd100Links = BiS|r · Rechts = Guide-Menü")
    print("  /wear | /ds              – Fenster")
    print("  /ds bis | /ds gear       – BiS-Übersicht")
    print("  /ds minimap              – Button an/aus")
    print("  /ds boss list            – Boss-Liste")
    print("  /ds boss <name|id>       – Boss testen")
end

SLASH_WEAR1 = "/wear"
SLASH_WEAR2 = "/dragonskill"
SLASH_WEAR3 = "/ds"
SlashCmdList["WEAR"] = function(msg)
    msg = msg and strtrim(msg) or ""
    local lower = msg:lower()

    if lower == "help" or lower == "?" then PrintHelp(); return end
    if lower == "minimap" then UI:ToggleMinimap(); return end
    if lower == "bis" or lower == "gear" or lower == "bisgear" then UI:OpenBiS(); return end

    local bossArg = lower:match("^boss%s*(.*)$")
    if bossArg ~= nil then
        local BM = DragonSkill:GetModule("BossMechanics")
        if not BM then print("|cffff0000Dragon Skill:|r BossMechanics fehlt."); return end
        if bossArg == "" or bossArg == "list" then BM:ListBosses(); return end
        local asNum = tonumber(bossArg)
        if asNum then BM:Simulate(asNum) else BM:Simulate(bossArg) end
        return
    end

    if lower == "testulatek" or lower == "ulatek" then
        local BM = DragonSkill:GetModule("BossMechanics")
        if BM then BM:SimulateUlatek() end
        return
    end

    UI:Toggle()
end

print("|cff00ff00Dragon Skill v" .. (DragonSkill.version or "1.6.0") .. " geladen!|r  Minimap = BiS · /ds help")

DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
    CreateMinimapButton()
end)

DragonSkill.Events:On("PLAYER_SPECIALIZATION_CHANGED", function()
    if C_Timer and C_Timer.After then
        C_Timer.After(0.15, function()
            if UI.frame and UI.frame:IsShown() then UI:Update() end
        end)
    elseif UI.frame and UI.frame:IsShown() then
        UI:Update()
    end
end)

DragonSkill.Events:On("TRAIT_CONFIG_UPDATED", function()
    if UI.frame and UI.frame:IsShown() then UI:Update() end
end)
DragonSkill.Events:On("ACTIVE_TALENT_GROUP_CHANGED", function()
    if UI.frame and UI.frame:IsShown() then UI:Update() end
end)

DragonSkill.UI = UI
