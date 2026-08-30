-- Dragon Skill - Module: AI Coach Chat UI (v1.9.0)
-- Full Real-AI Bridge support.

local AICoachUI = {}
local messages = {}

function AICoachUI:Draw(content, width)
    local Engine = DragonSkill:GetModule("AICoach")

    -- Check for Bridge response
    if DragonSkillDB.ai and DragonSkillDB.ai.pendingQuery and DragonSkillDB.ai.pendingQuery.status == "DONE" then
        if DragonSkillDB.ai.lastResponse and DragonSkillDB.ai.lastResponse ~= self.prevResponse then
            self:AddMessage("AI", DragonSkillDB.ai.lastResponse)
            self.prevResponse = DragonSkillDB.ai.lastResponse
            DragonSkillDB.ai.pendingQuery.status = "READ"
        end
    end

    -- Chat Area
    if not self.historyFrame then
        local h = CreateFrame("Frame", nil, content, "BackdropTemplate")
        h:SetSize(width - 40, 320); h:SetPoint("TOPLEFT", 15, -60)
        h:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 }})
        h:SetBackdropColor(0, 0, 0, 0.6)

        self.historyText = h:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        self.historyText:SetPoint("TOPLEFT", 10, -10); self.historyText:SetWidth(width - 70); self.historyText:SetJustifyH("LEFT"); self.historyText:SetSpacing(3)
        self.historyText:SetText("|cffaaaaaaSchreib eine Frage! Wenn du den API-Key gesetzt hast, antwortet eine echte KI.|r")
        self.historyFrame = h
    end
    self.historyFrame:Show()

    -- Input
    if not self.inputBox then
        local eb = CreateFrame("EditBox", "DragonSkillAICoachInput", content, "InputBoxTemplate")
        eb:SetSize(width - 110, 30); eb:SetPoint("TOPLEFT", 15, -390); eb:SetAutoFocus(false)
        eb:SetScript("OnEnterPressed", function(selfEb)
            local msg = selfEb:GetText()
            if msg ~= "" then
                selfEb:SetText(""); self:AddMessage("User", msg)
                local reply = Engine:GetReply(msg)
                if reply then self:AddMessage("Coach", reply) end
            end
            selfEb:ClearFocus()
        end)
        self.inputBox = eb

        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(70, 30); btn:SetPoint("LEFT", eb, "RIGHT", 5, 0); btn:SetText("Senden")
        btn:SetScript("OnClick", function() eb:GetScript("OnEnterPressed")(eb) end)
    end
    self.inputBox:Show()

    -- Settings
    if not self.settingsBtn then
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(120, 22); btn:SetPoint("TOPRIGHT", content, "TOPRIGHT", -15, -15); btn:SetText("KI-Key setzen")
        btn:SetScript("OnClick", function() StaticPopup_Show("DRAGONSKILL_AI_KEY") end)
        self.settingsBtn = btn
    end
    self.settingsBtn:Show()
end

function AICoachUI:AddMessage(sender, text)
    local prefix = (sender == "User") and "|cffffffffDu:|r " or (sender == "AI") and "|cff00ccffReal-AI:|r " or "|cff00ff00Local-Coach:|r "
    table.insert(messages, prefix .. text)
    if #messages > 8 then table.remove(messages, 1) end

    local full = ""
    for _, m in ipairs(messages) do full = full .. m .. "\n\n" end
    if self.historyText then self.historyText:SetText(full) end
end

DragonSkill.AICoachUI = AICoachUI

-- Popup for API Key & Provider
StaticPopupDialogs["DRAGONSKILL_AI_KEY"] = {
    text = "KI-Einstellungen (Mode 2):",
    button1 = "Speichern",
    button2 = "Anbieter wechseln",
    button3 = "Abbrechen",
    hasEditBox = 1,
    OnShow = function(self)
        local ai = DragonSkillDB and DragonSkillDB.ai or { provider = "openai" }
        local providerName = (ai.provider or "openai"):upper()
        local eb = self.EditBox or self.editBox
        local txt = self.Text or self.text

        if txt then
            txt:SetText(string.format("KI-Einstellungen (Mode 2):\nAktueller Anbieter: |cffffd100%s|r\n\nAPI-Key eingeben:", providerName))
        end

        if eb and ai.apiKey then
            eb:SetText(ai.apiKey)
        end
    end,
    OnAccept = function(self)
        local eb = self.EditBox or self.editBox
        local key = eb and eb:GetText() or ""
        DragonSkillDB.ai = DragonSkillDB.ai or {}
        DragonSkillDB.ai.apiKey = key
        DragonSkillDB.ai.enabled = (key ~= "")
        print("|cff00ff00Dragon Skill:|r KI-Schluessel gespeichert.")
    end,
    OnCancel = function(self, data, reason)
        if reason == "clicked" then
            if DragonSkillDB then
                DragonSkillDB.ai = DragonSkillDB.ai or { provider = "openai" }
                local ai = DragonSkillDB.ai
                ai.provider = (ai.provider == "openai") and "claude" or "openai"
                print("|cff00ff00Dragon Skill:|r Anbieter auf " .. ai.provider:upper() .. " gewechselt.")
                -- Kleiner Delay damit Blizzard das Fenster sauber schließt bevor es neu öffnet
                C_Timer.After(0.1, function() StaticPopup_Show("DRAGONSKILL_AI_KEY") end)
            end
        end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true,
}
