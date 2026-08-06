-- Tooltip integration helper for TalentCompare
local diff_summary = require("addon.Modules.TalentCompare.diff_summary")

local M = {}

function M.ShowDiffTooltip(frame, result)
    local text = diff_summary.TooltipText(result, 20)
    -- Assuming the UI has a standard GameTooltip usage
    if GameTooltip then
        GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        for line in text:gmatch("([^
]+)") do
            GameTooltip:AddLine(line)
        end
        GameTooltip:Show()
    end
end

return M
