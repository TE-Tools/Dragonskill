-- Dragon Skill - Haupt UI (v1.5.2)
-- Fixes: Fensterbreite, Skillungen anlegen/kopieren, Favoriten, Listen, 12.1 Popups

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants", "Buffs"}

-- Persistenter Cache für Popups
local cachedBuildData = nil

local CONTENT_WIDTH = 560
local FRAME_WIDTH = 640
local FRAME_HEIGHT = 560
local ROW_WIDTH = 540

---------------------------------------------------------------------------
-- Static Popups
---------------------------------------------------------------------------

StaticPopupDialogs["DRAGONSKILL_ACTION"] = {
    text = "Build: %s\nMatch: %d%%\n\nWas möchtest du tun?",
    button1 = "Kopieren",
    button2 = "Anlegen + Import",
    button3 = "Abbrechen",
    OnAccept = function(self)
        -- Button1: Kopieren
        if cachedBuildData then
            StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, cachedBuildData)
        end
    end,
    OnCancel = function(self, data, reason)
        -- Button2: Anlegen + Import (nur bei Klick, nicht Escape)
        if reason ~= "clicked" or not cachedBuildData then return end
        local build = cachedBuildData
        local _, class = UnitClass("player")
        local specIndex = GetSpecialization()
        local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or nil

        local saveData = {
            importString = build.importString,
            provider = build.provider,
            label = build.label,
            class = class,
            specID = specID,
        }
        local savedName = DragonSkill.Database:CreateSkilling(nil, saveData)
        print("|cff00ff00Dragon Skill:|r Skilling gespeichert als '|cffffd100" .. tostring(savedName) .. "|r'.")

        local TC = DragonSkill:GetModule("TalentCompare")
        if TC then
            TC:ImportToWoW(build.importString, build.label or savedName)
        end

        -- UI aktualisieren, damit Favoriten sichtbar werden
        if DragonSkill.UI and DragonSkill.UI.frame and DragonSkill.UI.frame:IsShown() then
            DragonSkill.UI:Update()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Strg+C zum Kopieren:",
    button1 = "Fertig",
    hasEditBox = 1,
    editBoxWidth = 320,
    OnShow = function(self, data)
        local build = data or cachedBuildData
        local code = ""
        if type(build) == "table" then
            code = build.importString or ""
        else
            code = tostring(build or "")
        end

        local function apply()
            local eb = self.EditBox or self.editBox
            if not eb then return end
            eb:SetText(code)
            eb:HighlightText()
            eb:SetFocus()
        end

        apply()
        -- 12.1: Template fertig initialisieren lassen
        if C_Timer and C_Timer.After then
            C_Timer.After(0, apply)
            C_Timer.After(0.05, apply)
        end
    end,
    OnAccept = function(self)
        local eb = self.EditBox or self.editBox
        if eb then eb:ClearFocus() end
    end,
    EditBoxOnEnterPressed = function(self)
        self:GetParent():Hide()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_DELETE"] = {
    text = "Skilling '%s' wirklich löschen?",
    button1 = "Löschen",
    button2 = "Abbrechen",
    OnAccept = function(self, data)
        local name = data
        if name and DragonSkill.Database:DeleteSkilling(name) then
            print("|cff00ff00Dragon Skill:|r '" .. tostring(name) .. "' gelöscht.")
            if DragonSkill.UI and DragonSkill.UI.frame and DragonSkill.UI.frame:IsShown() then
                DragonSkill.UI:Update()
            end
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

---------------------------------------------------------------------------
-- Frame Init
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

    if f.SetTitle then f:SetTitle("Dragon Skill v1.5.2") end
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
        tab:SetScript("OnClick", function(selfBtn)
            UI:SelectTab(selfBtn:GetID())
        end)
        f.Tabs[i] = tab
        if i == 1 then
            tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 12, 1)
        else
            tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", -15, 0)
        end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)

    f:Hide()
    self.frame = f
    self.talentBtns = {}
    self.favBtns = {}
    self.listRowsByTab = {}
end

function UI:SelectTab(id)
    currentTab = id
    if self.frame then
        PanelTemplates_SetTab(self.frame, id)
    end
    self:Update()
end

