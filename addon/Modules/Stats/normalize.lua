-- normalize.lua (expanded)
-- Utility to normalize stat names extracted from guide text to canonical keys used in the addon.
-- Exports: DragonSkill.Utils.NormalizeStatName(str) -> canonical string or nil

local mapping = {
    ["crit"] = "CriticalStrike",
    ["critical"] = "CriticalStrike",
    ["critical strike"] = "CriticalStrike",
    ["critical strike chance"] = "CriticalStrike",
    ["crit chance"] = "CriticalStrike",
    ["crit%"] = "CriticalStrike",
    ["crit percent"] = "CriticalStrike",
    ["crit rating"] = "CriticalStrike",

    ["haste"] = "Haste",
    ["haste%"] = "Haste",
    ["haste rating"] = "Haste",

    ["mastery"] = "Mastery",
    ["mastery%"] = "Mastery",

    ["versatility"] = "Versatility",
    ["vers"] = "Versatility",
    ["versatility damage done"] = "Versatility",

    ["leech"] = "Leech",
    ["stamina"] = "Stamina",
    ["intellect"] = "Intellect",
    ["agility"] = "Agility",
    ["strength"] = "Strength",

    ["critstr"] = "CriticalStrike",
    ["critstrike"] = "CriticalStrike",
}

local function normalizeText(s)
    if not s then return nil end
    local t = s:lower()
    -- remove punctuation except %
    t = t:gsub("[^%w%s%%]", "")
    -- trim
    t = t:match("^%s*(.-)%s*$") or t
    return t
end

local function canonicalize(name)
    local t = normalizeText(name)
    if not t then return nil end
    if mapping[t] then return mapping[t] end
    -- try to match words inside the string
    for k,v in pairs(mapping) do
        if t:find(k, 1, true) then return v end
    end
    -- fallback: return TitleCase of the input (remove spaces)
    local out = t:gsub("(%a)([%w_']*)", function(a,b) return a:upper() .. b:lower() end)
    out = out:gsub("%s+", "")
    return out
end

-- Export to global addon table for other modules to use
DragonSkill = DragonSkill or {}
DragonSkill.Utils = DragonSkill.Utils or {}
DragonSkill.Utils.NormalizeStatName = canonicalize

-- simple local return for require-style inclusion
return {
    NormalizeStatName = canonicalize
}
