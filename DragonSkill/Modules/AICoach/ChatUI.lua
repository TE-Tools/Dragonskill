-- Dragon Skill - Module: AI Coach Chat UI (v2.1.3)
-- Scrollable Chat Interface with Persistent History.

local AICoachUI = {}
DragonSkill.AICoachUI = AICoachUI

function AICoachUI:Draw(content, width)
    local Engine = DragonSkill:GetModule("AICoach")
    if not Engine then return end

    -- 1. Create Scrollable History Area
    if not self.scrollFrame then
        local sf = CreateFrame("ScrollFrame", "DragonSkillAICoachScroll", content, "UIPanelScrollFrameTemplate")
        sf:SetSize(width - 60, 300); sf:SetPoint("TOPLEFT", 15, -60)

        local h = CreateFrame("Frame", nil, sf)
        h:SetSize(width - 80, 1000)
        sf:SetScrollChild(h)

        local bg = CreateFrame("Frame", nil, content, "BackdropTemplate")
        bg:SetPoint("TOPLEFT", sf, -5, 5); bg:SetPoint("BOTTOMRIGHT", sf, 25, -5)
        bg:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 }})
        bg:SetBackdropColor(0, 0, 0, 0.75)

        local fs = h:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fs:SetPoint("TOPLEFT", 10, -10); fs:SetWidth(width - 100); fs:SetJustifyH("LEFT"); fs:SetSpacing(4)

        self.scrollFrame = sf; self.historyFrame = h; self.historyText = fs
    end
    self.scrollFrame:Show()
    self:RefreshHistory()

    -- 2. Create Input Box
    if not self.inputBox then
        local eb = CreateFrame("EditBox", "DragonSkillAICoachInput", content, "InputBoxTemplate")
        eb:SetSize(width - 110, 30); eb:SetPoint("TOPLEFT", 15, -390); eb:SetAutoFocus(false)
        eb:SetScript("OnEnterPressed", function(selfEb)
            local msg = selfEb:GetText()
            if msg ~= "" then
                selfEb:SetText(""); AICoachUI:AddMessage("User", msg)
                local reply = Engine:GetReply(msg)
                if reply then C_Timer.After(0.2, function() AICoachUI:AddMessage("Coach", reply) end) end
            end
            selfEb:ClearFocus()
        end)
        self.inputBox = eb

        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(70, 30); btn:SetPoint("LEFT", eb, "RIGHT", 5, 0); btn:SetText("Senden")
        btn:SetScript("OnClick", function() eb:GetScript("OnEnterPressed")(eb) end)
        self.sendBtn = btn
    end
    self.inputBox:Show(); self.sendBtn:Show()

    -- 3. Sync/Reload Button
    if not self.syncBtn then
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(140, 22); btn:SetPoint("BOTTOMLEFT", self.scrollFrame, "TOPLEFT", 0, 10)
        btn:SetText("KI-Antwort abholen")
        btn:SetScript("OnClick", function() ReloadUI() end)
        self.syncBtn = btn
    end
    self.syncBtn:Show()

    -- 4. Settings Button
    if not self.settingsBtn then
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(130, 22); btn:SetPoint("TOPRIGHT", content, "TOPRIGHT", -15, -15); btn:SetText("KI-Key setzen")
        btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_AI_KEY") end)
        self.settingsBtn = btn
    end
    self.settingsBtn:Show()
end

function AICoachUI:AddMessage(sender, text)
    local prefix = (sender == "User") and "|cffffffffDu: |r" or (sender == "AI") and "|cff00ccffReal-AI: |r" or "|cff00ff00Local-Coach: |r"
    if DragonSkillDB then
        DragonSkillDB.history = DragonSkillDB.history or {}
        table.insert(DragonSkillDB.history, prefix .. text)
        if #DragonSkillDB.history > 15 then table.remove(DragonSkillDB.history, 1) end
    end
    self:RefreshHistory()
end

function AICoachUI:RefreshHistory()
    if not self.historyText then return end
    local full = ""
    if DragonSkillDB and DragonSkillDB.history then
        for _, m in ipairs(DragonSkillDB.history) do full = full .. m .. "\n\n" end
    end
    self.historyText:SetText(full == "" and "|cffaaaaaaWillkommen beim Dragon Skill Coach!|r" or full)
    if self.scrollFrame then self.scrollFrame:SetVerticalScroll(self.scrollFrame:GetVerticalScrollRange()) end
end
