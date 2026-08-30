-- Dragon Skill - Module: AI Coach Chat UI (v2.1.5)
-- Fixed Scrollbar and added Item Tooltip support for AI messages.

local AICoachUI = {}
DragonSkill.AICoachUI = AICoachUI

function AICoachUI:Draw(content, width)
    local Engine = DragonSkill:GetModule("AICoach")

    if not self.scrollFrame then
        local sf = CreateFrame("ScrollFrame", "DragonSkillAICoachScroll", content, "UIPanelScrollFrameTemplate")
        sf:SetSize(width - 60, 300); sf:SetPoint("TOPLEFT", 15, -60)

        local h = CreateFrame("EditBox", nil, sf) -- Using EditBox for Hyperlink support
        h:SetMultiLine(true); h:SetMaxLetters(99999); h:SetFontObject("GameFontHighlightSmall")
        h:SetWidth(width - 80); h:SetTextInsets(10, 10, 10, 10); h:SetReadOnly(true); h:SetAutoFocus(false)
        h:SetScript("OnHyperlinkEnter", function(self, link)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(link); GameTooltip:Show()
        end)
        h:SetScript("OnHyperlinkLeave", function() GameTooltip:Hide() end)
        sf:SetScrollChild(h)

        local bg = CreateFrame("Frame", nil, content, "BackdropTemplate")
        bg:SetPoint("TOPLEFT", sf, -5, 5); bg:SetPoint("BOTTOMRIGHT", sf, 25, -5)
        bg:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 }})
        bg:SetBackdropColor(0, 0, 0, 0.8)

        self.scrollFrame = sf; self.historyText = h
    end
    self.scrollFrame:Show(); self:RefreshHistory()

    if not self.inputBox then
        local eb = CreateFrame("EditBox", "DragonSkillAICoachInput", content, "InputBoxTemplate")
        eb:SetSize(width - 110, 30); eb:SetPoint("TOPLEFT", 15, -390); eb:SetAutoFocus(false)
        eb:SetScript("OnEnterPressed", function(selfEb)
            local msg = selfEb:GetText()
            if msg ~= "" then
                selfEb:SetText(""); AICoachUI:AddMessage("User", msg)
                local reply = Engine:GetReply(msg)
                if reply then AICoachUI:AddMessage("Coach", reply) end
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
end

function AICoachUI:AddMessage(sender, text)
    local prefix = (sender == "User") and "|cffffffffDu: |r" or "|cff00ff00Coach: |r"
    if DragonSkillDB then
        DragonSkillDB.history = DragonSkillDB.history or {}
        table.insert(DragonSkillDB.history, prefix .. text)
        if #DragonSkillDB.history > 20 then table.remove(DragonSkillDB.history, 1) end
    end
    self:RefreshHistory()
end

function AICoachUI:RefreshHistory()
    if not self.historyText then return end
    local full = ""
    if DragonSkillDB and DragonSkillDB.history then
        for _, m in ipairs(DragonSkillDB.history) do full = full .. m .. "\n\n" end
    end
    self.historyText:SetText(full == "" and "Willkommen!" or full)
    self.scrollFrame:SetVerticalScroll(self.scrollFrame:GetVerticalScrollRange())
end
