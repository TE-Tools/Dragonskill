-- Dragon Skill - Module: AI Coach Engine (v2.1.5)
-- Master Engine: Returns Item Links and handles "Where" queries.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    context = { lastItemId = nil }
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "trinket", "waffe"},
    FARM = {"farm", "ini", "dungeon", "laufen"},
    UPGRADE = {"upgrade", "besser", "verbessern"},
    BOSS = {"boss", "sszorak", "ulatek", "nekzali", "droppt", "loot"},
    WHERE = {"woher", "woher", "quelle", "source", "where"}
}

local KNOWLEDGE = {
    BOSS_TACTICS = {
        ["sszorak"] = "Plattform-Kampf! Boss versucht die Gruppe runterzuschieben. Weiche den schwarzen Leeren-Zonen aus und stehe beim Push mittig.",
        ["ulatek"] = "Herz von Ulatek priorisieren! Heiler muessen Gruppen-Schaden abfangen.",
    }
}

function AICoach:GetItemLink(itemId)
    local name = DragonSkillGearData.items[itemId] and DragonSkillGearData.items[itemId].name or "Item"
    return "|cff0070dd|Hitem:" .. itemId .. "::::::::70:::::|h[" .. name .. "]|h|r"
end

function AICoach:GetReply(msg)
    local GM = DragonSkill:GetModule("GearManager")
    local Char = DragonSkill:GetModule("Character")
    msg = msg:lower()

    -- 1. WHERE IS LAST ITEM?
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
            return "Ich kenne das Item, aber habe keine Loot-Quelle in der 12.1 Datenbank gefunden."
        end
    end

    -- 2. BOSS INFO
    if msg:find("sszorak") then
        return "|cffffd100Taktik Sszorak:|r " .. KNOWLEDGE.BOSS_TACTICS["sszorak"]
    end

    -- 3. BEST UPGRADE
    if msg:find("besser") or msg:find("besten") or msg:find("upgrade") then
        local ups = GM:GetBestUpgrades()
        if ups[1] then
            self.context.lastItemId = ups[1].itemId
            local link = self:GetItemLink(ups[1].itemId)
            return "Dein aktuell bestes Ziel ist " .. link .. " (+ " .. (ups[1].percent or 0) .. "%). Frag mich 'Woher?', wenn du wissen willst, wo es droppt."
        end
    end

    return "Frag mich nach 'Upgrades', 'Farmen' oder einem Boss wie 'Sszorak'."
end
