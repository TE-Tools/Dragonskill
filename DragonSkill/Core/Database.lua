-- Dragon Skill - Database Layer (v2.3.6)
-- Enhanced with Auto-Cleanup for Patch 12.1 Purity.

local Database = {}

function Database:Init()
    DragonSkillDB = DragonSkillDB or {
        version = DragonSkill.version,
        favorites = {},
        history = {},
        minimap = { hide = false, pos = 225 },
        ai = { enabled = false, provider = "openai", apiKey = "", lastResponse = "", pendingQuery = nil },
    }
    DragonSkillCharDB = DragonSkillCharDB or {
        lastComparedBuild = nil,
    }

    -- Cleanup Old Data (Purge Season 1 / TWW 11.0 entries)
    if DragonSkillDB.version and DragonSkillDB.version < "2.3.0" then
        print("|cff00ff00Dragon Skill:|r Säubere alte Daten für Patch 12.1...")
        DragonSkillDB.history = {}
        -- We keep favorites but they might be filtered by GearManager purity check anyway
    end

    DragonSkillDB.favorites = DragonSkillDB.favorites or {}
    DragonSkillDB.history = DragonSkillDB.history or {}
    DragonSkillDB.minimap = DragonSkillDB.minimap or { hide = false, pos = 225 }
    DragonSkillDB.version = DragonSkill.version or DragonSkillDB.version

    self.account = DragonSkillDB
    self.char = DragonSkillCharDB
end

function Database:GetGuideData(class, spec)
    if not DragonSkillData then return nil end
    local classData = DragonSkillData[class]
    if not classData then return nil end
    return classData[spec]
end

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

function Database:GetSkillings(filterCurrentSpec)
    if not self.account then self:Init() end
    local list = {}
    local favs = self.account.favorites or {}

    local class, specID
    if filterCurrentSpec then
        class = select(2, UnitClass("player"))
        local idx = GetSpecialization()
        specID = idx and select(1, GetSpecializationInfo(idx)) or nil
    end

    for name, data in pairs(favs) do
        if filterCurrentSpec and class and data then
            local matchClass = not data.class or data.class == class
            local matchSpec = not data.specID or not specID or data.specID == specID
            if matchClass and matchSpec then
                table.insert(list, { name = name, data = data })
            end
        else
            table.insert(list, { name = name, data = data })
        end
    end

    table.sort(list, function(a, b)
        local ca = (a.data and a.data.createdAt) or ""
        local cb = (b.data and b.data.createdAt) or ""
        if ca == cb then return tostring(a.name) < tostring(b.name) end
        return ca > cb
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

DragonSkill = DragonSkill or {}
DragonSkill.Database = Database

DragonSkill.Events:On("ADDON_LOADED", function(loadedAddon)
    if loadedAddon == "DragonSkill" then
        Database:Init()
    end
end)
