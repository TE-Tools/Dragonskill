-- Dragon Skill - Event Manager (v1.5.1)
-- Zentrale Event-Registrierung über einen anonymen Frame zur Vermeidung von Blizzard-Blockaden.

local ADDON_NAME = ...
local EventManager = {}

-- Wir nutzen einen anonymen Frame ohne globalen Namen.
-- Dies verhindert "ADDON_ACTION_FORBIDDEN" Fehler in WoW 12.1.
local frame = CreateFrame("Frame")
EventManager.listeners = {}

function EventManager:On(event, callback)
    if not self.listeners[event] then
        self.listeners[event] = {}
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

DragonSkill = DragonSkill or {}
DragonSkill.Events = EventManager
