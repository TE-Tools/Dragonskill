-- Dragon Skill - Database Layer
-- Verwaltet SavedVariables (Nutzerdaten) getrennt von gebündelten Guide-Daten (aus dem Scraper).

local Database = {}

function Database:Init()
    DragonSkillDB = DragonSkillDB or {
        version = DragonSkill.version,
        favorites = {},
        history = {}
    }
    DragonSkillCharDB = DragonSkillCharDB or {
        lastComparedBuild = nil
    }
    self.account = DragonSkillDB
    self.char = DragonSkillCharDB
end

-- Guide-Daten sind separate Lua-Dateien, die vom Scraper-Output generiert werden,
-- z.B. Data/warrior_protection.lua mit: DragonSkillData = DragonSkillData or {}; DragonSkillData["WARRIOR"]["PROTECTION"] = {...}
function Database:GetGuideData(class, spec)
    if not DragonSkillData then return nil end
    local classData = DragonSkillData[class]
    if not classData then return nil end
    return classData[spec]
end

-- Erstelle ein neues "Skilling"-Eintrag in den SavedVariables (favorites).
-- name: string, data: table (z.B. { importString = "...", provider=..., label=... })
function Database:CreateSkilling(name, data)
    if not name or name == "" then
        -- Fallback: generiere einen Auto-Namen
        name = self:GenerateAutoSkillingName()
    end
    self.account.favorites = self.account.favorites or {}
    -- Falls Name bereits existiert, füge einen Zähler an
    local finalName = name
    local i = 1
    while self.account.favorites[finalName] do
        i = i + 1
        finalName = string.format("%s-%d", name, i)
    end
    data = data or {}
    data.createdAt = date("!%Y-%m-%dT%H:%M:%SZ")
    self.account.favorites[finalName] = data
    return finalName
end

-- Generiert einen autonamen im Format: <Provider>_<Label>_<YYYY-MM-DD>_<HH:MM>
function Database:GenerateAutoSkillingName(data)
    local provider = data and data.provider or "Manual"
    local label = data and data.label or "Build"
    local ts = date("%Y-%m-%d %H:%M")
    return string.format("%s: %s (%s)", provider, label, ts)
end

DragonSkill = DragonSkill or {}
DragonSkill.Database = Database

DragonSkill.Events:On("ADDON_LOADED", function(loadedAddon)
    if loadedAddon == "DragonSkill" then
        Database:Init()
    end
end)
