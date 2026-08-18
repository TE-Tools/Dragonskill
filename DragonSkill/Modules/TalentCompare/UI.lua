-- Dragon Skill - Haupt UI (v1.6.3) Minimap + Archon/Wowhead Merge + Sort/Empty
-- RESYNC main 2026-08-18 09:17 UTC

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants", "Gems", "Buffs", "Bosses"}
local TAB_GEAR = 6
local TAB_BOSSES = 10
local cachedBuildData = nil
local CONTENT_WIDTH, FRAME_WIDTH, FRAME_HEIGHT, ROW_WIDTH = 600, 680, 560, 580

local JUNK_NAMES = {
    ["cheat sheet"] = true, ["talent builds"] = true, ["talent build"] = true,
    ["rotation"] = true, ["bis gear"] = true, ["consumables"] = true,
    ["consumable"] = true, ["overview"] = true, ["basics"] = true,
    ["abilities"] = true, ["guide"] = true, ["macros"] = true,
    ["weak auras"] = true, ["faq"] = true,
}

local SLOT_ORDER = {
    Head = 1, Neck = 2, Shoulder = 3, Back = 4, Chest = 5,
    Wrist = 6, Hands = 7, Waist = 8, Legs = 9, Feet = 10,
    Ring = 11, Finger = 11, Trinket = 12, Weapon = 13, Shield = 14,
    Offhand = 15, ["Main Hand"] = 13, ["Off Hand"] = 15,
}

local function IsJunkItem(item)
    local name = string.lower(tostring(item.text or item.name or ""))
    if name == "" or name == "unbekannt" then return true end
    if JUNK_NAMES[name] then return true end
    if not item.itemId and not item.spellId and not item.slot and #name < 18 then return true end
    return false
end

local function RankValue(rank)
    if not rank then return -1 end
    local n = tonumber(tostring(rank):match("([%d%.]+)"))
    return n or -1
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
    table.sort(out, function(a, b)
        local sa = SLOT_ORDER[a.slot or ""] or 99
        local sb = SLOT_ORDER[b.slot or ""] or 99
        if sa ~= sb then return sa < sb end
        local ra, rb = RankValue(a.rank), RankValue(b.rank)
        if ra ~= rb then return ra > rb end
        return tostring(a.text or a.name or "") < tostring(b.text or b.name or "")
    end)
    return out
end

local function MergeProviderLists(providerTable)
    local out, seen = {}, {}
    if not providerTable then return out end
    local function add(list)
        if not list then return end
        for _, item in ipairs(list) do
            local key = tostring(item.itemId or "") .. "|" .. tostring(item.spellId or "") .. "|" .. tostring(item.text or item.name or "")
            if key ~= "||" and not seen[key] then
                seen[key] = true
                table.insert(out, {
                    text = item.text or item.name,
                    name = item.name or item.text,
                    itemId = item.itemId,
                    spellId = item.spellId,
                    slot = item.slot,
                    rank = item.rank or item.popularity,
                })
            end
        end
    end
    add(providerTable.archon)
    add(providerTable.wowhead)
    return out
end

local function MatchResult(TC, importString)
    if not TC or not importString then return { similarity = 0 } end
    if TC.CompareBuild then return TC:CompareBuild(importString) end
    local current = ""
    if TC.GetCurrentBuildString then
        current = TC:GetCurrentBuildString() or ""
    end
    if TC.Compare then
        return TC:Compare(importString, current)
    end
    return { similarity = 0 }
end

