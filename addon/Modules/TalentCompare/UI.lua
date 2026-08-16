-- Dragon Skill - Haupt UI (v1.2.1)
-- Native Blizzard-Look UI mit reparierter Klick-Logik und 8-Tab Support.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants", "Buffs"}

function UI:Init()
    if DragonSkillMainFrame then return end

    -- Hauptfenster (Wieder zurück zum Blizzard Template)
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(450, 550)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self) self:StartMoving() end)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

    -- Titel & Portrait
    if f.SetTitle then f:SetTitle("Dragon Skill") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end

    -- Inset (Hintergrund-Bereich)
    if f.Inset then
        f.Inset:ClearAllPoints()
        f.Inset:SetPoint("TOPLEFT", 4, -60)
        f.Inset:SetPoint("BOTTOMRIGHT", -6, 28) -- Platz für Tabs unten
    end

    -- ScrollFrame im Inset
    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)
    scrollFrame:EnableMouse(true)

    -- Inhalts-Container
    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(380, 1500)
    scrollFrame:SetScrollChild(content)
    f.Content = content

    -- Tab-System (Schmaler für 8 Tabs)
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
        content.text:SetSpacing(3)
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
    local specIndex = GetSpecialization()
    if not specIndex then return end
    local specID = GetSpecializationInfo(specIndex)
    local guideData = DragonSkill.Database:GetGuideData(class, specID)

    if not guideData or not guideData.talentBuilds then
        content.text:SetText("Keine Guide-Daten für diese Spezialisierung gefunden.")
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
            btn:SetFrameLevel(content:GetFrameLevel() + 5)
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
        diffText = "\n\n|cff00ff00Dein Build ist identisch!|r"
    end

    -- WICHTIG: Blizzard Popups nutzen OnAccept (Button 1) und OnCancel (Button 2)
    StaticPopupDialogs["DRAGONSKILL_CHOICE"] = {
        text = "Build: " .. build.label .. " (" .. (result.similarity or 0) .. "% Übereinstimmung)" .. diffText .. "\n\nWas möchtest du tun?",
        button1 = "Kopieren (Strg+C)",
        button2 = "Direkt in WoW anlegen",
        button3 = "Abbrechen",
        OnAccept = function()
            -- Button 1: Kopieren
            StaticPopup_Show("DRAGONSKILL_STRG_C", nil, nil, build.importString)
        end,
        OnCancel = function(_, _, reason)
            -- Button 2: Direkt anlegen (Blizzard nutzt OnCancel für Button 2 bei button3-Popups)
            if reason == "clicked" then
                local name = build.label .. " (DragonSkill)"
                TC:ImportToWoW(build.importString, name)
            end
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }

    StaticPopupDialogs["DRAGONSKILL_STRG_C"] = {
        text = "Markierten Text mit Strg+C kopieren:",
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

    StaticPopup_Show("DRAGONSKILL_CHOICE")
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

        -- Cleanup Wowhead leftovers
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
