-- Dragon Skill - Module: AI Coach Engine (v2.1.0)
-- Enhanced Local Expert Engine with expanded Knowledge Base.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    context = {}
})

-- Expanded Keywords for better Intent Recognition
local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "trinket", "schmuck", "brust", "ring", "waffe", "neck", "hals", "back", "rücken"},
    FARM = {"farm", "ini", "dungeon", "laufen", "route", "heute", "ziel", "wohin"},
    UPGRADE = {"upgrade", "besser", "austauschen", "verbessern", "optimieren"},
    INVENTORY = {"tasche", "bag", "dabei", "inventar", "rucksack"},
    STATS = {"stats", "werte", "prio", "prioritaet", "haste", "mastery", "tempo", "meisterschaft", "crit", "krit"},
    VAULT = {"vault", "kammer", "schatzkammer", "wöchentlich", "weekly"},
    CATALYST = {"catalyst", "katalysator", "tier", "set", "boni", "bonus"},
    TALENTS = {"talent", "skillung", "build", "baum", "pve", "raid"},
    CONSUMABLES = {"essen", "food", "fläschchen", "flask", "trank", "potion", "buff", "verzuberung", "enchant", "edelstein", "gem"},
    PROFESSIONS = {"beruf", "craft", "herstellen", "auftrag", "funke", "spark"},
    DUNGEON_TIPS = {"boss", "mechanik", "taktik", "tipp", "guide", "achtung", "gefährlich"}
}

-- Local Knowledge Base for 12.1 Midnight (Factual Data)
local KNOWLEDGE = {
    GENERAL = "Ich bin dein lokaler Dragon Skill Experte. Frag mich nach Gear, Farm-Routen, Stats oder deinen Taschen!",
    SPARK = "In Patch 12.1 erhältst du 'Funken der Erneuerung'. Nutze sie für deine schwächsten Slots (meistens Waffe oder Schmuck).",
    CRESTS = "Wappen (Crests) solltest du erst für Items nutzen, die mindestens Heroic-Stufe haben, um keine Ressourcen zu verschwenden.",
    CONSUMABLES = {
        dps = "Nutze 'Speise der Leere' für Primärwerte und das 'Fläschchen der unbändigen Wut'.",
        tank = "Nutze 'Eiserner Kuchen' für Ausdauer und 'Fläschchen der Standhaftigkeit'.",
        healer = "Nutze 'Manatee' und 'Fläschchen der klaren Sicht'.",
    },
    DUNGEONS = {
        ["Murder Row"] = "Achtung bei Zaen Bladesorrow: Die Schattenflächen müssen am Rand abgelegt werden!",
        ["Altar of Fangs"] = "Zul'jan beschwört Adds. Fokusse diese sofort, bevor der Giftstack zu hoch wird.",
        ["Voidscar Arena"] = "Taz'Rah springt viel herum. Behalte ihn im Fokus und kicke 'Nichts-Schlag'.",
        ["Den of Nalorakk"] = "Nalorakk stürmt den am weitesten entfernten Spieler an. Steht nicht zu weit weg!",
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

    -- 1. Check for specific Local Expert Answers first
    local reply = self:GetLocalReply(msg, GM, Char)

    -- 2. Parallel outbound request if AI is active (Hybrid Mode)
    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        self:TriggerExternalQuery(msg, GM, Char)
        if not reply:find("Anfrage") then
            reply = reply .. "\n\n|cff00ccff(Parallel wurde Claude gefragt, um eine detailliertere Antwort zu geben. Klick auf 'KI-Antwort abholen'.)|r"
        end
    end

    return reply
end

function AICoach:GetLocalReply(msg, GM, Char)
    local intents = self:ParseIntent(msg)
    msg = msg:lower()
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local role = (specID > 0) and DragonSkillGearData.specs[specID] and DragonSkillGearData.specs[specID].role or "dps"

    -- 1. TALENTS
    if intents.TALENTS then
        local guide = DragonSkill.Database:GetGuideData(select(2, UnitClass("player")), specID)
        if guide and guide.talentBuilds and guide.talentBuilds[1] then
            return "Ich empfehle dir die Skillung: |cffffffff" .. guide.talentBuilds[1].label .. "|r. Du findest den Import-Code im Reiter 'Talente'."
        end
    end

    -- 2. CONSUMABLES / ENCHANTS
    if intents.CONSUMABLES then
        local tip = KNOWLEDGE.CONSUMABLES[role] or KNOWLEDGE.CONSUMABLES.dps
        local prio = Char:GetStatPriority()
        local statTip = prio and ("\nVerwende Edelsteine mit: |cffffd100" .. prio.wowhead .. "|r.") or ""
        return "Buff-Food & Chemie: " .. tip .. statTip
    end

    -- 3. DUNGEON TIPS
    if intents.DUNGEON_TIPS or intents.FARM then
        for dName, tip in pairs(KNOWLEDGE.DUNGEONS) do
            if msg:find(dName:lower()) then
                return "|cffffd100Tipp fuer " .. dName .. ":|r " .. tip
            end
        end
    end

    -- 4. PROFESSIONS / CRAFTING
    if intents.PROFESSIONS then
        return KNOWLEDGE.SPARK .. " Vergiss nicht, deine Handwerksaufträge für das 12.1 Gear zu nutzen."
    end

    -- 5. INVENTORY SCAN
    if intents.INVENTORY then
        local upgrades = Char:GetInventoryUpgrades()
        if upgrades and #upgrades > 0 then
            return "Ja! Ich habe |cff00ff00" .. #upgrades .. " Upgrades|r in deinen Taschen gefunden! Sieh sie dir im 'Upgrades'-Reiter an."
        end
        return "Dein Inventar ist sauber. Ich habe keine Items gefunden, die besser als deine aktuelle Ausrüstung sind."
    end

    -- 6. VAULT & CATALYST (Expert Logic)
    if intents.VAULT then return GM:GetVaultRecommendation() end
    if intents.CATALYST then return GM:GetCatalystRecommendation() end

    -- 7. GEAR & UPGRADES
    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups and ups[1] then
            return string.format("Dein aktuell wichtigstes Ziel ist |cffffd100%s|r (%s). Das Item bringt dir eine theoretische Verbesserung von |cff00ff00+%.1f%%|r.",
                ups[1].name, ups[1].slot, ups[1].percent or 0)
        end
    end

    -- 8. FARM PLAN
    if intents.FARM then
        local plan = GM:GetFarmPlan()
        if plan and plan[1] then
            return "Wenn du jetzt losziehen willst, ist |cffffd100" .. plan[1].name .. "|r dein bester Dungeon. Dort hast du die höchste Upgrade-Dichte."
        end
    end

    -- 9. STATS
    if intents.STATS then
        local prio = Char:GetStatPriority()
        if prio and prio.wowhead then
            return "Deine Stat-Priorität ist: |cffffd100" .. prio.wowhead .. "|r. Achte bei neuem Gear vor allem auf den ersten Wert."
        end
    end

    return KNOWLEDGE.GENERAL
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
