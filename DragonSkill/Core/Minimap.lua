-- Dragon Skill - Minimap Button (v2.3.3)
-- Robust and secure implementation for 12.1.

local MinimapBtn = {}
DragonSkill.Minimap = MinimapBtn

function MinimapBtn:Init()
    if self.frame then return end

    -- Load Settings
    local db = DragonSkillDB and DragonSkillDB.minimap or { hide = false, pos = 225 }
    DragonSkillDB.minimap = db

    -- Create Button
    local f = CreateFrame("Button", "DragonSkillMinimapButton", Minimap)
    f:SetSize(32, 32)
    f:SetFrameStrata("MEDIUM")
    f:SetFrameLevel(10)
    f:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    -- Background
    local bg = f:CreateTexture(nil, "BACKGROUND")
    bg:SetSize(20, 20)
    bg:SetPoint("CENTER", 0, 0)
    bg:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    f.bg = bg

    -- Border
    local border = f:CreateTexture(nil, "OVERLAY")
    border:SetSize(52, 52)
    border:SetPoint("TOPLEFT", 0, 0)
    border:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Border")

    -- Tooltip
    f:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_LEFT")
        GameTooltip:SetText("|cffffd100Dragon Skill|r")
        GameTooltip:AddLine("Linksklick: Öffnen/Schließen")
        GameTooltip:AddLine("Rechtsklick: Verschieben")
        GameTooltip:Show()
    end)
    f:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- Click & Drag
    f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    f:SetMovable(true)
    f:SetScript("OnMouseDown", function(self, button)
        if button == "RightButton" then
            self:StartMoving()
        end
    end)
    f:SetScript("OnMouseUp", function(self, button)
        self:StopMovingOrSizing()
        if button == "LeftButton" then
            DragonSkill.UI:Toggle()
        end
        -- Save position logic could be added here
    end)

    -- Position calculation
    local function UpdatePosition(pos)
        local angle = rad(pos or 225)
        local x = cos(angle) * 80
        local y = sin(angle) * 80
        f:SetPoint("CENTER", Minimap, "CENTER", x, y)
    end

    UpdatePosition(db.pos)

    if db.hide then f:Hide() else f:Show() end
    self.frame = f
end

-- Refresh visibility
function MinimapBtn:Refresh()
    if not self.frame then return end
    if DragonSkillDB.minimap.hide then self.frame:Hide() else self.frame:Show() end
end

-- Slash command to toggle
function MinimapBtn:Toggle()
    DragonSkillDB.minimap.hide = not DragonSkillDB.minimap.hide
    self:Refresh()
    print("|cff00ff00Dragon Skill:|r Minimap Button " .. (DragonSkillDB.minimap.hide and "ausgeblendet." or "eingeblendet."))
end

DragonSkill.Events:On("PLAYER_LOGIN", function() MinimapBtn:Init() end)
