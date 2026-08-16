-- Dragon Skill - Database Layer
-- Verwaltet SavedVariables (Nutzerdaten) getrennt von gebündelten Guide-Daten (aus dem Scraper).

local Database = {}

function Database:Init()
    DragonSkillDB = DragonSkillDB or {
        version = DragonSkill.version,
        favorites = {},
        history = {}
    }
    DragonSkillDB.favorites = DragonSkillDB.favorites or {}
    DragonSkillDB.history = DragonSkillDB.history or {}
    DragonSkillCharDB = DragonSkillCharDB or {
        lastComparedBuild = nil
    }
    self.account = DragonSkillDB
    self.char = DragonSkillCharDB
end

function Database:GetGuideData(class, spec)
    if not DragonSkillData then return nil end
    local classData = DragonSkillData[class]
    if not classData then return nil end
    return classData[spec]
end

-- Erstelle ein neues "Skilling"-Eintrag in den SavedVariables (favorites).
-- name: string|nil, data: table (z.B. { importString = "...", provider=..., label=... })
function Database:CreateSkilling(name, data)
    data = data or {}
    if not name or name == "" then
        name = self:GenerateAutoSkillingName(data)
    end
    self.account = self.account or DragonSkillDB
    if not self.account then
        self:Init()
    end
    self.account.favorites = self.account.favorites or {}

    local finalName = name
    local i = 1
    while self.account.favorites[finalName] do
        i = i + 1
        finalName = string.format("%s-%d", name, i)
    end

    -- Kopie, damit das Original-Build-Objekt nicht mutiert wird
    local stored = {
        importString = data.importString,
        provider = data.provider or "Manual",
        label = data.label or "Build",
        createdAt = date("!%Y-%m-%dT%H:%M:%SZ"),
    }
    self.account.favorites[finalName] = stored
    return finalName
end

function Database:GenerateAutoSkillingName(data)
    local provider = data and data.provider or "Manual"
    local label = data and data.label or "Build"
    local ts = date("%Y-%m-%d %H:%M")
    return string.format("%s: %s (%s)", tostring(provider):upper(), tostring(label), ts)
end

-- Sortierte Liste { { name = "...", data = {...} }, ... }
function Database:GetSkillings()
    if not self.account then self:Init() end
    local list = {}
    local favs = (self.account and self.account.favorites) or {}
    for name, data in pairs(favs) do
        if type(data) == "table" and data.importString then
            table.insert(list, { name = name, data = data })
        end
    end
    table.sort(list, function(a, b)
        local ca = a.data.createdAt or ""
        local cb = b.data.createdAt or ""
        if ca ~= cb then return ca > cb end
        return a.name < b.name
    end)
    return list
end

function Database:DeleteSkilling(name)
    if not self.account then self:Init() end
    if self.account.favorites and name then
        self.account.favorites[name] = nil
        return true
    end
    return false
end

function Database:GetSkilling(name)
    if not self.account then self:Init() end
    return self.account.favorites and self.account.favorites[name]
end

DragonSkill = DragonSkill or {}
DragonSkill.Database = Database

DragonSkill.Events:On("ADDON_LOADED", function(loadedAddon)
    if loadedAddon == "DragonSkill" then
        Database:Init()
    end
end)
