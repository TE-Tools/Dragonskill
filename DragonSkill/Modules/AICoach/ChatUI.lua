-- Dragon Skill - Module: AI Coach Chat UI (v1.8.0)

local AICoachUI = {}
local messages = {}

function AICoachUI:Draw(content, width)
    local UI = DragonSkill.UI
    local Engine = DragonSkill:GetModule("AICoach")

    -- Chat History
    if not self.historyFrame then
        local h = CreateFrame("Frame", nil, content)
        h:SetSize(width - 40, 300)
        h:SetPoint("TOPLEFT", 15, -60)

        local fs = h:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        fs:SetPoint("TOPLEFT", 0, 0)
        fs:SetWidth(width - 60)
        fs:SetJustifyH("LEFT")
        fs:SetSpacing(4)
        fs:SetText("|cffaaaaaaWillkommen beim Dragon Skill Coach. Schreib mir deine Frage unten in die Box!|r")

        self.historyFrame = h
        self.historyText = fs
    end
    self.historyFrame:Show()

    -- Input Box
    if not self.inputBox then
        local eb = CreateFrame("EditBox", "DragonSkillAICoachInput", content, "InputBoxTemplate")
        eb:SetSize(width - 100, 30)
        eb:SetPoint("TOPLEFT", 15, -380)
        eb:SetAutoFocus(false)
        eb:SetScript("OnEnterPressed", function(selfEb)
            local msg = selfEb:GetText()
            if msg ~= "" then
                selfEb:SetText("")
                AICoachUI:AddMessage("User", msg)
                local reply = Engine:GetReply(msg)
                AICoachUI:AddMessage("Coach", reply)
            end
            selfEb:ClearFocus()
        end)
        self.inputBox = eb

        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(60, 30)
        btn:SetPoint("LEFT", eb, "RIGHT", 5, 0)
        btn:SetText("Senden")
        btn:SetScript("OnClick", function()
            eb:GetScript("OnEnterPressed")(eb)
        end)
    end
    self.inputBox:Show()
end

function AICoachUI:AddMessage(sender, text)
    local color = (sender == "User") and "|cffffffffDu: |r" or "|cff00ff00Coach: |r"
    table.insert(messages, color .. text)
    if #messages > 15 then table.remove(messages, 1) end

    local full = ""
    for _, m in ipairs(messages) do
        full = full .. m .. "\n\n"
    end
    self.historyText:SetText(full)
end

DragonSkill.AICoachUI = AICoachUI
