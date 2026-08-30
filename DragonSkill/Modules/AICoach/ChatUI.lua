-- Dragon Skill - Module: AI Coach Chat UI (v2.0.7)
-- Robust Chat Interface with Instant Local Response.

local AICoachUI = {}
local messages = {}
DragonSkill.AICoachUI = AICoachUI

function AICoachUI:Draw(content, width)
    local Engine = DragonSkill:GetModule("AICoach")
    if not Engine then return end

    -- 1. Create Chat History Area
    if not self.historyFrame then
        local h = CreateFrame("Frame", "DragonSkillAICoachHistory", content, "BackdropTemplate")
        h:SetSize(width - 40, 320)
        h:SetPoint("TOPLEFT", 15, -60)
        h:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true, tileSize = 16, edgeSize = 12,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        h:SetBackdropColor(0, 0, 0, 0.75)

        local fs = h:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fs:SetPoint("TOPLEFT", 10, -10)
        fs:SetWidth(width - 70)
        fs:SetJustifyH("LEFT")
        fs:SetSpacing(4)
        fs:SetText("|cffaaaaaaWillkommen beim Dragon Skill Coach. Frag mich etwas ueber dein Gear!|r")

        self.historyFrame = h
        self.historyText = fs
    end
    self.historyFrame:Show()

    -- Sync external response if ready
    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.pendingQuery and DragonSkillDB.ai.pendingQuery.status == "DONE" then
        if DragonSkillDB.ai.lastResponse and DragonSkillDB.ai.lastResponse ~= self.prevResponse then
            self:AddMessage("AI", DragonSkillDB.ai.lastResponse)
            self.prevResponse = DragonSkillDB.ai.lastResponse
            DragonSkillDB.ai.pendingQuery.status = "READ"
        end
    end

    self:RefreshHistory()

    -- 2. Create Input Box
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

                -- Instant Local Fact Engine
                local reply = Engine:GetReply(msg)
                if reply then
                    C_Timer.After(0.2, function()
                        AICoachUI:AddMessage("Coach", reply)
                    end)
                end
            end
            selfEb:ClearFocus()
        end)
        self.inputBox = eb

        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(70, 30)
        btn:SetPoint("LEFT", eb, "RIGHT", 5, 0)
        btn:SetText("Senden")
        btn:SetScript("OnClick", function()
            eb:GetScript("OnEnterPressed")(eb)
        end)
        self.sendBtn = btn
    end
    self.inputBox:Show()
    self.sendBtn:Show()

    -- 3. Sync/Reload Button (For External AI)
    if not self.syncBtn then
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(140, 22)
        btn:SetPoint("BOTTOMLEFT", self.historyFrame, "TOPLEFT", 0, 5)
        btn:SetText("KI-Antwort abholen")
        btn:SetScript("OnClick", function() ReloadUI() end)
        btn:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
            GameTooltip:SetText("Wenn Claude fertig ist (siehe Desktop-Fenster), klick hier zum Anzeigen.")
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        self.syncBtn = btn
    end
    self.syncBtn:Show()

    -- 4. Settings Button
    if not self.settingsBtn then
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(130, 22)
        btn:SetPoint("TOPRIGHT", content, "TOPRIGHT", -15, -15)
        btn:SetText("KI-Key setzen")
        btn:SetScript("OnClick", function()
            StaticPopup_Show("DRAGONSKILL_AI_KEY")
        end)
        self.settingsBtn = btn
    end
    self.settingsBtn:Show()
end

function AICoachUI:AddMessage(sender, text)
    local prefix = (sender == "User") and "|cffffffffDu: |r" or (sender == "AI") and "|cff00ccffReal-AI: |r" or "|cff00ff00Coach: |r"
    table.insert(messages, prefix .. text)
    if #messages > 8 then table.remove(messages, 1) end
    self:RefreshHistory()
end

function AICoachUI:RefreshHistory()
    if not self.historyText then return end
    local full = ""
    for _, m in ipairs(messages) do
        full = full .. m .. "\n\n"
    end
    if full == "" then
        full = "|cffaaaaaaSchreib eine Frage! Der Coach antwortet sofort lokal (intern), waehrend Claude im Hintergrund arbeitet.|r"
    end
    self.historyText:SetText(full)
end

-- Shared Settings Popup
StaticPopupDialogs["DRAGONSKILL_AI_KEY"] = {
    text = "KI-Einstellungen (Mode 2):",
    button1 = "Speichern",
    button2 = "Anbieter wechseln",
    button3 = "Abbrechen",
    hasEditBox = 1,
    OnShow = function(self)
        local ai = DragonSkillDB and DragonSkillDB.ai or { provider = "openai" }
        local providerName = (ai.provider or "openai"):upper()
        if self.Text then self.Text:SetText(string.format("KI-Einstellungen (Mode 2):\nAktueller Anbieter: |cffffd100%s|r\n\nAPI-Key eingeben:", providerName)) end
        if self.EditBox and ai.apiKey then self.EditBox:SetText(ai.apiKey) end
    end,
    OnAccept = function(self)
        local key = self.EditBox:GetText() or ""
        DragonSkillDB.ai = DragonSkillDB.ai or {}
        DragonSkillDB.ai.apiKey = key
        DragonSkillDB.ai.enabled = (key ~= "")
        print("|cff00ff00Dragon Skill:|r Key gespeichert.")
    end,
    OnCancel = function(self, data, reason)
        if reason == "clicked" then
            DragonSkillDB.ai = DragonSkillDB.ai or { provider = "openai" }
            DragonSkillDB.ai.provider = (DragonSkillDB.ai.provider == "openai") and "claude" or "openai"
            C_Timer.After(0.1, function() StaticPopup_Show("DRAGONSKILL_AI_KEY") end)
        end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true,
}