function UI:ClearContent(content)
    local children = { content:GetChildren() }
    for _, child in ipairs(children) do
        child:Hide()
    end
    if content.text then
        content.text:SetText("")
        content.text:Show()
    end
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

    if self.frame.ScrollFrame then
        self.frame.ScrollFrame:SetVerticalScroll(0)
    end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local guideData = DragonSkill.Database:GetGuideData(class, specID)

    if not guideData then
        content.text:SetText("|cffff0000DATEN-FEHLER:|r Keine Daten gefunden.\n\nBitte WoW neu starten und Addon-Ordner prüfen.")
        return
    end

    if currentTab == 1 then
        self:DrawTalents(content, guideData)
    elseif currentTab == 2 then
        self:DrawStats(content, guideData)
    elseif currentTab == 3 then
        self:DrawTrinkets(content, guideData)
    elseif currentTab == 4 then
        self:DrawCrafting(content, guideData)
    elseif currentTab == 5 then
        self:DrawRotation(content, guideData)
    elseif currentTab == 6 then
        self:DrawGear(content, guideData)
    elseif currentTab == 7 then
        self:DrawEnchants(content, guideData)
    elseif currentTab == 8 then
        self:DrawBuffs(content, guideData)
    end
end

---------------------------------------------------------------------------
-- Talente + Favoriten
---------------------------------------------------------------------------

function UI:DrawTalents(content, guideData)
    local TC = DragonSkill:GetModule("TalentCompare")
    local yOffset = -10

    -- Guide-Builds
    content.text:SetText("|cffffff00=== Guide-Builds ===|r")
    content.text:Show()
    yOffset = -28

    for _, btn in ipairs(self.talentBtns) do btn:Hide() end
    for _, btn in ipairs(self.favBtns) do btn:Hide() end

    local builds = guideData.talentBuilds or {}
    if #builds == 0 then
        content.text:SetText("|cffffff00=== Guide-Builds ===|r\n\n|cffffaa00Keine Guide-Talente gefunden.|r")
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
            btn:SetText(string.format("[%s] %s", string.upper(tostring(build.provider or "Guide")), tostring(build.label or ("Build " .. i))))
            btn:SetScript("OnClick", function()
                cachedBuildData = build
                local current = TC and TC:GetCurrentBuildString() or nil
                local result = TC and TC:Compare(build.importString, current) or { similarity = 0 }
                StaticPopup_Show("DRAGONSKILL_ACTION", build.label or "Build", result.similarity or 0)
            end)
            btn:Show()
            yOffset = yOffset - 36
        end
    end

    -- Favoriten / gespeicherte Skillungen
    yOffset = yOffset - 12
    local favHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    favHeader:SetPoint("TOPLEFT", 10, yOffset)
    favHeader:SetText("|cffffff00=== Meine Skillungen ===|r")
    favHeader:Show()
    -- keep reference so ClearContent hides it via GetChildren? FontStrings on content are not children frames.
    -- Use a dummy frame marker or just accept it shows until next full rebuild.
    -- Better: store on content and hide explicitly next Update via ClearContent only hides frames.
    if not content.extraFS then content.extraFS = {} end
    table.insert(content.extraFS, favHeader)
    yOffset = yOffset - 22

    local skillings = DragonSkill.Database:GetSkillings() or {}
    if #skillings == 0 then
        local empty = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        empty:SetPoint("TOPLEFT", 10, yOffset)
        empty:SetWidth(ROW_WIDTH)
        empty:SetJustifyH("LEFT")
        empty:SetText("|cff888888Noch keine gespeicherten Skillungen.\nKlicke einen Guide-Build → „Anlegen + Import“.|r")
        empty:Show()
        table.insert(content.extraFS, empty)
        yOffset = yOffset - 40
    else
        for i, entry in ipairs(skillings) do
            local name = entry.name
            local data = entry.data or {}
            local btn = self.favBtns[i]
            if not btn then
                btn = CreateFrame("Button", "DragonSkillFavBtn_" .. i, content, "UIPanelButtonTemplate")
                btn:SetSize(ROW_WIDTH - 70, 28)
                self.favBtns[i] = btn
            end
            btn:SetParent(content)
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", 10, yOffset)
            local label = data.label or name
            local provider = data.provider and ("[" .. string.upper(tostring(data.provider)) .. "] ") or ""
            btn:SetText(provider .. tostring(label))
            btn:SetScript("OnClick", function()
                cachedBuildData = {
                    importString = data.importString,
                    provider = data.provider or "saved",
                    label = data.label or name,
                }
                local current = TC and TC:GetCurrentBuildString() or nil
                local result = TC and TC:Compare(data.importString, current) or { similarity = 0 }
                StaticPopup_Show("DRAGONSKILL_ACTION", data.label or name, result.similarity or 0)
            end)
            btn:Show()

            -- Delete button
            local delKey = "del_" .. i
            if not self.favBtns[delKey] then
                local del = CreateFrame("Button", "DragonSkillFavDel_" .. i, content, "UIPanelButtonTemplate")
                del:SetSize(60, 28)
                self.favBtns[delKey] = del
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

    -- Content-Höhe anpassen
    local needed = math.max(2000, math.abs(yOffset) + 80)
    content:SetHeight(needed)
