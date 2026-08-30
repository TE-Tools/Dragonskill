WoWAICoachPlanner={}
function WoWAICoachPlanner:Build(snapshot,minutes)
 local a=WoWAICoachAnalyzer:Summary(snapshot);local steps={};local budget=minutes or 9999
 if a.upgrades[1] then steps[#steps+1]={kind="item",minutes=2,text=("Taschen-Upgrade prüfen: %s statt %s (+%d ILvl)"):format(a.upgrades[1].new.name,a.upgrades[1].old.name,a.upgrades[1].gain)};budget=budget-2 end
 if budget>0 then
  for _,c in ipairs(WoWAICoachSeason.Content) do
   if c.baseTime<=budget then steps[#steps+1]={kind=c.id,minutes=c.baseTime,text=("%s priorisieren (ca. %d Min.)"):format(c.name,c.baseTime)};budget=budget-c.baseTime;break end
  end
 end
 if #steps==0 then steps[1]={kind="inspect",minutes=1,text="Charakterdaten aktualisieren und danach erneut planen."} end
 return {minutes=minutes,remaining=budget,steps=steps,analysis=a}
end
