-- Dragon Skill - Haupt UI (v0.5.0) - Optimized for Retail 12.x
-- Baut das Hauptfenster mit Tabs auf und integriert Talente, Stats, Trinkets, Crafting, Rotation, Gear und Enchants.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants"}

function UI:Init()
    if DragonSkillMainFrame then return end

    -- Hauptfenster erstellen (Modernes Template)
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    if not f then return end

    self.frame = f
    f:SetSize(450, 550)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self) self:StartMoving() end)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    f:SetClampedToScreen(true)

    -- Titel setzen (Sicherer Weg für 12.x)
    if f.SetTitle then
        f:SetTitle("Dragon Skill v0.5")
    end

    -- Fallback für den Titel-Text
    local titleText = _G[f:GetName() .. "TitleText"] or (f.TitleContainer and f.TitleContainer.TitleText)
    if titleText and titleText.SetText then
        titleText:SetText("Dragon Skill v0.5")
    end

    -- Icon
    if f.portrait then
        f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    elseif f.PortraitContainer and f.PortraitContainer.portrait then
        f.PortraitContainer.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    end

    -- Initial verstecken
    f:Hide()

    -- Tab-System
    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "$parentTab"..i, f, "PanelTabButtonTemplate")
        tab:SetID(i)
        tab:SetText(name)
        tab:SetScript("OnClick", function(tabBtn) UI:SelectTab(tabBtn:GetID()) end)
        f.Tabs[i] = tab
        if i == 1 then
            tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 15, 2)
        else
            tab:SetPoint("LEFT", f.Tabs[i-1], "RIGHT", -15, 0)
        end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)

    -- Content Area
    local inset = f.Inset or _G[f:GetName() .. "Inset"]
    if inset then
        inset:SetPoint("TOPLEFT", 4, -60)
        inset:SetPoint("BOTTOMRIGHT", -6, 26)

        local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", inset, "UIPanelScrollFrameTemplate")
        scrollFrame:SetPoint("TOPLEFT", 8, -8)
        scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)

        local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
        content:SetSize(350, 1000)
        scrollFrame:SetScrollChild(content)
        f.Content = content
    else
        local content = CreateFrame("Frame", "DragonSkillContentFrame", f)
        content:SetPoint("TOPLEFT", 15, -60)
        content:SetPoint("BOTTOMRIGHT", -15, 30)
        f.Content = content
    end

    -- Slash Commands
    SLASH_DRAGONSKILL1 = "/ds"
    SLASH_DRAGONSKILL2 = "/dragonskill"
    SlashCmdList["DRAGONSKILL"] = function(msg)
        if msg == "testboss" then
            local BM = DragonSkill:GetModule("BossMechanics")
            if BM then BM:SimulateEntombedSentinels() end
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
        content.text:SetWidth(330)
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
            row:SetSize(330, 24)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(20, 20)
            row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 5, 0)
            self.listRows[i] = row
        end

        row:SetPoint("TOPLEFT", 10, yOffset)
        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        if item.icon then
            texture = item.icon
        elseif item.itemId then
            texture = C_Item.GetItemIconByID(item.itemId) or texture
        elseif item.spellId then
            texture = C_Spell.GetSpellTexture(item.spellId) or texture
        end
        row.icon:SetTexture(texture)
        row.text:SetText(item.text or item.name or "Unbekannt")

        row:SetScript("OnEnter", nil)
        row:SetScript("OnLeave", nil)
        row:SetScript("OnClick", nil)

        if item.itemId then
            row:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetItemByID(item.itemId)
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
            row:SetScript("OnClick", function()
                if IsShiftKeyDown() then
                    local _, link = GetItemInfo(item.itemId)
                    if not link then link = string.format("|Hitem:%d:::::::::|h[%s]|h", item.itemId, item.name or "Item") end
                    if link then HandleModifiedItemClick(link) end
                end
            end)
        elseif item.spellId then
            row:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetSpellByID(item.spellId)
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        end

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
            btn:SetSize(330, 25)
            self.talentBtns[i] = btn
        end
        btn:SetPoint("TOPLEFT", 10, yOffset)
        btn:SetText(string.format("[%s] %s", build.provider, build.label))
        btn:SetScript("OnClick", function()
            local current = TC:GetCurrentBuildString()
            if not current then
                print("|cffff0000Dragon Skill:|r Fehler - Kein aktiver Charakter-Build gefunden.")
                return
            end
            local result = TC:Compare(build.importString, current)
            if result then
                UI:ShowTalentDiff(build, result)
            else
                print("|cffff0000Dragon Skill:|r Fehler beim Build-Vergleich.")
            end
        end)
        btn:Show()
        yOffset = yOffset - 30
    end
end

function UI:ShowTalentDiff(build, result)
    local TC = DragonSkill:GetModule("TalentCompare")
    if not TC then print("|cffff0000Dragon Skill:|r Fehler - TalentCompare Modul nicht gefunden.") return end

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
    if not specIndex then
        content.text:SetText("Bitte wähle eine Spezialisierung.")
        return
    end
    local spec = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    local txt = "|cffffff00Stat-Vergleich:|r\n"

    -- Eigene Werte
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
            txt = txt .. "\n|cffffd100Archon Durchschnittswert (Vergleich):|r\n"
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
        table.insert(items, {
            name = string.format("[%s] %s", t.rank, t.name),
            itemId = t.itemId,
            icon = t.icon
        })
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

    local txt = "|cffffff00Empfohlene Embellishments (Wowhead):|r\n"
    for _, emb in ipairs(guideData.crafting.wowhead.embellishments) do
        txt = txt .. "- " .. emb .. "\n"
    end
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

    txt = txt .. "\n|cffffff00Empfohlene Edelsteine:|r\n"
    list = guideData and guideData.gems and guideData.gems.wowhead
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
