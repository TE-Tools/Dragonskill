@@
     local providerOrder = { "wowhead", "archon" }
     local providerNames = { wowhead = "|cffffcc00Wowhead|r", archon = "|cff66ccffArchon|r" }
 
     for _, provider in ipairs(providerOrder) do
         local text = data[provider]
         if text and text ~= "" then
             local header = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
             header:SetPoint("TOPLEFT", 4, yOffset)
             header:SetText(providerNames[provider])
             yOffset = yOffset - 22
 
-            local body = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
-            body:SetPoint("TOPLEFT", 8, yOffset)
-            body:SetWidth(344)
-            body:SetJustifyH("LEFT")
-            body:SetText(text)
-            yOffset = yOffset - (body:GetStringHeight() + 20)
+            -- Falls der Text ein strukturiertes Format ist (z. B. "Stat: value > ..."),
+            -- versuchen wir, die wichtigsten Stats zu parsen. Fallback: kompletten Text anzeigen.
+            local parsed = false
+            if type(text) == "string" then
+                -- einfacher Parser: suche nach bekannten Stat-Namen und extrahiere Reihenfolge
+                local stats = { "Intellect", "Agility", "Strength", "Haste", "Mastery", "Critical Strike", "CriticalStrike", "Critical", "Versatility", "Vers" }
+                local found = {}
+                for _, stat in ipairs(stats) do
+                    if string.find(text, stat) then
+                        table.insert(found, stat)
+                    end
+                end
+
+                if #found > 0 then
+                    parsed = true
+                    for _, statName in ipairs(found) do
+                        local line = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
+                        line:SetPoint("TOPLEFT", 8, yOffset)
+                        line:SetWidth(344)
+                        line:SetJustifyH("LEFT")
+                        line:SetText(statName)
+                        yOffset = yOffset - 18
+                    end
+                    yOffset = yOffset - 8
+                end
+            end
+
+            if not parsed then
+                local body = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
+                body:SetPoint("TOPLEFT", 8, yOffset)
+                body:SetWidth(344)
+                body:SetJustifyH("LEFT")
+                body:SetText(text)
+                yOffset = yOffset - (body:GetStringHeight() + 20)
+            end
         end
     end
@@
     content:SetHeight(math.abs(yOffset) + 10)
 end
