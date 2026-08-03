-- Dragon Skill - Haupt-UI
-- Fenster mit zwei Tabs: Talente (Vergleich + Import) und Stats (Prioritäten).
-- Titel/Rahmen/Close-Button werden bewusst NICHT über ButtonFrameTemplate
-- gebaut (dessen interne Regions wie TitleText ändern sich zwischen
-- Expansions/Patches - siehe Interface: 12.0.5) sondern manuell über die
-- stabilen Primitives BackdropTemplate + UIPanelCloseButton.

local frame = CreateFrame("Frame", "DragonSkillFrame", UIParent, "BackdropTemplate")
frame:SetSize(420, 480)
frame:SetPoint("CENTER")
frame:Hide()
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", 0, -14)
title:SetText("Dragon Skill")

local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", -4, -4)
closeBtn:SetScript("OnClick", function() frame:Hide() end)

-- ===== Tabs =====
local TAB_TALENTS = 1
local TAB_STATS = 2
frame.selectedTab = TAB_TALENTS

local tab1 = CreateFrame("Button", "DragonSkillFrameTab1", frame, "PanelTabButtonTemplate")
tab1:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 10, 2)
tab1:SetText("Talente")
PanelTemplates_TabResize(tab1, 0)

local tab2 = CreateFrame("Button", "DragonSkillFrameTab2", frame, "PanelTabButtonTemplate")
tab2:SetPoint("LEFT", tab1, "RIGHT", -14, 0)
tab2:SetText("Stats")
PanelTemplates_TabResize(tab2, 0)

PanelTemplates_SetNumTabs(frame, 2)

-- ===== Scroll-Content (gemeinsam genutzt, wird pro Tab neu befüllt) =====
local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 12, -36)
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 40)

local content = CreateFrame("Frame", nil, scrollFrame)
content:SetSize(360, 1)
scrollFrame:SetScrollChild(content)

local function ClearContent()
    for _, child in ipairs({ content:GetChildren() }) do
        child:Hide()
        child:SetParent(nil)
    end
end

-- ===== Tab 1: Talente =====
local function RenderTalentsTab()
    ClearContent()

    local _, classToken = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then
        local msg = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        msg:SetPoint("TOPLEFT", 4, -4)
        msg:SetText("Keine Spezialisierung gewählt.")
        return
    end
    local specID = GetSpecializationInfo(specIndex)

    local guideData = DragonSkill.Database:GetGuideData(classToken, specID)
    if not guideData or not guideData.talentBuilds or #guideData.talentBuilds == 0 then
        local msg = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        msg:SetPoint("TOPLEFT", 4, -4)
        msg:SetWidth(360)
        msg:SetJustifyH("LEFT")
        msg:SetText("Keine Guide-Daten geladen für diese Spec.\nFühre den Scraper aus und lade die Daten-Datei ins Addon.")
        return
    end

    local yOffset = -4
    local TalentCompare = DragonSkill:GetModule("TalentCompare")
    local currentString = TalentCompare:GetCurrentBuildString()

    for _, build in ipairs(guideData.talentBuilds) do
        local row = CreateFrame("Frame", nil, content)
        row:SetSize(360, 60)
        row:SetPoint("TOPLEFT", 0, yOffset)

        local label = row:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        label:SetPoint("TOPLEFT", 4, 0)
        local providerTag = build.provider == "archon" and "|cff66ccffArchon|r" or "|cffffcc00Wowhead|r"
        label:SetText(providerTag .. " " .. (build.context or "Build") .. (build.label and (" - " .. build.label) or ""))

        local result = TalentCompare:Compare(build.importString, currentString)
        local status = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        status:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -4)
        if result.identical then
            status:SetText("|cff44ff44Stimmt 100% mit deinem aktuellen Build überein|r")
        else
            status:SetText(string.format(
                "|cffffaa00%d%% Übereinstimmung (%d Abweichungen) - Klick zum Importieren|r",
                result.similarity or 0, result.diffCount or 0
            ))
        end

        local importBtn = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
        importBtn:SetSize(100, 22)
        importBtn:SetPoint("TOPRIGHT", 0, -2)
        importBtn:SetText("Kopieren")
        importBtn:SetScript("OnClick", function()
            StaticPopup_Show("DRAGONSKILL_COPY_IMPORT_STRING", nil, nil, build.importString)
        end)

        yOffset = yOffset - 64
    end

    content:SetHeight(math.abs(yOffset) + 10)
end

-- ===== Tab 2: Stats =====
local function RenderStatsTab()
    ClearContent()

    local StatPriority = DragonSkill:GetModule("StatPriority")
    local data, err = StatPriority:GetForCurrentSpec()

    if not data then
        local msg = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        msg:SetPoint("TOPLEFT", 4, -4)
        msg:SetWidth(360)
        msg:SetJustifyH("LEFT")
        msg:SetText(err or "Keine Daten verfügbar.")
        return
    end

    local yOffset = -4
    local providerOrder = { "wowhead", "archon" }
    local providerNames = { wowhead = "|cffffcc00Wowhead|r", archon = "|cff66ccffArchon|r" }

    for _, provider in ipairs(providerOrder) do
        local text = data[provider]
        if text and text ~= "" then
            local header = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            header:SetPoint("TOPLEFT", 4, yOffset)
            header:SetText(providerNames[provider])
            yOffset = yOffset - 22

            local body = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            body:SetPoint("TOPLEFT", 8, yOffset)
            body:SetWidth(344)
            body:SetJustifyH("LEFT")
            body:SetText(text)
            yOffset = yOffset - (body:GetStringHeight() + 20)
        end
    end

    if yOffset == -4 then
        local msg = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        msg:SetPoint("TOPLEFT", 4, -4)
        msg:SetText("Keine Stat-Prioritäten in den geladenen Daten gefunden.")
    end

    content:SetHeight(math.abs(yOffset) + 10)
end

local renderers = {
    [TAB_TALENTS] = RenderTalentsTab,
    [TAB_STATS] = RenderStatsTab
}

local function SelectTab(tabIndex)
    frame.selectedTab = tabIndex
    PanelTemplates_SetTab(frame, tabIndex)
    renderers[tabIndex]()
end

tab1:SetScript("OnClick", function() SelectTab(TAB_TALENTS) end)
tab2:SetScript("OnClick", function() SelectTab(TAB_STATS) end)

StaticPopupDialogs["DRAGONSKILL_COPY_IMPORT_STRING"] = {
    text = "Talent-Import-String (Strg+C zum Kopieren, dann in Blizzard Talent-UI einfügen):",
    button1 = "Schließen",
    hasEditBox = true,
    editBoxWidth = 350,
    OnShow = function(self, data)
        self.editBox:SetText(data)
        self.editBox:HighlightText()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

frame:SetScript("OnShow", function() SelectTab(frame.selectedTab) end)

SLASH_DRAGONSKILL1 = "/dragonskill"
SLASH_DRAGONSKILL2 = "/dskill"
SlashCmdList["DRAGONSKILL"] = function()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end
