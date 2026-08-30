-- Dragon Skill - Event Manager (v1.9.8)
-- Zentrale Event-Registrierung.

local ADDON_NAME = ...
local EventManager = {}
DragonSkill = DragonSkill or {}
DragonSkill.Events = EventManager

-- Wir nutzen einen anonymen Frame.
local frame = CreateFrame("Frame")
EventManager.listeners = {}

-- WoW 12.1 Fix: Wir verzögern die Registrierung minimal.
-- Dies verhindert ADDON_ACTION_FORBIDDEN während des initialen Ladens.
function EventManager:On(event, callback)
    if not self.listeners[event] then
        self.listeners[event] = {}

        -- Sicherer Aufruf via C_Timer.After, um den Callstack zu säubern.
        C_Timer.After(0, function()
            local ok, err = pcall(function() frame:RegisterEvent(event) end)
            if not ok then
                -- Fallback: Manche Events in 12.1 benötigen einen benannten Frame
                if not self.namedFrame then
                    self.namedFrame = CreateFrame("Frame", "DragonSkillSecureEventFrame")
                end
                pcall(function() self.namedFrame:RegisterEvent(event) end)
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
        if self.namedFrame then pcall(function() self.namedFrame:UnregisterEvent(event) end) end
    end
end

local function HandleEvent(e, ...)
    local list = EventManager.listeners[e]
    if not list then return end
    for _, callback in ipairs(list) do
        local ok, err = pcall(callback, ...)
        if not ok then
            print("|cffff4444Dragon Skill Fehler|r [" .. e .. "]: " .. tostring(err))
        end
    end
end

frame:SetScript("OnEvent", function(_, event, ...) HandleEvent(event, ...) end)

-- Falls der benannte Fallback-Frame genutzt wird, leiten wir auch dort weiter
C_Timer.After(0.1, function()
    if EventManager.namedFrame then
        EventManager.namedFrame:SetScript("OnEvent", function(_, event, ...) HandleEvent(event, ...) end)
    end
end)
