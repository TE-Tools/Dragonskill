-- Dragon Skill - Modern UI Theme (v2.5.0)
-- Shared dark, flat, class-color-accented look used by the main window and
-- the AI Coach chat panel. Pure CreateTexture/font code - no bundled art
-- assets required, so it works the same for every player out of the box.

local Theme = DragonSkill:RegisterModule("Theme", {})

Theme.bgDeep         = { 0.047, 0.051, 0.063, 0.97 } -- outer frame background
Theme.bgPanel        = { 0.086, 0.090, 0.106, 0.92 } -- header / card surface
Theme.bgPanelAlt     = { 0.067, 0.071, 0.086, 0.85 } -- scroll body surface
Theme.hairline       = { 1, 1, 1, 0.06 }
Theme.hairlineStrong = { 1, 1, 1, 0.14 }

Theme.textPrimary   = { 0.93, 0.94, 0.97 }
Theme.textSecondary = { 0.58, 0.61, 0.69 }
Theme.textMuted     = { 0.42, 0.44, 0.51 }

Theme.success = { 0.35, 0.82, 0.53 }
Theme.warn    = { 0.95, 0.75, 0.25 }
Theme.danger  = { 0.92, 0.35, 0.38 }
Theme.bis     = { 0.64, 0.21, 0.93 } -- epic purple, used for "BiS target" tags

-- The player's class color, used as the single accent color throughout the
-- UI (active tab, header name, hover highlight, top accent bar) so the
-- whole window feels tied together and personalized instead of one static
-- gold color everywhere.
function Theme:GetAccent()
    local _, class = UnitClass("player")
    local c = RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]
    if c then return c.r, c.g, c.b end
    return 1, 0.82, 0
end

function Theme:GetAccentHex()
    local r, g, b = self:GetAccent()
    return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

function Theme:Hex(color)
    return string.format("|cff%02x%02x%02x", color[1] * 255, color[2] * 255, color[3] * 255)
end

-- Flat panel with a crisp 1px hairline border on all four sides. Reads as a
-- modern flat "card" instead of the classic beveled tooltip-border look.
function Theme:Panel(parent, bgColor, borderColor)
    local f = CreateFrame("Frame", nil, parent)
    local bg = f:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(unpack(bgColor or self.bgPanel))
    f.bg = bg

    local bc = borderColor or self.hairline
    local top = f:CreateTexture(nil, "BORDER")
    top:SetColorTexture(unpack(bc)); top:SetPoint("TOPLEFT"); top:SetPoint("TOPRIGHT"); top:SetHeight(1)
    local bottom = f:CreateTexture(nil, "BORDER")
    bottom:SetColorTexture(unpack(bc)); bottom:SetPoint("BOTTOMLEFT"); bottom:SetPoint("BOTTOMRIGHT"); bottom:SetHeight(1)
    local left = f:CreateTexture(nil, "BORDER")
    left:SetColorTexture(unpack(bc)); left:SetPoint("TOPLEFT"); left:SetPoint("BOTTOMLEFT"); left:SetWidth(1)
    local right = f:CreateTexture(nil, "BORDER")
    right:SetColorTexture(unpack(bc)); right:SetPoint("TOPRIGHT"); right:SetPoint("BOTTOMRIGHT"); right:SetWidth(1)
    f.border = { top = top, bottom = bottom, left = left, right = right }

    function f:SetBorderColor(r, g, b, a)
        for _, line in pairs(self.border) do line:SetColorTexture(r, g, b, a or 1) end
    end
    return f
end

DragonSkill.Theme = Theme
