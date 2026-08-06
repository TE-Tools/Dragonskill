-- Dragon Skill - Haupt UI (v0.4)
-- Baut das Hauptfenster mit Tabs auf und integriert Talente, Stats, Trinkets, Crafting und Rotation.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants"}

function UI:Init()
    if DragonSkillMainFrame then return end

    -- Hauptfenster
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    if not f then
        print("|cffff0000Dragon Skill Fehler:|r Konnte Hauptfenster nicht erstellen.")
        return
    end
    self.frame = f

    f:SetSize(400, 500)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)

    -- Robuste Titel-Setzung für Retail (11.0+)
    local title = f.SetTitle and f or f.TitleText or (f.TitleContainer and f.TitleContainer.TitleText)
    if title and title.SetText then
        title:SetText("Dragon Skill v0.4")
    elseif f.SetTitle then
        f:SetTitle("Dragon Skill v0.4")
    end

    if f.portrait then
        f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    end

    f:Hide()
    self.frame = f

    -- Tab-System
    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "$parentTab"..i, f, "PanelTabButtonTemplate")
        tab:SetID(i)
        tab:SetText(name)
        tab:SetScript("OnClick", function(self) UI:SelectTab(self:GetID()) end)
        f.Tabs[i] = tab
        if i == 1 then
            tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 15, 1)
        else
            tab:SetPoint("LEFT", f.Tabs[i-1], "RIGHT", -16, 0)
        end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)

    -- Content Area
    local inset = f.Inset or _G[f:GetName() .. "Inset"]
    if inset then
        local scrollFrame = CreateFrame("ScrollFrame", "$parentScroll", inset, "UIPanelScrollFrameTemplate")
        scrollFrame:SetPoint("TOPLEFT", 8, -8)
        scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)

        local content = CreateFrame("Frame", "$parentContent", scrollFrame)
        content:SetSize(350, 400)
        scrollFrame:SetScrollChild(content)
        f.Content = content
    else
        -- Fallback falls Inset nicht existiert
        local content = CreateFrame("Frame", "$parentContent", f)
        content:SetPoint("TOPLEFT", 15, -60)
        content:SetPoint("BOTTOMRIGHT", -15, 30)
        f.Content = content
    end

    -- Slash Commands
    SLASH_DRAGONSKILL1 = "/ds"
    SLASH_DRAGONSKILL2 = "/dragonskill"
    SlashCmdList["DRAGONSKILL"] = function()
        if f:IsShown() then f:Hide() else f:Show() UI:Update() end
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

    -- Clear content children
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

    if currentTab == 1 then
        self:DrawTalents(content)
    elseif currentTab == 2 then
        self:DrawStats(content)
    elseif currentTab == 3 then
        self:DrawTrinkets(content)
    elseif currentTab == 4 then
        self:DrawCrafting(content)
    elseif currentTab == 5 then
        self:DrawRotation(content)
    else
        content.text:SetText("Modul '" .. tabs[currentTab] .. "' noch in Arbeit.")
    end
end

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
            texture = GetItemIcon(item.itemId)
        elseif item.spellId then
            texture = C_Spell.GetSpellTexture(item.spellId)
        end
        icon:SetTexture(texture)

        local text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("LEFT", icon, "RIGHT", 5, 0)
        text:SetText(item.text or item.name)

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
                    if not link then
                        -- Falls Item nicht im Cache, versuche Link zu bauen
                        link = string.format("|Hitem:%d:::::::::|h[%s]|h", item.itemId, item.name or "Item")
                    end
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
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    if not guideData or not guideData.talentBuilds then
        content.text:SetText("Keine Guide-Daten gefunden.")
        return
    end

    local yOffset = -10
    for _, build in ipairs(guideData.talentBuilds) do
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
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
        if #detailed > 5 then
            diffText = diffText .. "\n... und " .. (#detailed - 5) .. " weitere."
        end
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
    local spec = GetSpecializationInfo(GetSpecialization())
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
    local spec = GetSpecializationInfo(GetSpecialization())
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
    local spec = GetSpecializationInfo(GetSpecialization())
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
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)

    if not guideData or not guideData.rotation or not guideData.rotation.wowhead then
        content.text:SetText("Keine Rotations-Daten gefunden.")
        return
    end

    self:Helper_DrawListWithIcons(content, guideData.rotation.wowhead, "|cffffff00Rotations-Priorität:|r")
end

DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
end)

DragonSkill.UI = UI
