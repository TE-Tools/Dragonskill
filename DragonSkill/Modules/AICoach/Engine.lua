-- Dragon Skill - Module: AI Coach Engine (v2.3.7)
-- Substring boss match + safe gear answers.

local AICoach = DragonSkill:RegisterModule("AICoach", {
    context = { lastItemId = nil }
})

function AICoach:GetItemLink(itemId)
    if not itemId then return "Item" end
    local name = "Item " .. itemId
    if DragonSkillGearData and DragonSkillGearData.items and DragonSkillGearData.items[itemId] then
        name = DragonSkillGearData.items[itemId].name or name
    end
    return "|cff0070dd|Hitem:" .. itemId .. "::::::::70:::::|h[" .. name .. "]|h|r"
end

local function MatchBossGuide(msg)
    if not DragonSkillRaidGuides then return nil end
    for _, guide in ipairs(DragonSkillRaidGuides) do
        local gname = tostring(guide.name or ""):lower()
        if gname ~= "" and (msg:find(gname, 1, true) or gname:find(msg, 1, true)) then
            return guide
        end
        -- token match on first word / without punctuation
        local short = gname:match("^([%w']+)") or gname
        if short and #short >= 4 and msg:find(short, 1, true) then
            return guide
        end
    end
    return nil
end

function AICoach:GetReply(msg)
    if not msg or msg == "" then return "Bitte schreib mir eine Frage." end
    local GM = DragonSkill:GetModule("GearManager")
    msg = msg:lower()

    local guide = MatchBossGuide(msg)
    if guide then
        local tip = guide.summary or "Keine Zusammenfassung vorhanden."
        if guide.phases and guide.phases[1] then
            tip = tip .. "\n" .. tostring(guide.phases[1].desc or "")
        end
        return "|cffffd100Guide für " .. tostring(guide.name) .. ":|r\n" .. tip ..
            "\n\n|cffaaaaaaTipp: Reiter 'Raid Guides' für den vollen Boss-Browser.|r"
    end

    if msg:find("woher", 1, true) or msg:find("where", 1, true) then
        if self.context.lastItemId and DragonSkillGearData and DragonSkillGearData.dungeons then
            local id = self.context.lastItemId
            for dName, dData in pairs(DragonSkillGearData.dungeons) do
                for _, boss in ipairs(dData.bosses or {}) do
                    for _, lootId in ipairs(boss.loot or {}) do
                        if lootId == id then
                            return "Das Item " .. self:GetItemLink(id) ..
                                " droppt bei |cff00ff00" .. tostring(boss.name) ..
                                "|r in |cffffd100" .. tostring(dName) .. "|r."
                        end
                    end
                end
            end
            return "Ich kenne das Item " .. self:GetItemLink(id) ..
                ", aber habe keine Loot-Quelle in der 12.1 Datenbank gefunden."
        end
    end

    if msg:find("besser", 1, true) or msg:find("upgrade", 1, true) or msg:find("gear", 1, true)
        or msg:find("bis", 1, true) then
        if GM then
            local ups = GM:GetBestUpgrades()
            if ups and ups[1] then
                self.context.lastItemId = ups[1].itemId
                local link = self:GetItemLink(ups[1].itemId)
                return "Dein aktuell bestes Ziel ist " .. link ..
                    " (+ " .. tostring(ups[1].percent or 0) .. "%). Frag mich 'Woher?', wenn du die Quelle brauchst."
            end
            return "Aktuell keine Upgrades über deinem ausgerüsteten Gear gefunden."
        end
    end

    if DragonSkillDB and DragonSkillDB.ai and DragonSkillDB.ai.enabled and DragonSkillDB.ai.apiKey ~= "" then
        self:TriggerExternalQuery(msg, GM)
        return "|cff00ccff(Anfrage an externe AI gesendet. 'Antwort abholen' wenn die Bridge fertig ist.)|r"
    end

    return "Ich kenne mich aus mit Upgrades, Farm-Routen, Boss-Loot und Taktiken. Frag mich etwas!"
end

function AICoach:TriggerExternalQuery(msg, GM)
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local spec = specIndex and select(2, GetSpecializationInfo(specIndex)) or "Spec"
    if not DragonSkillDB then return end
    DragonSkillDB.ai = DragonSkillDB.ai or {}
    DragonSkillDB.ai.pendingQuery = {
        question = msg,
        context = "Character: " .. tostring(class) .. " " .. tostring(spec) .. " in WoW 12.1 Midnight.",
        timestamp = GetTime and GetTime() or 0,
        status = "SENT",
        provider = DragonSkillDB.ai.provider or "openai",
        apiKey = DragonSkillDB.ai.apiKey,
    }
end
