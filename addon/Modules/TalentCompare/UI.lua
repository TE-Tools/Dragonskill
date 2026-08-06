-- Dragon Skill - Haupt UI (v0.4.2) - Optimized for Retail 12.x
-- Baut das Hauptfenster mit Tabs auf und integriert Talente, Stats, Trinkets, Crafting und Rotation.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants"}

function UI:Init()
    if DragonSkillMainFrame then return end

    -- Hauptfenster erstellen (Modernes Template)
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    if not f then return end

    self.frame = f
    f:SetSize(450, 550) -- Etwas breiter und höher
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self) self:StartMoving() end)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    f:SetClampedToScreen(true)

    -- Titel setzen (Sicherer Weg für 12.x)
    if f.SetTitle then
        f:SetTitle("Dragon Skill v0.4")
    end

    -- Fallback für den Titel-Text
    local titleText = _G[f:GetName() .. "TitleText"] or (f.TitleContainer and f.TitleContainer.TitleText)
    if titleText and titleText.SetText then
        titleText:SetText("Dragon Skill v0.4")
    end

    -- Icon
    if f.portrait then
        f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    elseif f.PortraitContainer and f.PortraitContainer.portrait then
        f.PortraitContainer.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    end

    -- Initial verstecken (Verhindert Auto-Open Bug)
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
        inset:SetPoint("TOPLEFT", 4, -60) -- Mehr Platz oben für Titel/Portrait
        inset:SetPoint("BOTTOMRIGHT", -6, 26) -- Platz unten für Tabs

        local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", inset, "UIPanelScrollFrameTemplate")
        scrollFrame:SetPoint("TOPLEFT", 8, -8)
        scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(350, 1000) -- Viel Platz für Content
    scrollFrame:SetScrollChild(content)
    f.Content = content

    -- Slash Commands
    SLASH_DRAGONSKILL1 = "/ds"
    SLASH_DRAGONSKILL2 = "/dragonskill"
    SlashCmdList["DRAGONSKILL"] = function()
        if f:IsShown() then
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

    -- Routing zu den Modulen
    if currentTab == 1 then self:DrawTalents(content)
    elseif currentTab == 2 then self:DrawStats(content)
    elseif currentTab == 3 then self:DrawTrinkets(content)
    elseif currentTab == 4 then self:DrawCrafting(content)
    elseif currentTab == 5 then self:DrawRotation(content)
    elseif currentTab == 6 then self:DrawGear(content)
    elseif currentTab == 7 then self:DrawEnchants(content)
    end
end

-- Hilfsfunktion für Listen (Items/Spells)
function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -10
    if title then
        content.text:SetText(title)
        yOffset = -30
    end

    for i, item in ipairs(items) do
        local row = CreateFrame("Button", nil, content)
        row:SetSize(330, 24)
        row:SetPoint("TOPLEFT", 10, yOffset)

        local icon = row:CreateTexture(nil, "ARTWORK")
        icon:SetSize(20, 20)
        icon:SetPoint("LEFT", 0, 0)

        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        if item.icon then
            texture = item.icon
        elseif item.itemId then
            texture = C_Item.GetItemIconByID(item.itemId) or texture
        elseif item.spellId then
            texture = C_Spell.GetSpellTexture(item.spellId) or texture
        end
        icon:SetTexture(texture)

        local text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("LEFT", icon, "RIGHT", 5, 0)
        text:SetText(item.text or item.name or "Unbekannt")

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
    for i, build in ipairs(guideData.talentBuilds) do
        local btn = CreateFrame("Button", "DragonSkillBuildBtn"..i, content, "UIPanelButtonTemplate")
        btn:SetSize(330, 25)
        btn:SetPoint("TOPLEFT", 10, yOffset)
        btn:SetText(string.format("[%s] %s", build.provider, build.label))

        btn:SetScript("OnClick", function()
            local result = TC:Compare(build.importString, TC:GetCurrentBuildString())
            UI:ShowTalentDiff(build, result)
        end)
        btn:Show()
        yOffset = yOffset - 30
    end
end

function UI:ShowTalentDiff(build, result)
    local TC = DragonSkill:GetModule("TalentCompare")
    local detailed = TC:GetDetailedDiff(build.importString)

    local diffText = ""
    if detailed and #detailed > 0 then
        diffText = "\n\n|cffff0000Abweichungen:|r"
        for i = 1, math.min(#detailed, 5) do
            local d = detailed[i]
            diffText = diffText .. string.format("\n- %s (%d/%d -> %d/%d)", d.name, d.currentRank, d.maxRank, d.importedRank, d.maxRank)
        end
        if #detailed > 5 then diffText = diffText .. "\n... und " .. (#detailed - 5) .. " weitere." end
    end

    StaticPopupDialogs["DRAGONSKILL_IMPORT"] = {
        text = "Build: " .. build.label .. " (" .. (result.similarity or 0) .. "% Übereinstimmung)" .. diffText .. "\n\nWillst du diesen Build importieren?",
        button1 = "Importieren & Speichern",
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

    local txt = "|cffffff00Stat-Prioritäten:|r\n"
    if guideData and guideData.statPriority then
        for k, v in pairs(guideData.statPriority) do
            txt = txt .. "|cff00ff00" .. k .. ":|r " .. v .. "\n"
        end
    end

    txt = txt .. "\n|cffffff00Durchschnittswerte (Archon):|r\n"
    local averages = guideData and guideData.statAverages and guideData.statAverages.archon
    if averages then
        for sName, sVal in pairs(averages) do
            txt = txt .. string.format("%s: %s\n", sName, sVal)
        end
    else
        txt = txt .. "Keine Durchschnitts-Daten verfügbar.\n"
    end

    txt = txt .. "\n|cffffff00Deine Werte:|r\n"
    local crit = GetCritChance()
    local haste = GetHaste()
    local mastery = GetMasteryEffect()
    local vers = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)

    txt = txt .. string.format("Crit: %.1f%%\nHaste: %.1f%%\nMastery: %.1f%%\nVers: %.1f%%", crit, haste, mastery, vers)
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

-- Globaler Event Listener
DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
end)

DragonSkill.UI = UI
