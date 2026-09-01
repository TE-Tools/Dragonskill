-- Dragon Skill - Minimap Button (v2.3.7)
-- Saves angle position after drag.

local MinimapBtn = {}
DragonSkill.Minimap = MinimapBtn

local function AngleFromCursor()
    local mx, my = Minimap:GetCenter()
    local cx, cy = GetCursorPosition()
    local scale = Minimap:GetEffectiveScale()
    cx, cy = cx / scale, cy / scale
    local dx, dy = cx - mx, cy - my
    local angle = math.deg(math.atan2(dy, dx))
    if angle < 0 then angle = angle + 360 end
    return angle
end

local function UpdatePosition(f, pos)
    local angle = math.rad(pos or 225)
    local x = math.cos(angle) * 80
    local y = math.sin(angle) * 80
    f:ClearAllPoints()
    f:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function MinimapBtn:Init()
    if self.frame then return end

    if not DragonSkillDB then DragonSkillDB = {} end
    local db = DragonSkillDB.minimap or { hide = false, pos = 225 }
    DragonSkillDB.minimap = db

    local f = CreateFrame("Button", "DragonSkillMinimapButton", Minimap)
    f:SetSize(32, 32)
    f:SetFrameStrata("MEDIUM")
    f:SetFrameLevel(10)
    f:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local bg = f:CreateTexture(nil, "BACKGROUND")
    bg:SetSize(20, 20)
    bg:SetPoint("CENTER", 0, 0)
    bg:SetTexture("Interface\\Icons\\Inv_misc_head_dragon_01")
    f.bg = bg

    local border = f:CreateTexture(nil, "OVERLAY")
    border:SetSize(52, 52)
    border:SetPoint("TOPLEFT", 0, 0)
    border:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Border")

    f:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_LEFT")
        GameTooltip:SetText("|cffffd100Dragon Skill|r")
        GameTooltip:AddLine("Linksklick: Öffnen/Schließen", 1, 1, 1)
        GameTooltip:AddLine("Rechtsklick: Verschieben", 0.8, 0.8, 0.8)
        GameTooltip:Show()
    end)
    f:SetScript("OnLeave", function() GameTooltip:Hide() end)

    f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    f:RegisterForDrag("RightButton")
    f:SetMovable(true)

    f:SetScript("OnDragStart", function(selfBtn)
        selfBtn.dragging = true
        selfBtn:SetScript("OnUpdate", function(btn)
            local pos = AngleFromCursor()
            UpdatePosition(btn, pos)
            btn._pos = pos
        end)
    end)

    f:SetScript("OnDragStop", function(selfBtn)
        selfBtn.dragging = false
        selfBtn:SetScript("OnUpdate", nil)
        local pos = selfBtn._pos or AngleFromCursor()
        if DragonSkillDB and DragonSkillDB.minimap then
            DragonSkillDB.minimap.pos = pos
        end
        UpdatePosition(selfBtn, pos)
    end)

    f:SetScript("OnClick", function(selfBtn, button)
        if button == "LeftButton" and not selfBtn.dragging then
            if DragonSkill.UI then DragonSkill.UI:Toggle() end
        end
    end)

    UpdatePosition(f, db.pos or 225)
    if db.hide then f:Hide() else f:Show() end
    self.frame = f
end

function MinimapBtn:Refresh()
    if not self.frame then return end
    if DragonSkillDB and DragonSkillDB.minimap and DragonSkillDB.minimap.hide then
        self.frame:Hide()
    else
        self.frame:Show()
    end
end

function MinimapBtn:Toggle()
    if not DragonSkillDB then DragonSkillDB = {} end
    DragonSkillDB.minimap = DragonSkillDB.minimap or { hide = false, pos = 225 }
    DragonSkillDB.minimap.hide = not DragonSkillDB.minimap.hide
    self:Refresh()
    print("|cff00ff00Dragon Skill:|r Minimap Button " ..
        (DragonSkillDB.minimap.hide and "ausgeblendet." or "eingeblendet."))
end

DragonSkill.Events:On("PLAYER_LOGIN", function() MinimapBtn:Init() end)
