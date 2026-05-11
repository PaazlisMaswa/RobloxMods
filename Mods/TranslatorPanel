local Private=_G.MaswaLibrary
local Rayfield,UILibrary,Instancer,Strs=Private.Rayfield,Private.UILibrary,Private.Instancer,Private.Strs
local Services=Private.Services
local Players,ReplicatedStorage,TweenService,HttpService=Services.Players,Services.ReplicatedStorage,Services.TweenService,Services.HttpService
local LocalPlayer=Players.LocalPlayer
setclipboard=type(setclipboard)=="function" and setclipboard or function(text) warn(text) end
Private.LanguageData={
	["Afrikaans"]="af",
	["Albanian"]="sq",
	["Arabic"]="ar",
	["Armenian"]="hy",
	["Azerbaijani"]="az",
	["Basque"]="eu",
	["Bangladesh"]="bn",
	["Bulgaria"]="bg",
	["Catalan"]="ca",
	["China"]="zh-cn",
	["Taiwan"]="zh-tw",
	["Croatian"]="hr",
	["Czech"]="cs",
	["Danish"]="da",
	["Dutch"]="nl",
	["English"]="en",
	["Esperanto"]="eo",
	["Estonian"]="et",
	["Philippines"]="tl",
	["Finland"]="fi",
	["France"]="fr",
	["Galician"]="gl",
	["Georgia"]="ka",
	["Germany"]="de",
	["Greece"]="el",
	["Gujarati"]="gu",
	["Haitian Creole"]="ht",
	["Hebrew"]="iw",
	["Hindi"]="hi",
	["Hungary"]="hu",
	["Icelandic"]="is",
	["Indonesia"]="id",
	["Irish"]="ga",
	["Italian"]="it",
	["Japanese"]="ja",
	["Kannada"]="kn",
	["Korean"]="ko",
	["Latin"]="la",
	["Latvian"]="lv",
	["Lithuanian"]="lt",
	["Malaysia"]="ms",
	["Maltese"]="mt",
	["Norwegian"]="no",
	["Persian"]="fa",
	["Polish"]="pl",
	["Portuguese"]="pt",
	["Romania"]="ro",
	["Russia"]="ru",
	["Serbian"]="sr",
	["Slovak"]="sk",
	["Slovenia"]="sl",
	["Spanish"]="es",
	["Swahili"]="sw",
	["Swedish"]="sv",
	["Tamil"]="ta",
	["Telugu"]="te",
	["Thailand"]="th",
	["Turkish"]="tr",
	["Ukrainian"]="uk",
	["Urdu"]="ur",
	["Vietnamese"]="vi",
	["Welsh"]="cy"
}
Private.CountryData={
	["AF"]="Afrikaans",
	["AL"]="Albanian",
	["SA"]="Arabic",
	["AM"]="Armenian",
	["AZ"]="Azerbaijani",
	["BD"]="Bangladesh",
	["BG"]="Bulgaria",
	["ES"]="Spanish",
	["CN"]="China",
	["TW"]="Taiwan",
	["HR"]="Croatian",
	["CZ"]="Czech",
	["DK"]="Denmark",
	["NL"]="Netherlands",
	["US"]="English",
	["GB"]="English",
	["PH"]="Philippines",
	["FI"]="Finland",
	["FR"]="France",
	["GE"]="Georgia",
	["DE"]="Germany",
	["GR"]="Greece",
	["IN"]="Hindi",
	["HU"]="Hungarian",
	["IS"]="Icelandic",
	["ID"]="Indonesia",
	["IE"]="Irish",
	["IT"]="Italian",
	["JP"]="Japanese",
	["KR"]="Korean",
	["LV"]="Latvian",
	["LT"]="Lithuanian",
	["MY"]="Malaysia",
	["MT"]="Maltese",
	["NO"]="Norwegian",
	["IR"]="Persian",
	["PL"]="Polish",
	["PT"]="Portuguese",
	["BR"]="Portuguese",
	["RO"]="Romania",
	["RU"]="Russia",
	["RS"]="Serbian",
	["SK"]="Slovak",
	["SI"]="Slovenia",
	["TH"]="Thailand",
	["TR"]="Turkish",
	["UA"]="Ukrainian",
	["VN"]="Vietnamese",
	["IL"]="Hebrew",
	["PK"]="Urdu"
}
Private.Language="English" 
Private.LanguageValue=Private.LanguageData["English"] 
function Private.LoadCountryLanguage()
	local LocalizationService=Private.GetService("LocalizationService") 
	local Success,Country,Attempt=false,nil,0 
	repeat 
		Success,Country=pcall(function() 
			return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer) 
		end) 
		if not Success then task.wait(1) end 
		Attempt=Attempt+1 
	until Success or Attempt>=5 
	if Success and Country then  
		local Language=Private.CountryData[Country]
		if Language then Private.Language=Language  
			local LanguageValue=Private.LanguageData[Language] 
			if LanguageValue then 
				Private.LanguageValue=LanguageValue 
			end 
		end 
	end