end

---------------------------------------------------------------------------
-- Listen mit Icons (pro Tab isoliert)
---------------------------------------------------------------------------

function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -10
    self:EnsureText(content)
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

    -- andere Tabs-Rows verstecken
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

        local prefix = item.slot and ("|cff00ff00" .. item.slot .. ":|r ") or ""
        row.text:SetText(prefix .. itemName)

        local captured = item
        local capturedName = itemName
        row:SetScript("OnEnter", function(selfRow)
            GameTooltip:SetOwner(selfRow, "ANCHOR_RIGHT")
            if captured.itemId then
                GameTooltip:SetItemByID(captured.itemId)
            elseif captured.spellId then
                GameTooltip:SetSpellByID(captured.spellId)
            else
                GameTooltip:SetText(capturedName)
            end
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        row:Show()
        yOffset = yOffset - 28
    end

    local needed = math.max(400, math.abs(yOffset) + 40)
    content:SetHeight(needed)
end

---------------------------------------------------------------------------
-- Tab-Inhalte
---------------------------------------------------------------------------

function UI:DrawStats(content, guideData)
    local txt = "|cffffff00=== Deine Werte ===|r\n"
    txt = txt .. string.format(
        "Tempo: %.1f%%\nKritisch: %.1f%%\nMeisterschaft: %.1f%%\nVielseitigkeit: %.1f%%\n",
        GetHaste(),
        GetCritChance(),
        GetMasteryEffect(),
        GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)
    )
    if guideData.statPriority then
        txt = txt .. "\n|cffffff00=== Empfehlung ===|r\n"
        txt = txt .. "|cffffd100Wowhead:|r " .. (guideData.statPriority.wowhead or "N/A") .. "\n"
        if guideData.statPriority.archon then
            txt = txt .. "|cffffd100Archon:|r " .. (guideData.statPriority.archon or "N/A") .. "\n"
        end
    end
    content.text:SetText(txt)
end

function UI:DrawTrinkets(content, guideData)
    local items = (guideData.trinkets and guideData.trinkets.archon) or {}
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Top Trinkets (Archon):|r")
end

function UI:DrawCrafting(content, guideData)
    if guideData.crafting and guideData.crafting.wowhead
        and guideData.crafting.wowhead.embellishments
        and #guideData.crafting.wowhead.embellishments > 0 then
        local txt = "|cffffff00Embellishments (Wowhead):|r\n"
        for _, emb in ipairs(guideData.crafting.wowhead.embellishments) do
            txt = txt .. "- " .. emb .. "\n"
        end
        content.text:SetText(txt)
    else
        content.text:SetText("Keine Crafting-Daten.")
    end
end

function UI:DrawRotation(content, guideData)
    local items = (guideData.rotation and guideData.rotation.wowhead) or {}
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Priorität (Wowhead):|r")
end

function UI:DrawGear(content, guideData)
    local items = (guideData.bisGear and guideData.bisGear.wowhead) or {}
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Best-in-Slot (Wowhead):|r")
end

function UI:DrawEnchants(content, guideData)
    local items = (guideData.enchants and guideData.enchants.wowhead) or {}
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Verzauberungen (Wowhead):|r")
end

function UI:DrawBuffs(content, guideData)
    local items = (guideData.consumables and guideData.consumables.wowhead) or {}
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Buffs (Wowhead):|r")
end

---------------------------------------------------------------------------
-- Slash + Boot
---------------------------------------------------------------------------

SLASH_WEAR1 = "/wear"
SLASH_WEAR2 = "/dragonskill"
SlashCmdList["WEAR"] = function(msg)
    msg = msg and strtrim(msg) or ""
    if msg == "testulatek" then
        local BM = DragonSkill:GetModule("BossMechanics")
        if BM and BM.SimulateUlatek then BM:SimulateUlatek() end
        return
    end
    if not UI.frame then UI:Init() end
    if UI.frame:IsShown() then
        UI.frame:Hide()
    else
        UI.frame:Show()
        UI:Update()
    end
end

print("|cff00ff00Dragon Skill v1.5.2 geladen!|r Nutze /wear")
DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
end)
DragonSkill.UI = UI
