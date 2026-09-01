-- Dragon Skill - Module: AI Coach Engine (v2.3.13)
-- NUR INTERN: antwortet ausschließlich aus Addon-Daten (GuideData, Gear, RaidGuides).
-- Keine externen API-Calls, kein OpenAI, kein Netzwerk.

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
        local short = gname:match("^([%w']+)") or gname
        if short and #short >= 4 and msg:find(short, 1, true) then
            return guide
        end
        for token in gname:gmatch("[%w']+") do
            if #token >= 5 and msg:find(token, 1, true) then
                return guide
            end
        end
    end
    return nil
end

local function PlayerInfo()
    local name = UnitName("player") or "?"
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    local specID = specIndex and select(1, GetSpecializationInfo(specIndex)) or 0
    local specName = specIndex and select(2, GetSpecializationInfo(specIndex)) or "Spec"
    local _, ilvl = GetAverageItemLevel()
    return name, class, specID, specName, math.floor(ilvl or 0)
end

function AICoach:GetReply(msg)
    if not msg or msg == "" then
        return "Frag mich zu |cffffd100Upgrades, Farm, BiS, Talenten oder Raid-Bossen|r – ich antworte nur aus den Addon-Daten (kein Internet)."
    end

    local GM = DragonSkill:GetModule("GearManager")
    local lower = msg:lower()
    local name, class, specID, specName, ilvl = PlayerInfo()

    if lower:find("hilfe", 1, true) or lower:find("help", 1, true) or lower == "?" then
        return "|cffffd100Interner Coach – Befehle:|r\n"
            .. "• upgrade / bis / gear – beste Upgrade-Ziele\n"
            .. "• farm / dungeon – Farm-Routen\n"
            .. "• talent / build – Talent-Builds\n"
            .. "• Boss-Name – Raid-Guide\n"
            .. "• woher – Loot-Quelle zum letzten Item\n"
            .. "• status – dein Charakter\n"
            .. "|cffaaaaaaAlles lokal, keine externe AI.|r"
    end

    if lower:find("status", 1, true) or lower:find("wer bin", 1, true) then
        return string.format(
            "|cffffd100%s|r – %s %s (ilvl %d)\nGilde: %s\n|cffaaaaaaFilter: nur passende Rüstung/Waffen für %s.|r",
            name, tostring(class), tostring(specName), ilvl,
            GetGuildInfo("player") or "–",
            tostring(class)
        )
    end

    local guide = MatchBossGuide(lower)
    if guide then
        local lines = {
            "|cffffd100Guide: " .. tostring(guide.name) .. "|r",
            tostring(guide.summary or ""),
        }
        for i, p in ipairs(guide.phases or {}) do
            if i > 3 then break end
            table.insert(lines, "|cffffff00" .. tostring(p.name) .. "|r – " .. tostring(p.desc or ""))
            for j, m in ipairs(p.mechanics or {}) do
                if j > 2 then break end
                table.insert(lines, "  • " .. tostring(m.name) .. ": " .. tostring(m.tip or ""))
            end
        end
        table.insert(lines, "|cffaaaaaaMehr im Reiter Raid Guides.|r")
        return table.concat(lines, "\n")
    end

    if lower:find("woher", 1, true) or lower:find("where", 1, true) or lower:find("drop", 1, true)
        or lower:find("quelle", 1, true) then
        local id = self.context.lastItemId
        if id and DragonSkillGearData and DragonSkillGearData.dungeons then
            for dName, dData in pairs(DragonSkillGearData.dungeons) do
                for _, boss in ipairs(dData.bosses or {}) do
                    for _, lootId in ipairs(boss.loot or {}) do
                        if lootId == id then
                            return "Das Item " .. self:GetItemLink(id)
                                .. " droppt bei |cff00ff00" .. tostring(boss.name)
                                .. "|r in |cffffd100" .. tostring(dName) .. "|r."
                        end
                    end
                end
            end
            return "Item " .. self:GetItemLink(id) .. " – keine Loot-Quelle in der internen 12.1-DB."
        end
        return "Kein Item im Kontext. Frag zuerst nach |cffffd100upgrade|r oder |cffffd100bis|r."
    end

    if lower:find("besser", 1, true) or lower:find("upgrade", 1, true)
        or lower:find("gear", 1, true) or lower:find("bis", 1, true)
        or lower:find("item", 1, true) then
        if GM then
            local ups = GM:GetBestUpgrades()
            if ups and ups[1] then
                self.context.lastItemId = ups[1].itemId
                local lines = { "|cffffd100Top-Upgrades für " .. tostring(specName) .. ":|r" }
                for i = 1, math.min(5, #ups) do
                    local u = ups[i]
                    table.insert(lines, string.format(
                        "%d. %s |cff00ff00(+%.1f%%)|r  [%s]",
                        i, self:GetItemLink(u.itemId), u.percent or 0, tostring(u.slot or "?")
                    ))
                end
                table.insert(lines, "|cffaaaaaaFrag 'woher' für die Loot-Quelle des Top-Items.|r")
                return table.concat(lines, "\n")
            end
            local bis = GM:GetBiSList()
            if bis and bis[1] then
                self.context.lastItemId = bis[1].itemId
                local lines = { "|cffffd100BiS-Ziele (" .. tostring(class) .. "):|r" }
                for i = 1, math.min(5, #bis) do
                    table.insert(lines, string.format("%d. %s [%s]", i, self:GetItemLink(bis[i].itemId), tostring(bis[i].slot or "?")))
                end
                return table.concat(lines, "\n")
            end
            return "Keine klassenpassenden Upgrades in der internen DB gefunden."
        end
    end

    if lower:find("farm", 1, true) or lower:find("dungeon", 1, true)
        or lower:find("route", 1, true) or lower:find("m+", 1, true) then
        if GM then
            local plan = GM:GetFarmPlan()
            if plan and plan[1] then
                local lines = { "|cffffd100Farm-Routen (klassengefiltert):|r" }
                for i = 1, math.min(4, #plan) do
                    local d = plan[i]
                    table.insert(lines, string.format("%d. |cffffd100%s|r (%d Items)", i, d.name, #(d.items or {})))
                    for j = 1, math.min(2, #(d.items or {})) do
                        local it = d.items[j]
                        table.insert(lines, "   • " .. self:GetItemLink(it.itemId) .. " @ " .. tostring(it.boss))
                    end
                end
                return table.concat(lines, "\n")
            end
            return "Keine Farm-Daten für deine Klasse in der internen DB."
        end
    end

    if lower:find("talent", 1, true) or lower:find("build", 1, true)
        or lower:find("skillung", 1, true) then
        local gd = DragonSkill.Database and DragonSkill.Database:GetGuideData(class, specID)
        if gd and gd.talentBuilds and #gd.talentBuilds > 0 then
            local lines = { "|cffffd100Talent-Builds für " .. tostring(specName) .. ":|r" }
            for i, b in ipairs(gd.talentBuilds) do
                table.insert(lines, string.format(
                    "%d. [%s] %s",
                    i, tostring(b.provider or "?"):upper(), tostring(b.label or "Build")
                ))
            end
            table.insert(lines, "|cffaaaaaaImport-Strings im Reiter Talente (klicken zum Kopieren).|r")
            return table.concat(lines, "\n")
        end
        return "Keine Talent-Builds für " .. tostring(class) .. " " .. tostring(specName) .. " hinterlegt."
    end

    if lower:find("gilde", 1, true) or lower:find("guild", 1, true) or lower:find("website", 1, true) then
        local url = (DragonSkillDB and DragonSkillDB.guildUrl) or "https://guildsofwow.com/dragon-lords"
        return "|cffffd100Gilde:|r " .. (GetGuildInfo("player") or "–")
            .. "\n|cff00aaffWebsite:|r " .. tostring(url)
            .. "\n|cffaaaaaaLink auch im Header / Dashboard.|r"
    end

    return "Ich bin der |cffffd100interne Coach|r und nutze nur Addon-Daten.\n"
        .. "Versuch: |cffffd100upgrade|r, |cffffd100farm|r, |cffffd100talent|r, |cffffd100status|r oder einen |cffffd100Boss-Namen|r.\n"
        .. "|cffaaaaaaKeine externe AI, kein Internet.|r"
end

function AICoach:TriggerExternalQuery()
    -- disabled – never call external APIs
end