StaticPopupDialogs["DRAGONSKILL_ACTION"] = {
    text = "Build: %s\nMatch: %d%%\n\nLinks: Kopieren / Anlegen",
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
        if TC and TC.ImportToWoW then TC:ImportToWoW(build.importString, build.label or savedName) end
        if DragonSkill.UI and DragonSkill.UI.frame and DragonSkill.UI.frame:IsShown() then DragonSkill.UI:Update() end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Strg+C zum Kopieren:", button1 = "Fertig", hasEditBox = 1, editBoxWidth = 320,
    OnShow = function(self, data)
        local build = data or cachedBuildData
        local code = type(build) == "table" and (build.importString or "") or tostring(build or "")
        local eb = self.EditBox or self.editBox
        if eb then eb:SetText(code); eb:HighlightText(); eb:SetFocus() end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_DELETE"] = {
    text = "Skilling '%s' wirklich loeschen?", button1 = "Loeschen", button2 = "Abbrechen",
    OnAccept = function(_, data)
        if data and DragonSkill.Database:DeleteSkilling(data) then
            print("|cff00ff00Dragon Skill:|r '" .. tostring(data) .. "' geloescht.")
            if DragonSkill.UI and DragonSkill.UI.frame and DragonSkill.UI.frame:IsShown() then DragonSkill.UI:Update() end
        end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

function UI:Open(tabId)
    if not self.frame then self:Init() end
    self.frame:Show()
    if tabId then self:SelectTab(tabId) else self:Update() end
end
function UI:OpenBiS() self:Open(TAB_GEAR) end
function UI:Toggle()
    if not self.frame then self:Init() end
    if self.frame:IsShown() then self.frame:Hide() else self:Open(currentTab) end
end

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
        { text = "|cffffd100BiS Gear|r", notCheckable = true, func = function() UI:OpenBiS() end },
        { text = "Talente", notCheckable = true, func = function() UI:Open(1) end },
        { text = "Bosses", notCheckable = true, func = function() UI:OpenBosses() end },
        { text = "Trinkets", notCheckable = true, func = function() UI:Open(3) end },
        { text = "Enchants", notCheckable = true, func = function() UI:Open(7) end },
        { text = "Gems", notCheckable = true, func = function() UI:Open(8) end },
        { text = "Buffs", notCheckable = true, func = function() UI:Open(9) end },
        { text = "Stats", notCheckable = true, func = function() UI:Open(2) end },
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
    btn:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) end)
    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("|cffffd100Dragon Skill|r")
        GameTooltip:AddLine("Linksklick: BiS", 1, 1, 1)
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
        print("|cff00ff00Dragon Skill:|r Minimap aus - wieder an mit /ds minimap")
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
    if f.SetTitle then f:SetTitle("Dragon Skill v1.6.3") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end
    if f.Inset then
        f.Inset:ClearAllPoints()
        f.Inset:SetPoint("TOPLEFT", 4, -60)
        f.Inset:SetPoint("BOTTOMRIGHT", -6, 28)
    end
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
        if i == 1 then
            tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 8, 1)
        else
            tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", -16, 0)
        end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)
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
    local content = self.frame.Content
    self:ClearContent(content)
    self:EnsureText(content)
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end

    if currentTab == TAB_BOSSES then
        self:DrawBosses(content)
        return
    end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if not guideData then
        content.text:SetText("|cffff0000DATEN-FEHLER:|r Keine Guide-Daten fuer diese Spec.")
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

function UI:DrawTalents(content, guideData)
    local TC = DragonSkill:GetModule("TalentCompare")
    content.extraFS = content.extraFS or {}
    content.text:SetText("|cffffff00=== Guide-Builds ===|r")
    content.text:Show()
    local yOffset = -28
    for _, btn in pairs(self.talentBtns) do btn:Hide() end
    for _, btn in pairs(self.favBtns) do btn:Hide() end

    local raw = guideData.talentBuilds or {}
    local builds, seen = {}, {}
    local hasFull = false
    for _, build in ipairs(raw) do
        local lab = tostring(build.label or ""):lower()
        if not lab:find("class tree", 1, true) then
            hasFull = true
            break
        end
    end
    for _, build in ipairs(raw) do
        local key = build.importString or ""
        local lab = tostring(build.label or ""):lower()
        if key ~= "" and not seen[key] then
            if hasFull and lab:find("class tree", 1, true) then
            else
                seen[key] = true
                local r = MatchResult(TC, build.importString)
                local prio = 0
                local p = tostring(build.provider or ""):lower()
                if p == "method" or p == "icyveins" then prio = 3
                elseif p == "wowhead" then prio = 2
                elseif p == "archon" then prio = 1
                end
                table.insert(builds, {
                    importString = build.importString,
                    provider = build.provider,
                    label = build.label,
                    _sim = r.similarity or 0,
                    _prio = prio,
                })
            end
        end
    end
    table.sort(builds, function(a, b)
        if a._sim ~= b._sim then return a._sim > b._sim end
        if (a._prio or 0) ~= (b._prio or 0) then return (a._prio or 0) > (b._prio or 0) end
        return tostring(a.label or "") < tostring(b.label or "")
    end)

    if #builds == 0 then
        content.text:SetText("|cffffff00=== Guide-Builds ===|r\n\n|cffffaa00Keine Guide-Talente.|r")
    else
        for i, build in ipairs(builds) do
            local btn = self.talentBtns[i]
            if not btn then
                btn = CreateFrame("Button", "DragonSkillTalentBtn_" .. i, content, "UIPanelButtonTemplate")
                btn:SetSize(ROW_WIDTH, 32)
                self.talentBtns[i] = btn
            end
            btn:SetParent(content)
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", 10, yOffset)
            local sim = build._sim or 0
            local simColor = sim >= 90 and "00ff00" or (sim >= 70 and "ffff00" or "ff6666")
            btn:SetText(string.format("[%s] %s  |cff%s%d%%|r",
                string.upper(tostring(build.provider or "Guide")),
                tostring(build.label or ("Build " .. i)), simColor, sim))
            btn:SetScript("OnClick", function()
                cachedBuildData = build
                StaticPopup_Show("DRAGONSKILL_ACTION", build.label or "Build", sim)
            end)
            btn:Show()
            yOffset = yOffset - 36
        end
    end
    content:SetHeight(math.max(400, math.abs(yOffset) + 80))
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
    for _, row in ipairs(rows) do row:Hide() end
    if not items or #items == 0 then
        content.text:SetText((title or "") .. "\n\n|cffffaa00Keine Daten verfuegbar.|r")
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
            row.text:SetWidth(ROW_WIDTH - 40)
            rows[i] = row
        end
        row:SetParent(content)
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 10, yOffset)
        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        if item.itemId and C_Item and C_Item.GetItemIconByID then
            texture = C_Item.GetItemIconByID(item.itemId) or texture
        end
        row.icon:SetTexture(texture)
        local rank = item.rank and (" |cff888888(" .. tostring(item.rank) .. ")|r") or ""
        row.text:SetText((item.slot and ("|cff00ff00" .. item.slot .. ":|r ") or "") .. itemName .. rank)
        local captured, capturedName = item, itemName
        row:SetScript("OnEnter", function(selfRow)
            GameTooltip:SetOwner(selfRow, "ANCHOR_RIGHT")
            if captured.itemId then GameTooltip:SetItemByID(captured.itemId)
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
    local txt = "|cffffff00=== Deine Werte ===|r\n" .. string.format(
        "Tempo: %.1f%%\nKritisch: %.1f%%\nMeisterschaft: %.1f%%\nVielseitigkeit: %.1f%%\n",
        GetHaste(), GetCritChance(), GetMasteryEffect(),
        GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE))
    local prio = guideData.statPriority
    if prio then
        txt = txt .. "\n|cffffff00=== Empfehlung ===|r\n"
        txt = txt .. "|cffffd100Wowhead:|r " .. (prio.wowhead or "N/A") .. "\n"
        if prio.archon then txt = txt .. "|cffffd100Archon:|r " .. prio.archon .. "\n" end
    end
    content.text:SetText(txt)
