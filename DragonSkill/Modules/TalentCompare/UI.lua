-- Dragon Skill - Haupt UI (v1.5.2)
-- Fixes: Fensterbreite vs. Tabs, Talent anlegen/kopieren, Favoriten, List-Rows, 12.1 Popups

local UI = {}
local currentTab = 1
local tabs = { "Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants", "Buffs" }

-- Persistenter Cache für Popup-Aktionen
local cachedBuildData = nil

-- Layout-Konstanten (Tabs brauchen Breite)
local FRAME_W = 680
local FRAME_H = 560
local CONTENT_W = 600
local BTN_W = 580

---------------------------------------------------------------------------
-- Static Popups
---------------------------------------------------------------------------

StaticPopupDialogs["DRAGONSKILL_ACTION"] = {
    text = "Build: %s\nMatch: %d%%\n\nWas möchtest du tun?",
    button1 = "Kopieren",
    button2 = "Neu anlegen",
    button3 = "Abbrechen",
    OnAccept = function(self)
        -- Button1: Kopieren
        StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, cachedBuildData)
    end,
    OnCancel = function(self, data, reason)
        -- Button2: Neu anlegen (nur bei echtem Klick, nicht Escape)
        if reason ~= "clicked" or not cachedBuildData then return end
        local build = cachedBuildData
        local DB = DragonSkill.Database
        local TC = DragonSkill:GetModule("TalentCompare")

        local savedName
        if DB and DB.CreateSkilling then
            savedName = DB:CreateSkilling(nil, {
                importString = build.importString,
                provider = build.provider or "Guide",
                label = build.label or "Build",
            })
            print("|cff00ff00Dragon Skill:|r Skilling gespeichert als '|cffffd100" .. tostring(savedName) .. "|r'.")
        end

        if TC and build.importString then
            TC:ImportToWoW(build.importString, savedName or build.label or "DragonSkill")
        end

        -- UI refreshen falls Talent-Tab offen
        if DragonSkill.UI and DragonSkill.UI.frame and DragonSkill.UI.frame:IsShown() then
            DragonSkill.UI:Update()
        end
    end,
    OnAlt = function()
        -- Button3: Abbrechen – no-op
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Strg+C zum Kopieren:\n(String ist markiert)",
    button1 = "Fertig",
    hasEditBox = 1,
    editBoxWidth = 320,
    OnShow = function(self, data)
        local eb = self.EditBox or self.editBox
        if not eb then return end
        local build = data or cachedBuildData
        local code = ""
        if type(build) == "table" then
            code = build.importString or ""
        else
            code = tostring(build or "")
        end
        eb:SetText(code)
        eb:SetFocus()
        eb:HighlightText()
        -- 12.1: Focus/Highlight manchmal erst im nächsten Frame stabil
        if C_Timer and C_Timer.After then
            C_Timer.After(0, function()
                if eb and eb.SetFocus then
                    eb:SetFocus()
                    eb:HighlightText()
                end
            end)
        end
    end,
    OnAccept = function(self)
        local eb = self.EditBox or self.editBox
        if eb then eb:ClearFocus() end
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_DELETE_SKILLING"] = {
    text = "Skilling '%s' wirklich löschen?",
    button1 = "Löschen",
    button2 = "Abbrechen",
    OnAccept = function(self, data)
        local name = data
        if name and DragonSkill.Database and DragonSkill.Database.DeleteSkilling then
            DragonSkill.Database:DeleteSkilling(name)
            print("|cff00ff00Dragon Skill:|r Skilling gelöscht: " .. tostring(name))
            if DragonSkill.UI and DragonSkill.UI.frame and DragonSkill.UI.frame:IsShown() then
                DragonSkill.UI:Update()
            end
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

---------------------------------------------------------------------------
-- Frame Setup
---------------------------------------------------------------------------

function UI:Init()
    if self.frame then return end

    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(FRAME_W, FRAME_H)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    if f.SetTitle then
        f:SetTitle("Dragon Skill v" .. (DragonSkill.version or "1.5.2"))
    end
    if f.portrait then
        f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    end

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
    content:SetSize(CONTENT_W, 2000)
    content:EnableMouse(true)
    scrollFrame:SetScrollChild(content)
    f.Content = content
    f.ScrollFrame = scrollFrame

    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "DragonSkillTabBtn" .. i, f, "PanelTabButtonTemplate")
        tab:SetID(i)
        tab:SetText(name)
        tab:SetScript("OnClick", function(btn)
            UI:SelectTab(btn:GetID())
        end)
        f.Tabs[i] = tab
        if i == 1 then
            tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 12, 2)
        else
            -- etwas mehr Überlappung, damit 8 Tabs in 680px passen
            tab:SetPoint("LEFT", f.Tabs[i - 1], "RIGHT", -18, 0)
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
    PanelTemplates_SetTab(self.frame, id)
    self:Update()
