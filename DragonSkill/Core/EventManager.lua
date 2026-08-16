-- Dragon Skill - Event Manager
-- Zentrale Event-Registrierung, damit Module nicht jeweils eigene Frames erzeugen müssen.

local ADDON_NAME = ...

local EventManager = {}
EventManager.frame = CreateFrame("Frame", "DragonSkillEventFrame")
EventManager.listeners = {}

function EventManager:On(event, callback)
    if not self.listeners[event] then
        self.listeners[event] = {}
        self.frame:RegisterEvent(event)
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
        self.frame:UnregisterEvent(event)
    end
end

EventManager.frame:SetScript("OnEvent", function(_, event, ...)
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
