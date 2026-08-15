-- Dragon Skill - Haupt UI (v0.8.1)
-- Nutzt wieder das Blizzard ButtonFrameTemplate für einen nativen Look.

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
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self) self:StartMoving() end)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    f:SetClampedToScreen(true)

    -- Titel & Icon
    if f.SetTitle then f:SetTitle("Dragon Skill") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end

    -- Inset anpassen, damit es die Tabs unten NICHT überlappt
    if f.Inset then
        f.Inset:SetPoint("TOPLEFT", 4, -60)
        f.Inset:SetPoint("BOTTOMRIGHT", -6, 28) -- Genug Platz für Tabs unten
    end

    -- ScrollFrame
    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(380, 1000)
    scrollFrame:SetScrollChild(content)
    f.Content = content

    -- Tab-System (Blizzard Style)
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
        elseif msg == "testexplorers" then
            local BM = DragonSkill:GetModule("BossMechanics")
            if BM then BM:SimulateLostExplorers() end
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

function UI:DrawTalents(content)
    local TC = DragonSkill:GetModule("TalentCompare")
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then content.text:SetText("Bitte wähle eine Spezialisierung.") return end
    local _, specName, _, _, _, _, _ = GetSpecializationInfo(specIndex)
    local specID = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)

    if not guideData or not guideData.talentBuilds then
        content.text:SetText("Keine Guide-Daten für " .. (specName or "Spec") .. " gefunden.")
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
        yOffset = yOffset - 35
    end
end

function UI:ShowImportDialog(build, result)
    local TC = DragonSkill:GetModule("TalentCompare")
    local detailed = TC:GetDetailedDiff(build.importString)

    local diffText = ""
    if detailed and #detailed > 0 then
        diffText = "\n\n|cffff0000Abweichungen:|r"
        for i = 1, math.min(#detailed, 5) do
            local d = detailed[i]
            diffText = diffText .. string.format("\n- %s (%d/%d -> %d/%d)", d.name, d.currentRank, d.maxRank, d.importedRank, d.maxRank)
        end
    else
        diffText = "\n\n|cff00ff00Dein Build ist identisch!|r"
    end

    StaticPopupDialogs["DRAGONSKILL_COPY"] = {
        text = "Build: " .. build.label .. " (" .. (result.similarity or 0) .. "% Match)" .. diffText .. "\n\nKopiere den String unten (Strg+C):",
        button1 = "Fertig",
        hasEditBox = 1,
        OnShow = function(self)
            self.editBox:SetText(build.importString or "")
            self.editBox:SetFocus()
            self.editBox:HighlightText()
        end,
        OnAccept = function()
            local db = DragonSkill.Database
            local name = db:GenerateAutoSkillingName(build)
            db:CreateSkilling(name, build)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }
    StaticPopup_Show("DRAGONSKILL_COPY")
end

function UI:DrawStats(content)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local specID = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)

    local txt = "|cffffff00Stat-Vergleich:|r\n"
    txt = txt .. string.format("- Kritisch: %.1f%%\n- Tempo: %.1f%%\n- Meisterschaft: %.1f%%\n- Vielseitigkeit: %.1f%%\n", GetCritChance(), GetHaste(), GetMasteryEffect(), GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE))

    if guideData then
        if guideData.statPriority then
            txt = txt .. "\n|cffffd100Wowhead:|r " .. (guideData.statPriority.wowhead or "N/A")
            txt = txt .. "\n|cffffd100Archon:|r " .. (guideData.statPriority.archon or "N/A")
        end
        local averages = guideData.statAverages and guideData.statAverages.archon
        if averages then
            txt = txt .. "\n\n|cffffd100Archon Durchschnitte:|r\n"
            for k, v in pairs(averages) do txt = txt .. "- " .. k .. ": " .. v .. "\n" end
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
            row:SetSize(360, 24)
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

        if item.itemId then
            texture = C_Item.GetItemIconByID(item.itemId) or texture
        elseif item.spellId then
            texture = C_Spell.GetSpellTexture(item.spellId) or texture
        end

        row.icon:SetTexture(texture)
        row.text:SetText(itemName)
        row:Show()
        yOffset = yOffset - 26
    end
end

function UI:DrawTrinkets(content)
    local _, class = UnitClass("player")
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)
    if guideData and guideData.trinkets and guideData.trinkets.archon then
        local items = {}
        for _, t in ipairs(guideData.trinkets.archon) do
            table.insert(items, { name = string.format("[%s] %s", t.rank, t.name), itemId = t.itemId })
        end
        self:Helper_DrawListWithIcons(content, items, "|cffffff00Archon Trinkets:|r")
    else
        content.text:SetText("Keine Trinket-Daten.")
    end
end

function UI:DrawCrafting(content)
    local _, class = UnitClass("player")
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)
    if guideData and guideData.crafting and guideData.crafting.wowhead then
        local txt = "|cffffff00Embellishments:|r\n"
        for _, emb in ipairs(guideData.crafting.wowhead.embellishments) do txt = txt .. "- " .. emb .. "\n" end
        content.text:SetText(txt)
    else
        content.text:SetText("Keine Crafting-Daten.")
    end
end

function UI:DrawRotation(content)
    local _, class = UnitClass("player")
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)
    if guideData and guideData.rotation and guideData.rotation.wowhead then
        self:Helper_DrawListWithIcons(content, guideData.rotation.wowhead, "|cffffff00Rotation:|r")
    else
        content.text:SetText("Keine Rotations-Daten.")
    end
end

function UI:DrawGear(content)
    local _, class = UnitClass("player")
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)
    if guideData and guideData.bisGear and guideData.bisGear.wowhead then
        local items = {}
        for _, g in ipairs(guideData.bisGear.wowhead) do
            table.insert(items, { text = string.format("%s: %s", g.slot, g.item), itemId = g.itemId })
        end
        self:Helper_DrawListWithIcons(content, items, "|cffffff00BiS Gear:|r")
    else
        content.text:SetText("Keine Gear-Daten.")
    end
end

function UI:DrawEnchants(content)
    local _, class = UnitClass("player")
    local spec = GetSpecializationInfo(GetSpecialization())
    local guideData = DragonSkill.Database:GetGuideData(class, spec)
    if guideData and guideData.enchants then
        local txt = "|cffffff00Enchants:|r\n"
        for _, e in ipairs(guideData.enchants.wowhead or {}) do txt = txt .. "- " .. e .. "\n" end
        content.text:SetText(txt)
    else
        content.text:SetText("Keine Daten.")
    end
end

DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end)
DragonSkill.UI = UI
