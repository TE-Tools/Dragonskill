WoWAICoachUI={};local frame,scroll,edit,content
function WoWAICoachUI:Create()
 if frame then return end
 frame=CreateFrame("Frame","WoWAICoachFrame",UIParent,"BackdropTemplate");frame:SetSize(820,640);frame:SetPoint("CENTER");frame:SetMovable(true);frame:EnableMouse(true);frame:RegisterForDrag("LeftButton");frame:SetScript("OnDragStart",frame.StartMoving);frame:SetScript("OnDragStop",frame.StopMovingOrSizing)
 frame:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background",edgeFile="Interface/DialogFrame/UI-DialogBox-Border",edgeSize=16,insets={left=4,right=4,top=4,bottom=4}});frame:SetBackdropColor(.02,.025,.04,.98)
 local title=frame:CreateFontString(nil,"OVERLAY","GameFontHighlightLarge");title:SetPoint("TOPLEFT",18,-14);title:SetText("WoW AI Coach  •  12.1 / Local Expert Engine")
 local sub=frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");sub:SetPoint("TOPLEFT",20,-38);sub:SetText("Gear • Loot • Route • Upgrade • Plan • keine externe KI erforderlich")
 local close=CreateFrame("Button",nil,frame,"UIPanelCloseButton");close:SetPoint("TOPRIGHT",2,2)
 scroll=CreateFrame("ScrollFrame",nil,frame,"UIPanelScrollFrameTemplate");scroll:SetPoint("TOPLEFT",18,-64);scroll:SetPoint("BOTTOMRIGHT",-34,94);content=CreateFrame("Frame",nil,scroll);content:SetSize(740,1);scroll:SetScrollChild(content);self.lines={}
 edit=CreateFrame("EditBox",nil,frame,"InputBoxTemplate");edit:SetAutoFocus(false);edit:SetSize(650,34);edit:SetPoint("BOTTOMLEFT",18,30);edit:SetText("Was soll ich jetzt machen?");edit:SetScript("OnEnterPressed",function()local q=edit:GetText();edit:SetText("");WoWAICoach:Ask(q)end)
 local b=CreateFrame("Button",nil,frame,"UIPanelButtonTemplate");b:SetSize(110,32);b:SetPoint("BOTTOMRIGHT",-18,30);b:SetText("Senden");b:SetScript("OnClick",function()local q=edit:GetText();edit:SetText("");WoWAICoach:Ask(q)end)
 self:Add("Coach","Bereit. Frag mich frei nach deinem Charakter.")
end
function WoWAICoachUI:Add(who,text)
 if not frame then self:Create() end
 local y=0;for _,l in ipairs(self.lines)do y=y-l:GetHeight()-12 end
 local l=content:CreateFontString(nil,"OVERLAY","GameFontNormal");l:SetWidth(720);l:SetJustifyH("LEFT");l:SetWordWrap(true);l:SetText((who=="Du" and "|cffFFD100Du|r: " or "|cff7dd3fcCoach|r: ")..text);l:SetPoint("TOPLEFT",0,-y);self.lines[#self.lines+1]=l;content:SetHeight(math.max(1,y+l:GetHeight()+24));C_Timer.After(.05,function()scroll:SetVerticalScroll(scroll:GetVerticalScrollRange())end)
end
function WoWAICoachUI:Show()self:Create();frame:Show();edit:SetFocus()end
