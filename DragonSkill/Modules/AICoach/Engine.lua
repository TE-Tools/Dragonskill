-- Dragon Skill - Module: AI Coach Engine (v2.1.4)
-- Final Master Knowledge Base: Verified Loot and Tactics for ALL 12.1 Content.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    context = {}
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "trinket", "brust", "ring", "waffe"},
    FARM = {"farm", "ini", "dungeon", "laufen", "route", "heute"},
    UPGRADE = {"upgrade", "besser", "austauschen", "verbessern"},
    INVENTORY = {"tasche", "bag", "dabei", "inventar"},
    STATS = {"stats", "werte", "prio", "prioritaet"},
    VAULT = {"vault", "kammer", "schatzkammer"},
    CATALYST = {"catalyst", "katalysator", "tier", "set"},
    CRAFTING = {"craft", "herstellen", "beruf", "funke", "spark"},
    BOSS = {"boss", "droppt", "beute", "loot", "taktik", "wie geht", "tipp"}
}

local KNOWLEDGE = {
    SPARK = "Nutze deine 'Funken der Erneuerung' fuer schwache Slots. 'Omen-Forged Greatsword' (Waffe) oder 'Abyssal Signet' (Ring) sind aktuell die staerksten Craft-Optionen.",
    BOSS_TACTICS = {
        -- --- RAID: VENOMOUS ABYSS ---
        ["entombed sentinels"] = "Heroic: Paare finden bei Helical Toxins (1+3 / 2+2 Stacks). Mythic: Unstetes Protogift erfordert schnelles Zusammenlaufen mit dem Partner.",
        ["nekzali"] = "Sandwirbeln ausweichen. Portale nur nutzen, wenn der Debuff weg ist. Adds muessen sofort gefokusst werden.",
        ["the lost explorers"] = "Drei Bosse gleichzeitig. Unterbrecht 'Eisiger Schuss'. Wenn einer 20% erreicht, muessen alle schnell sterben (Enrage).",
        ["vashnik"] = "Achtung bei 'Schmetterschlag'. Tanks muessen den Boss vom Raid wegdrehen. Heiler bereitmachen fuer den Phasenuebergang.",
        ["sszorak"] = "Plattform-Kampf! Boss stoesst die Gruppe regelmaessig zurueck. Positioniere dich mittig. Weiche den schwarzen Leeren-Zonen am Boden aus.",
        ["twin fangs"] = "Beide Schlangen muessen gleichzeitig sterben. Wenn eine stirbt, wirkt die andere einen toedlichen Cast.",
        ["coiled altar"] = "Soakt die lila Kugeln, bevor sie den Altar erreichen. Jede Kugel am Altar erhoeht den Schaden des Bosses permanent.",
        ["ulatek"] = "Prio auf das 'Herz von Ula'tek'. Nutze Cooldowns, wenn der Boss die gesamte Plattform mit Schattenfluten bedeckt.",
        ["nymrissa"] = "Endboss! Phasenwechsel bei 60% und 30%. Weiche den Strahlen aus und achte auf die Adds in der Zwischenphase.",

        -- --- DUNGEONS (SEASON 2) ---
        ["kystia manaheart"] = "Unterbrich 'Manamanifestation'. Bewege den Boss aus den blauen Zonen am Boden.",
        ["zaen bladesorrow"] = "Lege die Schattenflaechen am Rand der Arena ab. Tanks muessen den Boss bei 'Klingenwirbel' kiten.",
        ["xathuux"] = "Fokusse die Leeren-Tentakel sofort. Heiler muessen den Dot auf dem Tank stark gegenheilen.",
        ["zul'jan"] = "Gift-Adds sofort toeten. Wenn der Boss springt, muessen alle Spieler verteilt stehen.",
        ["taz'rah"] = "Kicke 'Nichts-Schlag'. Wenn der Boss auf einen Spieler springt, muessen andere Spieler mithelfen den Schaden zu teilen (Soak).",
        ["guardian bakar"] = "Bewege den Hund aus dem Knochenfeld. Weiche dem Ansturm aus.",
        ["nalorakk"] = "Nalorakk stuermt den entferntesten Spieler an. Wechselt euch ab, um den Debuff nicht zu hoch stapeln zu lassen.",
        ["lightwarden ruia"] = "Sammle die Lichtpartikel, um den Schild des Bosses zu brechen. Weiche den Sonnenstrahlen aus.",
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

    local reply = self:GetLocalReply(msg, GM, Char)

    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        self:TriggerExternalQuery(msg, GM, Char)
        if not reply:find("Anfrage") then
            reply = reply .. "\n\n|cff00ccff(Real-AI wurde parallel fuer eine detaillierte Strategie-Analyse gefragt.)|r"
        end
    end

    return reply
end

function AICoach:GetLocalReply(msg, GM, Char)
    local intents = self:ParseIntent(msg)
    msg = msg:lower()

    if intents.CRAFTING then return KNOWLEDGE.SPARK end

    if intents.BOSS then
        -- 1. Search for Boss Tactic (Comprehensive Check)
        for name, tip in pairs(KNOWLEDGE.BOSS_TACTICS) do
            if msg:find(name) then
                return "|cffffd100Taktik-Tipp fuer " .. name:upper() .. ":|r\n" .. tip
            end
        end
        -- 2. Search for Boss Loot (Comprehensive Check)
        for dName, dData in pairs(DragonSkillGearData.dungeons) do
            for _, boss in ipairs(dData.bosses) do
                if msg:find(boss.name:lower()) then
                    local lootList = ""
                    for _, itemId in ipairs(boss.loot) do
                        local item = DragonSkillGearData.items[itemId]
                        if item then
                            local up = GM:GetUpgradeScore(item.slot, itemId)
                            local color = (up > 0) and "|cff00ff00" or "|cffffffff"
                            lootList = lootList .. "\n  - " .. color .. item.name .. "|r (" .. (item.slot or "Item") .. ")"
                        end
                    end
                    if lootList ~= "" then
                        return "|cffffd100Loot von " .. boss.name .. " (" .. dName .. "):|r" .. lootList
                    else
                        return "Ich kenne den Boss " .. boss.name .. ", aber habe momentan keine Loot-Daten in meiner 12.1 Datenbank."
                    end
                end
            end
        end
    end

    if intents.VAULT then return GM:GetVaultRecommendation() end
    if intents.CATALYST then return GM:GetCatalystRecommendation() end
    if intents.INVENTORY then
        local ups = Char:GetInventoryUpgrades()
        return (#ups > 0) and "Ich habe |cff00ff00" .. #ups .. " Upgrades|r in deiner Tasche gefunden! Sieh sie dir im Reiter 'Upgrades' an." or "Dein Inventar enthaelt momentan keine besseren Items."
    end
    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups[1] then return string.format("Dein naechstes grosses Ziel ist |cffffd100%s|r (%s). Das waere eine Verbesserung von |cff00ff00+%.1f%%|r.", ups[1].name, ups[1].slot, ups[1].percent or 0) end
    end
    if intents.FARM then
        local plan = GM:GetFarmPlan()
        if plan and plan[1] then return "Die effektivste Route fuer dich ist heute |cffffd100" .. plan[1].name .. "|r." end
    end

    return "Frag mich nach: 'Taktik [Boss]', 'Loot [Boss]', 'Vault', 'Catalyst' oder 'Tasche'."
end

function AICoach:TriggerExternalQuery(msg, GM, Char)
    local _, class = UnitClass("player")
    local spec = select(2, GetSpecializationInfo(GetSpecialization() or 0))
    DragonSkillDB.ai.pendingQuery = {
        question = msg, context = "Character: " .. class .. " " .. spec .. " in WoW 12.1 Midnight.",
        timestamp = GetTime(), status = "SENT",
        provider = DragonSkillDB.ai.provider or "openai", apiKey = DragonSkillDB.ai.apiKey
    }
end
