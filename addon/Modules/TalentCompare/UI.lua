-- Dragon Skill - Haupt UI (v1.1.0)
-- Baut ein stabiles Fenster mit direktem Import-Support für WoW 12.1.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants", "Buffs"}

function UI:Init()
    if DragonSkillMainFrame then return end

    -- Hauptfenster
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "BackdropTemplate")
    f:SetSize(450, 550)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    -- Hintergrund
    f:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    f:SetBackdropColor(0, 0, 0, 0.95)

    -- Header
    f.Header = f:CreateTexture(nil, "ARTWORK")
    f.Header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    f.Header:SetSize(256, 64)
    f.Header:SetPoint("TOP", 0, 12)
    f.Title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.Title:SetPoint("TOP", f.Header, "TOP", 0, -14)
    f.Title:SetText("Dragon Skill v1.1.0")

    f.Close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    f.Close:SetPoint("TOPRIGHT", -5, -5)
    f.Close:SetScript("OnClick", function() f:Hide() end)

    -- Content Area
    local contentBg = CreateFrame("Frame", nil, f, "BackdropTemplate")
    contentBg:SetPoint("TOPLEFT", 15, -45)
    contentBg:SetPoint("BOTTOMRIGHT", -15, 65)
    contentBg:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    contentBg:SetBackdropColor(0.1, 0.1, 0.1, 0.8)

    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", contentBg, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)
    scrollFrame:SetFrameLevel(contentBg:GetFrameLevel() + 5)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(380, 1500)
    scrollFrame:SetScrollChild(content)
    f.Content = content

    -- Tabs (CharFrame Style)
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
        local BM = DragonSkill:GetModule("BossMechanics")
        if msg == "testboss" then if BM then BM:SimulateEntombedSentinels() end
        elseif msg == "testnekzali" then if BM then BM:SimulateNekzali() end
        elseif msg == "testexplorers" then if BM then BM:SimulateLostExplorers() end
        elseif msg == "testvashnik" then if BM then BM:SimulateVashnik() end
        elseif msg == "testsszorak" then if BM then BM:SimulateSszorak() end
        elseif msg == "testfangs" then if BM then BM:SimulateTwinFangs() end
        elseif msg == "testaltar" then if BM then BM:SimulateCoiledAltar() end
        elseif msg == "testulatek" then if BM then BM:SimulateUlatek() end
        elseif f:IsShown() then f:Hide()
        else f:Show(); UI:Update() end
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

    if currentTab == 1 then self:DrawTalents(content)
    elseif currentTab == 2 then self:DrawStats(content)
    elseif currentTab == 3 then self:DrawTrinkets(content)
    elseif currentTab == 4 then self:DrawCrafting(content)
    elseif currentTab == 5 then self:DrawRotation(content)
    elseif currentTab == 6 then self:DrawGear(content)
    elseif currentTab == 7 then self:DrawEnchants(content)
    elseif currentTab == 8 then self:DrawBuffs(content)
    end
end

