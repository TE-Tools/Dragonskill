WoWAICoachScanner={}
local function id(link)return link and tonumber(link:match("item:(%d+)"))end
local function level(link)
 if not link then return 0 end
 if C_Item and C_Item.GetCurrentItemLevel then local ok,v=pcall(C_Item.GetCurrentItemLevel,link);if ok and type(v)=="number" then return v end end
 return 0
end
local function name(link,itemID)
 if itemID and C_Item and C_Item.GetItemNameByID then local ok,v=pcall(C_Item.GetItemNameByID,itemID);if ok and v then return v end end
 return link or ("Item "..tostring(itemID or "?"))
end
function WoWAICoachScanner:Equipment()
 local r={}
 for _,slot in ipairs(WoWAICoachData.SlotOrder) do
  local link=GetInventoryItemLink("player",slot)
  if link then local itemID=id(link);r[#r+1]={slot=slot,id=itemID,link=link,name=name(link,itemID),level=level(link)} end
 end
 return r
end
function WoWAICoachScanner:Inventory()
 local r={};if not C_Container then return r end
 for bag=0,5 do for slot=1,(C_Container.GetContainerNumSlots(bag) or 0) do
  local info=C_Container.GetContainerItemInfo(bag,slot)
  if info and info.hyperlink then local itemID=id(info.hyperlink);r[#r+1]={bag=bag,slot=slot,id=itemID,link=info.hyperlink,name=name(info.hyperlink,itemID),level=level(info.hyperlink),count=info.stackCount or 1} end
 end end
 return r
end
function WoWAICoachScanner:Snapshot()
 local specID=GetSpecialization and GetSpecialization() or 0;local spec="Unbekannt"
 if specID>0 and GetSpecializationInfo then local _,n=GetSpecializationInfo(specID);spec=n or spec end
 local className,classToken=UnitClass("player");local eq=self:Equipment();local total,count=0,0
 for _,x in ipairs(eq) do if x.level>0 then total=total+x.level;count=count+1 end end
 return {name=UnitName("player"),realm=GetRealmName(),className=className,class=classToken,level=UnitLevel("player"),spec=spec,specID=specID,avgItemLevel=count>0 and math.floor(total/count*10+.5)/10 or 0,equipment=eq,inventory=self:Inventory(),timestamp=time()}
end
