-- Dragon Skill - Module: AI Coach Engine (v1.9.0)
-- Hybrid Engine: Local Facts + External AI Bridge support.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    history = {},
    context = {
        lastItem = nil,
        lastDungeon = nil,
    }
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "trinket", "brust", "ring", "waffe"},
    FARM = {"farm", "ini", "dungeon", "laufen", "route", "heute"},
    UPGRADE = {"upgrade", "besser", "austauschen", "verbessern"},
    INVENTORY = {"tasche", "bag", "dabei", "inventar"},
    STATS = {"stats", "werte", "prio", "haste", "mastery"},
    TIME = {"minuten", "stunden", "zeit"},
    FOLLOWUP = {"wo", "warum", "danach"}
}

function AICoach:ParseIntent(msg)
    msg = msg:lower()
    local detected = {}
    for intent, keywords in pairs(INTENTS) do
        for _, word in ipairs(keywords) do
            if msg:find(word) then detected[intent] = true; break end
        end
    end
    return detected
end

function AICoach:GetReply(msg)
    local GM = DragonSkill:GetModule("GearManager")
    local Char = DragonSkill:GetModule("Character")

    -- Check if External AI (Mode 2/3) is active
    if DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        return self:GetExternalReply(msg)
    end

    return self:GetLocalReply(msg, GM, Char)
end

function AICoach:GetLocalReply(msg, GM, Char)
    local intents = self:ParseIntent(msg)
    msg = msg:lower()

    if msg:find("warum") or msg:find("why") then
        if self.context.lastItem then
            local item = DragonSkillGearData.items[self.context.lastItem]
            if item then
                local details = GM:GetUpgradeDetails(item.slot, self.context.lastItem)
                return string.format("Dieses Item verbessert dich um |cff00ff00%.1f%%|r. Es hat ideale Stats für deine Prio.", details.percent)
            end
        end
    end

    if intents.INVENTORY then
        local upgrades = Char:GetInventoryUpgrades()
        return (#upgrades > 0) and "Ich habe Upgrades in deiner Tasche gefunden!" or "Nichts Besseres in der Tasche."
    end

    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups[1] then
            self.context.lastItem = ups[1].itemId
            return string.format("Upgrade: |cffffd100%s|r (+%.1f%%) in %s.", ups[1].name, ups[1].percent, (ups[1].dungeonName or "Dungeon"))
        end
    end

    if intents.FARM then
        local plan = GM:GetFarmPlan()
        return plan[1] and ("Heute farmen: |cffffd100" .. plan[1].name .. "|r (Score: " .. plan[1].score .. ")") or "Kein Farm-Ziel."
    end

    return "Ich antworte lokal. Aktiviere 'KI Einstellungen' für echte KI-Power."
end

-- EXTERNAL AI LOGIC (Outbound via SavedVariables)
function AICoach:GetExternalReply(msg)
    -- Prepare context for the external AI
    local GM = DragonSkill:GetModule("GearManager")
    local Char = DragonSkill:GetModule("Character")
    local _, class = UnitClass("player")
    local spec = select(2, GetSpecializationInfo(GetSpecialization() or 0))
    local upgrades = GM:GetBestUpgrades()

    local contextStr = string.format("Class: %s, Spec: %s, Ilvl: %.1f. Top 2 Upgrades: %s, %s.",
        class, spec, select(2, GetAverageItemLevel()),
        upgrades[1] and upgrades[1].name or "None",
        upgrades[2] and upgrades[2].name or "None"
    )

    -- Write to SavedVariables for the Bridge App
    DragonSkillDB.ai.pendingQuery = {
        question = msg,
        context = contextStr,
        timestamp = GetTime(),
        status = "SENT"
    }

    return "|cff888888(Anfrage an OpenAI gesendet... Warte auf Bridge-Antwort. Nutze '/reload' nach der Antwort.)|r"
end
