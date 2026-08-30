-- Dragon Skill - Event Manager (v1.9.7)
-- Zentrale Event-Registrierung.

local ADDON_NAME = ...
local EventManager = {}
DragonSkill = DragonSkill or {}
DragonSkill.Events = EventManager

-- Wir nutzen einen anonymen Frame.
local frame = CreateFrame("Frame")
EventManager.listeners = {}

-- WoW 12.1 Fix: Wir registrieren Events so früh wie möglich.
function EventManager:On(event, callback)
    if not self.listeners[event] then
        self.listeners[event] = {}
        -- Wir registrieren das Event sofort.
        -- In 12.1 darf dies NICHT aus einem geschützten Callstack passieren.
        frame:RegisterEvent(event)
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
        frame:UnregisterEvent(event)
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
