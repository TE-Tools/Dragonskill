-- Dragon Skill - Database Layer (v1.5.8)

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
    DragonSkillDB.favorites = DragonSkillDB.favorites or {}
    DragonSkillDB.history = DragonSkillDB.history or {}
    DragonSkillDB.minimap = DragonSkillDB.minimap or { hide = false }
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

function Database:GetBiSData(class, spec)
    -- Try new structured GearData first
    if DragonSkillGearData and DragonSkillGearData.specs[class] and DragonSkillGearData.specs[class][spec] then
        return DragonSkillGearData.specs[class][spec]
    end
    -- Fallback to legacy GuideData format
    local legacy = self:GetGuideData(class, spec)
    if legacy and legacy.bisGear then
        return {
            items = legacy.bisGear.wowhead or {},
            legacy = true
        }
    end
    return nil
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

-- filterCurrentSpec: wenn true, nur Skillungen der aktuellen Klasse/Spec
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
            -- Einträge ohne class/specID weiter anzeigen (Legacy)
            local matchClass = not data.class or data.class == class
            local matchSpec = not data.specID or not specID or data.specID == specID
            if not (matchClass and matchSpec) then
                -- skip
            else
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
