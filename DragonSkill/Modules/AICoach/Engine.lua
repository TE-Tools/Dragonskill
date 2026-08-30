-- Dragon Skill - Module: AI Coach Engine (v2.0.5)
-- Hybrid Engine: Fixed instant local responses.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    context = {}
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "trinket", "brust", "ring", "waffe"},
    FARM = {"farm", "ini", "dungeon", "laufen", "route", "heute"},
    UPGRADE = {"upgrade", "besser", "austauschen", "verbessern"},
    INVENTORY = {"tasche", "bag", "dabei", "inventar"},
    STATS = {"stats", "werte", "prio", "prioritaet", "haste", "mastery"},
    VAULT = {"vault", "kammer", "schatzkammer"},
    CATALYST = {"catalyst", "katalysator", "tier", "set"},
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

    if not GM or not Char then return "Daten-Module laden noch..." end

    -- 1. Always give the Local Response (Instant facts)
    local reply = self:GetLocalReply(msg, GM, Char)

    -- 2. Parallel outbound request if AI is active
    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        self:TriggerExternalQuery(msg, GM, Char)
        reply = reply .. "\n\n|cff00ccff(KI-Anfrage wurde parallel gesendet. Klick auf 'Synchronisieren' wenn die Bridge fertig ist.)|r"
    end

    return reply
end

function AICoach:GetLocalReply(msg, GM, Char)
    local intents = self:ParseIntent(msg)
    msg = msg:lower()

    if intents.INVENTORY then
        local upgrades = Char:GetInventoryUpgrades()
        if upgrades and #upgrades > 0 then return "Ich habe Upgrades in deinen Taschen gefunden! Schau im Upgrades-Tab nach." end
        return "Keine besseren Items in deinen Taschen gefunden."
    end

    if intents.VAULT then return GM:GetVaultRecommendation() end
    if intents.CATALYST then return GM:GetCatalystRecommendation() end

    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups and ups[1] then
            return string.format("Upgrade: |cffffd100%s|r (%s). Steigerung: |cff00ff00+%.1f%%|r.", ups[1].name, ups[1].slot, ups[1].percent or 0)
        end
    end

    if intents.FARM then
        local plan = GM:GetFarmPlan()
        if plan and plan[1] then return "Die beste Ini heute: |cffffd100" .. plan[1].name .. "|r. Dort droppen deine wichtigsten Upgrades." end
    end

    return "Ich antworte momentan lokal. Frag mich nach 'Farmen', 'Upgrades' oder 'Tasche'."
end

function AICoach:TriggerExternalQuery(msg, GM, Char)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local spec = specIndex and select(2, GetSpecializationInfo(specIndex)) or "Spec"
    local upgrades = GM:GetBestUpgrades()

    DragonSkillDB.ai.pendingQuery = {
        question = msg,
        context = string.format("Class: %s, Spec: %s. TopUpgrade: %s.", class, spec, upgrades[1] and upgrades[1].name or "None"),
        timestamp = GetTime(),
        status = "SENT",
        provider = DragonSkillDB.ai.provider or "openai",
        apiKey = DragonSkillDB.ai.apiKey
    }
end
