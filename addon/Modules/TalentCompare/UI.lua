-- Dragon Skill - Haupt UI (v0.6.6) - Robust Reconstruction
-- Baut ein stabiles Fenster OHNE ButtonFrameTemplate, um Layout-Fehler zu vermeiden.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants"}

function UI:Init()
    if DragonSkillMainFrame then return end

    -- Hauptfenster (Eigenes Design für maximale Stabilität)
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "BackdropTemplate")
    f:SetSize(450, 550)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG") -- Sehr hohe Ebene
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)

    -- Hintergrund & Rand
    f:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    f:SetBackdropColor(0, 0, 0, 0.95)

    -- Titelzeile
    f.Header = f:CreateTexture(nil, "ARTWORK")
    f.Header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    f.Header:SetSize(256, 64)
    f.Header:SetPoint("TOP", 0, 12)

    f.Title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.Title:SetPoint("TOP", f.Header, "TOP", 0, -14)
    f.Title:SetText("Dragon Skill v0.6.6")

    -- Schließen-Button
    f.Close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    f.Close:SetPoint("TOPRIGHT", -5, -5)
    f.Close:SetScript("OnClick", function() f:Hide() end)

    -- Portrait (Oben links)
    f.Portrait = f:CreateTexture(nil, "OVERLAY")
    f.Portrait:SetSize(60, 60)
    f.Portrait:SetPoint("TOPLEFT", -10, 10)
    f.Portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")

    -- Content Bereich (Inset-Ersatz)
    local contentBg = CreateFrame("Frame", nil, f, "BackdropTemplate")
    contentBg:SetPoint("TOPLEFT", 15, -40)
    contentBg:SetPoint("BOTTOMRIGHT", -15, 60) -- Platz für Tabs unten
    contentBg:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    contentBg:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
    f.ContentBg = contentBg

    -- ScrollFrame für den Inhalt
    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", contentBg, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)
    scrollFrame:SetFrameLevel(f:GetFrameLevel() + 5)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(380, 1000)
    scrollFrame:SetScrollChild(content)
    f.Content = content

    -- Tab-System (Sauber unter dem Content-Bereich)
    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "$parentTab"..i, f, "CharacterFrameTabButtonTemplate")
        tab:SetID(i)
        tab:SetText(name)
        tab:SetScript("OnClick", function(self) UI:SelectTab(self:GetID()) end)
        f.Tabs[i] = tab
        if i == 1 then
            tab:SetPoint("TOPLEFT", contentBg, "BOTTOMLEFT", 0, -2)
        else
            tab:SetPoint("LEFT", f.Tabs[i-1], "RIGHT", -16, 0)
        end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)

    f:Hide()
    self.frame = f

    -- Slash Commands
    SLASH_DRAGONSKILL1 = "/ds"
    SLASH_DRAGONSKILL2 = "/dragonskill"
    SlashCmdList["DRAGONSKILL"] = function(msg)
        if msg == "testboss" then
            local BM = DragonSkill:GetModule("BossMechanics")
            if BM then BM:SimulateEntombedSentinels() end
        elseif msg == "testnekzali" then
            local BM = DragonSkill:GetModule("BossMechanics")
            if BM then BM:SimulateNekzali() end
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

    -- UI Reset
    local children = {content:GetChildren()}
    for _, child in ipairs(children) do child:Hide() end

    if not content.text then
        content.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        content.text:SetPoint("TOPLEFT", 10, -10)
        content.text:SetWidth(360)
        content.text:SetJustifyH("LEFT")
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
            row:SetSize(360, 24)
            row:SetFrameLevel(content:GetFrameLevel() + 2)
            row:EnableMouse(true)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(20, 20)
            row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 5, 0)
            self.listRows[i] = row
        end

        row:SetPoint("TOPLEFT", 10, yOffset)
        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        local itemName = item.text or item.name or "Unbekannt"
        local colorPrefix = ""

        if item.itemId then
            texture = C_Item.GetItemIconByID(item.itemId) or texture
            local name, _, quality = GetItemInfo(item.itemId)
            if name then
                itemName = name
                local _, _, _, argbHex = GetItemQualityColor(quality or 1)
                colorPrefix = "|c" .. argbHex
            end
        elseif item.spellId then
            texture = C_Spell.GetSpellTexture(item.spellId) or texture
            local spellInfo = C_Spell.GetSpellInfo(item.spellId)
            if spellInfo then itemName = spellInfo.name end
        end

        row.icon:SetTexture(texture)
        row.text:SetText(colorPrefix .. itemName .. "|r")

        row:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if item.itemId then GameTooltip:SetItemByID(item.itemId)
            elseif item.spellId then GameTooltip:SetSpellByID(item.spellId) end
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row:SetScript("OnClick", function()
            if IsShiftKeyDown() and item.itemId then
                local _, link = GetItemInfo(item.itemId)
                if link then HandleModifiedItemClick(link) end
            end
        end)

        row:Show()
        yOffset = yOffset - 26
    end
