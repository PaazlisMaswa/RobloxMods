-- Create by @Paazlis
-- Version: 1.5

if type(_G.PaazlisUI)=="table" then return _G.PaazlisUI end

local Missing=function(t,v,f)
	return type(v)==t and v or f
end

cloneref,gethui=Missing("function",cloneref,function(v) return v end),Missing("function",gethui,nil)

local GetService=function(name)
	local service=game:GetService(name)
	if cloneref then return cloneref(service) else return service end
end

local Services={}

for i,v in ipairs({'Players','UserInputService','TweenService','StarterGui','RunService'}) do 
	if not Services[v] then 
		local success,service=pcall(GetService,v) 
		if success and service then 
			Services[v]=service 
		end 
	end 
end

local RunService=GetService("RunService")
if not RunService:IsClient() then
	error("PaazlisUI only works on client")
	return
end

local GlobalData={
	["Others"]={
		{
			["Switch"]=true,
			["TextLabel"]=true,
			["Button"]=true,
			["Field"]=true,
			["TextBox"]=true,
			["TextButton"]=true,
			["Selector"]=true,
			["Toggle"]=true,
			["Select"]=true,
			["Dropdown"]=true,
		},
		{
			[true]="■",
			[false]="□"
		},
		{
			[true]=Color3.fromRGB(0,200,97),
			[false]=Color3.fromRGB(255,89,89)
		}
	}
}

local Notifications,Module={},{}
local Library={Loaded=false}
_G.PaazlisUI=Library

local Players,UserInputService,TweenService,StarterGui=GetService("Players"),GetService("UserInputService"),GetService("TweenService"),GetService("StarterGui")

local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
local OFFSET=UDim2.new(0,100,0,50) -- geser 100px kanan, 50px bawah

local NameTypes,TurnSysmbols,TurnColors=unpack(GlobalData.Others)
local baseX,baseY=1024,768
local UseStudio=RunService:IsStudio()

