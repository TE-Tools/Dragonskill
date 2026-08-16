-- Dragon Skill - Haupt UI (v1.3.5)
-- Ultimative Reparatur für Talent-Import, Dialoge und Daten-Vollständigkeit.

local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants", "Buffs"}

-- Persistenter Speicher (Absolut sicher!)
local lastClickedBuild = { label = "", importString = "" }

-- Statische Popups
StaticPopupDialogs["DRAGONSKILL_ACTION"] = {
    text = "Build: %s\nMatch: %d%%\n\nWas möchtest du tun?",
    button1 = "Kopieren",
    button2 = "Neu anlegen",
    button3 = "Abbrechen",
    OnAccept = function(self)
        -- Button 1: Kopieren (Übergabe via lastClickedBuild)
        StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, lastClickedBuild.importString)
    end,
    OnCancel = function(self, data, reason)
        -- Button 2: Neu anlegen
        if reason == "clicked" and lastClickedBuild.importString ~= "" then
            local TC = DragonSkill:GetModule("TalentCompare")
            if TC then TC:ImportToWoW(lastClickedBuild.importString, lastClickedBuild.label) end
        end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true,
}

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Strg+C zum Kopieren drücken:",
    button1 = "Fertig",
    hasEditBox = 1,
    OnShow = function(self, data)
        -- Wir nutzen hier direkt die übergebene data ODER den Cache
        local code = data or lastClickedBuild.importString
        self.editBox:SetText(code or "")
        self.editBox:SetFocus()
        self.editBox:HighlightText()
    end,
    timeout = 0, whileDead = true, hideOnEscape = true,
}

function UI:Init()
    if self.frame then return end

    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(450, 550)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    if f.SetTitle then f:SetTitle("Dragon Skill v1.3.5") end
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
        local tab = CreateFrame("Button", "DragonSkillTabBtn"..i, f, "PanelTabButtonTemplate")
        tab:SetID(i)
        tab:SetText(name)
        tab:SetScript("OnClick", function(self) UI:SelectTab(self:GetID()) end)
        f.Tabs[i] = tab
        if i == 1 then tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 15, 2)
        else tab:SetPoint("LEFT", f.Tabs[i-1], "RIGHT", -16, 0) end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)

    f:Hide()
    self.frame = f
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
        content.text:SetText("|cffff0000INFO:|r Keine Daten für " .. tostring(class) .. " (Spec " .. tostring(specID) .. ") gefunden.\n\nDaten für diese Klasse werden in Kürze nachgereicht!")
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
    if not guideData.talentBuilds or #guideData.talentBuilds == 0 then
        content.text:SetText("Keine Talente für diese Spec verfügbar.")
        return
    end

    if not self.talentBtns then self.talentBtns = {} end
    for _, btn in ipairs(self.talentBtns) do btn:Hide() end

    local yOffset = -10
    for i, build in ipairs(guideData.talentBuilds) do
        local btn = self.talentBtns[i]
        if not btn then
            btn = CreateFrame("Button", "DragonSkillTalentBtn_"..i, content, "UIPanelButtonTemplate")
            btn:SetSize(360, 32)
            self.talentBtns[i] = btn
        end
        btn:SetPoint("TOPLEFT", 10, yOffset)
        btn:SetText(string.format("[%s] %s", (build.provider or "Wowhead"):upper(), build.label))
        btn:SetScript("OnClick", function()
            lastClickedBuild = { label = build.label, importString = build.importString }
            local current = TC:GetCurrentBuildString()
            local result = TC:Compare(build.importString, current)
            StaticPopup_Show("DRAGONSKILL_ACTION", build.label, result.similarity or 0)
        end)
        btn:Show()
        yOffset = yOffset - 38
    end
end

