WoWAICoachAnalyzer={}
local function sortLow(a,b)return a.level<b.level end
function WoWAICoachAnalyzer:WeakSlots(s)
 local r={};for _,x in ipairs(s.equipment or {}) do if x.level>0 then r[#r+1]=x end end;table.sort(r,sortLow);return r
end
function WoWAICoachAnalyzer:DirectUpgrades(s)
 local r={}
 for _,bag in ipairs(s.inventory or {}) do for _,eq in ipairs(s.equipment or {}) do
  if bag.id and eq.id and bag.level>eq.level then r[#r+1]={new=bag,old=eq,gain=bag.level-eq.level,slot=eq.slot} end
 end end
 table.sort(r,function(a,b)return a.gain>b.gain end);return r
end
function WoWAICoachAnalyzer:ScoreItem(item,snapshot,slot)
 local score=(item.level or 0)*10
 local meta=WoWAICoachDBData:GetItem(item.id)
 if meta then
  if meta.specs and meta.specs[snapshot.specID] then score=score+(meta.specs[snapshot.specID].score or 0) end
  if meta.slots and meta.slots[slot] then score=score+meta.slots[slot] end
 end
 return score
end
function WoWAICoachAnalyzer:RankUpgrades(s)
 local r={}
 for _,x in ipairs(self:DirectUpgrades(s)) do
  x.score=self:ScoreItem(x.new,s,x.slot)+x.gain*2
  r[#r+1]=x
 end
 table.sort(r,function(a,b)return a.score>b.score end);return r
end
function WoWAICoachAnalyzer:Summary(s)
 local weak=self:WeakSlots(s);local upgrades=self:RankUpgrades(s)
 return {weak=weak,upgrades=upgrades,countEquipped=#(s.equipment or {}),countInventory=#(s.inventory or {})}
end
