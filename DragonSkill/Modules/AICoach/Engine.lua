-- Dragon Skill - Module: AI Coach Engine (v2.1.6)
-- Enhanced Master Knowledge Base with Video-Verified Raid Tactics.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    context = { lastItemId = nil }
})

local INTENTS = {
    GEAR = {"gear", "ausruestung", "item", "trinket", "waffe"},
    FARM = {"farm", "ini", "dungeon", "laufen"},
    UPGRADE = {"upgrade", "besser", "verbessern"},
    BOSS = {"boss", "sszorak", "ulatek", "nekzali", "droppt", "loot", "jawae", "explorers", "fangs", "vashnik"},
    WHERE = {"woher", "quelle", "source", "where"}
}

local KNOWLEDGE = {
    BOSS_TACTICS = {
        ["nekzali"] = "P1 bis 50%. Adds vom Brunnen fernhalten (Schilde brechen!). Tod der Adds verursacht Explosion (15m). Tanks muessen bei Debuff wechseln.",
        ["jawae"] = "Wächter: Boss ist immun solange Echo lebt. Gemeinsam Soak-Zonen abfangen. In P2 hoher Raid-Schaden.",
        ["vashnik"] = "Positionierung ist der Key: Boss MUSS immer zwischen zwei der drei Altare stehen.",
        ["lost explorers"] = "Kampf gegen 3 Tortollaner. Gebbos Kisten durchlaufen, Fisch aufnehmen und per Extra-Button verfuettern. Namas Panzern ausweichen.",
        ["sszorak"] = "Plattform-Kampf! 6 Windkanaele stoessen dich runter. Positioniere dich mittig. Weiche Giftwogen/Voids aus.",
        ["twin fangs"] = "HP teilen! Beide muessen gleichzeitig sterben. Ewiges Gift (11 Stacks) ist toedlich. Kugeln kontrolliert soaken.",
        ["coiled altar"] = "Guillotine mit 5+ Spielern soaken. Bei Malacrass erst den Schild brechen, dann den Todeszauber unterbrechen!",
        ["ulatek"] = "Herz von Ulatek hat Prio 1. Spiraltoxine: Finde den Partner mit der passenden Farbe ueber dem Kopf!",
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

    -- 2. BOSS INFO (Tactics)
    for name, tip in pairs(KNOWLEDGE.BOSS_TACTICS) do
        if msg:find(name) then
            return "|cffffd100Taktik fuer " .. name:upper() .. ":|r\n" .. tip
        end
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

    -- 4. FARM PLAN
    if msg:find("farm") or msg:find("heute") or msg:find("laufen") then
        local plan = GM:GetFarmPlan()
        if plan and plan[1] then
            return "Geh heute in |cffffd100" .. plan[1].name .. "|r. Dort hast du statistisch die besten Upgrades."
        end
    end

    return "Frag mich nach 'Upgrades', 'Farmen' oder einem Boss wie 'Ulatek' oder 'Nekzali'."
end
