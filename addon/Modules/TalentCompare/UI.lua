@@
-local function RenderTalentsTab()
+local function RenderTalentsTab()
     ClearContent()
@@
-        local importBtn = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
-        importBtn:SetSize(100, 22)
-        importBtn:SetPoint("TOPRIGHT", 0, -2)
-        importBtn:SetText("Kopieren")
-        importBtn:SetScript("OnClick", function()
-            StaticPopup_Show("DRAGONSKILL_COPY_IMPORT_STRING", nil, nil, build.importString)
-        end)
+        local importBtn = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
+        importBtn:SetSize(120, 22)
+        importBtn:SetPoint("TOPRIGHT", 0, -2)
+        importBtn:SetText("Anlage erstellen")
+        importBtn:SetScript("OnClick", function()
+            local db = DragonSkill.Database
+            local autoName = db:GenerateAutoSkillingName()
+            local skillingData = {
+                importString = build.importString,
+                provider = build.provider,
+                label = build.label,
+                context = build.context
+            }
+            local finalName = db:CreateSkilling(autoName, skillingData)
+            StaticPopup_Show("DRAGONSKILL_SKILLING_CREATED", finalName, nil, skillingData.importString)
+        end)
@@
 StaticPopupDialogs["DRAGONSKILL_COPY_IMPORT_STRING"] = {
@@
 }
+
+StaticPopupDialogs["DRAGONSKILL_SKILLING_CREATED"] = {
+    text = "Skilling erstellt: %s\nImport-String (Strg+C zum Kopieren):",
+    button1 = "Schließen",
+    hasEditBox = true,
+    editBoxWidth = 350,
+    timeout = 0,
+    whileDead = true,
+    hideOnEscape = true,
+    OnShow = function(self, data)
+        local name = data or "Unbekannt"
+        local skilling = DragonSkill.Database.account.favorites[name] or {}
+        self.editBox:SetText(skilling.importString or "")
+        self.editBox:HighlightText()
+        self.text:SetFormattedText(self.text:GetText() or "Skilling erstellt: %s", name)
+    end,
+}