end

function UI:DrawTrinkets(content, guideData)
    local mod = DragonSkill:GetModule("Trinkets")
    local items = (mod and mod.GetList and mod:GetList(guideData)) or {}
    if not items or #items == 0 then
        items = MergeProviderLists(guideData.trinkets)
    end
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Top Trinkets (Archon + Wowhead):|r")
end

function UI:DrawCrafting(content, guideData)
    local mod = DragonSkill:GetModule("Crafting")
    content.text:SetText((mod and mod.FormatText and mod:FormatText(guideData)) or "Keine Crafting-Daten.")
end

function UI:DrawRotation(content, guideData)
    local mod = DragonSkill:GetModule("Rotation")
    local items = (mod and mod.GetList and mod:GetList(guideData)) or {}
    if not items or #items == 0 then
        items = (guideData.rotation and guideData.rotation.wowhead) or {}
    end
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Prioritaet (Wowhead):|r")
end

function UI:DrawGear(content, guideData)
    local items = MergeProviderLists(guideData.bisGear)
    local n = #FilterItems(items)
    local header = string.format(
        "|cffffd100=== BiS (Archon + Wowhead) ===|r\n|cff888888%d Empfehlungen · Hover = Tooltip|r", n)
    self:Helper_DrawListWithIcons(content, items, header)
end

function UI:DrawEnchants(content, guideData)
    self:Helper_DrawListWithIcons(content, MergeProviderLists(guideData.enchants),
        "|cffffff00Verzauberungen (Archon + Wowhead):|r")
end

function UI:DrawGems(content, guideData)
    self:Helper_DrawListWithIcons(content, MergeProviderLists(guideData.gems),
        "|cffffff00Gems (Archon + Wowhead):|r")
end

function UI:DrawBuffs(content, guideData)
    local items = MergeProviderLists(guideData.consumables)
    local n = #FilterItems(items)
    local header = string.format(
        "|cffffd100=== Consumables / Buffs (Archon) ===|r\n|cff888888%d Eintraege · Flask · Food · Potion · Weapon Oil|r", n)
    self:Helper_DrawListWithIcons(content, items, header)
end

local BOSS_ORDER = { 3011, 3010, 3013, 3012, 3014, 3015, 3016, 3017, 3101 }

