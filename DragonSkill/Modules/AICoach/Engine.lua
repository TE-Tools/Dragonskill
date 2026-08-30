-- Dragon Skill - Module: AI Coach Engine (v2.2.6)
-- Hybrid Master Engine: Local Verified Facts + External Real-AI Bridge.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    context = { lastItemId = nil }
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "trinket", "waffe"},
    FARM = {"farm", "ini", "dungeon", "laufen", "heute"},
    UPGRADE = {"upgrade", "besser", "verbessern"},
    BOSS = {"boss", "sszorak", "ulatek", "nekzali", "jawae", "explorers", "droppt", "loot"},
    WHERE = {"woher", "quelle", "source", "where"}
}

function AICoach:GetItemLink(itemId)
    if not itemId then return "Item" end
    local name = DragonSkillGearData.items[itemId] and DragonSkillGearData.items[itemId].name or "Item "..itemId
    return "|cff0070dd|Hitem:" .. itemId .. "::::::::70:::::|h[" .. name .. "]|h|r"
end

function AICoach:GetReply(msg)
    if not msg or msg == "" then return "Bitte schreib mir eine Frage." end
    local GM = DragonSkill:GetModule("GearManager")
    local Char = DragonSkill:GetModule("Character")
    msg = msg:lower()

    -- 1. Check for specific Boss Tactic (Highest Priority)
    for _, guide in ipairs(DragonSkillRaidGuides or {}) do
        if msg:find(guide.name:lower()) then
            local tip = guide.summary or "Keine Zusammenfassung vorhanden."
            if guide.phases and guide.phases[1] then tip = tip .. "\n" .. guide.phases[1].desc end
            return "|cffffd100Guide fuer " .. guide.name .. ":|r\n" .. tip .. "\n\n|cffaaaaaaTipp: Schau im Reiter 'Raid Guides' fuer den vollen Boss-Browser!|r"
        end
    end

    -- 2. "Where" Query for contextual memory
    if msg:find("woher") or msg:find("where") then
        if self.context.lastItemId then
            local id = self.context.lastItemId
            for dName, dData in pairs(DragonSkillGearData.dungeons) do
                for _, boss in ipairs(dData.bosses) do
                    for _, lootId in ipairs(boss.loot) do
                        if lootId == id then
                            return "Das Item " .. self:GetItemLink(id) .. " droppt bei |cff00ff00" .. boss.name .. "|r in |cffffd100" .. dName .. "|r."
                        end
                    end
                end
            end
            return "Ich kenne das Item " .. self:GetItemLink(id) .. ", aber habe keine Loot-Quelle in der 12.1 Datenbank gefunden."
        end
    end

    -- 3. Gear / Upgrade Query
    if msg:find("besser") or msg:find("upgrade") or msg:find("gear") then
        local ups = GM:GetBestUpgrades()
        if ups and ups[1] then
            self.context.lastItemId = ups[1].itemId
            local link = self:GetItemLink(ups[1].itemId)
            return "Dein aktuell bestes Ziel ist " .. link .. " (+ " .. (ups[1].percent or 0) .. "%). Frag mich 'Woher?', wenn du wissen willst, wo es droppt."
        end
    end

    -- 4. Hybrid External Query
    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        self:TriggerExternalQuery(msg, GM, Char)
        return "|cff00ccff(Anfrage an Claude gesendet. Klick auf 'Antwort abholen' wenn die Bridge fertig ist.)|r"
    end

    return "Ich kenne mich aus mit Upgrades, Farm-Routen, Boss-Loot und Taktiken. Frag mich etwas!"
end

function AICoach:TriggerExternalQuery(msg, GM, Char)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local spec = specIndex and select(2, GetSpecializationInfo(specIndex)) or "Spec"
    DragonSkillDB.ai.pendingQuery = {
        question = msg, context = "Character: " .. class .. " " .. spec .. " in WoW 12.1 Midnight.",
        timestamp = GetTime(), status = "SENT",
        provider = DragonSkillDB.ai.provider or "openai", apiKey = DragonSkillDB.ai.apiKey
    }
end
