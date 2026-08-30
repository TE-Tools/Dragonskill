WoWAICoachEngine={}
local function has(q,list)q=(q or ""):lower();for _,w in ipairs(list or {}) do if q:find(w,1,true) then return true end end end
local function intent(q)
 local best="general";local n=0
 for k,v in pairs(WoWAICoachData.Intents) do local score=0;for _,w in ipairs(v) do if q:lower():find(w,1,true) then score=score+1 end end;if score>n then n=score;best=k end end
 return best
end
local function mins(q)return tonumber(q:match("(%d+)%s*[mM]in")) or tonumber(q:match("(%d+)%s*[mM]inuten")) or 60 end
function WoWAICoachEngine:Answer(q,s)
 local i=intent(q);local a=WoWAICoachAnalyzer:Summary(s)
 if i=="help" then return "Ich kann Gear, Taschen, direkte Upgrades, M+, Skillung, Stats und deinen nächsten Schritt analysieren. Beispiele: 'Was soll ich jetzt machen?', 'Welche Ini bringt mich weiter?', 'Habe ich ein besseres Item?'" end
 if i=="inventory" then return ("Taschen: %d Items. Direkte Itemlevel-Upgrades: %d."):format(#(s.inventory or {}),#a.upgrades) end
 if i=="compare" and a.upgrades[1] then local x=a.upgrades[1];return ("Bestes direktes Upgrade: %s (%d) statt %s (%d), +%d Itemlevel."):format(x.new.name,x.new.level,x.old.name,x.old.level,x.gain) end
 if i=="gear" then local t="Schwächste Slots:\n";for n=1,math.min(6,#a.weak) do local x=a.weak[n];t=t..("%d. %s – %s – %d\n"):format(n,WoWAICoachData.Slots[x.slot] or "Slot",x.name,x.level) end;if a.upgrades[1] then t=t..("\nPriorisiertes Taschen-Upgrade: %s (+%d)."):format(a.upgrades[1].new.name,a.upgrades[1].gain) end;return t end
 if i=="dungeon" or i=="route" then local t="Saison-2-M+:\n";for n,d in ipairs(WoWAICoachSeason.MPlus) do t=t..("%d. %s\n"):format(n,d.name) end;return t.."\nKonkrete Loot-Routen werden automatisch aktiv, sobald verifizierte Loot-/Bossdaten geladen sind." end
 if i=="plan" then local p=WoWAICoachPlanner:Build(s,mins(q));local t=("Plan für %d Minuten:\n"):format(p.minutes);for n,x in ipairs(p.steps) do t=t..("%d. %s\n"):format(n,x.text) end;return t end
 if i=="talent" then local b=WoWAICoachDBData:GetBuild(s.specID);if b then return ("Build für %s: %s"):format(s.spec,b.name or "verifiziert") end;return ("Spec erkannt: %s. Für konkrete Talente verwende ich nur verifizierte 12.1-Daten."):format(s.spec) end
 if i=="stat" then local st=WoWAICoachDBData.Stats[s.specID];if st and st.text then return st.text end;return ("Spec erkannt: %s. Stat-Prioritäten werden nur aus verifizierten Daten übernommen."):format(s.spec) end
 return ("%s – %s, Ø %s. Frag mich frei nach Gear, Items, M+, Skillung, Stats oder deinem nächsten Schritt."):format(s.className or "Klasse",s.spec or "Spec",s.avgItemLevel or 0)
end
