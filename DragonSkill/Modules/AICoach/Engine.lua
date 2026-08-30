-- Dragon Skill - Module: AI Coach Engine (v2.1.2)
-- Master Knowledge Base with Raid/Dungeon Tactics and Crafting expertise.

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
    TALENTS = {"talent", "skillung", "build", "falsch", "korrekt"},
    CRAFTING = {"craft", "herstellen", "beruf", "funke", "spark", "auftrag"},
    BOSS = {"boss", "droppt", "beute", "loot", "taktik", "wie geht", "tipp"}
}

local KNOWLEDGE = {
    SPARK = "Nutze deine 'Funken der Erneuerung' fuer schwache Slots. Das 'Omen-Forged Greatsword' oder der 'Abyssal Signet' Ring sind exzellente Craft-Ziele.",
    CRAFT_TIP = "Craft-Items koennen mit Wappen aufgewertet werden. Spare deine Wappen fuer Items mit hohem Itemlevel-Potenzial.",
    BOSS_TACTICS = {
        -- RAIDS
        ["entombed sentinels"] = "Heroic: Achtung bei Helical Toxins (1+3 / 2+2 Kombinationen). Mythic: Unstetes Protogift - Partner finden!",
        ["nekzali"] = "Weiche den Sandwirbeln aus und klicke die Portale nur, wenn der Debuff abgelaufen ist.",
        ["sszorak"] = "Plattform-Kampf! Springe ueber die Ringe und bleibe bei Push-Phasen nicht am Rand stehen.",
        ["ulatek"] = "Fokusse das Herz von Ula'tek, sobald es erscheint. Heiler muessen den Gruppen-Dot gegenheilen.",
        ["nymrissa"] = "Endboss! Weiche den Leeren-Strahlen aus und achte auf die Positionierung der Adds.",
        -- DUNGEONS
        ["kystia manaheart"] = "Unterbrich die Manamanifestation sofort, sonst explodiert sie.",
        ["zul'jan"] = "Toete die Gift-Adds zuerst. Wenn der Boss 'Zorn' wirkt, muessen Tanks Cooldowns ziehen.",
        ["taz'rah"] = "Kickt 'Nichts-Schlag'. Wenn Taz'Rah springt, lauft sofort aus dem Einschlagsradius.",
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
            reply = reply .. "\n\n|cff00ccff(Hybrid: Claude wurde parallel fuer eine detaillierte Taktik-Analyse gefragt.)|r"
        end
    end

    return reply
end

function AICoach:GetLocalReply(msg, GM, Char)
    local intents = self:ParseIntent(msg)
    msg = msg:lower()
    local _, class = UnitClass("player")
    local specID = select(1, GetSpecializationInfo(GetSpecialization() or 0)) or 0

    -- 1. CRAFTING & SPARKS
    if intents.CRAFTING then
        local craftList = ""
        for _, item in ipairs(DragonSkillGearData.crafted) do
            craftList = craftList .. "\n  - |cffffffff" .. item.name .. "|r (" .. item.profession .. ")"
        end
        return KNOWLEDGE.SPARK .. "\n\n|cffffd100Crafting-Ziele:|r" .. craftList
    end

    -- 2. BOSS LOOT & TACTICS
    if intents.BOSS then
        -- Search for Tactic first
        for name, tip in pairs(KNOWLEDGE.BOSS_TACTICS) do
            if msg:find(name) then
                return "|cffffd100Taktik-Tipp fuer " .. name:upper() .. ":|r " .. tip
            end
        end
        -- Fallback to Loot
        for dName, dData in pairs(DragonSkillGearData.dungeons) do
            for _, boss in ipairs(dData.bosses) do
                if msg:find(boss.name:lower()) then
                    local lootList = ""
                    for _, itemId in ipairs(boss.loot) do
                        local item = DragonSkillGearData.items[itemId]
                        if item then
                            local upgrade = GM:GetUpgradeScore(item.slot, itemId)
                            local color = (upgrade > 0) and "|cff00ff00" or "|cffffffff"
                            lootList = lootList .. "\n  - " .. color .. item.name .. "|r (" .. (item.slot or "Item") .. ")"
                        end
                    end
                    return "|cffffd100Loot von " .. boss.name .. ":|r" .. lootList
                end
            end
        end
    end

    -- 3. TALENT AUDIT
    if intents.TALENTS then
        local inInstance, instanceType = IsInInstance()
        if instanceType == "raid" then
            return "Du bist im Raid. Pruefe im Reiter 'Talente', ob du den dedizierten |cffffffffRaid-Build|r nutzt!"
        elseif instanceType == "party" then
            return "Fuer Dungeons empfehle ich den |cffffffffM+ Build|r. Import-Strings findest du im Talente-Tab."
        end
        return "Deine Skillung sieht gut aus. Vergiss nicht, fuer Raids den Build zu wechseln."
    end

    -- 4. STANDARD GEAR & PROGRESS
    if intents.INVENTORY then
        local upgrades = Char:GetInventoryUpgrades()
        return (#upgrades > 0) and "Upgrades in deinen Taschen gefunden! Schau in den Upgrades-Tab." or "Keine Taschen-Upgrades."
    end

    if intents.VAULT then return GM:GetVaultRecommendation() end
    if intents.CATALYST then return GM:GetCatalystRecommendation() end

    if intents.UPGRADE or intents.GEAR then
        local ups = GM:GetBestUpgrades()
        if ups[1] then
            return string.format("Naechstes Ziel: |cffffd100%s|r (+%.1f%%). Droppt in %s.", ups[1].name, ups[1].percent or 0, (ups[1].dungeonName or "Dungeon"))
        end
    end

    if intents.FARM then
        local plan = GM:GetFarmPlan()
        if plan and plan[1] then return "Beste Ini heute: |cffffd100" .. plan[1].name .. "|r." end
    end

    return "Frag mich nach: 'Taktik [Bossname]', 'Loot [Bossname]', 'Herstellen' oder 'Was mache ich mit dem Funken?'."
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