end

function UI:ClearContentChildren(content)
    local children = { content:GetChildren() }
    for _, child in ipairs(children) do
        child:Hide()
    end
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content
    self:ClearContentChildren(content)

    if not content.text then
        content.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        content.text:SetPoint("TOPLEFT", 10, -10)
        content.text:SetWidth(CONTENT_W - 40)
        content.text:SetJustifyH("LEFT")
        content.text:SetSpacing(3)
    end
    content.text:SetText("")
    content.text:Show()

    if self.frame.ScrollFrame then
        self.frame.ScrollFrame:SetVerticalScroll(0)
    end

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization and GetSpecialization()
    local specID = 0
    if specIndex and GetSpecializationInfo then
        specID = GetSpecializationInfo(specIndex) or 0
    end
    local guideData = DragonSkill.Database and DragonSkill.Database:GetGuideData(class, specID)

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
-- Talente + gespeicherte Skillings
---------------------------------------------------------------------------

function UI:DrawTalents(content, guideData)
    local TC = DragonSkill:GetModule("TalentCompare")

    for _, btn in ipairs(self.talentBtns) do btn:Hide() end
    for _, btn in ipairs(self.favBtns) do btn:Hide() end

    local yOffset = -10
    local builds = guideData.talentBuilds or {}

    if #builds == 0 then
        content.text:SetText("|cffffaa00Keine Guide-Talentbuilds für diese Spec.|r")
    else
        content.text:SetText("|cffffff00=== Guide-Builds ===|r")
        yOffset = -28
    end

    for i, build in ipairs(builds) do
        local btn = self.talentBtns[i]
        if not btn then
            btn = CreateFrame("Button", "DragonSkillTalentBtn_" .. i, content, "UIPanelButtonTemplate")
            btn:SetSize(BTN_W, 32)
            self.talentBtns[i] = btn
        end
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
        yOffset = yOffset - 38
    end

    -- Gespeicherte Skillings
    local skillings = (DragonSkill.Database and DragonSkill.Database.GetSkillings and DragonSkill.Database:GetSkillings()) or {}
    yOffset = yOffset - 8
    local header = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    -- wiederverwendbares Header-Label
    if not content.favHeader then
        content.favHeader = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        content.favHeader:SetJustifyH("LEFT")
        content.favHeader:SetWidth(CONTENT_W - 40)
    end
    content.favHeader:ClearAllPoints()
    content.favHeader:SetPoint("TOPLEFT", 10, yOffset)
    content.favHeader:SetText("|cffffff00=== Meine Skillings ===|r  |cffaaaaaa(gespeichert)|r")
    content.favHeader:Show()
    yOffset = yOffset - 24

    if #skillings == 0 then
        if not content.favEmpty then
            content.favEmpty = content:CreateFontString(nil, "OVERLAY", "GameFontDisable")
            content.favEmpty:SetJustifyH("LEFT")
            content.favEmpty:SetWidth(CONTENT_W - 40)
        end
        content.favEmpty:ClearAllPoints()
        content.favEmpty:SetPoint("TOPLEFT", 10, yOffset)
        content.favEmpty:SetText("Noch keine. Klicke einen Guide-Build → „Neu anlegen“.")
        content.favEmpty:Show()
        yOffset = yOffset - 22
    else
        if content.favEmpty then content.favEmpty:Hide() end
        for i, entry in ipairs(skillings) do
            local btn = self.favBtns[i]
            if not btn then
                btn = CreateFrame("Button", "DragonSkillFavBtn_" .. i, content, "UIPanelButtonTemplate")
                btn:SetSize(BTN_W - 70, 28)
                self.favBtns[i] = btn
            end
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", 10, yOffset)
            btn:SetText(entry.name)
            btn:SetScript("OnClick", function()
                local data = entry.data
                cachedBuildData = {
                    importString = data.importString,
                    provider = data.provider or "Saved",
                    label = entry.name,
                }
                local current = TC and TC:GetCurrentBuildString() or nil
                local result = TC and TC:Compare(data.importString, current) or { similarity = 0 }
                StaticPopup_Show("DRAGONSKILL_ACTION", entry.name, result.similarity or 0)
            end)
            btn:Show()

            -- Delete-Button
            local delKey = "del_" .. i
            if not self.favBtns[delKey] then
                local del = CreateFrame("Button", "DragonSkillFavDel_" .. i, content, "UIPanelButtonTemplate")
                del:SetSize(60, 28)
                del:SetText("X")
                self.favBtns[delKey] = del
            end
            local del = self.favBtns[delKey]
            del:ClearAllPoints()
            del:SetPoint("LEFT", btn, "RIGHT", 6, 0)
            del:SetScript("OnClick", function()
                StaticPopup_Show("DRAGONSKILL_DELETE_SKILLING", entry.name, nil, entry.name)
            end)
            del:Show()

            yOffset = yOffset - 34
        end
    end

    -- Content-Höhe an Inhalt anpassen
    local needed = math.max(2000, math.abs(yOffset) + 40)
    content:SetHeight(needed)
