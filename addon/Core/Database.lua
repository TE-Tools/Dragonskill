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

DragonSkill = DragonSkill or {}
DragonSkill.Database = Database

DragonSkill.Events:On("ADDON_LOADED", function(loadedAddon)
    if loadedAddon == "DragonSkill" then
        Database:Init()
    end
end)
