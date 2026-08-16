-- Dragon Skill - Database Layer (v1.5.2)
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
    -- Migration / Defaults
    DragonSkillDB.favorites = DragonSkillDB.favorites or {}
    DragonSkillDB.history = DragonSkillDB.history or {}
    DragonSkillDB.version = DragonSkill.version or DragonSkillDB.version

    self.account = DragonSkillDB
    self.char = DragonSkillCharDB
end

-- Guide-Daten sind separate Lua-Dateien, die vom Scraper-Output generiert werden.
function Database:GetGuideData(class, spec)
    if not DragonSkillData then return nil end
    local classData = DragonSkillData[class]
    if not classData then return nil end
    return classData[spec]
end

-- Erstelle ein neues "Skilling"-Eintrag in den SavedVariables (favorites).
-- name: string, data: table (z.B. { importString = "...", provider=..., label=... })
function Database:CreateSkilling(name, data)
    if not self.account then self:Init() end
    data = data or {}

    if not name or name == "" then
        name = self:GenerateAutoSkillingName(data)
    end

    self.account.favorites = self.account.favorites or {}

    local finalName = name
    local i = 1
    while self.account.favorites[finalName] do
        i = i + 1
        finalName = string.format("%s-%d", name, i)
    end

    -- Shallow-Kopie, damit Guide-Tabellen nicht mutiert werden
    local entry = {
        importString = data.importString,
        provider = data.provider,
        label = data.label or finalName,
        class = data.class,
        specID = data.specID,
        createdAt = date("!%Y-%m-%dT%H:%M:%SZ"),
    }
    self.account.favorites[finalName] = entry
    return finalName
end

function Database:GenerateAutoSkillingName(data)
    local provider = (data and data.provider) or "Manual"
    local label = (data and data.label) or "Build"
    local ts = date("%Y-%m-%d %H:%M")
    return string.format("%s: %s (%s)", tostring(provider), tostring(label), ts)
end

-- Sortierte Liste der Favoriten: { { name = "...", data = {...} }, ... }
function Database:GetSkillings()
    if not self.account then self:Init() end
    local list = {}
    local favs = self.account.favorites or {}
    for name, data in pairs(favs) do
        table.insert(list, { name = name, data = data })
    end
    table.sort(list, function(a, b)
        local ca = (a.data and a.data.createdAt) or ""
        local cb = (b.data and b.data.createdAt) or ""
        if ca == cb then return tostring(a.name) < tostring(b.name) end
        return ca > cb -- neueste zuerst
    end)
    return list
end

function Database:DeleteSkilling(name)
    if not self.account then self:Init() end
    if not name or not self.account.favorites then return false end
    if self.account.favorites[name] then
        self.account.favorites[name] = nil
        return true
    end
    return false
end

function Database:GetSkilling(name)
    if not self.account then self:Init() end
    if not name or not self.account.favorites then return nil end
    return self.account.favorites[name]
end

DragonSkill = DragonSkill or {}
DragonSkill.Database = Database

DragonSkill.Events:On("ADDON_LOADED", function(loadedAddon)
    if loadedAddon == "DragonSkill" then
        Database:Init()
    end
end)
