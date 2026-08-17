-- Dragon Skill - Haupt UI (v1.6.2) Archon+Wowhead Merge
local UI = {}
local currentTab = 1
local tabs = {"Talente", "Stats", "Trinkets", "Crafting", "Rotation", "Gear", "Enchants", "Gems", "Buffs"}
local TAB_GEAR = 6
local cachedBuildData = nil
local CONTENT_WIDTH, FRAME_WIDTH, FRAME_HEIGHT, ROW_WIDTH = 600, 680, 560, 580

local function MergeProviderLists(providerTable)
    local out, seen = {}, {}
    if not providerTable then return out end
    local function add(list)
        if not list then return end
        for _, item in ipairs(list) do
            local key = tostring(item.itemId or "") .. "|" .. tostring(item.text or item.name or "")
            if key ~= "|" and not seen[key] then
                seen[key] = true
                table.insert(out, {
                    text = item.text or item.name,
                    name = item.name or item.text,
                    itemId = item.itemId,
                    spellId = item.spellId,
                    slot = item.slot,
                    rank = item.rank or item.popularity,
                })
            end
        end
    end
    add(providerTable.archon)
    add(providerTable.wowhead)
    return out
end

local function FilterItems(items)
    if not items then return {} end
    local out, seen = {}, {}
    for _, item in ipairs(items) do
        local name = tostring(item.text or item.name or "")
        if name ~= "" and name:lower() ~= "unbekannt" then
            local key = tostring(item.itemId or "") .. "|" .. name
            if not seen[key] then seen[key] = true; table.insert(out, item) end
        end
    end
    return out
end