end

function UI:DrawTalents(content)
    local TC = DragonSkill:GetModule("TalentCompare")
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then content.text:SetText("Bitte wähle eine Spezialisierung.") return end
    local spec = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    if not guideData or not guideData.talentBuilds then
        content.text:SetText("Keine Guide-Daten gefunden.")
        return
    end

    local yOffset = -10
    if not self.talentBtns then self.talentBtns = {} end
    for _, btn in ipairs(self.talentBtns) do btn:Hide() end

    for i, build in ipairs(guideData.talentBuilds) do
        local btn = self.talentBtns[i]
        if not btn then
            btn = CreateFrame("Button", "DragonSkillBuildBtn"..i, content, "UIPanelButtonTemplate")
            btn:SetSize(360, 30)
            btn:SetFrameLevel(content:GetFrameLevel() + 5)
            btn:EnableMouse(true)
            self.talentBtns[i] = btn
        end
        btn:SetPoint("TOPLEFT", 10, yOffset)
        btn:SetText(string.format("[%s] %s", build.provider, build.label))
        btn:SetScript("OnClick", function()
            print("|cff00ff00Dragon Skill:|r Klick auf " .. build.label) -- Debug
            local current = TC:GetCurrentBuildString()
            if not current then return end
            local result = TC:Compare(build.importString, current)
            if result then UI:ShowTalentDiff(build, result) end
        end)
        btn:Show()
        yOffset = yOffset - 35
    end
end

