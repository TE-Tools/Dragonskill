-- Dragon Skill - Module: AI Coach Engine (v2.0.2)
-- Local Facts Engine and Hybrid Intelligence.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    context = {}
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "trinket", "brust", "ring", "waffe"},
    FARM = {"farm", "ini", "dungeon", "laufen", "route", "heute"},
    UPGRADE = {"upgrade", "besser", "austauschen", "verbessern"},
    INVENTORY = {"tasche", "bag", "dabei", "inventar"},
    STATS = {"stats", "werte", "prio", "haste", "mastery"},
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

    if not GM or not Char then return "Einige Addon-Module sind noch nicht bereit." end

    -- Check for external AI first
    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        return self:GetExternalReply(msg)
    end

    return self:GetLocalReply(msg, GM, Char)
end

function AICoach:GetLocalReply(msg, GM, Char)
    local intents = self:ParseIntent(msg)
    msg = msg:lower()

    if intents.VAULT then
        return GM:GetVaultRecommendation()
    end

    if intents.CATALYST then
        return GM:GetCatalystRecommendation()
    end

    if intents.INVENTORY then
        local upgrades = Char:GetInventoryUpgrades()
        if upgrades and #upgrades > 0 then
            return "Ich habe |cff00ff00" .. #upgrades .. " Upgrades|r in deinen Taschen gefunden! Schau im Upgrades-Tab nach."
        end
        return "Keine besseren Items in deinen Taschen gefunden."
    end

    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups and ups[1] then
            return string.format("Dein naechstes Ziel ist |cffffd100%s|r (%s). Es bringt eine Steigerung von |cff00ff00%.1f%%|r.", ups[1].name, ups[1].slot, ups[1].percent or 0)
        end
    end

    if intents.FARM then
        local plan = GM:GetFarmPlan()
        if plan and plan[1] then
            return "Die beste Ini heute ist |cffffd100" .. plan[1].name .. "|r. Dort droppen deine wichtigsten Upgrades."
        end
    end

    if intents.STATS then
        local prio = Char:GetStatPriority()
        if prio and prio.wowhead then
            return "Prioritaet laut Guide: |cffffd100" .. prio.wowhead .. "|r."
        end
    end

    return "Frag mich nach: 'Farmen', 'Upgrades', 'Vault', 'Catalyst' oder 'Tasche'."
end

function AICoach:GetExternalReply(msg)
    local GM = DragonSkill:GetModule("GearManager")
    local Char = DragonSkill:GetModule("Character")
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local spec = specIndex and select(2, GetSpecializationInfo(specIndex)) or "Spec"
    local upgrades = GM:GetBestUpgrades()

    local contextStr = string.format("Char: %s %s, Ilvl: %.1f. TopUpgrade: %s.",
        class, spec, select(2, GetAverageItemLevel()),
        upgrades[1] and upgrades[1].name or "None"
    )

    DragonSkillDB.ai.pendingQuery = {
        question = msg,
        context = contextStr,
        timestamp = GetTime(),
        status = "SENT",
        provider = DragonSkillDB.ai.provider or "openai",
        apiKey = DragonSkillDB.ai.apiKey
    }

    local pName = (DragonSkillDB.ai.provider == "claude") and "Claude" or "OpenAI"
    return "|cff00ccff(Anfrage an " .. pName .. " gesendet...)|r\n|cff888888Warte auf Bridge-Programm auf deinem Desktop. Sobald dort 'Fertig' steht, nutze /reload.|r"
end
