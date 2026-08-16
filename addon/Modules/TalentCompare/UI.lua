-- Dragon Skill - Haupt UI (v1.2.3)
-- Native Blizzard-Look mit robusterer Fehlerbehandlung und direktem Daten-Feedback.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants", "Buffs"}

function UI:Init()
    if DragonSkillMainFrame then return end

    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(450, 550)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self) self:StartMoving() end)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

    if f.SetTitle then f:SetTitle("Dragon Skill") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end

    if f.Inset then
        f.Inset:ClearAllPoints()
        f.Inset:SetPoint("TOPLEFT", 4, -60)
        f.Inset:SetPoint("BOTTOMRIGHT", -6, 28)
    end

    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -25, 8)
    scrollFrame:EnableMouse(true)

    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(380, 1500)
    content:EnableMouse(true)
    scrollFrame:SetScrollChild(content)
    f.Content = content

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

    SLASH_DRAGONSKILL1 = "/ds"
    SLASH_DRAGONSKILL2 = "/dragonskill"
    SlashCmdList["DRAGONSKILL"] = function(msg)
        if f:IsShown() then f:Hide()
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

    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and GetSpecializationInfo(specIndex) or 0

    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if not guideData then
        content.text:SetText("|cffff0000Fehler:|r Keine Daten für " .. tostring(class) .. " (Spec ID " .. tostring(specID) .. ") gefunden.\nBitte /reload nutzen.")
        return
    end

    if currentTab == 1 then self:DrawTalents(content, guideData)
    elseif currentTab == 2 then self:DrawStats(content, guideData)
    elseif currentTab == 3 then self:DrawTrinkets(content, guideData)
    elseif currentTab == 4 then self:DrawCrafting(content, guideData)
    elseif currentTab == 5 then self:DrawRotation(content, guideData)
    elseif currentTab == 6 then self:DrawGear(content, guideData)
    elseif currentTab == 7 then self:DrawEnchants(content, guideData)
    elseif currentTab == 8 then self:DrawBuffs(content, guideData)
    end
end

function UI:DrawTalents(content, guideData)
    local TC = DragonSkill:GetModule("TalentCompare")
    if not guideData.talentBuilds then return end

    if not self.talentBtns then self.talentBtns = {} end
    for _, btn in ipairs(self.talentBtns) do btn:Hide() end

    local yOffset = -10
    for i, build in ipairs(guideData.talentBuilds) do
        local btn = self.talentBtns[i]
        if not btn then
            btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            btn:SetSize(360, 32)
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
        for i = 1, math.min(#detailed, 5) do
            local d = detailed[i]
            diffText = diffText .. string.format("\n- %s (%d/%d -> %d/%d)", d.name, d.currentRank, d.maxRank, d.importedRank, d.maxRank)
        end
    else
        diffText = "\n\n|cff00ff00Dein Build ist identisch!|r"
    end

    StaticPopupDialogs["DRAGONSKILL_ACTION_V3"] = {
        text = "Build: " .. build.label .. " (" .. (result.similarity or 0) .. "% Match)" .. diffText .. "\n\nWas möchtest du tun?",
        button1 = "Kopieren",
        button2 = "Direkt anlegen",
        button3 = "Abbrechen",
        OnAccept = function() StaticPopup_Show("DRAGONSKILL_COPY_V4", nil, nil, build.importString) end,
        OnCancel = function(_, _, reason)
            if reason == "clicked" then
                TC:ImportToWoW(build.importString, build.label)
            end
        end,
        timeout = 0, whileDead = true, hideOnEscape = true,
    }

    StaticPopupDialogs["DRAGONSKILL_COPY_V4"] = {
        text = "Kopiere den String mit Strg+C:",
        button1 = "Fertig",
        hasEditBox = 1,
        OnShow = function(self, data)
            self.editBox:SetText(data or "")
            self.editBox:SetFocus()
            self.editBox:HighlightText()
        end,
        timeout = 0, whileDead = true, hideOnEscape = true,
    }
    StaticPopup_Show("DRAGONSKILL_ACTION_V3")
end

function UI:DrawStats(content, guideData)
    local txt = "|cffffff00=== Deine Werte ===|r\n"
    txt = txt .. string.format("Tempo: %.1f%%\nKritisch: %.1f%%\nMeisterschaft: %.1f%%\nVielseitigkeit: %.1f%%\n", GetHaste(), GetCritChance(), GetMasteryEffect(), GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE))
    if guideData.statPriority then
        txt = txt .. "\n|cffffff00=== Empfehlung ===|r\n"
        txt = txt .. "|cffffd100Wowhead:|r " .. (guideData.statPriority.wowhead or "N/A") .. "\n"
        if guideData.statPriority.archon then
            txt = txt .. "|cffffd100Archon:|r " .. (guideData.statPriority.archon or "N/A") .. "\n"
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
        itemName = itemName:gsub("%[url[^%]]*%]", ""):gsub("%[/url%]", ""):gsub("%[item=%d+[^%]]*%]", ""):gsub("%[/item%]", ""):gsub("%[b%]", ""):gsub("%[/b%]", ""):trim()
        if item.itemId then texture = C_Item.GetItemIconByID(item.itemId) or texture
        elseif item.spellId then texture = C_Spell.GetSpellTexture(item.spellId) or texture end
        row.icon:SetTexture(texture)
        row.text:SetText(itemName)
        row:Show()
        yOffset = yOffset - 28
    end
