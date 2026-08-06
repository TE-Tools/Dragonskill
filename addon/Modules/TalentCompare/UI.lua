@@
         importBtn:SetScript("OnClick", function()
             local db = DragonSkill.Database
             local autoName = db:GenerateAutoSkillingName()
             local skillingData = {
                 importString = build.importString,
                 provider = build.provider,
                 label = build.label,
                 context = build.context
             }
             local finalName = db:CreateSkilling(autoName, skillingData)
-            StaticPopup_Show("DRAGONSKILL_SKILLING_CREATED", finalName, nil, skillingData.importString)
+            -- Versuche, den Import-String in die Zwischenablage zu legen (falls Client erlaubt)
+            if type(SetClipboard) == "function" then
+                pcall(SetClipboard, skillingData.importString or "")
+            end
+            StaticPopup_Show("DRAGONSKILL_SKILLING_CREATED", finalName, nil, skillingData.importString)
         end)
@@
     OnShow = function(self, data)
         local name = data or "Unbekannt"
         local skilling = DragonSkill.Database.account.favorites[name] or {}
         self.editBox:SetText(skilling.importString or "")
         self.editBox:HighlightText()
-        self.text:SetFormattedText(self.text:GetText() or "Skilling erstellt: %s", name)
+        self.text:SetFormattedText(self.text:GetText() or "Skilling erstellt: %s", name)
+        -- kleine Hinweiszeile, dass der String auch in die Zwischenablage kopiert wurde
+        if type(GetClipboard) == "function" and GetClipboard() == (skilling.importString or "") then
+            local hint = self:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
+            hint:SetPoint("TOPLEFT", self, "TOPLEFT", 16, -40)
+            hint:SetText("Import-String wurde in die Zwischenablage kopiert.")
+            C_Timer.After(3, function() if hint and hint.SetText then hint:SetText("") end end)
+        end
     end,
 }
*** End Patch
