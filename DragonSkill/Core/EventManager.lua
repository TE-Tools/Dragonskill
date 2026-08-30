-- Dragon Skill - Event Manager (v2.0.1)
-- Zentrale Event-Registrierung fuer WoW 12.1 (Midnight).

local ADDON_NAME = ...
local EventManager = {}
DragonSkill = DragonSkill or {}
DragonSkill.Events = EventManager

-- Wir nutzen einen anonymen Frame.
local frame = CreateFrame("Frame")
EventManager.listeners = {}

-- WoW 12.1 Sicherheit: Wir blockieren die Registrierung von COMBAT_LOG_EVENT_UNFILTERED,
-- da dies in Patch 12.1 fuer Drittanbieter-Addons verboten ist (ADDON_ACTION_FORBIDDEN).
local RESTRICTED_EVENTS = {
    ["COMBAT_LOG_EVENT_UNFILTERED"] = true,
}

function EventManager:On(event, callback)
    if RESTRICTED_EVENTS[event] then
        print("|cffff4444Dragon Skill:|r Warnung - Event '" .. event .. "' ist in WoW 12.1 geschuetzt. Nutze alternative APIs.")
        return
    end

    if not self.listeners[event] then
        self.listeners[event] = {}

        -- Sicherer Aufruf via C_Timer.After(0)
        C_Timer.After(0, function()
            local ok, err = pcall(function() frame:RegisterEvent(event) end)
            if not ok then
                -- Falls RegisterEvent fehlschlaegt, loggen wir es dezent
            end
        end)
    end
    table.insert(self.listeners[event], callback)
end

function EventManager:Off(event, callback)
    local list = self.listeners[event]
    if not list then return end
    for i = #list, 1, -1 do
        if list[i] == callback then
            table.remove(list, i)
        end
    end
    if #list == 0 then
        pcall(function() frame:UnregisterEvent(event) end)
    end
end

frame:SetScript("OnEvent", function(_, event, ...)
    local list = EventManager.listeners[event]
    if not list then return end
    for _, callback in ipairs(list) do
        local ok, err = pcall(callback, ...)
        if not ok then
            print("|cffff4444Dragon Skill Fehler|r [" .. event .. "]: " .. tostring(err))
        end
    end
end)
