-- Dragon Skill - Module: AI Coach Engine (v2.1.1)
-- Enhanced Expert Engine with Boss Loot lookup and Talent Audit.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    context = {}
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "trinket", "schmuck", "brust", "ring", "waffe", "neck", "hals", "back", "rücken"},
    FARM = {"farm", "ini", "dungeon", "laufen", "route", "heute", "ziel", "wohin"},
    UPGRADE = {"upgrade", "besser", "austauschen", "verbessern", "optimieren"},
    INVENTORY = {"tasche", "bag", "dabei", "inventar", "rucksack"},
    STATS = {"stats", "werte", "prio", "prioritaet", "haste", "mastery", "tempo", "meisterschaft", "crit", "krit"},
    VAULT = {"vault", "kammer", "schatzkammer", "wöchentlich", "weekly"},
    CATALYST = {"catalyst", "katalysator", "tier", "set", "boni", "bonus"},
    TALENTS = {"talent", "skillung", "build", "baum", "pve", "raid", "falsch", "korrekt"},
    CONSUMABLES = {"essen", "food", "fläschchen", "flask", "trank", "potion", "buff", "verzuberung", "enchant", "edelstein", "gem"},
    PROFESSIONS = {"beruf", "craft", "herstellen", "auftrag", "funke", "spark"},
    BOSS = {"boss", "sszorak", "nekzali", "sentinels", "ulatek", "droppt", "beute", "loot"}
}

local KNOWLEDGE = {
    GENERAL = "Ich bin dein lokaler Dragon Skill Experte. Frag mich nach Gear, Farm-Routen, Stats oder deinen Taschen!",
    SPARK = "Nutze deine 'Funken der Erneuerung' fuer schwache Slots wie Waffe oder Trinket.",
    CONSUMABLES = {
        dps = "Nutze 'Speise der Leere' und 'Flaeschchen der unbaendigen Wut'.",
        tank = "Nutze 'Eiserner Kuchen' und 'Flaeschchen der Standhaftigkeit'.",
        healer = "Nutze 'Manatee' und 'Flaeschchen der klaren Sicht'.",
    }
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

    local localReply = self:GetLocalReply(msg, GM, Char)

    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        self:TriggerExternalQuery(msg, GM, Char)
        if not localReply:find("Anfrage") then
            localReply = localReply .. "\n\n|cff00ccff(Parallel wurde Claude gefragt. Klick auf 'KI-Antwort abholen' fuer Details.)|r"
        end
    end

    return localReply
end

function AICoach:GetLocalReply(msg, GM, Char)
    local intents = self:ParseIntent(msg)
    msg = msg:lower()
    local _, class = UnitClass("player")
    local specID = select(1, GetSpecializationInfo(GetSpecialization() or 0)) or 0
    local role = (specID > 0) and DragonSkillGearData.specs[specID] and DragonSkillGearData.specs[specID].role or "dps"

    -- 1. BOSS LOOT LOOKUP
    if intents.BOSS then
        for dName, dData in pairs(DragonSkillGearData.dungeons) do
            for _, boss in ipairs(dData.bosses) do
                if msg:find(boss.name:lower()) or (boss.loot and msg:find("loot")) then
                    local lootList = ""
                    for _, itemId in ipairs(boss.loot) do
                        local item = DragonSkillGearData.items[itemId]
                        if item then
                            local upgrade = GM:GetUpgradeScore(item.slot, itemId)
                            local color = (upgrade > 0) and "|cff00ff00" or "|cffffffff"
                            lootList = lootList .. "\n  - " .. color .. item.name .. "|r (" .. item.slot .. ")"
                        end
                    end
                    if lootList ~= "" then
                        return "|cffffd100Beute bei " .. boss.name .. ":|r" .. lootList
                    end
                end
            end
        end
    end

    -- 2. TALENT AUDIT
    if intents.TALENTS then
        local inInstance, instanceType = IsInInstance()
        local guide = DragonSkill.Database:GetGuideData(class, specID)
        local currentBuild = "Unbekannt" -- In real, use C_Traits to get active build name

        if msg:find("falsch") or msg:find("korrekt") or msg:find("raid") then
            if instanceType == "raid" then
                return "Du bist im Raid. Ich empfehle hierfuer den |cffffffffRaid-Build|r aus meinen Guides. Pruefe im Reiter 'Talente', ob du ihn geladen hast."
            elseif instanceType == "party" then
                return "Fuer Dungeons solltest du den |cffffffffM+ Build|r nutzen. Schau im Talente-Tab nach dem passenden Import-String."
            else
                return "Deine Skillung sieht gut aus. Achte darauf, fuer Raids auf den dedizierten Raid-Build zu wechseln."
            end
        end
        if guide and guide.talentBuilds and guide.talentBuilds[1] then
            return "Empfohlene Skillung: |cffffffff" .. guide.talentBuilds[1].label .. "|r. Import-Code ist im Reiter 'Talente' hinterlegt."
        end
    end

    -- 3. INVENTORY & UPGRADES
    if intents.INVENTORY then
        local upgrades = Char:GetInventoryUpgrades()
        return (#upgrades > 0) and "Ich habe |cff00ff00" .. #upgrades .. " Upgrades|r in deinen Taschen gefunden!" or "Keine Taschen-Upgrades gefunden."
    end

    -- 4. VAULT & CATALYST
    if intents.VAULT then return GM:GetVaultRecommendation() end
    if intents.CATALYST then return GM:GetCatalystRecommendation() end

    -- 5. GEAR & STATS
    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups[1] then
            return string.format("Top-Ziel: |cffffd100%s|r (%s). Steigerung: |cff00ff00+%.1f%%|r.", ups[1].name, ups[1].slot, ups[1].percent or 0)
        end
    end

    if intents.STATS then
        local prio = Char:GetStatPriority()
        return prio and ("Deine Prio: |cffffd100" .. prio.wowhead .. "|r.") or "Stat-Prioritaet wird geladen..."
    end

    return KNOWLEDGE.GENERAL
end

function AICoach:TriggerExternalQuery(msg, GM, Char)
    local _, class = UnitClass("player")
    local spec = select(2, GetSpecializationInfo(GetSpecialization() or 0))
    local upgrades = GM:GetBestUpgrades()
    DragonSkillDB.ai.pendingQuery = {
        question = msg,
        context = string.format("Class: %s, Spec: %s. TopUpgrade: %s.", class, spec, upgrades[1] and upgrades[1].name or "None"),
        timestamp = GetTime(), status = "SENT",
        provider = DragonSkillDB.ai.provider or "openai", apiKey = DragonSkillDB.ai.apiKey
    }
end