end

---------------------------------------------------------------------------
-- Listen mit Icons (pro Tab getrennt)
---------------------------------------------------------------------------

function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -10
    if title then
        content.text:SetText(title)
        yOffset = -30
    end

    self.listRowsByTab = self.listRowsByTab or {}
    local rows = self.listRowsByTab[currentTab]
    if not rows then
        rows = {}
        self.listRowsByTab[currentTab] = rows
    end

    for _, row in ipairs(rows) do
        row:Hide()
    end

    if not items or #items == 0 then
        content.text:SetText((title or "") .. "\n\n|cffffaa00Keine Daten verfügbar.|r")
        return
    end

    for i, item in ipairs(items) do
        local itemName = item.text or item.name or "Unbekannt"
        local row = rows[i]
        if not row then
            row = CreateFrame("Button", "DragonSkillRow_" .. currentTab .. "_" .. i, content)
            row:SetSize(BTN_W, 26)
            row:SetFrameLevel(content:GetFrameLevel() + 5)
            row:EnableMouse(true)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22)
            row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
            row.text:SetWidth(BTN_W - 40)
            row.text:SetJustifyH("LEFT")
            rows[i] = row
        end

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 10, yOffset)

        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        if item.itemId and C_Item and C_Item.GetItemIconByID then
            texture = C_Item.GetItemIconByID(item.itemId) or texture
        elseif item.spellId and C_Spell and C_Spell.GetSpellTexture then
            texture = C_Spell.GetSpellTexture(item.spellId) or texture
        end

        row.icon:SetTexture(texture)
        row.text:SetText((item.slot and ("|cff00ff00" .. item.slot .. ":|r ") or "") .. itemName)

        -- Closure über lokale Kopie, nicht über den Loop-Index
        local itemId = item.itemId
        local spellId = item.spellId
        local tipName = itemName
        row:SetScript("OnEnter", function(selfBtn)
            GameTooltip:SetOwner(selfBtn, "ANCHOR_RIGHT")
            if itemId then
                GameTooltip:SetItemByID(itemId)
            elseif spellId then
                GameTooltip:SetSpellByID(spellId)
            else
                GameTooltip:SetText(tipName)
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

function UI:DrawStats(content, guideData)
    local txt = "|cffffff00=== Deine Werte ===|r\n"
    local haste = GetHaste and GetHaste() or 0
    local crit = GetCritChance and GetCritChance() or 0
    local mastery = GetMasteryEffect and GetMasteryEffect() or 0
    local vers = (GetCombatRatingBonus and CR_VERSATILITY_DAMAGE_DONE and GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)) or 0
    txt = txt .. string.format("Tempo: %.1f%%\nKritisch: %.1f%%\nMeisterschaft: %.1f%%\nVielseitigkeit: %.1f%%\n", haste, crit, mastery, vers)
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
    if guideData.crafting and guideData.crafting.wowhead and guideData.crafting.wowhead.embellishments and #guideData.crafting.wowhead.embellishments > 0 then
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
-- Slash
---------------------------------------------------------------------------

SLASH_WEAR1 = "/wear"
SLASH_WEAR2 = "/dragonskill"
SlashCmdList["WEAR"] = function(msg)
    msg = msg and strtrim(msg:lower()) or ""
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

print("|cff00ff00Dragon Skill v" .. (DragonSkill.version or "1.5.2") .. " geladen!|r Nutze /wear")
DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
end)
DragonSkill.UI = UI
