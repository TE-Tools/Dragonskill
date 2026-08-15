-- Dragon Skill - Haupt UI (v0.8.5)
-- Stabiles Blizzard-Look-UI mit fixierter Klickbarkeit und korrigiertem Layout.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants"}

function UI:Init()
    if DragonSkillMainFrame then return end

    -- Hauptfenster (Blizzard Template)
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(450, 550)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    f:SetFrameStrata("DIALOG") -- Sicherstellen, dass es über dem Inset liegt
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self) self:StartMoving() end)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

    -- Titel & Portrait
    if f.SetTitle then f:SetTitle("Dragon Skill") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end

    -- Inset (Hintergrund) - Wir setzen es manuell, um Überlappungen zu vermeiden
    if f.Inset then
        f.Inset:ClearAllPoints()
        f.Inset:SetPoint("TOPLEFT", 4, -60)
        f.Inset:SetPoint("BOTTOMRIGHT", -6, 26) -- Platz für Tabs am unteren Rand
    end

    -- ScrollFrame (Wichtig: Muss im Inset liegen)
    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)
    scrollFrame:EnableMouse(true)

    -- Content Frame (Dieses Frame hält alle Buttons)
    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(380, 1500)
    content:EnableMouse(true)
    scrollFrame:SetScrollChild(content)
    f.Content = content

    -- Tab-System (Fest am unteren Rand verankert)
    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "$parentTab"..i, f, "PanelTabButtonTemplate")
        tab:SetID(i)
        tab:SetText(name)
        tab:SetScript("OnClick", function(self) UI:SelectTab(self:GetID()) end)
        f.Tabs[i] = tab
        if i == 1 then
            tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 15, 2)
        else
            tab:SetPoint("LEFT", f.Tabs[i-1], "RIGHT", -16, 0)
        end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)

    f:Hide()
    self.frame = f

    -- Slash Commands (Global)
    SLASH_DRAGONSKILL1 = "/ds"
    SLASH_DRAGONSKILL2 = "/dragonskill"
    SlashCmdList["DRAGONSKILL"] = function(msg)
        if msg == "testboss" then
            local BM = DragonSkill:GetModule("BossMechanics")
            if BM then BM:SimulateEntombedSentinels() end
        elseif msg == "testnekzali" then
            local BM = DragonSkill:GetModule("BossMechanics")
            if BM then BM:SimulateNekzali() end
        elseif msg == "testexplorers" then
            local BM = DragonSkill:GetModule("BossMechanics")
            if BM then BM:SimulateLostExplorers() end
        elseif msg == "testvashnik" then
            local BM = DragonSkill:GetModule("BossMechanics")
            if BM then BM:SimulateVashnik() end
        elseif f:IsShown() then
            f:Hide()
        else
            f:Show()
            UI:Update()
        end
    end
end

function UI:SelectTab(id)
    currentTab = id
    PanelTemplates_SetTab(self.frame, id)
    self:Update()
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content

    -- Alles Alte verstecken
    local children = {content:GetChildren()}
    for _, child in ipairs(children) do child:Hide() end

    -- Text-Bereich initialisieren
    if not content.text then
        content.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        content.text:SetPoint("TOPLEFT", 10, -10)
        content.text:SetWidth(360)
        content.text:SetJustifyH("LEFT")
        content.text:SetSpacing(3)
    end
    content.text:SetText("")
    content.text:Show()

    -- Routing
    if currentTab == 1 then self:DrawTalents(content)
    elseif currentTab == 2 then self:DrawStats(content)
    elseif currentTab == 3 then self:DrawTrinkets(content)
    elseif currentTab == 4 then self:DrawCrafting(content)
    elseif currentTab == 5 then self:DrawRotation(content)
    elseif currentTab == 6 then self:DrawGear(content)
    elseif currentTab == 7 then self:DrawEnchants(content)
    end
end

function UI:DrawTalents(content)
    local TC = DragonSkill:GetModule("TalentCompare")
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local specID = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)

    if not guideData or not guideData.talentBuilds then
        content.text:SetText("Keine Guide-Daten für deine Spezialisierung gefunden.")
        return
    end

    if not self.talentBtns then self.talentBtns = {} end
    for _, btn in ipairs(self.talentBtns) do btn:Hide() end

    local yOffset = -10
    for i, build in ipairs(guideData.talentBuilds) do
        local btn = self.talentBtns[i]
        if not btn then
            btn = CreateFrame("Button", "DragonSkillBuildBtn"..i, content, "UIPanelButtonTemplate")
            btn:SetSize(360, 32)
            btn:SetFrameLevel(content:GetFrameLevel() + 10) -- Ganz nach oben!
            self.talentBtns[i] = btn
        end
        btn:SetPoint("TOPLEFT", 10, yOffset)
        btn:SetText(string.format("[%s] %s", build.provider:upper(), build.label))
        btn:SetScript("OnClick", function()
            print("|cff00ff00Dragon Skill:|r Klick auf Build " .. build.label)
            local current = TC:GetCurrentBuildString()
            local result = TC:Compare(build.importString, current)
            UI:ShowImportDialog(build, result)
        end)
        btn:Show()
        yOffset = yOffset - 38
    end
end