function UI:DrawBosses(content)
    for _, btn in pairs(self.talentBtns) do btn:Hide() end
    for _, btn in pairs(self.favBtns) do btn:Hide() end

    local BM = DragonSkill:GetModule("BossMechanics") or DragonSkill.BossMechanics
    content.text:SetText("|cffffff00=== Boss Guides ===|r\n|cff888888Venomous Abyss + Tidebound Grotto · Klick = Simulieren|r")
    content.text:Show()

    if not BM or not BM.Bosses then
        content.text:SetText("|cffffff00=== Boss Guides ===|r\n\n|cffff0000BossMechanics-Modul nicht geladen.|r\nPruefe TOC + Modules/BossMechanics/.")
        return
    end

    local yOffset = -42
    local index = 0
    local function addBossRow(id, boss)
        index = index + 1
        local btn = self.talentBtns[index]
        if not btn then
            btn = CreateFrame("Button", "DragonSkillTalentBtn_" .. index, content, "UIPanelButtonTemplate")
            btn:SetSize(ROW_WIDTH, 32)
            self.talentBtns[index] = btn
        end
        btn:SetParent(content)
        btn:ClearAllPoints()
        btn:SetPoint("TOPLEFT", 10, yOffset)
        local phase = boss.Phase and ("  |cff66ccff" .. tostring(boss.Phase) .. "|r") or ""
        btn:SetText(string.format("|cffffd100%d|r  %s%s", id, boss.Name or "?", phase))
        btn:SetScript("OnClick", function()
            if BM.Simulate then
                BM:Simulate(id)
            elseif DragonSkill.BossMechanicsUI and DragonSkill.BossMechanicsUI.OnBossStart then
                DragonSkill.BossMechanicsUI:OnBossStart(boss)
            end
            print("|cff00ff00Dragon Skill:|r Boss-Guide: |cffffd100" .. tostring(boss.Name or id) .. "|r")
            if boss.Tip and boss.Tip ~= "" then
                print("|cffaaaaaaTip:|r " .. boss.Tip)
            end
        end)
        btn:SetScript("OnEnter", function(selfBtn)
            GameTooltip:SetOwner(selfBtn, "ANCHOR_RIGHT")
            GameTooltip:SetText(boss.Name or ("Boss " .. tostring(id)), 1, 0.82, 0)
            if boss.Phase then GameTooltip:AddLine("Phase: " .. tostring(boss.Phase), 0.6, 0.9, 1, true) end
            if boss.Tip then GameTooltip:AddLine(boss.Tip, 0.9, 0.9, 0.8, true) end
            GameTooltip:AddLine(" ", 1, 1, 1)
            GameTooltip:AddLine("Klick: Overlay + Timer starten (Simulate)", 0.5, 0.8, 0.5)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        btn:Show()
        yOffset = yOffset - 36
    end

    local shown = {}
    for _, id in ipairs(BOSS_ORDER) do
        local boss = BM.Bosses[id]
        if boss then
            addBossRow(id, boss)
            shown[id] = true
        end
    end
    for id, boss in pairs(BM.Bosses) do
        if not shown[id] then
            addBossRow(id, boss)
        end
    end

    if index == 0 then
        content.text:SetText("|cffffff00=== Boss Guides ===|r\n\n|cffffaa00Keine Bosse registriert.|r\nBoss-Dateien in Modules/BossMechanics/Bosses/ pruefen.")
    end
end

function UI:OpenBosses() self:Open(TAB_BOSSES) end

SLASH_WEAR1 = "/wear"
SLASH_WEAR2 = "/dragonskill"
SLASH_WEAR3 = "/ds"
SlashCmdList["WEAR"] = function(msg)
    msg = msg and strtrim(msg) or ""
    local lower = msg:lower()
    if lower == "help" or lower == "?" then
        print("|cff00ff00Dragon Skill v1.6.3|r")
        print("  /ds | /wear     - Fenster")
        print("  /ds bis         - BiS-Uebersicht")
        print("  /ds minimap     - Minimap an/aus")
        print("  /ds boss | bosses - Boss-Guides Tab")
        print("  /ds boss list     - BossMechanics Liste (Chat)")
        print("  /ds boss <name>   - Boss simulieren")
        return
    end
    if lower == "minimap" then UI:ToggleMinimap(); return end
    if lower == "bis" or lower == "gear" or lower == "bisgear" then UI:OpenBiS(); return end
    if lower == "bosses" or lower == "bossguide" or lower == "bossguides" then
        UI:OpenBosses()
        return
    end
    local bossArg = lower:match("^boss%s*(.*)$")
    if bossArg ~= nil then
        local BM = DragonSkill:GetModule("BossMechanics") or DragonSkill.BossMechanics
        if not BM then print("|cffff0000Dragon Skill:|r BossMechanics fehlt."); return end
        if bossArg == "" then
            UI:OpenBosses()
            return
        end
        if bossArg == "list" then
            if BM.ListBosses then BM:ListBosses() end
            return
        end
        local asNum = tonumber(bossArg)
        if BM.Simulate then BM:Simulate(asNum or bossArg) end
        return
    end
    UI:Toggle()
end

print("|cff00ff00Dragon Skill v1.6.3 geladen!|r  Minimap = BiS · /ds help")

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

DragonSkill.UI = UI