StaticPopupDialogs["DRAGONSKILL_ACTION"] = {
    text = "Build: %s\nMatch: %d%%\n\nWas möchtest du tun?",
    button1 = "Kopieren", button2 = "Neu anlegen", button3 = "Abbrechen",
    OnAccept = function()
        if cachedBuildData then StaticPopup_Show("DRAGONSKILL_COPY", nil, nil, cachedBuildData) end
    end,
    OnCancel = function(_, _, reason)
        if reason == "clicked" and cachedBuildData then
            local TC = DragonSkill:GetModule("TalentCompare")
            if TC then TC:ImportToWoW(cachedBuildData.importString, cachedBuildData.label) end
        end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["DRAGONSKILL_COPY"] = {
    text = "Strg+C zum Kopieren:", button1 = "Fertig", hasEditBox = 1, editBoxWidth = 320,
    OnShow = function(self, data)
        local build = data or cachedBuildData
        local code = type(build) == "table" and (build.importString or "") or tostring(build or "")
        local eb = self.EditBox or self.editBox
        if eb then eb:SetText(code); eb:HighlightText(); eb:SetFocus() end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

function UI:Open(tabId)
    if not self.frame then self:Init() end
    self.frame:Show()
    if tabId then self:SelectTab(tabId) else self:Update() end
end
function UI:OpenBiS() self:Open(TAB_GEAR) end
function UI:Toggle()
    if not self.frame then self:Init() end
    if self.frame:IsShown() then self.frame:Hide() else self:Open(currentTab) end
end

function UI:Init()
    if self.frame then return end
    local f = CreateFrame("Frame", "DragonSkillMainFrame", UIParent, "ButtonFrameTemplate")
    f:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
    f:SetPoint("CENTER")
    f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    if f.SetTitle then f:SetTitle("Dragon Skill v1.6.2") end
    if f.portrait then f.portrait:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01") end
    if f.Inset then
        f.Inset:ClearAllPoints()
        f.Inset:SetPoint("TOPLEFT", 4, -60)
        f.Inset:SetPoint("BOTTOMRIGHT", -6, 28)
    end
    local scrollFrame = CreateFrame("ScrollFrame", "DragonSkillScrollFrame", f.Inset, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 8)
    local content = CreateFrame("Frame", "DragonSkillContentFrame", scrollFrame)
    content:SetSize(CONTENT_WIDTH, 2000)
    scrollFrame:SetScrollChild(content)
    f.Content = content
    f.ScrollFrame = scrollFrame
    f.Tabs = {}
    for i, name in ipairs(tabs) do
        local tab = CreateFrame("Button", "DragonSkillTabBtn"..i, f, "PanelTabButtonTemplate")
        tab:SetID(i); tab:SetText(name)
        tab:SetScript("OnClick", function(selfBtn) UI:SelectTab(selfBtn:GetID()) end)
        f.Tabs[i] = tab
        if i == 1 then tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 8, 1)
        else tab:SetPoint("LEFT", f.Tabs[i-1], "RIGHT", -16, 0) end
    end
    PanelTemplates_SetNumTabs(f, #tabs)
    PanelTemplates_SetTab(f, 1)
    tinsert(UISpecialFrames, "DragonSkillMainFrame")
    f:Hide()
    self.frame = f
    self.talentBtns = {}
    self.listRowsByTab = {}
end

function UI:SelectTab(id)
    currentTab = id
    if self.frame then PanelTemplates_SetTab(self.frame, id) end
    self:Update()
end

function UI:ClearContent(content)
    for _, child in ipairs({ content:GetChildren() }) do child:Hide() end
    if content.text then content.text:SetText(""); content.text:Show() end
end

function UI:EnsureText(content)
    if not content.text then
        content.text = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        content.text:SetPoint("TOPLEFT", 10, -10)
        content.text:SetWidth(CONTENT_WIDTH - 30)
        content.text:SetJustifyH("LEFT")
        content.text:SetSpacing(3)
    end
    return content.text
end

function UI:Update()
    if not self.frame or not self.frame.Content then return end
    local content = self.frame.Content
    self:ClearContent(content)
    self:EnsureText(content)
    if self.frame.ScrollFrame then self.frame.ScrollFrame:SetVerticalScroll(0) end
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local guideData = DragonSkill.Database:GetGuideData(class, specID)
    if not guideData then
        content.text:SetText("|cffff0000DATEN-FEHLER:|r Keine Guide-Daten für diese Spec.")
        return
    end
    if currentTab == 1 then self:DrawTalents(content, guideData)
    elseif currentTab == 2 then self:DrawStats(content, guideData)
    elseif currentTab == 3 then self:DrawTrinkets(content, guideData)
    elseif currentTab == 4 then self:DrawCrafting(content, guideData)
    elseif currentTab == 5 then self:DrawRotation(content, guideData)
    elseif currentTab == 6 then self:DrawGear(content, guideData)
    elseif currentTab == 7 then self:DrawEnchants(content, guideData)
    elseif currentTab == 8 then self:DrawGems(content, guideData)
    elseif currentTab == 9 then self:DrawBuffs(content, guideData)
    end
end

function UI:DrawTalents(content, guideData)
    local TC = DragonSkill:GetModule("TalentCompare")
    if not guideData.talentBuilds or #guideData.talentBuilds == 0 then
        content.text:SetText("Keine Talente gefunden.")
        return
    end
    content.text:SetText("|cffffff00=== Guide-Builds ===|r")
    for _, btn in pairs(self.talentBtns) do btn:Hide() end
    local yOffset = -30
    for i, build in ipairs(guideData.talentBuilds) do
        local btn = self.talentBtns[i]
        if not btn then
            btn = CreateFrame("Button", "DragonSkillTalentBtn_"..i, content, "UIPanelButtonTemplate")
            btn:SetSize(ROW_WIDTH, 32)
            self.talentBtns[i] = btn
        end
        btn:SetParent(content)
        btn:ClearAllPoints()
        btn:SetPoint("TOPLEFT", 10, yOffset)
        btn:SetText(string.format("[%s] %s", string.upper(tostring(build.provider or "Guide")), tostring(build.label or ("Build "..i))))
        btn:SetScript("OnClick", function()
            cachedBuildData = build
            local sim = 0
            if TC and TC.Compare then
                local r = TC:Compare(build.importString, TC:GetCurrentBuildString and TC:GetCurrentBuildString() or "")
                sim = (r and r.similarity) or 0
            end
            StaticPopup_Show("DRAGONSKILL_ACTION", build.label or "Build", sim)
        end)
        btn:Show()
        yOffset = yOffset - 36
    end
    content:SetHeight(math.max(400, math.abs(yOffset) + 40))
end

function UI:Helper_DrawListWithIcons(content, items, title)
    local yOffset = -10
    self:EnsureText(content)
    items = FilterItems(items)
    if title then content.text:SetText(title); content.text:Show(); yOffset = -30 end
    self.listRowsByTab[currentTab] = self.listRowsByTab[currentTab] or {}
    local rows = self.listRowsByTab[currentTab]
    for _, row in ipairs(rows) do row:Hide() end
    if not items or #items == 0 then
        content.text:SetText((title or "") .. "\n\n|cffffaa00Keine Daten verfügbar.|r")
        return
    end
    for i, item in ipairs(items) do
        local itemName = item.text or item.name or "Unbekannt"
        local row = rows[i]
        if not row then
            row = CreateFrame("Button", nil, content)
            row:SetSize(ROW_WIDTH, 26)
            row:EnableMouse(true)
            row.icon = row:CreateTexture(nil, "ARTWORK")
            row.icon:SetSize(22, 22)
            row.icon:SetPoint("LEFT", 0, 0)
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
            row.text:SetWidth(ROW_WIDTH - 40)
            rows[i] = row
        end
        row:SetParent(content)
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 10, yOffset)
        local texture = "Interface\\Icons\\Inv_misc_questionmark"
        if item.itemId and C_Item and C_Item.GetItemIconByID then
            texture = C_Item.GetItemIconByID(item.itemId) or texture
        end
        row.icon:SetTexture(texture)
        local rank = item.rank and (" |cff888888("..tostring(item.rank)..")|r") or ""
        row.text:SetText((item.slot and ("|cff00ff00"..item.slot..":|r ") or "") .. itemName .. rank)
        local captured, capturedName = item, itemName
        row:SetScript("OnEnter", function(selfRow)
            GameTooltip:SetOwner(selfRow, "ANCHOR_RIGHT")
            if captured.itemId then GameTooltip:SetItemByID(captured.itemId)
            else GameTooltip:SetText(capturedName) end
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row:Show()
        yOffset = yOffset - 28
    end
    content:SetHeight(math.max(400, math.abs(yOffset) + 40))
end

function UI:DrawStats(content, guideData)
    local txt = "|cffffff00=== Deine Werte ===|r\n" .. string.format(
        "Tempo: %.1f%%\nKritisch: %.1f%%\nMeisterschaft: %.1f%%\nVielseitigkeit: %.1f%%\n",
        GetHaste(), GetCritChance(), GetMasteryEffect(),
        GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE))
    local prio = guideData.statPriority
    if prio then
        txt = txt .. "\n|cffffff00=== Empfehlung ===|r\n"
        txt = txt .. "|cffffd100Wowhead:|r " .. (prio.wowhead or "N/A") .. "\n"
        if prio.archon then txt = txt .. "|cffffd100Archon:|r " .. prio.archon .. "\n" end
    end
    content.text:SetText(txt)
end

function UI:DrawTrinkets(content, guideData)
    self:Helper_DrawListWithIcons(content, MergeProviderLists(guideData.trinkets),
        "|cffffff00Top Trinkets (Archon + Wowhead):|r")
end

function UI:DrawCrafting(content, guideData)
    content.text:SetText("Keine Crafting-Daten.")
end

function UI:DrawRotation(content, guideData)
    local items = (guideData.rotation and guideData.rotation.wowhead) or {}
    self:Helper_DrawListWithIcons(content, items, "|cffffff00Priorität (Wowhead):|r")
end

function UI:DrawGear(content, guideData)
    local items = MergeProviderLists(guideData.bisGear)
    local n = #FilterItems(items)
    local header = string.format(
        "|cffffd100=== BiS (Archon + Wowhead) ===|r\n|cff888888%d Empfehlungen · Hover = Tooltip|r", n)
    self:Helper_DrawListWithIcons(content, items, header)
end

function UI:DrawEnchants(content, guideData)
    self:Helper_DrawListWithIcons(content, MergeProviderLists(guideData.enchants),
        "|cffffff00Verzauberungen (Archon + Wowhead):|r")
end

function UI:DrawGems(content, guideData)
    self:Helper_DrawListWithIcons(content, MergeProviderLists(guideData.gems),
        "|cffffff00Gems (Archon + Wowhead):|r")
end

function UI:DrawBuffs(content, guideData)
    self:Helper_DrawListWithIcons(content, MergeProviderLists(guideData.consumables),
        "|cffffff00Buffs (Archon + Wowhead):|r")
end

SLASH_WEAR1 = "/wear"
SLASH_WEAR2 = "/dragonskill"
SLASH_WEAR3 = "/ds"
SlashCmdList["WEAR"] = function(msg)
    msg = msg and strtrim(msg) or ""
    local lower = msg:lower()
    if lower == "bis" or lower == "gear" then UI:OpenBiS(); return end
    if lower == "help" or lower == "?" then
        print("|cff00ff00Dragon Skill v1.6.2|r  /ds  /ds bis")
        return
    end
    UI:Toggle()
end

print("|cff00ff00Dragon Skill v1.6.2 geladen!|r  /ds · /ds bis")
DragonSkill.Events:On("PLAYER_LOGIN", function() UI:Init() end)
DragonSkill.UI = UI