function UI:ShowImportDialog(build, result)
    local TC = DragonSkill:GetModule("TalentCompare")
    local detailed = TC:GetDetailedDiff(build.importString)

    local diffText = ""
    if detailed and #detailed > 0 then
        diffText = "\n\n|cffff0000Abweichungen:|r"
        for i = 1, math.min(#detailed, 8) do
            local d = detailed[i]
            diffText = diffText .. string.format("\n- %s (%d/%d -> %d/%d)", d.name, d.currentRank, d.maxRank, d.importedRank, d.maxRank)
        end
    else
        diffText = "\n\n|cff00ff00Dein Build ist identisch!|r"
    end

    StaticPopupDialogs["DRAGONSKILL_COPY"] = {
        text = "Build: " .. build.label .. " (" .. (result.similarity or 0) .. "% Übereinstimmung)" .. diffText .. "\n\nKopiere den String mit Strg+C:",
        button1 = "Fertig",
        hasEditBox = 1,
        OnShow = function(self)
            self.editBox:SetText(build.importString or "")
            self.editBox:SetFocus()
            self.editBox:HighlightText()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }
    StaticPopup_Show("DRAGONSKILL_COPY")
end

function UI:DrawStats(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)

    local txt = "|cffffff00=== Deine Werte ===|r\n"
    txt = txt .. string.format("Tempo: %.1f%%\nKritisch: %.1f%%\nMeisterschaft: %.1f%%\nVielseitigkeit: %.1f%%\n", GetHaste(), GetCritChance(), GetMasteryEffect(), GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE))

    if guideData then
        txt = txt .. "\n|cffffff00=== Guide Empfehlung ===|r\n"
        if guideData.statPriority then
            txt = txt .. "|cffffd100Wowhead:|r " .. (guideData.statPriority.wowhead or "Keine Daten") .. "\n"
            if guideData.statPriority.archon then
                txt = txt .. "|cffffd100Archon:|r " .. guideData.statPriority.archon .. "\n"
            end
        end
        local averages = guideData.statAverages and guideData.statAverages.archon
        if averages then
            txt = txt .. "\n|cffffff00=== Archon Durchschnitte ===|r\n"
            for k, v in pairs(averages) do txt = txt .. k .. ": |cff00ff00" .. v .. "|r\n" end
        end
    end
    content.text:SetText(txt)
end

function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -10
    if title then
        content.text:SetText(title)
        yOffset = -30
    end

    if not self.listRows then self.listRows = {} end
    for _, row in ipairs(self.listRows) do row:Hide() end

    for i, item in ipairs(items) do
        local row = self.listRows[i]
        if not row then
            row = CreateFrame("Button", nil, content)
            row:SetSize(360, 26)
            row:SetFrameLevel(content:GetFrameLevel() + 10)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22)
            row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
            self.listRows[i] = row
        end

        row:SetPoint("TOPLEFT", 10, yOffset)
        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        local itemName = item.text or item.name or "Unbekannt"

        if item.itemId then texture = C_Item.GetItemIconByID(item.itemId) or texture
        elseif item.spellId then texture = C_Spell.GetSpellTexture(item.spellId) or texture end

        row.icon:SetTexture(texture)
        row.text:SetText(itemName)
        row:Show()
        yOffset = yOffset - 28
    end
end

function UI:DrawTrinkets(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.trinkets and guideData.trinkets.archon then
        local list = {}
        for _, t in ipairs(guideData.trinkets.archon) do table.insert(list, { name = string.format("[%s] %s", t.rank, t.name), itemId = t.itemId }) end
        self:Helper_DrawListWithIcons(content, list, "|cffffff00Top Trinkets (Archon):|r")
    else content.text:SetText("Keine Trinket-Daten gefunden.") end
end

function UI:DrawCrafting(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.crafting and guideData.crafting.wowhead then
        local txt = "|cffffff00Embellishments (Wowhead):|r\n"
        for _, emb in ipairs(guideData.crafting.wowhead.embellishments) do txt = txt .. "- " .. emb .. "\n" end
        content.text:SetText(txt)
    else content.text:SetText("Keine Crafting-Daten.") end
end

function UI:DrawRotation(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.rotation and guideData.rotation.wowhead then
        self:Helper_DrawListWithIcons(content, guideData.rotation.wowhead, "|cffffff00Prio-Liste (Wowhead):|r")
    else content.text:SetText("Keine Rotations-Daten.") end
end

function UI:DrawGear(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.bisGear and guideData.bisGear.wowhead then
        local list = {}
        for _, g in ipairs(guideData.bisGear.wowhead) do table.insert(list, { text = string.format("|cff00ff00%s:|r %s", g.slot, g.item), itemId = g.itemId }) end
        self:Helper_DrawListWithIcons(content, list, "|cffffff00Best-in-Slot (Wowhead):|r")
    else content.text:SetText("Keine Gear-Daten.") end
end

function UI:DrawEnchants(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.enchants and guideData.enchants.wowhead then
        local txt = "|cffffff00VZ & Steine (Wowhead):|r\n"
        for _, e in ipairs(guideData.enchants.wowhead) do txt = txt .. "- " .. e .. "\n" end
        content.text:SetText(txt)
    else content.text:SetText("Keine Daten.") end
end

DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end)
DragonSkill.UI = UI