end

function UI:DrawTrinkets(content, guideData)
    if guideData.trinkets and guideData.trinkets.archon and #guideData.trinkets.archon > 0 then
        local list = {}
        for _, t in ipairs(guideData.trinkets.archon) do table.insert(list, { name = string.format("[%s] %s", t.rank, t.name), itemId = t.itemId }) end
        self:Helper_DrawListWithIcons(content, list, "|cffffff00Top Trinkets (Archon):|r")
    else content.text:SetText("Keine Trinket-Daten gefunden.") end
end

function UI:DrawCrafting(content, guideData)
    if guideData.crafting and guideData.crafting.wowhead and #guideData.crafting.wowhead.embellishments > 0 then
        local txt = "|cffffff00Embellishments (Wowhead):|r\n"
        for _, emb in ipairs(guideData.crafting.wowhead.embellishments) do txt = txt .. "- " .. emb .. "\n" end
        content.text:SetText(txt)
    else content.text:SetText("Keine Crafting-Daten.") end
end

function UI:DrawRotation(content, guideData)
    if guideData.rotation and guideData.rotation.wowhead and #guideData.rotation.wowhead > 0 then
        self:Helper_DrawListWithIcons(content, guideData.rotation.wowhead, "|cffffff00Prio-Liste (Wowhead):|r")
    else content.text:SetText("Keine Rotations-Daten.") end
end

function UI:DrawGear(content, guideData)
    if guideData.bisGear and guideData.bisGear.wowhead and #guideData.bisGear.wowhead > 0 then
        local list = {}
        for _, g in ipairs(guideData.bisGear.wowhead) do
            if g.slot:lower() ~= "slot" then table.insert(list, { text = string.format("|cff00ff00%s:|r %s", g.slot, g.item), itemId = g.itemId }) end
        end
        self:Helper_DrawListWithIcons(content, list, "|cffffff00Best-in-Slot (Wowhead):|r")
    else content.text:SetText("Keine Gear-Daten.") end
end

function UI:DrawEnchants(content, guideData)
    if guideData.enchants and guideData.enchants.wowhead and #guideData.enchants.wowhead > 0 then
        local txt = "|cffffff00VZ & Steine (Wowhead):|r\n"
        for _, e in ipairs(guideData.enchants.wowhead) do txt = txt .. "- " .. e .. "\n" end
        content.text:SetText(txt)
    else content.text:SetText("Keine Daten.") end
end

function UI:DrawBuffs(content, guideData)
    if guideData.consumables and guideData.consumables.wowhead and #guideData.consumables.wowhead > 0 then
        local txt = "|cffffff00Empfohlene Buffs (Wowhead):|r\n"
        for _, c in ipairs(guideData.consumables.wowhead) do txt = txt .. "- " .. c .. "\n" end
        content.text:SetText(txt)
    else content.text:SetText("Keine Buff-Daten gefunden.") end
end

DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end)
DragonSkill.UI = UI
