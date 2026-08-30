-- Dragon Skill - Module: AI Coach Engine (v2.1.3)
-- Master Knowledge Base with Corrected Boss Tactics.

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
    SPARK = "Nutze deine 'Funken der Erneuerung' fuer schwache Slots. 'Omen-Forged Greatsword' oder 'Abyssal Signet' sind top.",
    BOSS_TACTICS = {
        ["sszorak"] = "Plattform-Kampf! Boss versucht die Gruppe runterzuschieben. Stehe niemals am Rand, wenn der Push kommt. Weiche den Bodenflaechen aus.",
        ["entombed sentinels"] = "Heroic: Helical Toxins (Partner finden). Mythic: Unstetes Protogift - Partner finden!",
        ["nekzali"] = "Weiche Sandwirbeln aus. Nutze Portale nur ohne Debuff.",
        ["ulatek"] = "Herz von Ulatek priorisieren! Heiler muessen Gruppen-Schaden abfangen.",
        ["nymrissa"] = "Endboss: Leeren-Strahlen ausweichen, Adds kontrollieren.",
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
    if not GM or not Char then return "Module laden noch..." end
    local reply = self:GetLocalReply(msg, GM, Char)
    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        self:TriggerExternalQuery(msg, GM, Char)
        if not reply:find("Anfrage") then
            reply = reply .. "\n\n|cff00ccff(KI wurde parallel fuer Details gefragt.)|r"
        end
    end
    return reply
end

function AICoach:GetLocalReply(msg, GM, Char)
    local intents = self:ParseIntent(msg)
    msg = msg:lower()

    if intents.CRAFTING then
        return KNOWLEDGE.SPARK
    end

    if intents.BOSS then
        for name, tip in pairs(KNOWLEDGE.BOSS_TACTICS) do
            if msg:find(name) then return "|cffffd100Taktik-Tipp fuer " .. name:upper() .. ":|r " .. tip end
        end
        for dName, dData in pairs(DragonSkillGearData.dungeons) do
            for _, boss in ipairs(dData.bosses) do
                if msg:find(boss.name:lower()) then
                    local lootList = ""
                    for _, itemId in ipairs(boss.loot) do
                        local item = DragonSkillGearData.items[itemId]
                        if item then
                            local up = GM:GetUpgradeScore(item.slot, itemId)
                            lootList = lootList .. "\n  - " .. ((up > 0) and "|cff00ff00" or "|cffffffff") .. item.name .. "|r (" .. (item.slot or "Item") .. ")"
                        end
                    end
                    return "|cffffd100Loot von " .. boss.name .. ":|r" .. lootList
                end
            end
        end
    end

    if intents.VAULT then return GM:GetVaultRecommendation() end
    if intents.CATALYST then return GM:GetCatalystRecommendation() end
    if intents.INVENTORY then
        local ups = Char:GetInventoryUpgrades()
        return (#ups > 0) and "Upgrades in der Tasche gefunden!" or "Nichts Besseres gefunden."
    end
    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups[1] then return string.format("Ziel: |cffffd100%s|r (+%.1f%%).", ups[1].name, ups[1].percent or 0) end
    end
    if intents.FARM then
        local plan = GM:GetFarmPlan()
        if plan and plan[1] then return "Geh heute in |cffffd100" .. plan[1].name .. "|r." end
    end

    return "Frag mich nach: 'Taktik [Boss]', 'Loot [Boss]', 'Vault', 'Catalyst' oder 'Tasche'."
end

function AICoach:TriggerExternalQuery(msg, GM, Char)
    local _, class = UnitClass("player")
    local spec = select(2, GetSpecializationInfo(GetSpecialization() or 0))
    DragonSkillDB.ai.pendingQuery = {
        question = msg, context = "Class: " .. class .. ", Spec: " .. spec,
        timestamp = GetTime(), status = "SENT",
        provider = DragonSkillDB.ai.provider or "openai", apiKey = DragonSkillDB.ai.apiKey
    }
end
