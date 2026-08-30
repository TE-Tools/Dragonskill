WoWAICoachSaved=WoWAICoachSaved or {history={},settings={maxHistory=100}}
WoWAICoach={VERSION="1.2.0"}
function WoWAICoach:Ask(q)
 q=tostring(q or ""):gsub("^%s+",""):gsub("%s+$","");if q=="" then return end
 local s=WoWAICoachScanner:Snapshot();local a=WoWAICoachEngine:Answer(q,s)
 table.insert(WoWAICoachSaved.history,{q=q,a=a,t=time()});while #WoWAICoachSaved.history>(WoWAICoachSaved.settings.maxHistory or 100) do table.remove(WoWAICoachSaved.history,1) end
 WoWAICoachUI:Add("Du",q);WoWAICoachUI:Add("Coach",a)
end
SLASH_WOWAICOACH1="/wki";SLASH_WOWAICOACH2="/wowai";SlashCmdList.WOWAICOACH=function(msg)WoWAICoachUI:Show();if msg and msg~="" then WoWAICoach:Ask(msg) end end
local f=CreateFrame("Frame");f:RegisterEvent("PLAYER_LOGIN");f:SetScript("OnEvent",function()DEFAULT_CHAT_FRAME:AddMessage("|cff7dd3fcWoW AI Coach|r v1.2.0 – 12.1 geladen. /wki")end)
