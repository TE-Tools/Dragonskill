-- Dragon Skill - Module: AI Coach Chat UI (v2.3.13)
-- Fix: EditBox has no SetReadOnly in 12.1 – use EnableKeyboard(false) + mouse only.

local AICoachUI = {}
DragonSkill.AICoachUI = AICoachUI

function AICoachUI:Draw(content, width)
    local chatWidth = (width or 580) - 20
    local Engine = DragonSkill:GetModule("AICoach")

    if not self.historyText then
        local sf = CreateFrame("ScrollFrame", "DragonSkillAICoachScroll", content, "UIPanelScrollFrameTemplate")
        sf:SetSize(chatWidth, 340)
        sf:SetPoint("TOPLEFT", 10, -40)

        local h = CreateFrame("EditBox", nil, sf)
        h:SetMultiLine(true)
        h:SetFontObject(GameFontHighlight)
        h:SetWidth(chatWidth - 30)
        h:SetAutoFocus(false)
        h:EnableMouse(true)
        h:EnableKeyboard(false)
        h:SetTextInsets(10, 10, 10, 10)
        h:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
        sf:SetScrollChild(h)

        local bg = CreateFrame("Frame", nil, content, "BackdropTemplate")
        bg:SetPoint("TOPLEFT", sf, "TOPLEFT", -5, 5)
        bg:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", 25, -5)
        bg:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true, tileSize = 16, edgeSize = 12,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        bg:SetBackdropColor(0, 0, 0, 0.8)
        self.historyBg = bg

        self.scrollFrame = sf
        self.historyText = h
    end
    self.scrollFrame:SetParent(content)
    self.scrollFrame:Show()
    if self.historyBg then self.historyBg:SetParent(content); self.historyBg:Show() end
    self:RefreshHistory()

    if not self.inputBox then
        local eb = CreateFrame("EditBox", "DragonSkillAICoachInput", content, "InputBoxTemplate")
        eb:SetSize(chatWidth - 110, 30)
        eb:SetPoint("TOPLEFT", 15, -390)
        eb:SetAutoFocus(false)
        eb:SetScript("OnEnterPressed", function(selfEb)
            local msg = selfEb:GetText()
            if msg and msg ~= "" then
                selfEb:SetText("")
                AICoachUI:AddMessage("User", msg)

                local ok, reply = pcall(function() return Engine:GetReply(msg) end)
                if ok and reply then
                    AICoachUI:AddMessage("Coach", tostring(reply))
                else
                    AICoachUI:AddMessage("Coach", "|cffff0000Fehler:|r " .. tostring(reply))
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
            if eb and eb:GetScript("OnEnterPressed") then
                eb:GetScript("OnEnterPressed")(eb)
            end
        end)
        self.sendBtn = btn
    end
    self.inputBox:SetParent(content)
    self.sendBtn:SetParent(content)
    self.inputBox:Show()
    self.sendBtn:Show()
end

function AICoachUI:AddMessage(sender, text)
    if not text then return end
    local prefix = (sender == "User") and "|cffffffffDu: |r" or "|cff00ff00Coach: |r"
    if DragonSkillDB then
        DragonSkillDB.history = DragonSkillDB.history or {}
        table.insert(DragonSkillDB.history, prefix .. tostring(text))
        if #DragonSkillDB.history > 15 then table.remove(DragonSkillDB.history, 1) end
    end
    self:RefreshHistory()
end

function AICoachUI:RefreshHistory()
    if not self.historyText then return end
    local full = ""
    if DragonSkillDB and DragonSkillDB.history then
        for _, m in ipairs(DragonSkillDB.history) do
            full = full .. tostring(m) .. "\n\n"
        end
    end
    if full == "" then
        full = "|cffaaaaaaInterner Coach (nur Addon-Daten). Frag: upgrade, farm, talent, status oder Boss-Name.|r"
    end
    self.historyText:SetText(full)
    if self.scrollFrame then
        self.scrollFrame:UpdateScrollChildRect()
        local max = self.scrollFrame:GetVerticalScrollRange() or 0
        self.scrollFrame:SetVerticalScroll(max)
    end
end