function Module:CreateCanvas(Gui)
	local Frame=Instance.new("Frame")
	Frame.Name="Frame"
	Frame.BackgroundColor3=Color3.fromRGB(57,59,61)
	Frame.BackgroundTransparency=0
	Frame.BorderSizePixel=0
	Frame.Position=UDim2.new(0.1,0,0.38,0)
	Frame.Size=UDim2.new(0,180,0,34)
	Frame.Parent=Gui
	
	local Title=Instance.new("TextLabel")
	Title.Name="Title"
	Title.BackgroundTransparency=1
	Title.BorderSizePixel=0
	Title.Position=UDim2.new(0,0,0,0)
	Title.Size=UDim2.new(1,0,1,0)
	Title.TextSize=18
	Title.Font=Enum.Font.SourceSansBold
	Title.TextColor3=Color3.fromRGB(248,248,248)
	Title.Text="Title Here"
	Title.Parent=Frame

	local Open=Instance.new("TextButton")
	Open.Name="Open"
	Open.BackgroundTransparency=1
	Open.Position=UDim2.new(0.85,0,0.05,0)
	Open.BorderSizePixel=0
	Open.Size=UDim2.new(0.15,0,0.8,0)
	Open.TextSize=18
	Open.Font=Enum.Font.SourceSansBold
	Open.TextColor3=Color3.fromRGB(248,248,248)
	Open.Text="v"
	Open.Parent=Frame

	local Container=Instance.new("ScrollingFrame")
	Container.Name="Container"
	Container.BackgroundColor3=Color3.fromRGB(57,59,61)
	Container.BackgroundTransparency=0
	Container.BorderSizePixel=0
	Container.Position=UDim2.new(0,0,1,0)
	Container.Size=UDim2.new(1,0,0,200)
	Container.BorderSizePixel=0
	Container.CanvasSize=UDim2.new(0,0,0,0)
	Container.ScrollBarThickness=0
	Container.ScrollingDirection=Enum.ScrollingDirection.Y
	Container.Selectable=false
	Container.AutomaticCanvasSize=Enum.AutomaticSize.Y
	Container.Parent=Frame

	local UIListLayout=Instance.new("UIListLayout")
	UIListLayout.SortOrder=Enum.SortOrder.LayoutOrder
	UIListLayout.Parent=Container

	local UIPadding=Instance.new("UIPadding")
	UIPadding.PaddingBottom=UDim.new(0,5)
	UIPadding.PaddingLeft=UDim.new(0,5)
	UIPadding.PaddingRight=UDim.new(0,5)
	UIPadding.PaddingTop=UDim.new(0,5)
	UIPadding.Parent=Container
	
	-- TextButton, TextLabel, TextBox
	local Template=Instance.new("Frame")
	Template.Name="Template"
	Template.BackgroundTransparency=1
	Template.BorderSizePixel=0
	Template.Position=UDim2.new(0,0,0,0)
	Template.Size=UDim2.new(1,0,0,30)
	Template.Parent=Container
	
	local TextButton=Instance.new("TextButton")
	TextButton.Name="TextButton"
	TextButton.BackgroundColor3=Color3.fromRGB(163,162,165)
	TextButton.BackgroundTransparency=0
	TextButton.BorderSizePixel=0
	TextButton.Position=UDim2.new(0.049,0,0.123,0)
	TextButton.Size=UDim2.new(0.9,0,0.753,0)
	TextButton.Text="Text Here"
	TextButton.Font=Enum.Font.SourceSansBold
	TextButton.TextStrokeTransparency=1
	TextButton.TextTransparency=0
	TextButton.TextColor3=Color3.fromRGB(248,248,248)
	TextButton.TextSize=18
	TextButton.Parent=Template

	local TextBox=Instance.new("TextBox")
	TextBox.Name="TextBox"
	TextBox.BackgroundColor3=Color3.fromRGB(163,162,165)
	TextBox.BackgroundTransparency=0
	TextBox.BorderSizePixel=0
	TextBox.Position=UDim2.new(0.049,0,0.123,0)
	TextBox.Size=UDim2.new(0.9,0,0.753,0)
	TextBox.PlaceholderText="Text Here"
	TextBox.Font=Enum.Font.SourceSansBold
	TextBox.TextStrokeTransparency=1
	TextBox.TextTransparency=0
	TextBox.PlaceholderColor3=Color3.fromRGB(248,248,248)
	TextBox.TextColor3=Color3.fromRGB(248,248,248)
	TextBox.TextSize=18
	TextBox.Parent=Template

	local TextLabel=Instance.new("TextLabel")
	TextLabel.Name="TextLabel"
	TextLabel.BackgroundTransparency=1
	TextLabel.BorderSizePixel=0
	TextLabel.Position=UDim2.new(0,0,0,0)
	TextLabel.Size=UDim2.new(1,0,1,0)
	TextLabel.Text="Text Here"
	TextLabel.Font=Enum.Font.SourceSansBold
	TextLabel.TextStrokeTransparency=1
	TextLabel.TextTransparency=0
	TextLabel.TextColor3=Color3.fromRGB(248,248,248)
	TextLabel.TextSize=18
	TextLabel.Parent=Template
	
	Template.Parent=nil
	
	-- Toggle
	local Toggle=Instance.new("Frame")
	Toggle.Name="Toggle"
	Toggle.BackgroundTransparency=1
	Toggle.BorderSizePixel=0
	Toggle.Position=UDim2.new(0,0,0,0)
	Toggle.Size=UDim2.new(1,0,0,30)
	Toggle.Parent=Container

	local TextLabel2=Instance.new("TextLabel")
	TextLabel2.Name="TextLabel"
	TextLabel2.BackgroundTransparency=1
	TextLabel2.BorderSizePixel=0
	TextLabel2.Position=UDim2.new(0.049,0,0.123,0)
	TextLabel2.Size=UDim2.new(0.682,0,0.753,0)
	TextLabel2.Text="Text Here"
	TextLabel2.Font=Enum.Font.SourceSansBold
	TextLabel2.TextStrokeTransparency=1
	TextLabel2.TextTransparency=0
	TextLabel2.TextColor3=Color3.fromRGB(248,248,248)
	TextLabel2.TextScaled=true
	TextLabel2.Parent=Toggle

	local TextButton2=Instance.new("TextButton")
	TextButton2.Name="TextButton"
	TextButton2.BackgroundTransparency=1
	TextButton2.BorderSizePixel=0
	TextButton2.AutoButtonColor=false
	TextButton2.Position=UDim2.new(0.767,0,0.123,0)
	TextButton2.Size=UDim2.new(0.179,0,0.753,0)
	TextButton2.Text="□"
	TextButton2.Font=Enum.Font.SourceSansBold
	TextButton2.TextStrokeTransparency=1
	TextButton2.TextTransparency=0
	TextButton2.TextColor3=Color3.fromRGB(248,248,248)
	TextButton2.TextScaled=true
	TextButton2.Parent=Toggle
	
	Toggle.Parent=nil
	
	-- Selector
	local Selector=Instance.new("Frame")
	Selector.Name="Selector"
	Selector.BackgroundTransparency=1
	Selector.BorderSizePixel=0
	Selector.Position=UDim2.new(0,0,0,0)
	Selector.Size=UDim2.new(1,0,0,30)
	Selector.Parent=Container
	
	local TextLabel3=Instance.new("TextLabel")
	TextLabel3.Name="TextLabel"
	TextLabel3.BackgroundTransparency=1
	TextLabel3.BorderSizePixel=0
	TextLabel3.Position=UDim2.new(0,0,0,0)
	TextLabel3.Size=UDim2.new(1,0,1,0)
	TextLabel3.Text="Option 1"
	TextLabel3.Font=Enum.Font.SourceSansBold
	TextLabel3.TextStrokeTransparency=1
	TextLabel3.TextTransparency=0
	TextLabel3.TextColor3=Color3.fromRGB(248,248,248)
	TextLabel3.TextSize=18
	TextLabel3.Parent=Selector

	local Next=Instance.new("TextButton")
	Next.Name="Next"
	Next.AutoButtonColor=false
	Next.BackgroundTransparency=1
	Next.BorderSizePixel=0
	Next.Position=UDim2.new(0.806,0,0,0)
	Next.Size=UDim2.new(0.194,0,1,0)
	Next.Font=Enum.Font.SourceSansBold
	Next.TextColor3=Color3.fromRGB(248,248,248)
	Next.TextTransparency=1
	Next.Text=""
	Next.Parent=Selector
	
	local TextLabel4=Instance.new("TextLabel")
	TextLabel4.Name="TextLabel"
	TextLabel4.AnchorPoint=Vector2.new(0.5,0.5)
	TextLabel4.BackgroundTransparency=1
	TextLabel4.BorderSizePixel=0
	TextLabel4.Position=UDim2.new(0.5,0,0.5,0)
	TextLabel4.Size=UDim2.new(1,0,1,0)
	TextLabel4.Text=">"
	TextLabel4.Font=Enum.Font.SourceSansBold
	TextLabel4.TextStrokeTransparency=1
	TextLabel4.TextTransparency=0
	TextLabel4.TextColor3=Color3.fromRGB(248,248,248)
	TextLabel4.TextScaled=true
	TextLabel4.Parent=Next
	
	local Previous=Instance.new("TextButton")
	Previous.Name="Previous"
	Previous.AutoButtonColor=false
	Previous.BackgroundTransparency=1
	Previous.BorderSizePixel=0
	Previous.Position=UDim2.new(0,0,0,0)
	Previous.Size=UDim2.new(0.194,0,1,0)
	Previous.TextScaled=true
	Previous.Font=Enum.Font.SourceSansBold
	Previous.TextColor3=Color3.fromRGB(248,248,248)
	Previous.TextTransparency=1
	Previous.Text=""
	Previous.Parent=Selector
	
	local TextLabel5=Instance.new("TextLabel")
	TextLabel5.Name="TextLabel"
	TextLabel5.AnchorPoint=Vector2.new(0.5,0.5)
	TextLabel5.BackgroundColor3=Color3.fromRGB(163,162,165)
	TextLabel5.BackgroundTransparency=1
	TextLabel5.BorderSizePixel=0
	TextLabel5.Position=UDim2.new(0.5,0,0.5,0)
	TextLabel5.Size=UDim2.new(1,0,1,0)
	TextLabel5.Text="<"
	TextLabel5.Font=Enum.Font.SourceSansBold
	TextLabel5.TextStrokeTransparency=1
	TextLabel5.TextTransparency=0
	TextLabel5.TextColor3=Color3.fromRGB(248,248,248)
	TextLabel5.TextScaled=true
	TextLabel5.Parent=Previous
	
	Selector.Parent=nil
	
	
	-- Select
	local Select=Instance.new("Frame")
	Select.Name="Select"
	Select.BackgroundTransparency=1
	Select.BorderSizePixel=0
	Select.Position=UDim2.new(0,0,0,0)
	Select.Size=UDim2.new(1,0,0,30)
	Select.Parent=Container
	
	local Frame2=Instance.new("Frame")
	Frame2.Name="Frame"
	Frame2.BackgroundColor3=Color3.fromRGB(200,200,200)
	Frame2.BackgroundTransparency=0
	Frame2.BorderSizePixel=0
	Frame2.Position=UDim2.new(0.41,0,0.123,0)
	Frame2.Size=UDim2.new(0.539,0,0.753,0)
	Frame2.Parent=Select

	local TextButton3=Instance.new("TextButton")
	TextButton3.Name="TextButton"
	TextButton3.BackgroundColor3=Color3.fromRGB(0,200,97)
	TextButton3.BackgroundTransparency=0
	TextButton3.BorderSizePixel=0
	TextButton3.Position=UDim2.new(0.049,0,0.123,0)
	TextButton3.Size=UDim2.new(0.299,0,0.753,0)
	TextButton3.Font=Enum.Font.SourceSansBold
	TextButton3.TextScaled=true
	TextButton3.TextColor3=Color3.fromRGB(248,248,248)
	TextButton3.Text="Select"
	TextButton3.Parent=Select
	
	Select.Parent=nil
	

	-- Dropdown
	local Dropdown=Instance.new("Frame")
	Dropdown.Name="Dropdown"
	Dropdown.BackgroundTransparency=1
	Dropdown.BorderSizePixel=0
	Dropdown.Position=UDim2.new(0,0,0,0)
	Dropdown.Size=UDim2.new(1,0,0,30)
	Dropdown.Parent=Container

	local TextLabel6=Instance.new("TextLabel")
	TextLabel6.Name="TextLabel"
	TextLabel6.BackgroundTransparency=1
	TextLabel6.BorderSizePixel=0
	TextLabel6.Position=UDim2.new(0.049,0,0,0)
	TextLabel6.Size=UDim2.new(0.757,0,1,0)
	TextLabel6.Text="Dropdown"
	TextLabel6.Font=Enum.Font.SourceSansBold
	TextLabel6.TextStrokeTransparency=1
	TextLabel6.TextTransparency=0
	TextLabel6.TextColor3=Color3.fromRGB(248,248,248)
	TextLabel6.TextSize=18
	TextLabel6.Parent=Dropdown
	
	local TextLabel7=Instance.new("TextLabel")
	TextLabel7.Name="Subtitle"
	TextLabel7.BackgroundTransparency=1
	TextLabel7.BorderSizePixel=0
	TextLabel7.Position=UDim2.new(0.806,0,0,0)
	TextLabel7.Size=UDim2.new(0.194,0,1,0)
	TextLabel7.Text="-"
	TextLabel7.Font=Enum.Font.SourceSansBold
	TextLabel7.TextStrokeTransparency=1
	TextLabel7.TextTransparency=0
	TextLabel7.TextColor3=Color3.fromRGB(248,248,248)
	TextLabel7.TextSize=18
	TextLabel7.Parent=Dropdown
	
	local TextButton4=Instance.new("TextButton")
	TextButton4.Name="TextButton"
	TextButton4.AutoButtonColor=false
	TextButton4.BackgroundTransparency=1
	TextButton4.BorderSizePixel=0
	TextButton4.Position=UDim2.new(0,0,0,0)
	TextButton4.Size=UDim2.new(1,0,1,0)
	TextButton4.Font=Enum.Font.SourceSansBold
	TextButton4.TextColor3=Color3.fromRGB(248,248,248)
	TextButton4.TextTransparency=1
	TextButton4.Parent=Dropdown

	Dropdown.Parent=nil
	
	return {
		["Frame"]=Frame,
		["Title"]=Title,
		["Open"]=Open,
		["Container"]=Container,
		["UIListLayout"]=UIListLayout,
		["Template"]=Template,
		["Toggle"]=Toggle,
		["Selector"]=Selector,
		["Select"]=Select,
		["Dropdown"]=Dropdown
	}
