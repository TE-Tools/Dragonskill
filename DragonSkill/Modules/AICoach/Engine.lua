-- Dragon Skill - Module: AI Coach Engine (v1.9.2)
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
    STATS = {"stats", "werte", "prio", "prioritaet", "haste", "mastery"},
    TIME = {"minuten", "stunden", "zeit"},
    VAULT = {"vault", "kammer", "schatzkammer", "auswahl"},
    CATALYST = {"catalyst", "katalysator", "tier", "set"},
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
    if not msg or msg == "" then return "Bitte schreib mir eine Frage." end

    local GM = DragonSkill:GetModule("GearManager")
    local Char = DragonSkill:GetModule("Character")

    if not GM or not Char then
        return "|cffff0000Fehler:|r GearManager oder Character Modul nicht geladen."
    end

    -- Check if External AI (Mode 2/3) is active
    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        return self:GetExternalReply(msg)
    end

    return self:GetLocalReply(msg, GM, Char)
end

function AICoach:GetLocalReply(msg, GM, Char)
    local intents = self:ParseIntent(msg)
    msg = msg:lower()

    -- 1. WHY / EXPLANATION
    if msg:find("warum") or msg:find("why") then
        if self.context.lastItem then
            local item = DragonSkillGearData.items[self.context.lastItem]
            if item then
                local details = GM:GetUpgradeDetails(item.slot, self.context.lastItem)
                local reason = string.format("Dieses Item verbessert dich um |cff00ff00%.1f%%|r. ", details.percent)
                if item.tierItem then reason = reason .. "Es ist ein Teil deines Tier-Sets! " end
                return reason .. "Die Kombination aus Stats und Item-Level macht es zu deinem aktuellen Top-Ziel."
            end
        end
    end

    -- 2. VAULT
    if intents.VAULT then
        return GM:GetVaultRecommendation()
    end

    -- 3. CATALYST / TIER
    if intents.CATALYST then
        return GM:GetCatalystRecommendation()
    end

    -- 4. INVENTORY
    if intents.INVENTORY then
        local upgrades = Char:GetInventoryUpgrades()
        if upgrades and #upgrades > 0 then
            return "Ja! Ich habe |cff00ff00" .. #upgrades .. " potenzielle Upgrades|r in deinen Taschen gefunden. Schau sie dir im Upgrades-Reiter an."
        else
            return "Ich habe dein Inventar gescannt, aber momentan scheint kein Item darin besser zu sein als dein aktuelles Gear."
        end
    end

    -- 5. UPGRADES
    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups and ups[1] then
            self.context.lastItem = ups[1].itemId
            return string.format("Dein naechstes grosses Upgrade ist |cffffd100%s|r (%s). Es bringt eine Verbesserung von |cff00ff00%.1f%%|r. Du findest es in %s.",
                ups[1].name, ups[1].slot, ups[1].percent, (ups[1].dungeonName or "einem Dungeon"))
        end
    end

    -- 6. FARMING / TIME
    if intents.FARM or intents.TIME then
        local mins = msg:match("(%d+)")
        mins = tonumber(mins) or 60
        local plan = GM:GetFarmPlan()

        if plan and plan[1] then
            self.context.lastDungeon = plan[1].name
            if mins <= 30 then
                return "Fuer 30 Minuten empfehle ich einen schnellen Run in |cffffd100" .. plan[1].name .. "|r. Das ist dein aktuell effizientestes Ziel."
            else
                return string.format("Die effektivste Route fuer dich ist heute |cffffd100%s|r (Score: %d/100). Dort hast du die hoechste Chance auf Upgrades.",
                    plan[1].name, plan[1].score)
            end
        end
    end

    -- 7. STATS
    if intents.STATS then
        local prio = Char:GetStatPriority()
        if prio and prio.wowhead then
            return "Deine Stat-Priorität laut Guide ist: |cffffd100" .. prio.wowhead .. "|r. Ich richte meine Gear-Bewertung genau danach aus."
        end
    end

    return "Ich bin dein Dragon Skill Coach. Frag mich nach 'Farmen', 'Upgrades', 'Werten', 'Vault' oder ob du was 'in der Tasche' hast."
end

-- EXTERNAL AI LOGIC
function AICoach:GetExternalReply(msg)
    local GM = DragonSkill:GetModule("GearManager")
    local Char = DragonSkill:GetModule("Character")
    local _, class = UnitClass("player")
    local specInfo = GetSpecialization()
    local spec = specInfo and select(2, GetSpecializationInfo(specInfo)) or "None"
    local upgrades = GM:GetBestUpgrades()

    local contextStr = string.format("Class: %s, Spec: %s, Ilvl: %.1f. Top 2 Upgrades: %s, %s.",
        class, spec, select(2, GetAverageItemLevel()),
        upgrades[1] and upgrades[1].name or "None",
        upgrades[2] and upgrades[2].name or "None"
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
    return "|cff00ccff(Anfrage an " .. pName .. " gesendet...)|r\n|cff888888Sobald die Brücke 'Fertig' zeigt, nutze /reload.|r"
end

print("|cff00ff00Dragon Skill:|r AI Coach Engine geladen.")
