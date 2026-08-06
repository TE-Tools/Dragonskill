-- Dragon Skill - Haupt UI
-- Baut das Hauptfenster mit Tabs auf und integriert Talent-Vergleich sowie Stats.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Gear", "Enchants", "Consumables"}

function UI:Init()
    if DragonSkillMainFrame then return end

    -- Hauptfenster
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(400, 500)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)

    f.TitleText:SetText("Dragon Skill")
    f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")

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
    local scrollFrame = CreateFrame("ScrollFrame", "$parentScroll", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)

    local content = CreateFrame("Frame", "$parentContent", scrollFrame)
    content:SetSize(350, 400)
    scrollFrame:SetScrollChild(content)
    f.Content = content

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
    local content = self.frame.Content
    -- Clear content
    for _, child in ipairs({content:GetChildren()}) do child:Hide() end
    if content.text then content.text:SetText("") end

    if not content.text then
        content.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        content.text:SetPoint("TOPLEFT", 10, -10)
        content.text:SetWidth(330)
        content.text:SetJustifyH("LEFT")
    end

    if currentTab == 1 then
        self:DrawTalents(content)
    elseif currentTab == 2 then
        self:DrawStats(content)
    else
        content.text:SetText("Modul '" .. tabs[currentTab] .. "' noch in Arbeit.")
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

DragonSkill.Events:On("PLAYER_LOGIN", function()
    UI:Init()
end)

DragonSkill.UI = UI
