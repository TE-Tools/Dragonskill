WoWAICoachDBData={}
WoWAICoachDBData.Items={}
WoWAICoachDBData.Loot={}
WoWAICoachDBData.Bosses={}
WoWAICoachDBData.Builds={}
WoWAICoachDBData.Stats={}
function WoWAICoachDBData:AddItem(id,data) if id then self.Items[id]=data end end
function WoWAICoachDBData:GetItem(id) return id and self.Items[id] end
function WoWAICoachDBData:AddLoot(dungeon,data) self.Loot[dungeon]=data end
function WoWAICoachDBData:AddBuild(specID,data) if specID then self.Builds[specID]=data end end
function WoWAICoachDBData:GetBuild(specID) return specID and self.Builds[specID] end
