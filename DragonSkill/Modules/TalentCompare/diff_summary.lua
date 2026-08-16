-- Verbessere Diff-Zusammenfassung: zeige die Anzahl Abweichungen und bis zu N Positionen
local function SummarizeDiff(result, maxShow)
    maxShow = maxShow or 10
    if not result or not result.differences then return "Keine Diff-Informationen" end
    local count = result.diffCount or #result.differences
    if count == 0 then return "Keine Unterschiede" end

    local parts = {}
    for i = 1, math.min(count, maxShow) do
        table.insert(parts, tostring(result.differences[i]))
    end
    local more = count - #parts
    local posList = table.concat(parts, ",")
    if more > 0 then
        posList = posList .. ", +" .. tostring(more) .. " more"
    end
    return string.format("%d Abweichungen — Positionen: %s", count, posList)
end

-- Beispiel: In TalentCompare UI benutzen wir SummarizeDiff(result, 6)
