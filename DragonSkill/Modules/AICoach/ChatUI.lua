-- Dragon Skill - Module: AI Coach Chat UI (v2.3.9)
-- Fix: EditBox has no SetReadOnly in 12.1 – use EnableKeyboard(false) + mouse only.

local AICoachUI = {}
DragonSkill.AICoachUI = AICoachUI

function AICoachUI:Draw(content, width)
    if not content then return end
    local Engine = DragonSkill:GetModule("AICoach")
    if not Engine then
        local fs = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("TOPLEFT", 15, -20)
        fs:SetText("|cffff0000AI Coach Engine nicht geladen.|r")
        return
    end

    local chatWidth = 580

    if not self.scrollFrame then
        local sf = CreateFrame("ScrollFrame", "DragonSkillAICoachScroll", content, "UIPanelScrollFrameTemplate")
        sf:SetSize(chatWidth - 60, 300)
        sf:SetPoint("TOPLEFT", 15, -60)

        local h = CreateFrame("EditBox", nil, sf)
        h:SetMultiLine(true)
        h:SetMaxLetters(99999)
        h:SetWidth(chatWidth - 100)
        h:SetTextInsets(10, 10, 10, 10)
        h:SetAutoFocus(false)
        h:EnableMouse(true)
        h:EnableKeyboard(false)
        if h.SetFontObject then h:SetFontObject("ChatFontNormal") end

        h:SetScript("OnHyperlinkEnter", function(eb, link)
            if link and eb then
                GameTooltip:SetOwner(eb, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(link)
                GameTooltip:Show()
            end
        end)
        h:SetScript("OnHyperlinkLeave", function() GameTooltip:Hide() end)
        h:SetScript("OnEscapePressed", function(eb) eb:ClearFocus() end)
        sf:SetScrollChild(h)

        local bg = CreateFrame("Frame", nil, content, "BackdropTemplate")
        bg:SetPoint("TOPLEFT", sf, -5, 5)
        bg:SetPoint("BOTTOMRIGHT", sf, 25, -5)
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
    local prefix = (sender == "User") and "|cffffffffDu: |r" or (sender == "AI") and "|cff00ccffReal-AI: |r" or "|cff00ff00Coach: |r"
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
    self.historyText:SetText(full == "" and "Willkommen beim Coach! Frag nach Upgrades, Farm-Routen oder Boss-Taktiken." or full)
    if self.scrollFrame then
        local range = self.scrollFrame:GetVerticalScrollRange() or 0
        if range > 0 then self.scrollFrame:SetVerticalScroll(range) end
    end
end
