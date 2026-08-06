-- Improved diff_summary.lua
-- Returns a compact summary and a tooltip-friendly list of differing positions.

local M = {}

-- Summarize differences: returns summary string and a comma-separated short list
function M.SummarizeDiff(result, maxShow)
    maxShow = maxShow or 10
    if not result or not result.differences then return "Keine Diff-Informationen" end
    local diffs = result.differences
    local count = result.diffCount or #diffs
    if count == 0 then return "Keine Unterschiede", "" end

    local parts = {}
    for i = 1, math.min(count, maxShow) do
        table.insert(parts, tostring(diffs[i]))
    end
    local shown = #parts
    local more = count - shown
    local posList = table.concat(parts, ", ")
    if more > 0 then
        posList = posList .. ", +" .. tostring(more) .. " more"
    end
    local summary = string.format("%d Abweichungen — Positionen: %s", count, posList)
    return summary, posList
end

-- Build tooltip text listing up to maxTooltip positions (one per line). Indicates omitted count if any.
function M.TooltipText(result, maxTooltip)
    maxTooltip = maxTooltip or 20
    if not result or not result.differences then return "Keine Diff-Informationen" end
    local diffs = result.differences
    local count = result.diffCount or #diffs
    if count == 0 then return "Keine Unterschiede" end

    local lines = {}
    for i = 1, math.min(count, maxTooltip) do
        table.insert(lines, string.format("Position %d", diffs[i]))
    end
    local shown = math.min(count, maxTooltip)
    if count > shown then
        table.insert(lines, string.format("...und %d weitere Positionen", count - shown))
    end
    return table.concat(lines, "\n")
end

return M