end

local LastFrame=nil

local PlayerGui=LocalPlayer:WaitForChild("PlayerGui")
local CoreGui=UseStudio and GetService("CoreGui") or nil

local Gui=Instance.new("ScreenGui")
Gui.Name="PaazlisGui"
Gui.DisplayOrder=1000
Gui.ResetOnSpawn=false
Gui.AutoLocalize=false
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Global

if gethui then
	Gui.Parent=gethui()
elseif syn and syn.protect_gui then 
	syn.protect_gui(Gui)
	Gui.Parent=CoreGui
elseif not UseStudio then
	Gui.Parent=CoreGui:FindFirstChild("RobloxGui") or CoreGui
elseif UseStudio and script and script.Parent then
	Gui.Parent=PlayerGui
end

function Module:DeepCopy(t)
	local copyTable={}
	for k,v in t do
		if type(v)=="table" then
			copyTable[k]=Module:DeepCopy(v)
		else
			copyTable[k]=v
		end
	end
	return copyTable
end

function Module:GrabUI(frame)
	local dragging,dragInput,dragStart,startPos
	local inputBeganConnection,inputChangedConnection1,inputChangedConnection2
	inputBeganConnection=frame.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			dragging=true dragStart=input.Position startPos=frame.Position
			input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
		end
	end)
	inputChangedConnection1=frame.InputChanged:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then dragInput=input end
	end)
	inputChangedConnection2=UserInputService.InputChanged:Connect(function(input)
		if input==dragInput and dragging then
			local delta=input.Position-dragStart
			frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
		end
	end)
	return function()
		inputBeganConnection:Disconnect()
		inputChangedConnection1:Disconnect()
		inputChangedConnection2:Disconnect()
	end