end
Private.LoadCountryLanguage()
Private.LanguageList={} 
for k,v in pairs(Private.LanguageData) do if not table.find(Private.LanguageList,k) then table.insert(Private.LanguageList,k) end end
table.sort(Private.LanguageList,function(a,b) return a:lower()<b:lower() end) 
function Private.StartTanslatorPanel()
	local screenGui=Instance.new("ScreenGui") screenGui.ResetOnSpawn=false screenGui.Name="TranslatorGui" screenGui.Enabled=false
	local mainFrame=Instance.new("Frame",screenGui) mainFrame.Name="Main" mainFrame.Size=UDim2.new(0,400,0,320) mainFrame.Position=UDim2.new(0,20,0.5,-160) mainFrame.BackgroundColor3=Color3.fromRGB(20,20,20) mainFrame.Active=true mainFrame.Draggable=true Instance.new("UICorner",mainFrame)
	local title=Instance.new("TextLabel",mainFrame) title.Name="Title" title.Size=UDim2.new(1,0,0,40) title.BackgroundColor3=Color3.fromRGB(35,35,35) title.Text="     Chat Translator by Google" title.TextColor3=Color3.new(1,1,1) title.Font=Enum.Font.SourceSansBold title.TextSize=16 title.TextXAlignment=Enum.TextXAlignment.Left Instance.new("UICorner",title)
	local scrollFrame=Instance.new("ScrollingFrame",mainFrame) scrollFrame.Name="List" scrollFrame.Size=UDim2.new(1,-10,1,-55) scrollFrame.Position=UDim2.new(0,5,0,45) scrollFrame.BackgroundTransparency=1 scrollFrame.AutomaticCanvasSize=Enum.AutomaticSize.Y scrollFrame.ScrollBarThickness=4 scrollFrame.CanvasSize=UDim2.new(0,0,0,0)
	local layout=Instance.new("UIListLayout",scrollFrame) layout.Padding=UDim.new(0,6)
	local chatBox=Instance.new("TextBox",mainFrame) chatBox.Name="ChatBox" chatBox.Text="" chatBox.Position=UDim2.new(0,0,1.01,0) chatBox.Size=UDim2.new(1,0,0.103,0) chatBox.BackgroundColor3=Color3.fromRGB(20,20,20) chatBox.BorderSizePixel=0 chatBox.PlaceholderText="Type here" chatBox.TextColor3=Color3.fromRGB(255,255,255) Instance.new("UICorner",chatBox)
	title.TextColor3=Rayfield.SelectedTheme.TextColor mainFrame.BackgroundColor3=Rayfield.SelectedTheme.Background chatBox.BackgroundColor3=Rayfield.SelectedTheme.Background title.BackgroundColor3=Rayfield.SelectedTheme.Topbar chatBox.TextColor3=Rayfield.SelectedTheme.TextColor chatBox.PlaceholderColor3=Rayfield.SelectedTheme.PlaceholderColor
	Rayfield.Gui.Main:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
		if screenGui.Parent then title.TextColor3=Rayfield.SelectedTheme.TextColor mainFrame.BackgroundColor3=Rayfield.SelectedTheme.Background chatBox.BackgroundColor3=Rayfield.SelectedTheme.Background title.BackgroundColor3=Rayfield.SelectedTheme.Topbar chatBox.TextColor3=Rayfield.SelectedTheme.TextColor chatBox.PlaceholderColor3=Rayfield.SelectedTheme.PlaceholderColor end
	end)
	UILibrary:SetProtectUI(screenGui) UILibrary:SetAutoResizeUI(screenGui) Private.TanslatorPanel=screenGui
	Private.NormalChatQueue={}
	local function AddChatToUI(key,original,translated)
		if not screenGui.Parent then return end
		if #Private.NormalChatQueue>=150 then local oldestMessage=table.remove(Private.NormalChatQueue,1) if oldestMessage then oldestMessage:Destroy() end end
		local container=Instance.new("Frame",scrollFrame) container.Name=key container.Size=UDim2.new(1,-5,0,0) container.AutomaticSize=Enum.AutomaticSize.Y container.BackgroundTransparency=1
		local label=Instance.new("TextButton",container) label.Name="Title" label.Size=UDim2.new(1,-65,0,20) label.AutomaticSize=Enum.AutomaticSize.Y label.BackgroundColor3=Color3.fromRGB(40,45,50) label.TextColor3=Color3.new(1,1,1) label.Font=Enum.Font.SourceSans label.TextSize=15 label.RichText=true label.TextWrapped=true label.TextXAlignment=Enum.TextXAlignment.Left label.Text="<b>"..key.."</b>: "..translated Instance.new("UIPadding",label).PaddingLeft=UDim.new(0,8)
		local interact=Instance.new("TextButton",container) interact.Name="Interact" interact.Size=UDim2.new(0,60,0,20) interact.Position=UDim2.new(1,-60,0,0) interact.BackgroundTransparency=0 interact.BackgroundColor3=Color3.fromRGB(60,120,255) interact.Text="Origin" interact.TextColor3=Color3.new(1,1,1) interact.TextSize=25 interact.Font=Enum.Font.SourceSansBold interact.TextScaled=true Instance.new("UITextSizeConstraint",interact).MaxTextSize=20
		local showingOriginal,currentText,connection=false,translated,nil
		label.BorderSizePixel=0 interact.BorderSizePixel=0 label.TextColor3=Rayfield.SelectedTheme.TextColor label.BackgroundColor3=Rayfield.SelectedTheme.ElementBackground
		if Instancer.IsAlive(Rayfield.Gui) then connection=Rayfield.Gui.Main:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() if screenGui.Parent and container.Parent then label.TextColor3=Rayfield.SelectedTheme.TextColor label.BackgroundColor3=Rayfield.SelectedTheme.ElementBackground local switchColor=showingOriginal and Rayfield.SelectedTheme.ToggleDisabled or Rayfield.SelectedTheme.ToggleEnabled TweenService:Create(interact,TweenInfo.new(0.8,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{BackgroundColor3=switchColor}):Play() end end) else container:Destroy() return end
		container.AncestryChanged:Connect(function(_,parent) if not parent and connection then connection:Disconnect() end end)
		table.insert(Private.NormalChatQueue,container)
		local function UpdateTranslator()
			if showingOriginal then 
				currentText=original
				label.Text="<b>"..key.."</b>: <font color='#ffaa00'>"..original.."</font>" 
				interact.Text="TRANS" 
				TweenService:Create(interact,TweenInfo.new(0.8,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{BackgroundColor3=Rayfield.SelectedTheme.ToggleDisabled}):Play()
			else 
				currentText=translated
				label.Text="<b>"..key.."</b>: "..translated 
				interact.Text="ORIGIN" 
				TweenService:Create(interact,TweenInfo.new(0.8,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{BackgroundColor3=Rayfield.SelectedTheme.ToggleEnabled}):Play()
			end 
		end
		UpdateTranslator()
		container:SetAttribute("Translate",false)
		local selectedLanguage=Private.LanguageValue
		container:GetAttributeChangedSignal("SelectedLanguage"):Connect(function()
			local newSelectedLanguage=Private.LanguageValue
			if selectedLanguage~=newSelectedLanguage then
				selectedLanguage=newSelectedLanguage
				local newTranslated=nil
				if Private.GoogleTranslate then
					newTranslated=Private.GoogleTranslate(original,selectedLanguage) 
				elseif Private.UseStudio then
					newTranslated=ReplicatedStorage:WaitForChild("UpdateLanguageFunc"):InvokeServer(original,selectedLanguage)
				end
				if newTranslated then
					translated=newTranslated
					UpdateTranslator()
				end
			end
		end)
		label.Activated:Connect(function()
			setclipboard(currentText)
			Private.Notify("Info","Copied To Clipboard!",5)
		end)
		interact.MouseButton1Click:Connect(function() 
			showingOriginal=not showingOriginal 
			UpdateTranslator()
			task.wait(0.05) 
			scrollFrame.CanvasPosition=Vector2.new(scrollFrame.CanvasPosition.X,scrollFrame.CanvasPosition.Y-layout.AbsoluteContentSize.Y)
		end)
	end
	if Private.UseStudio then
		local Remote=ReplicatedStorage:WaitForChild("TranslateEvent") 
		Remote.OnClientEvent:Connect(AddChatToUI)
		Private.AddChatTranslator=function(key,text,language)
			local translated=ReplicatedStorage:WaitForChild("UpdateLanguageFunc"):InvokeServer(text,language) 
			AddChatToUI(key,text,translated) 
		end
	else
		Private.GoogleTranslate=function(text,language) 
			language=language or "en" 
			local url="https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl="..language.."&dt=t&q="..HttpService:UrlEncode(text) 
			local success,result,attempt=nil,nil,0
			repeat success,result=pcall(function() return game:HttpGet(url) end)  if not success or not result then task.wait(1) end attempt+=1 until success or attempt>=10
			if success then local decoded=HttpService:JSONDecode(result) if decoded and decoded[1] and decoded[1][1] then return decoded[1][1][1] end end 
			return "[Error]" 
		end
		Private.AddChatTranslator=function(key,text,language) 
			local translated=Private.GoogleTranslate(text,language) 
			AddChatToUI(key,text,translated) 
		end
		local function SetupPlayer(player) player.Chatted:Connect(function(message) Private.AddChatTranslator(player.Name,message,Private.LanguageValue) end) end
		Players.PlayerAdded:Connect(SetupPlayer)
		for i,player in ipairs(Players:GetPlayers()) do task.defer(SetupPlayer,player) end
	end
	if Private.AddChatTranslator then
		chatBox.FocusLost:Connect(function(enter)
			if not enter then return end
			local InputText=chatBox.Text
			if Strs.IsEmpty(InputText) then return end
			Private.AddChatTranslator(LocalPlayer.Name,InputText,Private.LanguageValue)
			chatBox.Text=""
		end)
	end
end
pcall(Private.StartTanslatorPanel)
function Private.SetTanslator(no) Private.TanslatorPanel.Enabled=no==1 end
Private.AddCommand({"tanslator"},function() Private.SetTanslator(1) end) Private.AddCommand({"untanslator"},function() Private.SetTanslator(0) end)
Private.TranslatorTab=Private.Window:CreateTab("Translator")
Private.CanUpdateLanguage=true
Private.TanslatorCommandList={
	{Type="Toggle",Name="Tanslator",Callback=function(Value) Private.ExecuteCommand(Value and "tanslator" or "untanslator") end}, 
	{Type="Dropdown",Name="Language Mode",MultipleOptions=false,Options=Private.LanguageList,["Option"]={Private.Language},Callback=function(Values) 
		local newLanguageValue=Private.LanguageData[Values[1] or ""] 
		if newLanguageValue and Private.LanguageValue~=newLanguageValue then 
			Private.LanguageValue=newLanguageValue 
			if Private.CanUpdateLanguage then 
				for i,v in ipairs(Private.NormalChatQueue) do 
					if Instancer.IsAlive(v) then v:SetAttribute("SelectedLanguage",newLanguageValue) end
				end 
			end 
			if Private.UseStudio then 
				ReplicatedStorage:WaitForChild("ChangeLanguageEvent"):FireServer(newLanguageValue) 
			end 
		end 
	end},
	{Type="Toggle",Name="Auto Language Enabled",Value=true,Callback=function(Value) Private.CanUpdateLanguage=Value end}
}
for i,v in ipairs(Private.TanslatorCommandList) do local NewContext=Private.TranslatorTab:AddContext(v) Private.ServerExpand:Add(NewContext) end
_G.MaswaLibrary=Private
return Private