function UI:ShowTalentDiff(build, result)
    local TC = DragonSkill:GetModule("TalentCompare")
    local detailed = TC:GetDetailedDiff(build.importString)

    local diffText = ""
    if detailed and #detailed > 0 then
        diffText = "\n\n|cffff0000Abweichungen:|r"
        for i = 1, math.min(#detailed, 8) do
            local d = detailed[i]
            diffText = diffText .. string.format("\n- %s (%d/%d -> %d/%d)", d.name, d.currentRank, d.maxRank, d.importedRank, d.maxRank)
        end
        if #detailed > 8 then diffText = diffText .. "\n... und " .. (#detailed - 8) .. " weitere." end
    else
        diffText = "\n\n|cff00ff00Build ist identisch!|r"
    end

    StaticPopupDialogs["DRAGONSKILL_IMPORT"] = {
        text = "Build: " .. build.label .. " (" .. (result.similarity or 0) .. "% Übereinstimmung)" .. diffText .. "\n\nWillst du diesen Build importieren?",
        button1 = "Speichern",
        button2 = "Abbrechen",
        OnAccept = function()
            local db = DragonSkill.Database
            local name = db:GenerateAutoSkillingName(build)
            db:CreateSkilling(name, build)
            print("|cff00ff00Dragon Skill:|r Build gespeichert als: " .. name)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }
    StaticPopup_Show("DRAGONSKILL_IMPORT")
end

function UI:DrawStats(content)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local spec = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    local txt = "|cffffff00Stat-Vergleich:|r\n"
    local crit = GetCritChance()
    local haste = GetHaste()
    local mastery = GetMasteryEffect()
    local vers = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)

    txt = txt .. "\n|cffffd100Deine Werte:|r\n"
    txt = txt .. string.format("- Kritisch: |cffffffff%.1f%%|r\n", crit)
    txt = txt .. string.format("- Tempo: |cffffffff%.1f%%|r\n", haste)
    txt = txt .. string.format("- Meisterschaft: |cffffffff%.1f%%|r\n", mastery)
    txt = txt .. string.format("- Vielseitigkeit: |cffffffff%.1f%%|r\n", vers)

    if guideData then
        if guideData.statPriority then
            txt = txt .. "\n|cffffd100Wowhead Empfehlung:|r\n"
            txt = txt .. "|cffffffff" .. (guideData.statPriority.wowhead or "Keine Daten") .. "|r\n"
            if guideData.statPriority.archon then
                txt = txt .. "\n|cffffd100Archon Empfehlung:|r\n"
                txt = txt .. "|cffffffff" .. guideData.statPriority.archon .. "|r\n"
            end
        end
        local averages = guideData.statAverages and guideData.statAverages.archon
        if averages and next(averages) then
            txt = txt .. "\n|cffffd100Archon Durchschnittswert:|r\n"
            for sName, sVal in pairs(averages) do
                txt = txt .. string.format("- %s: |cff00ff00%s|r\n", sName, sVal)
            end
        end
    else
        txt = txt .. "\n|cffff0000Keine Guide-Daten geladen.|r"
    end
    content.text:SetText(txt)
end

function UI:DrawTrinkets(content)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local spec = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    if not guideData or not guideData.trinkets or not guideData.trinkets.archon then
        content.text:SetText("Keine Trinket-Daten gefunden.")
        return
    end

    local items = {}
    for _, t in ipairs(guideData.trinkets.archon) do
        table.insert(items, { name = string.format("[%s] %s", t.rank, t.name), itemId = t.itemId, icon = t.icon })
    end
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Archon Trinket Tier List:|r")
end

function UI:DrawCrafting(content)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local spec = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    if not guideData or not guideData.crafting or not guideData.crafting.wowhead then
        content.text:SetText("Keine Crafting-Daten gefunden.")
        return
    end

    local txt = "|cffffff00Empfohlene Embellishments:|r\n"
    for _, emb in ipairs(guideData.crafting.wowhead.embellishments) do txt = txt .. "- " .. emb .. "\n" end
    content.text:SetText(txt)
end

function UI:DrawRotation(content)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local spec = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    if not guideData or not guideData.rotation or not guideData.rotation.wowhead then
        content.text:SetText("Keine Rotations-Daten gefunden.")
        return
    end
    self:Helper_DrawListWithIcons(content, guideData.rotation.wowhead, "|cffffff00Rotations-Priorität:|r")
end

function UI:DrawGear(content)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local spec = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    local txt = "|cffffff00Best-in-Slot Gear (Wowhead):|r\n\n"
    local gear = guideData and guideData.bisGear and guideData.bisGear.wowhead
    if gear and #gear > 0 then
        for _, item in ipairs(gear) do
            txt = txt .. string.format("|cff00ff00%s:|r %s\n|cff888888Quelle: %s|r\n\n", item.slot, item.item, item.source)
        end
    else
        txt = txt .. "Keine Gear-Daten verfügbar."
    end
    content.text:SetText(txt)
end

function UI:DrawEnchants(content)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local spec = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    local txt = "|cffffff00Empfohlene Verzauberungen:|r\n"
    local list = guideData and guideData.enchants and guideData.enchants.wowhead
    if list and #list > 0 then
        for _, v in ipairs(list) do txt = txt .. "- " .. v .. "\n" end
    else
        txt = txt .. "Keine Daten.\n"
    end
    content.text:SetText(txt)
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
end)

DragonSkill.UI = UI
