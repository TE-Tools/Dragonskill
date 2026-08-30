-- Dragon Skill - Module: AI Coach Chat UI (v1.8.1)
-- Improved Chat display and context handling.

local AICoachUI = {}
local messages = {}

function AICoachUI:Draw(content, width)
    local UI = DragonSkill.UI
    local Engine = DragonSkill:GetModule("AICoach")

    -- Chat History Area
    if not self.historyFrame then
        local h = CreateFrame("Frame", nil, content, "BackdropTemplate")
        h:SetSize(width - 40, 320)
        h:SetPoint("TOPLEFT", 15, -60)
        h:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true, tileSize = 16, edgeSize = 12,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        h:SetBackdropColor(0, 0, 0, 0.5)

        local fs = h:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fs:SetPoint("TOPLEFT", 10, -10)
        fs:SetWidth(width - 70)
        fs:SetJustifyH("LEFT")
        fs:SetSpacing(3)
        fs:SetText("|cffaaaaaaSchreib mir deine Frage unten in die Box!|r\n\n|cff888888Beispiel: 'Was soll ich heute farmen?' oder 'Habe ich was Gutes in der Tasche?'|r")

        self.historyFrame = h
        self.historyText = fs
    end
    self.historyFrame:Show()

    -- Input Box
    if not self.inputBox then
        local eb = CreateFrame("EditBox", "DragonSkillAICoachInput", content, "InputBoxTemplate")
        eb:SetSize(width - 110, 30)
        eb:SetPoint("TOPLEFT", 15, -390)
        eb:SetAutoFocus(false)
        eb:SetScript("OnEnterPressed", function(selfEb)
            local msg = selfEb:GetText()
            if msg ~= "" then
                selfEb:SetText("")
                AICoachUI:AddMessage("User", msg)

                -- Simulate thinking
                C_Timer.After(0.3, function()
                    local reply = Engine:GetReply(msg)
                    AICoachUI:AddMessage("Coach", reply)
                end)
            end
            selfEb:ClearFocus()
        end)
        self.inputBox = eb

        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(70, 30)
        btn:SetPoint("LEFT", eb, "RIGHT", 5, 0)
        btn:SetText("Fragen")
        btn:SetScript("OnClick", function()
            eb:GetScript("OnEnterPressed")(eb)
        end)
    end
    self.inputBox:Show()

    -- API Key Button (Mode 2)
    if not self.settingsBtn then
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(120, 22)
        btn:SetPoint("TOPRIGHT", content, "TOPRIGHT", -15, -15)
        btn:SetText("KI Einstellungen")
        btn:SetScript("OnClick", function()
            StaticPopup_Show("DRAGONSKILL_AI_KEY")
        end)
        self.settingsBtn = btn
    end
    self.settingsBtn:Show()
end

function AICoachUI:AddMessage(sender, text)
    local color = (sender == "User") and "|cffffffffDu:|r " or "|cff00ff00Coach:|r "
    table.insert(messages, color .. text)

    -- Limit history
    if #messages > 10 then table.remove(messages, 1) end

    local full = ""
    for _, m in ipairs(messages) do
        full = full .. m .. "\n\n"
    end
    if self.historyText then
        self.historyText:SetText(full)
    end
end

-- Popup for API Key
StaticPopupDialogs["DRAGONSKILL_AI_KEY"] = {
    text = "OpenAI API-Key eingeben (Mode 2):\n|cffff0000Achtung:|r Key wird lokal gespeichert.",
    button1 = "Speichern",
    button2 = "Abbrechen",
    hasEditBox = 1,
    OnShow = function(self)
        if DragonSkillDB.ai and DragonSkillDB.ai.apiKey then
            self.editBox:SetText(DragonSkillDB.ai.apiKey)
        end
    end,
    OnAccept = function(self)
        local key = self.editBox:GetText()
        DragonSkillDB.ai = DragonSkillDB.ai or {}
        DragonSkillDB.ai.apiKey = key
        DragonSkillDB.ai.enabled = (key ~= "")
        print("|cff00ff00Dragon Skill:|r KI-Schluessel gespeichert.")
    end,
    timeout = 0, whileDead = true, hideOnEscape = true,
}

DragonSkill.AICoachUI = AICoachUI
