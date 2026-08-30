-- Dragon Skill - Event Manager (v1.7.8)
-- Zentrale Event-Registrierung.

local ADDON_NAME = ...
local EventManager = {}
DragonSkill = DragonSkill or {}
DragonSkill.Events = EventManager

-- Wir nutzen einen benannten Frame, um Blizzard-Blockaden zu minimieren.
local frame = CreateFrame("Frame", "DragonSkillEventFrame")
EventManager.listeners = {}

function EventManager:On(event, callback)
    if not self.listeners[event] then
        self.listeners[event] = {}
        -- Wir nutzen pcall, falls Blizzard bestimmte Events fuer Addons sperrt
        local ok, err = pcall(function() frame:RegisterEvent(event) end)
        if not ok then
            print("|cffff4444Dragon Skill:|r Konnte Event nicht registrieren: " .. tostring(event))
        end
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
