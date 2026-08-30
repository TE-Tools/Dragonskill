-- Dragon Skill - Module: AI Coach Chat UI (v2.0.4)
-- Hybrid Chat: Local Response + Sync for External AI.

local AICoachUI = {}
local messages = {}
DragonSkill.AICoachUI = AICoachUI

function AICoachUI:Draw(content, width)
    local Engine = DragonSkill:GetModule("AICoach")
    if not Engine then return end

    -- Check for Bridge response (Mode 2/3)
    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.pendingQuery and DragonSkillDB.ai.pendingQuery.status == "DONE" then
        if DragonSkillDB.ai.lastResponse and DragonSkillDB.ai.lastResponse ~= self.prevResponse then
            self:AddMessage("AI", DragonSkillDB.ai.lastResponse)
            self.prevResponse = DragonSkillDB.ai.lastResponse
            DragonSkillDB.ai.pendingQuery.status = "READ"
        end
    end

    -- Create Chat History Area
    if not self.historyFrame then
        local h = CreateFrame("Frame", "DragonSkillAICoachHistory", content, "BackdropTemplate")
        h:SetSize(width - 40, 320); h:SetPoint("TOPLEFT", 15, -60)
        h:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 }})
        h:SetBackdropColor(0, 0, 0, 0.7)

        self.historyText = h:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        self.historyText:SetPoint("TOPLEFT", 10, -10); self.historyText:SetWidth(width - 70); self.historyText:SetJustifyH("LEFT"); self.historyText:SetSpacing(4)
        self.historyText:SetText("|cffaaaaaaWillkommen beim Dragon Skill Coach. Frag mich nach deinem Gear oder Inis!|r")
        self.historyFrame = h
    end
    self.historyFrame:Show()

    self:RefreshHistory()

    -- Input Box
    if not self.inputBox then
        local eb = CreateFrame("EditBox", "DragonSkillAICoachInput", content, "InputBoxTemplate")
        eb:SetSize(width - 110, 30); eb:SetPoint("TOPLEFT", 15, -390); eb:SetAutoFocus(false)
        eb:SetScript("OnEnterPressed", function(selfEb)
            local msg = selfEb:GetText()
            if msg ~= "" then
                selfEb:SetText("")
                AICoachUI:AddMessage("User", msg)

                -- Local Engine Response (Instant)
                local reply = Engine:GetReply(msg)
                if reply then
                    AICoachUI:AddMessage("Coach", reply)
                end
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

    -- Sync Button (Manual Refresh for External AI)
    if not self.syncBtn then
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(130, 22); btn:SetPoint("BOTTOMLEFT", self.historyFrame, "TOPLEFT", 0, 5)
        btn:SetText("Antwort synchronisieren")
        btn:SetScript("OnClick", function() ReloadUI() end)
        btn:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
            GameTooltip:SetText("Wenn das Bridge-Programm auf deinem PC 'Fertig' anzeigt, klicke hier zum Synchronisieren.")
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        self.syncBtn = btn
    end
    self.syncBtn:Show()

    -- Live Hub Info
    if not self.hubInfo then
        local fs = content:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        fs:SetPoint("BOTTOMLEFT", content, "BOTTOMLEFT", 15, 20)
        fs:SetText("|cffaaaaaaLive-Chat ohne Reload? Nutze den Live-Hub: |cffffffffhttp://localhost:3000|r")
        self.hubInfo = fs
    end
    self.hubInfo:Show()

    -- Settings
    if not self.settingsBtn then
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(130, 22); btn:SetPoint("TOPRIGHT", content, "TOPRIGHT", -15, -15); btn:SetText("KI-Key setzen")
        btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_AI_KEY") end)
        self.settingsBtn = btn
    end
    self.settingsBtn:Show()
end

function AICoachUI:AddMessage(sender, text)
    local color = (sender == "User") and "|cffffffffDu: |r" or (sender == "AI") and "|cff00ccffReal-AI: |r" or "|cff00ff00Coach: |r"
    table.insert(messages, color .. text)
    if #messages > 8 then table.remove(messages, 1) end
    self:RefreshHistory()
end

function AICoachUI:RefreshHistory()
    if not self.historyText then return end
    local full = ""
    for _, m in ipairs(messages) do full = full .. m .. "\n\n" end
    if full == "" then full = "|cffaaaaaaWillkommen beim Dragon Skill Coach. Frag mich nach Gear oder Inis!|r" end
    self.historyText:SetText(full)
end