function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -10
    if title then content.text:SetText(title); yOffset = -30 end

    if not self.listRows then self.listRows = {} end
    for _, row in ipairs(self.listRows) do row:Hide() end

    if not items or #items == 0 then
        content.text:SetText(title .. "\n\n|cffffaa00Keine Daten für diesen Reiter verfügbar.|r")
        return
    end

    for i, item in ipairs(items) do
        local itemName = item.text or item.name or "Unbekannt"
        local row = self.listRows[i]
        if not row then
            row = CreateFrame("Button", "DragonSkillRow_"..currentTab.."_"..i, content)
            row:SetSize(360, 26)
            row:SetFrameLevel(content:GetFrameLevel() + 5)
            row:EnableMouse(true)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22)
            row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
            self.listRows[i] = row
        end

        row:SetPoint("TOPLEFT", 10, yOffset)
        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        if item.itemId then texture = C_Item.GetItemIconByID(item.itemId) or texture
        elseif item.spellId then texture = C_Spell.GetSpellTexture(item.spellId) or texture end

        row.icon:SetTexture(texture)
        row.text:SetText((item.slot and "|cff00ff00"..item.slot..":|r " or "") .. itemName)

        row:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if item.itemId then GameTooltip:SetItemByID(item.itemId)
            elseif item.spellId then GameTooltip:SetSpellByID(item.spellId)
            else GameTooltip:SetText(itemName) end
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end)

        row:Show()
        yOffset = yOffset - 28
    end
end

function UI:DrawStats(content, guideData)
    local txt = "|cffffff00=== Deine Werte ===|r\n"
    txt = txt .. string.format("Tempo: %.1f%%\nKritisch: %.1f%%\nMeisterschaft: %.1f%%\nVielseitigkeit: %.1f%%\n", GetHaste(), GetCritChance(), GetMasteryEffect(), GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE))
    if guideData.statPriority then
        txt = txt .. "\n|cffffff00=== Empfehlung ===|r\n"
        txt = txt .. "|cffffd100Wowhead:|r " .. (guideData.statPriority.wowhead or "N/A") .. "\n"
        if guideData.statPriority.archon then txt = txt .. "|cffffd100Archon:|r " .. (guideData.statPriority.archon or "N/A") .. "\n" end
    end
    content.text:SetText(txt)
end

function UI:DrawTrinkets(content, guideData)
    local items = guideData.trinkets and guideData.trinkets.archon
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Top Trinkets (Archon):|r")
end

function UI:DrawCrafting(content, guideData)
    if guideData.crafting and guideData.crafting.wowhead and guideData.crafting.wowhead.embellishments and #guideData.crafting.wowhead.embellishments > 0 then
        local txt = "|cffffff00Embellishments (Wowhead):|r\n"
        for _, emb in ipairs(guideData.crafting.wowhead.embellishments) do txt = txt .. "- " .. emb .. "\n" end
        content.text:SetText(txt)
    else content.text:SetText("Keine Crafting-Daten gefunden.") end
end

function UI:DrawRotation(content, guideData)
    local items = guideData.rotation and guideData.rotation.wowhead
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Priorität (Wowhead):|r")
end

function UI:DrawGear(content, guideData)
    local items = guideData.bisGear and guideData.bisGear.wowhead
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Best-in-Slot (Wowhead):|r")
end

function UI:DrawEnchants(content, guideData)
    local items = guideData.enchants and guideData.enchants.wowhead
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Verzauberungen (Wowhead):|r")
end

function UI:DrawBuffs(content, guideData)
    local items = guideData.consumables and guideData.consumables.wowhead
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Buffs (Wowhead):|r")
end

-- Slash Commands (Sofort registrieren)
SLASH_WEAR1 = "/wear"
SLASH_WEAR2 = "/dragonskill"
SlashCmdList["WEAR"] = function(msg)
    if not UI.frame then UI:Init() end
    if UI.frame:IsShown() then UI.frame:Hide()
    else UI.frame:Show(); UI:Update() end
end

print("|cff00ff00Dragon Skill v1.3.5 geladen!|r Nutze /wear")
DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end)
DragonSkill.UI = UI
