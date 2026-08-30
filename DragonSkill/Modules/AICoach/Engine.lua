-- Dragon Skill - Module: AI Coach Engine (v1.8.0)
-- Local Facts Engine and Intent Recognition.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    history = {},
    context = {}
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "gegenstand", "trinket", "schmuck", "brust", "chest", "ring", "waffe", "weapon"},
    FARM = {"farm", "ini", "dungeon", "laufen", "route", "heute", "today"},
    UPGRADE = {"upgrade", "besser", "austauschen", "verbessern"},
    INVENTORY = {"tasche", "bag", "dabei", "inventar"},
    STATS = {"stats", "werte", "prio", "prioritaet", "haste", "mastery", "tempo", "meisterschaft"},
    CATALYST = {"catalyst", "katalysator", "tier", "set"}
}

function AICoach:ParseIntent(msg)
    msg = msg:lower()
    local detected = {}
    for intent, keywords in pairs(INTENTS) do
        for _, word in ipairs(keywords) do
            if msg:find(word) then
                detected[intent] = true
                break
            end
        end
    end
    return detected
end

function AICoach:GetReply(msg)
    local intents = self:ParseIntent(msg)
    local GM = DragonSkill:GetModule("GearManager")
    local Char = DragonSkill:GetModule("Character")

    if intents.INVENTORY then
        local upgrades = Char:GetInventoryUpgrades()
        if upgrades and #upgrades > 0 then
            return "Ja! Ich habe |cff00ff00" .. #upgrades .. " potenzielle Upgrades|r in deinen Taschen gefunden. Schau sie dir im Upgrades-Reiter an."
        else
            return "Ich habe dein Inventar gescannt, aber momentan scheint kein Item darin besser zu sein als dein aktuelles Gear."
        end
    end

    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups[1] then
            self.context.lastItem = ups[1].itemId
            return string.format("Dein naechstes grosses Upgrade ist |cffffd100%s|r (%s). Es hat Prio %d/10. Du bekommst es in %s.",
                ups[1].name, ups[1].slot, ups[1].priority, (ups[1].dungeonName or "einem Dungeon"))
        end
    end

    if intents.FARM then
        local plan = GM:GetFarmPlan()
        if plan[1] then
            return string.format("Die effektivste Route fuer dich ist heute |cffffd100%s|r. Dort hast du die hoechste Chance auf Upgrades (Score: %d/100).",
                plan[1].name, plan[1].score)
        end
    end

    if intents.STATS then
        local prio = Char:GetStatPriority()
        if prio and prio.wowhead then
            return "Deine Stat-Priorität laut Guide ist: |cffffd100" .. prio.wowhead .. "|r. Ich richte meine Gear-Bewertung genau danach aus."
        end
    end

    if intents.CATALYST then
        return GM:GetCatalystRecommendation()
    end

    return "Ich bin dein Dragon Skill Coach. Frag mich nach 'Farmen', 'Upgrades', 'Werten' oder ob du was 'in der Tasche' hast."
end