end

function Module:ResizeUIScale(ui,screenSize)
	local scaleX=screenSize.X / baseX
	local scaleY=screenSize.Y / baseY
	local scale=math.min(scaleX, scaleY)
	
	local minAxis=math.min(screenSize.X, screenSize.Y)
	local isSmallScreen=minAxis <= 500
	
	local uiScale=ui:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
	uiScale.Parent=ui
	
	local result=1
	
	if scale < 1 then
		result=scale*1.5
	elseif scale > 1 then
		result=scale*1
	else
		result=1
	end
	
	uiScale.Scale=result
end

function Module:UpdateTextSize(label)
	local c=#label.Text label.TextSize=if c>=90 and c<101 then 0 elseif c>=60 and c<70 then 7 elseif c>=50 and c<60 then 8 elseif c>=10 and c<20 then 10 else 14; label.TextScaled=label.TextSize<=0
end

Module:ResizeUIScale(Gui,workspace.CurrentCamera.ViewportSize)
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	Module:ResizeUIScale(Gui,workspace.CurrentCamera.ViewportSize)
end)

do
	function Library:CreateWindow(WindowSettings)
		local Contexts={}

		local Window=Module:CreateCanvas(Gui)
		Window.Order=0
		Window.Parent=true

		if type(WindowSettings)=="table" then
			Window.Title.Text=type(WindowSettings.Title)=="string" and WindowSettings.Title or Window.Title.Text
		end

		function Window:SetTitle(Text)
			self.Title.Text=Text
		end
		
		local Frm=Window.Frame
		if LastFrame and LastFrame.Position==Frm.Position then
			LastFrame.Position=Frm.Position+OFFSET
		end
		
		local GrabUIClean=nil
		
		LastFrame=Frm

		-- Recalculate the window height
		function Window:ApplyWindowHeight()
			local container=self.Container
			local height=container.UIListLayout.AbsoluteContentSize.Y+container.UIPadding.PaddingTop.Offset+container.UIPadding.PaddingBottom.Offset
			container.Size=UDim2.new(container.Size.X.Scale,container.Size.X.Offset,0,math.clamp(height,0,300))
		end

		-- Set the visibility of the window
		function Window:SetVisible(visible)
			self.Container.Visible=visible
			local open=self.Open
			open.Text=visible and "–" or "v"
			open.TextSize=visible and 30 or 18
			self:ApplyWindowHeight()
		end

		-- Get the visibility of the window
		function Window:IsVisible()
			return self.Container.Visible
		end

		-- Hide the visibility of the window
		function Window:Hide()
			self:SetVisible(false)
		end

		-- Add a context to the window
		function Window:AddContext(ContextSettings)
			ContextSettings=Missing("table",ContextSettings,{})
			
			local setCallback,applyCallback,cleanCallback
			
			local saveContext=Module:DeepCopy(ContextSettings)
			local typeName=ContextSettings.Type
			local template=nil
			local cache={}

			local switch,toggle,selector,selec,dropDown,temp,uiListLayout,container=self.Switch,self.Toggle,self.Selector,self.Select,self.Dropdown,self.Template,self.UIListLayout,self.Container
			if typeName=="Switch" then
				if switch then
					template=switch:Clone()
				end
			elseif typeName=="Selector" then
				if selector then
					template=selector:Clone()
				end
			elseif typeName=="Toggle" then
				if toggle then
					template=toggle:Clone()
				end
			elseif typeName=="Select" then
				if selec then
					template=selec:Clone()
				end
			elseif typeName=="Dropdown" then
				if dropDown then
					template=dropDown:Clone()
				end
			else
				if temp then
					template=temp:Clone()
				end
			end

			if not template then return ContextSettings end

			template.Name=NameTypes[typeName] and typeName or "Unknown"

			if not NameTypes[typeName] then
				if template then
					template:Destroy()
				end
				return ContextSettings
			end

			local textLabel:TextLabel=template:FindFirstChild("TextLabel")
			local textButton:TextButton=template:FindFirstChild("TextButton")
			local textBox:TextBox=template:FindFirstChild("TextBox")
			local emptyFrame:Frame=template:FindFirstChild("Frame")
			local subtitleLabel:TextLabel=template:FindFirstChild("Subtitle")
			
			local contextClass={Type=typeName}
			
			local function SafeCallback(...)
				if ContextSettings.Callback then pcall(ContextSettings.Callback,...) end
			end

			if typeName=="TextLabel" then
				textButton:Destroy() textButton=nil
				textBox:Destroy() textBox=nil
				setCallback=function(value)
					if ContextSettings.Value~=value then
						ContextSettings.Value=value
						textLabel.Text=value
					end
				end
				textLabel.Text=ContextSettings.Name or ContextSettings.Text or "Text Here"
				ContextSettings.Value=textLabel.Text
			elseif typeName=="TextButton" or typeName=="Button" then
				textBox:Destroy() textBox=nil
				textLabel:Destroy() textLabel=nil
				textButton.Text=ContextSettings.Name or ContextSettings.Text or "Text Here"
				cache.ButtonActivated=textButton.Activated:Connect(SafeCallback)
			elseif typeName=="TextBox" then
				textButton:Destroy() textButton=nil
				textLabel:Destroy() textLabel=nil
				textBox.PlaceholderText=ContextSettings.PlaceholderText or "Text here"
				textBox.Text=""
				cache.TextFocustLost=textBox.FocusLost:Connect(function(submit)
					if not submit then return end
					SafeCallback(textBox.Text)
				end)
				cache.TextChanged=textBox:GetPropertyChangedSignal("Text"):Connect(function()
					if ContextSettings.Changed then pcall(ContextSettings.Changed,textBox.Text) end
				end)
			elseif typeName=="Toggle" then
				setCallback=function(value)
					if ContextSettings.Value~=value then
						ContextSettings.Value=value
						textButton.Text=TurnSysmbols[value]
						SafeCallback(value)
					end
				end
				ContextSettings.Value=Missing("boolean",ContextSettings.Value,false)
				textButton.Text=TurnSysmbols[ContextSettings.Value]
				textLabel.Text=ContextSettings.Name or ContextSettings.Text or "Text Here"
				cache.ButtonActivated=textButton.Activated:Connect(function()
					setCallback(not ContextSettings.Value)
				end)
			elseif typeName=="Selector" then
				ContextSettings.Mode=Missing("number",ContextSettings.Mode,1) 
				if type(ContextSettings.Options)~="table" then
					ContextSettings.Options={"Option 1","Option 2"}
				end
				ContextSettings.Index=type(ContextSettings.Index)=="number" and ContextSettings.Index or 0
				ContextSettings.Value=type(ContextSettings.Value)=="string" and ContextSettings.Value or ContextSettings.Options[1]
				if ContextSettings.Mode==2 then
					template:Destroy() template=nil
					self.Order-=1
					
					local newSection,newDropdown
					
					if type(ContextSettings.Title)=="string" then
						self.Order-=1
						newSection=Window:AddContext({
							Type="TextLabel",
							Name=ContextSettings.Title,
						})
					end
					
					newDropdown=Window:AddContext({
						Type="Dropdown",
						Name=tostring(ContextSettings.Value),
						Active=false
					})
					
					template=newDropdown.Template
					textLabel=template:FindFirstChildOfClass("TextLabel") :: TextLabel
					textLabel.Text=tostring(ContextSettings.Value)
					
					setCallback=function(value,index)
						if ContextSettings.Value~=value then
							ContextSettings.Value=value
							textLabel.Text=tostring(value)
							if index then ContextSettings.Index=index end
							SafeCallback(value,index)
						end
					end

					for i,v in ipairs(ContextSettings.Options) do
						local newButton=Window:AddContext({
							Type="Button",
							Name=v,
							Callback=function()
								if newDropdown.Parent and newDropdown.Active then
									setCallback(v,i)
									newDropdown:Apply()
								end
							end
						})
						newButton.Template.Visible=false
						newButton.Parent=newDropdown
					end

					uiListLayout:ApplyLayout()
					
					ContextSettings.Dropdown=newDropdown
					ContextSettings.Section=newSection
					
					cleanCallback=function()
						ContextSettings.Dropdown=nil
						ContextSettings.Section=nil
						if newDropdown then newDropdown:Destroy() end
						if newSection then newSection:Destroy() end
					end
				else
					setCallback=function(value,index)
						if ContextSettings.Value~=value then
							ContextSettings.Value=value
							textLabel.Text=tostring(value)
							if index then ContextSettings.Index=index end
							SafeCallback(value,index)
						end
					end
					textLabel.Text=tostring(ContextSettings.Value)

					local selectorTweenInfo=TweenInfo.new(1,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out)
					local selectorPropertys1,selectorPropertys2={["Size"]=UDim2.new(0.8,0,0.8,0)},{["Size"]=UDim2.new(1,0,1,0)}

					local previousButton=template:FindFirstChild("Previous") :: TextButton

					cache.PreviousActivated=previousButton.Activated:Connect(function()
						if ContextSettings.NoCap then
							if ContextSettings.Index<=0 then ContextSettings.Index=1 end
							ContextSettings.Index=ContextSettings.Index<=1 and #ContextSettings.Options or ContextSettings.Index-1
						else
							ContextSettings.Index=ContextSettings.Index<=0 and 1 or ContextSettings.Index-1
							if ContextSettings.Index<=0 then ContextSettings.Index=1 end
						end
						setCallback(tostring(ContextSettings.Options[ContextSettings.Index]),ContextSettings.Index)
					end)

					local previousLabel=previousButton:FindFirstChild("TextLabel")

					cache.PreviousMouseEnter=previousButton.MouseEnter:Connect(function()
						TweenService:Create(previousLabel,selectorTweenInfo,selectorPropertys1):Play()
					end)

					cache.PreviousMouseLeave=previousButton.MouseLeave:Connect(function()
						TweenService:Create(previousLabel,selectorTweenInfo,selectorPropertys2):Play()
					end)

					local nextButton=template:FindFirstChild("Next") :: TextButton

					cache.NextActivated=nextButton.Activated:Connect(function()
						if ContextSettings.Index<=0 then ContextSettings.Index=1 end
						if ContextSettings.Index>=#ContextSettings.Options then
							ContextSettings.Index=ContextSettings.Index and 1 or #ContextSettings.Options
						else
							ContextSettings.Index+=1
						end
						setCallback(tostring(ContextSettings.Options[ContextSettings.Index]),ContextSettings.Index)
					end)

					local nextLabel=nextButton:FindFirstChild("TextLabel")

					cache.NextMouseEnter=nextButton.MouseEnter:Connect(function()
						TweenService:Create(nextLabel,selectorTweenInfo,selectorPropertys1):Play()
					end)

					cache.NextMouseLeave=nextButton.MouseLeave:Connect(function()
						TweenService:Create(nextLabel,selectorTweenInfo,selectorPropertys2):Play()
					end)
				end
			elseif typeName=="Select" then
				setCallback=function(value)
					if ContextSettings.Value~=value then
						ContextSettings.Value=value
						if type(value)=="table" then
							emptyFrame.BackgroundColor3=value.Color or Color3.fromRGB(200,200,200)
						elseif typeof(value)=="Instance" and value:IsA("BasePart") then
							emptyFrame.BackgroundColor3=value.Color
						end
						SafeCallback(value)
					end
				end

				ContextSettings.Value=ContextSettings.Value or nil
				ContextSettings.Active=type(ContextSettings.Active)=="boolean" and ContextSettings.Active or false
				
				textButton.BackgroundColor3=TurnColors[not ContextSettings.Active]
				
				cache.ButtonActivated=textButton.Activated:Connect(function()
					if cache.SelectMouseClick then cache.SelectMouseClick:Disconnect() cache.SelectMouseClick=nil end
					ContextSettings.Active=not ContextSettings.Active
					textButton.BackgroundColor3=TurnColors[not ContextSettings.Active]
					if ContextSettings.Active then
						cache.SelectMouseClick=Mouse.Button1Down:Connect(function()
							if ContextSettings.Active then
								local target=Mouse.Target
								if not (target and target.Parent) then return end
								setCallback(target)
							end
						end)
					end
				end)
			elseif typeName=="Dropdown" then
				ContextSettings.Active=type(ContextSettings.Active)=="boolean" and ContextSettings.Active or false
				subtitleLabel.Text=ContextSettings.Value and "v" or "–"
				contextClass.Children={}
				setCallback=function(value)
					if ContextSettings.Active~=value then
						ContextSettings.Active=value
						for i,v in ipairs(contextClass.Children) do
							if type(v)=="table" and v.Parent and v.Template then
								v.Template.Visible=value
							end
						end
						Window:ApplyWindowHeight()
						subtitleLabel.Text=value and "v" or "–"
						SafeCallback(value)
					end
				end
				applyCallback=function()
					local value=not ContextSettings.Active
					ContextSettings.Active=value
					for i,v in ipairs(contextClass.Children) do if type(v)=="table" and v.Parent and v.Template then v.Template.Visible=value end end
					Window:ApplyWindowHeight()
					subtitleLabel.Text=value and "v" or "–"
					SafeCallback(value)
				end
				cache.ButtonActivated=textButton.Activated:Connect(applyCallback)
			else
				template:Destroy()
				template=nil
				textLabel=nil
				textButton=nil
				textBox=nil
				emptyFrame=nil
			end

			if template and template.Parent~=container then
				self.Order+=1
				template.LayoutOrder=self.Order
				uiListLayout:ApplyLayout()
				template.Parent=container
				contextClass.Template=template
				ContextSettings.Parent=true
				template.Name=`{typeName} | {tostring(self.Order)}`
			end

			local funcs={}
			funcs.Destroy=function(this)
				local checkParent=ContextSettings.Parent
				ContextSettings.Parent=nil
				if type(checkParent)=="table" and type(checkParent.Children)=="table" then
					local foundIndex=table.find(checkParent.Children,this)
					if foundIndex then
						table.remove(checkParent.Children,foundIndex)
					end
					checkParent=nil
				end
				if type(this.Children)=="table" then
					local k,v=next(this.Children)
					while v do
						this.Children[k]=nil
						v:Destroy()
						k,v=next(this.Children)
					end
				end
				local k,v=next(cache)
				while v do
					cache[k]=nil
					v:Disconnect()
					k,v=next(cache)
				end
				cache={}
				template:Destroy()
				funcs={}
				ContextSettings={}
				table.clear(this)
				if cleanCallback then cleanCallback() cleanCallback=nil end
			end
			
			funcs.Set=function(this,value)
				local thisType=this.Type
				local valueType=type(value)
				if thisType=="TextLabel" and valueType=="string" then
					setCallback(value)
				elseif thisType=="TextBox" and valueType=="string" then
					textBox.PlaceholderText=value
				elseif thisType=="TextButton" and valueType=="string" then
					textButton.Text=value
				elseif thisType=="Toggle" and valueType=="boolean" then
					setCallback(value)
				elseif thisType=="Selector" and valueType=="string" then
					if ContextSettings.Value~=value then
						ContextSettings.Value=value
						if this.Mode==2 and this.Dropdown then
							this.Dropdown:Apply()
						end
						textLabel.Text=value
						local index=table.find(ContextSettings.Options,value)
						if index then ContextSettings.Index=index end
						SafeCallback(value,index)
					end
				elseif typeName=="Select" then
					setCallback(value)
				elseif typeName=="Dropdown" then
					setCallback(not ContextSettings.Active)
				end
			end
			
			funcs.Apply=function(this)
				if applyCallback then applyCallback() end
			end
			
			local newMetaTable=setmetatable(contextClass,{
				__index=function(this,key)
					local resolve=funcs[key]
					if resolve then
						return function(_,...)
							return resolve(this,...)
						end
					elseif key=="Type" then
						return typeName
					elseif key=="Value" then
						return ContextSettings.Value
					elseif key=="Active" then
						return ContextSettings.Active
					elseif key=="Index" then
						return ContextSettings.Index
					elseif key=="Template" then 
						return template
					elseif key=="Parent" then
						return ContextSettings.Parent
					elseif key=="CanVisibleWhenParent" then
						return ContextSettings.CanVisibleWhenParent
					elseif key=="Children" then
						return ContextSettings.Children
					elseif key=="Mode" then
						return ContextSettings.Mode
					else
						local success,result=pcall(function()
							if typeName=="TextLabel" then
								return textLabel[key]
							elseif typeName=="TextBox" then
								return textBox[key]
							elseif typeName=="TextButton" or typeName=="Select" then
								return textButton[key]
							elseif typeName=="Selector" then
								return ContextSettings[key]
							end
							return nil
						end)
						if success then
							return result
						end
					end
					return nil
				end,
				
				__newindex=function(this,key,value)
					if key=="Value" then
						if next(funcs) then funcs.Set(this,value) end
					elseif key=="Parent" then
						if type(value)=="table" then
							if type(value.Children)=="table" and value.Parent then
								ContextSettings.Parent=value
								table.insert(value.Children,this)
								if value.Type=="Dropdown" and value.CanVisibleWhenParent then
									if value.Active then
										value.Active=false
									else
										value.Active=true
									end
								end
							end
						else
							local lastParent=ContextSettings.Parent
							ContextSettings.Parent=value
							if lastParent and type(lastParent)=="table" then
								local foundIndex=table.find(lastParent.Children,this)
								if foundIndex then
									table.remove(lastParent.Children,foundIndex)
								end
								lastParent=nil
							end
						end
					elseif key=="Active" and this.Type=="Dropdown" then
						if next(funcs) then funcs.Set(this,value) end
					else
						if typeName=="TextLabel" then
							textLabel[key]=value
						elseif typeName=="TextBox" then
							textBox[key]=value
						elseif typeName=="TextButton" or typeName=="Select" then
							textButton[key]=value
						elseif typeName=="Toggle" then
							textLabel[key]=value
						end
					end
				end,
			})
			newMetaTable.Parent=true
			table.insert(Contexts,newMetaTable)
			return newMetaTable
		end

		-- Destroy a window
		function Window:Destroy()
			self.Parent=nil
			if GrabUIClean then GrabUIClean() end
			for k,v in ipairs(Contexts) do
				v:Destroy()
			end
			self.Frame:Destroy()
			table.clear(self)
		end

		local frame=Window.Frame
		GrabUIClean=Module:GrabUI(Window.Frame)
		Window:Hide()
		Window:ApplyWindowHeight()
		Window.Open.Activated:Connect(function()
			Window:SetVisible(not Window:IsVisible())
		end)
		
		return Window
	end
	
	function Library:Notify(...)
		local title,description,duration,barColor,mode
		local Data={}
		local args={...}
		if args[1] and type(args[1])=="table" then
			title,description,duration,barColor,mode=Data.Title,Data.Description,Data.Duration,Data.BarColor,Data.Mode
		else
			title,description,duration,barColor,mode=unpack(args)
		end
		title=Missing("string",title,"Title")
		description=Missing("string",description,"Description")
		duration=Missing("number",duration,5)
		mode=string.lower(Missing("string",mode,"None"))
		barColor=barColor or Color3.fromRGB(0,170,255)
		if mode=="error" then
			barColor=Color3.fromRGB(255,0,0)
		elseif mode=="success" then
			barColor=Color3.fromRGB(0,255,0)
		elseif mode=="warn" then
			barColor=Color3.fromRGB(255,170,0)
		end
		local tc,dc,spacing,height,width=#title,#description,10,60,260;
		local offsetY=20+(#Notifications*(height+spacing))
		local notification=Instance.new("Frame")
		notification.Size=UDim2.new(0,width,0,height)
		notification.Position=UDim2.new(1,width+20,1,-offsetY)
		notification.AnchorPoint=Vector2.new(1,1) 
		notification.BackgroundColor3=Color3.fromRGB(57,59,61)
		notification.BackgroundTransparency=0
		notification.ClipsDescendants=true
		notification.ZIndex=10
		notification.Parent=Gui
		local nuic1=Instance.new("UICorner")
		nuic1.CornerRadius=UDim.new(0,8)
		nuic1.Parent=notification
		local tl=Instance.new("TextLabel")
		tl.Size=UDim2.new(1,-12,0,20)
		tl.Position=UDim2.new(0,6,0,5)
		tl.BackgroundTransparency=1
		tl.Text=title
		tl.TextColor3=Color3.new(1,1,1)
		tl.Font=Enum.Font.GothamBold
		tl.TextSize=14
		tl.TextXAlignment=Enum.TextXAlignment.Left
		tl.ZIndex=11
		Module:UpdateTextSize(tl)
		tl.Name="Title"
		tl.Parent=notification
		local dl=Instance.new("TextLabel")
		dl.Size=UDim2.new(1,-12,0,18)
		dl.Position=UDim2.new(0,6,0,26)
		dl.BackgroundTransparency=1
		dl.Text=description
		dl.TextColor3=Color3.fromRGB(200,200,200)
		dl.Font=Enum.Font.FredokaOne
		dl.TextXAlignment=Enum.TextXAlignment.Left
		dl.ZIndex=11
		Module:UpdateTextSize(dl)
		dl.Name="Description"
		dl.Parent=notification
		local barContainer=Instance.new("Frame")
		barContainer.Size=UDim2.new(1,-12,0,4)
		barContainer.Position=UDim2.new(0,6,1,-10)
		barContainer.BackgroundTransparency=1
		barContainer.ClipsDescendants=true
		barContainer.ZIndex=11
		barContainer.Parent=notification
		local bar=Instance.new("Frame")
		bar.Size=UDim2.new(0,0,1,0)
		bar.Position=UDim2.new(0,0,0,0)
		bar.BackgroundColor3=barColor
		bar.BorderSizePixel=0
		bar.ZIndex=11
		bar.Parent=barContainer
		local nuic2=Instance.new("UICorner")
		nuic2.CornerRadius=UDim.new(1,8)
		nuic2.Parent=bar
		table.insert(Notifications,notification)
		TweenService:Create(notification,TweenInfo.new(0.3,Enum.EasingStyle.Sine,Enum.EasingDirection.Out),{Position=UDim2.new(1,-20,1,-offsetY),}):Play()
		TweenService:Create(bar,TweenInfo.new(duration,Enum.EasingStyle.Linear),{Size=UDim2.new(1,0,1,0)}):Play()
		task.delay(duration,function()
			TweenService:Create(notification,TweenInfo.new(0.3,Enum.EasingStyle.Sine,Enum.EasingDirection.In),{Position=notification.Position+UDim2.new(0,width+20,0,0),}):Play()
			task.wait(0.3)
			notification:Destroy()
			local notificationIndex=table.find(Notifications,notification)
			if notificationIndex then
				table.remove(Notifications,notificationIndex)
			end
			task.wait(0.2)
			for i,v in ipairs(Notifications) do
				local newY=-(20+((i-1)*(height+spacing)))
				TweenService:Create(v,TweenInfo.new(0.2),{Position=UDim2.new(1,-20,1,newY)}):Play()
			end
		end)
	end
	
	function Library:GrabUI(frame)
		return Module:GrabUI(frame)
	end
end

Library.Loaded=true
Library.Gui=Gui

return Library
