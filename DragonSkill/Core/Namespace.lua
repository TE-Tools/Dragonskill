-- Dragon Skill - Core Namespace
local ADDON_NAME = ...

DragonSkill = DragonSkill or {}
DragonSkill.Modules = {}
DragonSkill.version = "2.1.6"
DragonSkill.author = "wear-alleria"

local ns = select(2, ...) or {}
_G[ADDON_NAME .. "_NS"] = ns

function DragonSkill:RegisterModule(name, moduleTable)
    if self.Modules[name] then
        error("Dragon Skill: Modul '" .. name .. "' bereits registriert.")
    end
    self.Modules[name] = moduleTable
    return moduleTable
end

function DragonSkill:GetModule(name)
    return self.Modules[name]
end
