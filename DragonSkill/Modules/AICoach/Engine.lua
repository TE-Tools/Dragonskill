-- Dragon Skill - Module: AI Coach Engine (v1.8.2)
-- Local Facts Engine with Contextual Memory and Upgrade Explanations.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    history = {},
    context = {
        lastItem = nil,
        lastDungeon = nil,
        lastTopic = nil
    }
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "gegenstand", "trinket", "schmuck", "brust", "chest", "ring", "waffe", "weapon"},
    FARM = {"farm", "ini", "dungeon", "laufen", "route", "heute", "today"},
    UPGRADE = {"upgrade", "besser", "austauschen", "verbessern"},
    INVENTORY = {"tasche", "bag", "dabei", "inventar"},
    STATS = {"stats", "werte", "prio", "prioritaet", "haste", "mastery", "tempo", "meisterschaft"},
    CATALYST = {"catalyst", "katalysator", "tier", "set"},
    TIME = {"minuten", "stunden", "zeit", "hour", "minutes", "stunde"},
    FOLLOWUP = {"wo", "warum", "danach", "where", "why", "next"}
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

    msg = msg:lower()

    -- 1. WHY / EXPLANATION (Special Handling)
    if msg:find("warum") or msg:find("why") then
        if self.context.lastItem then
            local item = DragonSkillGearData.items[self.context.lastItem]
            if item then
                local details = GM:GetUpgradeDetails(item.slot, self.context.lastItem)
                local reason = string.format("Dieses Item verbessert dich um |cff00ff00%.1f%%|r. ", details.percent)
                if item.tierItem then reason = reason .. "Es ist ein Teil deines Tier-Sets! " end
                if item.effect then reason = reason .. "Es hat einen starken Sondereffekt (" .. item.effect .. "). " end
                return reason .. "Die Kombination aus Stats und Item-Level macht es zu deinem aktuellen Top-Ziel."
            end
        end
        return "Ich kann dir erklaeren, warum ein Item gut ist, wenn wir gerade darueber gesprochen haben."
    end

    -- 2. TIME OPTIMIZATION
    if intents.TIME then
        local mins = msg:match("(%d+)")
        mins = tonumber(mins) or 60
        local plan = GM:GetFarmPlan()

        if mins <= 30 then
            if plan[1] then
                self.context.lastDungeon = plan[1].name
                return "Fuer 30 Minuten empfehle ich einen schnellen Run in |cffffd100" .. plan[1].name .. "|r. Das ist dein aktuell effizientestes Ziel."
            end
        elseif mins <= 60 then
            if plan[1] and plan[2] then
                return "In einer Stunde schaffst du locker |cffffd100" .. plan[1].name .. "|r und vielleicht noch |cffffd100" .. plan[2].name .. "|r."
            end
        else
            return "Bei so viel Zeit solltest du die gesamte Top-Route ablaufen: " .. plan[1].name .. " -> " .. (plan[2] and plan[2].name or "Ende") .. "."
        end
    end

    -- 3. FOLLOW-UP QUESTIONS (Context awareness)
    if intents.FOLLOWUP then
        if msg:find("wo") or msg:find("where") then
            if self.context.lastItem then
                local item = DragonSkillGearData.items[self.context.lastItem]
                return "Dieses Item droppt bei |cff00ff00" .. (item.bossName or "einem Boss") .. "|r in |cffffd100" .. (item.dungeonName or item.sourceName or "einem Dungeon") .. "|r."
            elseif self.context.lastDungeon then
                return "Der Eingang zu |cffffd100" .. self.context.lastDungeon .. "|r befindet sich in der entsprechenden Zone von Midnight. Nutze deine Map!"
            end
        elseif msg:find("danach") or msg:find("next") then
            local ups = GM:GetBestUpgrades()
            if ups[2] then
                self.context.lastItem = ups[2].itemId
                return "Nach deinem Haupt-Ziel solltest du dich auf |cffffd100" .. ups[2].name .. "|r konzentrieren."
            end
        end
    end

    -- 4. INVENTORY UPGRADES
    if intents.INVENTORY then
        local upgrades = Char:GetInventoryUpgrades()
        if upgrades and #upgrades > 0 then
            return "Ja! Ich habe |cff00ff00" .. #upgrades .. " potenzielle Upgrades|r in deinen Taschen gefunden. Schau sie dir im Upgrades-Reiter an."
        else
            return "Ich habe dein Inventar gescannt, aber momentan scheint kein Item darin besser zu sein als dein aktuelles Gear."
        end
    end

    -- 5. GENERAL GEAR/UPGRADE
    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups[1] then
            self.context.lastItem = ups[1].itemId
            return string.format("Dein naechstes grosses Upgrade ist |cffffd100%s|r (%s). Es bringt eine Verbesserung von |cff00ff00%.1f%%|r. Du findest es in %s.",
                ups[1].name, ups[1].slot, ups[1].percent, (ups[1].dungeonName or "einem Dungeon"))
        end
    end

    -- 6. FARMING
    if intents.FARM then
        local plan = GM:GetFarmPlan()
        if plan[1] then
            self.context.lastDungeon = plan[1].name
            return string.format("Die effektivste Route fuer dich ist heute |cffffd100%s|r. Dort hast du die hoechste Chance auf Upgrades (Score: %d/100).",
                plan[1].name, plan[1].score)
        end
    end

    -- 7. STATS
    if intents.STATS then
        local prio = Char:GetStatPriority()
        if prio and prio.wowhead then
            return "Deine Stat-Priorität laut Guide ist: |cffffd100" .. prio.wowhead .. "|r. Ich richte meine Gear-Bewertung genau danach aus."
        end
    end

    -- 8. CATALYST
    if intents.CATALYST then
        return GM:GetCatalystRecommendation()
    end

    return "Ich bin dein Dragon Skill Coach. Frag mich nach 'Farmen', 'Upgrades', 'Werten' oder ob du was 'in der Tasche' hast."
end
