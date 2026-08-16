-- Dragon Skill - Core Namespace
-- Stellt einen einzigen globalen Einstiegspunkt bereit, alles andere bleibt lokal/gekapselt.

local ADDON_NAME = ...

DragonSkill = DragonSkill or {}
DragonSkill.Modules = {}
DragonSkill.version = "0.1.0"
DragonSkill.author = "wear-alleria"

-- Interner Namespace für Datei-zu-Datei Kommunikation (nicht global sichtbar)
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