function UI:DrawTalents(content)
    local TC = DragonSkill:GetModule("TalentCompare")
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)

    if not guideData or not guideData.talentBuilds then
        content.text:SetText("Keine Guide-Daten gefunden.")
        return
    end

    if not self.talentBtns then self.talentBtns = {} end
    for _, btn in ipairs(self.talentBtns) do btn:Hide() end

    local yOffset = -10
    for i, build in ipairs(guideData.talentBuilds) do
        local btn = self.talentBtns[i]
        if not btn then
            btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            btn:SetSize(360, 32)
            btn:SetFrameLevel(content:GetFrameLevel() + 20)
            self.talentBtns[i] = btn
        end
        btn:SetPoint("TOPLEFT", 10, yOffset)
        btn:SetText(string.format("[%s] %s", build.provider:upper(), build.label))
        btn:SetScript("OnClick", function()
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
        diffText = "\n\n|cff00ff00Build ist identisch!|r"
    end

    StaticPopupDialogs["DRAGONSKILL_ACTION"] = {
        text = "Build: " .. build.label .. " (" .. (result.similarity or 0) .. "% Match)" .. diffText .. "\n\nWas möchtest du tun?",
        button1 = "Kopieren (Strg+C)",
        button2 = "Direkt in WoW anlegen",
        button3 = "Abbrechen",
        OnButton1 = function()
            StaticPopup_Show("DRAGONSKILL_COPY_STRG", nil, nil, build.importString)
        end,
        OnButton2 = function()
            local name = build.label .. " (DragonSkill)"
            TC:ImportToWoW(build.importString, name)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }

    StaticPopupDialogs["DRAGONSKILL_COPY_STRG"] = {
        text = "Kopiere den String mit Strg+C:",
        button1 = "Fertig",
        hasEditBox = 1,
        OnShow = function(self, data)
            self.editBox:SetText(data or "")
            self.editBox:SetFocus()
            self.editBox:HighlightText()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }

    StaticPopup_Show("DRAGONSKILL_ACTION")
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
            txt = txt .. "|cffffd100Wowhead:|r " .. (guideData.statPriority.wowhead or "N/A") .. "\n"
            if guideData.statPriority.archon then
                txt = txt .. "|cffffd100Archon:|r " .. (guideData.statPriority.archon or "N/A") .. "\n"
            end
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
            row:SetFrameLevel(content:GetFrameLevel() + 15)
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

        -- BBCode Bereinigung (Wowhead Guide Reste)
        itemName = itemName:gsub("%[url[^%]]*%]", ""):gsub("%[/url%]", "")
        itemName = itemName:gsub("%[item=%d+[^%]]*%]", ""):gsub("%[/item%]", "")
        itemName = itemName:gsub("%[b%]", ""):gsub("%[/b%]", "")
        itemName = itemName:trim()

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
    if guideData and guideData.trinkets and guideData.trinkets.archon and #guideData.trinkets.archon > 0 then
        local list = {}
        for _, t in ipairs(guideData.trinkets.archon) do table.insert(list, { name = string.format("[%s] %s", t.rank, t.name), itemId = t.itemId }) end
        self:Helper_DrawListWithIcons(content, list, "|cffffff00Top Trinkets (Archon):|r")
    else content.text:SetText("Keine Trinket-Daten gefunden.") end
end

function UI:DrawCrafting(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.crafting and guideData.crafting.wowhead and #guideData.crafting.wowhead.embellishments > 0 then
        local txt = "|cffffff00Embellishments (Wowhead):|r\n"
        for _, emb in ipairs(guideData.crafting.wowhead.embellishments) do txt = txt .. "- " .. emb .. "\n" end
        content.text:SetText(txt)
    else content.text:SetText("Keine Crafting-Daten.") end
end

function UI:DrawRotation(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.rotation and guideData.rotation.wowhead and #guideData.rotation.wowhead > 0 then
        self:Helper_DrawListWithIcons(content, guideData.rotation.wowhead, "|cffffff00Prio-Liste (Wowhead):|r")
    else content.text:SetText("Keine Rotations-Daten.") end
end

function UI:DrawGear(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.bisGear and guideData.bisGear.wowhead and #guideData.bisGear.wowhead > 0 then
        local list = {}
        for _, g in ipairs(guideData.bisGear.wowhead) do
            -- Filter Header Rows
            if g.slot:lower() ~= "slot" then
                table.insert(list, { text = string.format("|cff00ff00%s:|r %s", g.slot, g.item), itemId = g.itemId })
            end
        end
        self:Helper_DrawListWithIcons(content, list, "|cffffff00Best-in-Slot (Wowhead):|r")
    else content.text:SetText("Keine Gear-Daten.") end
end

function UI:DrawEnchants(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.enchants and guideData.enchants.wowhead and #guideData.enchants.wowhead > 0 then
        local txt = "|cffffff00VZ & Steine (Wowhead):|r\n"
        for _, e in ipairs(guideData.enchants.wowhead) do txt = txt .. "- " .. e .. "\n" end
        content.text:SetText(txt)
    else content.text:SetText("Keine Daten.") end
end

function UI:DrawBuffs(content)
    local _, class = UnitClass("player")
    local specID = GetSpecializationInfo(GetSpecialization() or 0)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if guideData and guideData.consumables and guideData.consumables.wowhead and #guideData.consumables.wowhead > 0 then
        local txt = "|cffffff00Empfohlene Buffs (Wowhead):|r\n"
        for _, c in ipairs(guideData.consumables.wowhead) do txt = txt .. "- " .. c .. "\n" end
        content.text:SetText(txt)
    else content.text:SetText("Keine Buff-Daten gefunden.") end
end

DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end)
DragonSkill.UI = UI
