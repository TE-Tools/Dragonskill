-- Dragon Skill - Event Manager (v2.0.5)
-- Structural Fix for WoW 12.1 security.

local ADDON_NAME = ...
local EventManager = {}
DragonSkill = DragonSkill or {}
DragonSkill.Events = EventManager

-- Use a local frame to avoid forbidden actions.
local frame = CreateFrame("Frame")
EventManager.listeners = {}

function EventManager:On(event, callback)
    if not self.listeners[event] then
        self.listeners[event] = {}
        -- WoW 12.1 Fix: Use pcall and avoid registering restricted combat events.
        if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then
            pcall(function() frame:RegisterEvent(event) end)
        end
    end
    table.insert(self.listeners[event], callback)
end

function EventManager:Off(event, callback)
    local list = self.listeners[event]
    if not list then return end
    for i = #list, 1, -1 do
        if list[i] == callback then table.remove(list, i) end
    end
    if #list == 0 then pcall(function() frame:UnregisterEvent(event) end) end
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
