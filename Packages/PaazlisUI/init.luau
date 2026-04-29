-- Create by @Paazlis
-- Version: 1.1

if type(_G.PaazlisUI)=="table" then return _G.PaazlisUI end

local function getService(name)
    local service=game:GetService(name)
    if cloneref then return cloneref(service) else return service end
end

local RunService=getService("RunService")

if not RunService:IsClient() then
	error("[PaazlisUI] only works on client")
	return
end

local Library={Loaded=false}
_G.PaazlisUI=Library

local Players,UserInputService,TweenService,StarterGui=getService("Players"),getService("UserInputService"),getService("TweenService"),getService("StarterGui")

local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
local OFFSET=UDim2.new(0,100,0,50) -- geser 100px kanan, 50px bawah

local baseX,baseY=1024,768 -- 1366,768

local function CreateCanvas(Gui)
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
	Dropdown.BackgroundColor3=Color3.fromRGB(0,138,207)
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

	local TextButton4=Instance.new("TextButton")
	TextButton4.Name="TextButton"
	TextButton4.AutoButtonColor=false
	TextButton4.BackgroundTransparency=1
	TextButton4.BorderSizePixel=0
	TextButton4.Position=UDim2.new(0.806,0,0,0)
	TextButton4.Size=UDim2.new(0.194,0,1,0)
	TextButton4.Font=Enum.Font.SourceSansBold
	TextButton4.TextColor3=Color3.fromRGB(248,248,248)
	TextButton4.TextTransparency=1
	TextButton4.Text=""
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

local IsStudio=RunService:IsStudio() or false

local PlayerGui=LocalPlayer:WaitForChild("PlayerGui")
local CoreGui=IsStudio and getService("CoreGui") or nil

local Gui=Instance.new("ScreenGui")
Gui.Name="PaazlisGui"
Gui.DisplayOrder=1000
Gui.ResetOnSpawn=false
Gui.AutoLocalize=false
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Global

if gethui then
	Gui.Parent=gethui()
elseif syn and syn.protect_gui then 
	syn.protect_gui(Rayfield)
	Gui.Parent=CoreGui
elseif not IsStudio then
    Gui.Parent=CoreGui:FindFirstChild("RobloxGui") or CoreGui
elseif IsStudio and script and script.Parent then
    Gui.Parent=PlayerGui
end

local function GrabUI(frame)
	task.spawn(function()
		local dragging,dragInput,dragStart,startPos
		local connection1=frame.InputBegan:Connect(function(input)
			if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
				dragging=true dragStart=input.Position startPos=frame.Position
				input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
			end
		end)
		local connection2=frame.InputChanged:Connect(function(input)
			if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then dragInput=input end
		end)
		local connection3=UserInputService.InputChanged:Connect(function(input)
			if input==dragInput and dragging then
				local delta=input.Position-dragStart
				frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
			end
		end)
        frame.Destroying:Connect(function()
            connection1:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
	end)
end

local NameTypes={
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
}

local TurnSysmbols={
	[true]="■",
	[false]="□"
}

local TurnColors={
	[true]=Color3.fromRGB(0,200,97),
	[false]=Color3.fromRGB(255,89,89)
}

local function ResizeUIScale(ui:Instance,screenSize:Vector2)
	local scaleX=screenSize.X / baseX
	local scaleY=screenSize.Y / baseY
	local scale=math.min(scaleX, scaleY)
	
	local minAxis=math.min(screenSize.X, screenSize.Y)
	local isSmallScreen=minAxis <= 500
	
	local uiScale=ui:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
	uiScale.Parent=ui
	
	local result=1
	
	if scale<1 then
		result=scale*1.5
	elseif scale>1 then
		result=scale*1
	else
		result=1
	end
	
	uiScale.Scale=result
end

ResizeUIScale(Gui,workspace.CurrentCamera.ViewportSize)
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	ResizeUIScale(Gui,workspace.CurrentCamera.ViewportSize)
end)

local LastFrm=nil

local function CreateWindow(WindowSettings)
	local Contexts={}
	
	local Window=CreateCanvas(Gui)
	Window.Order=0
	Window.Parent=true

    if WindowSettings then
       Window.Title.Text=WindowSettings.Title or Window.Title.Text
    end
     
	local Frm=Window.Frame
	if LastFrm and LastFrm.Position==Frm.Position then
		LastFrm.Position=Frm.Position+OFFSET
	end
    
	LastFrm=Frm

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
	function Window:AddContext(context)
		context=type(context)=="table" and context or {}

		local typeName,name,callback=context.Type,context.Name,context.Callback
		local template=nil
		local cache={}
	
		if type(callback)~="function" then
			callback=function(...)
				warn("No callback:",...)
			end
		end

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
		
		if not template then return context end
		
		template.Name=NameTypes[typeName] and typeName or "Unknown"
		
		if not NameTypes[typeName] then
			if template then
				template:Destroy()
			end
			return context
		end
		

		local textLabel:TextLabel=template:FindFirstChild("TextLabel")
		local textButton:TextButton=template:FindFirstChild("TextButton") :: TextButton
		local textBox:TextBox=template:FindFirstChild("TextBox")
		local emptyFrame:Frame=template:FindFirstChild("Frame") :: Frame
		
		local setCallback,mainThemes,mainKey,mainValue,mainActive
		
		mainThemes={}
		
		local function SafeCallback(...)
			if callback then
				pcall(callback,...)
			end
		end
		
		if typeName=="TextLabel" then
			setCallback=function(value)
				if mainValue~=value then
					mainValue=value
					textLabel.Text=value
					SafeCallback(value)
				end
			end
			textButton:Destroy() textButton=nil
			textBox:Destroy() textBox=nil
			textLabel.Text=context.Name or context.Text or "Text Here"
			mainValue=textLabel.Text
		elseif typeName=="TextButton" then
			textBox:Destroy() textBox=nil
			textLabel:Destroy() textLabel=nil
			textButton.Text=context.Name or context.Text or "Text Here"
			cache.ButtonActivated=textButton.Activated:Connect(function()
				SafeCallback()
			end)
		elseif typeName=="TextBox" then
			textButton:Destroy() textButton=nil
			textLabel:Destroy() textLabel=nil
			textBox.PlaceholderText=context.PlaceholderText or "Text here"
			textBox.Text=""
			mainValue=textBox.Text
			cache.TextFocustLost=textBox.FocusLost:Connect(function(submit)
				if not submit then return end
				mainValue=textBox.Text
				SafeCallback(mainValue)
			end)
			cache.TextChanged=textBox:GetPropertyChangedSignal("Text"):Connect(function()
				if context.Changed then
					pcall(context.Changed,textBox.Text)
				end
			end)
		elseif typeName=="Toggle" then
			setCallback=function(value)
				if mainValue~=value then
					mainValue=value
					textButton.Text=TurnSysmbols[value]
					SafeCallback(value)
				end
			end
			
			mainValue=type(context.Value)=="boolean" and context.Value or false
			textButton.Text=TurnSysmbols[mainValue]
			textLabel.Text=context.Name or context.Text or "Text Here"
			
			cache.ButtonActivated=textButton.Activated:Connect(function()
				setCallback(not mainValue)
			end)
		elseif typeName=="Selector" then
			setCallback=function(value,index)
				if mainValue~=value then
					mainValue=value
					textLabel.Text=value
					if index then mainKey=index end
					SafeCallback(value,index)
				end
			end
			
			if type(context.Options)~="table" then
				context.Options={"Option 1","Option 2"}
			end
			
			mainKey=0
			local noCap,maxIndex=context.NoCap,0
			for i,v in ipairs(context.Options) do maxIndex+=1 end

			mainValue=type(context.Value)=="string" and context.Value or context.Options[1]
			textLabel.Text=tostring(mainValue)
			
			local selectorTweenInfo=TweenInfo.new(1,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out)
			local selectorPropertys1,selectorPropertys2={["Size"]=UDim2.new(0.8,0,0.8,0)},{["Size"]=UDim2.new(1,0,1,0)}
			
			local previousButton=template:FindFirstChild("Previous") :: TextButton
			
			cache.PreviousActivated=previousButton.Activated:Connect(function()
				if noCap then
					if mainKey<=0 then mainKey=1 end
					mainKey=mainKey<=1 and maxIndex or mainKey-1
				else
					mainKey=mainKey<=0 and 1 or mainKey-1
					if mainKey<=0 then mainKey=1 end
				end
				setCallback(tostring(context.Options[mainKey]),mainKey)
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
				if mainKey<=0 then mainKey=1 end
				
				if mainKey>=maxIndex then
					mainKey=noCap and 1 or maxIndex
				else
					mainKey+=1
				end
				
				setCallback(tostring(context.Options[mainKey]),mainKey)
			end)

			local nextLabel=nextButton:FindFirstChild("TextLabel")

			cache.NextMouseEnter=nextButton.MouseEnter:Connect(function()
				TweenService:Create(nextLabel,selectorTweenInfo,selectorPropertys1):Play()
			end)
			
			cache.NextMouseLeave=nextButton.MouseLeave:Connect(function()
				TweenService:Create(nextLabel,selectorTweenInfo,selectorPropertys2):Play()
			end)
		elseif typeName=="Select" then
			setCallback=function(value)
				if mainValue~=value then
					mainValue=value
					if type(value)=="table" then
						emptyFrame.BackgroundColor3=value.Color or Color3.fromRGB(200,200,200)
					elseif typeof(value)=="Instance" and value:IsA("BasePart") then
						emptyFrame.BackgroundColor3=value.Color
					end
					SafeCallback(value)
				end
			end
			
			mainValue=context.Value or nil
			mainActive=type(context.Pressed)=="boolean" and context.Pressed or false
			textButton.BackgroundColor3=TurnColors[not mainActive]

			cache.ButtonActivated=textButton.Activated:Connect(function()
				if cache.SelectMouseClick then cache.SelectMouseClick:Disconnect() cache.SelectMouseClick=nil end
				mainActive=not mainActive
				textButton.BackgroundColor3=TurnColors[not mainActive]
				if mainActive then
					cache.SelectMouseClick=Mouse.Button1Down:Connect(function()
						local target=Mouse.Target
						if not (target and target.Parent) then return end
						setCallback(target)
					end)
				end
			end)
		elseif typeName=="Dropdown" then
			mainActive=false
			
			cache.ButtonActivated=textButton.Activated:Connect(function()
				mainActive=not mainActive
				textButton.Text=mainActive and "v" or "–"
			end)
		else
			template:Destroy()
			template=nil
			textLabel=nil
			textButton=nil
			textBox=nil
			emptyFrame=nil
		end

		if template then
			template.LayoutOrder=self.Order
			uiListLayout:ApplyLayout()
			template.Parent=container
			self.Order=#container:GetChildren()-2
			context.Template=template
			context.Parent=true
		end
		
		context.Pressed=nil
		context.PlaceholderText=nil
		context.Text=nil
		context.Name=nil
		context.Value=nil
		
		local funcs={}
		funcs.Destroy=function(this)
			context.Parent=nil
			local k,v=next(cache)
			while v do
				cache[k]=nil
				v:Disconnect()
				k,v=next(cache)
			end
			cache={}
			template:Destroy()
			table.clear(this)
			funcs={}
			context={}
		end
		funcs.Set=function(this,value)
			local valueType=type(value)
			if typeName=="TextLabel" and valueType=="string" then
				setCallback(value)
			elseif typeName=="TextBox" and valueType=="string" then
				textBox.PlaceholderText=value
			elseif typeName=="TextButton" and valueType=="string" then
				textButton.Text=value
			elseif typeName=="Toggle" and valueType=="boolean" then
				setCallback(value)
			elseif typeName=="Selector" and valueType=="string" then
				if mainValue~=value then
					mainValue=value
					textLabel.Text=value
					local index=table.find(context.Options,value)
					if index then mainKey=index end
					SafeCallback(mainValue,index)
				end
			elseif typeName=="Select" then
				setCallback(value)
			end
		end
		
		local newMetaTable=setmetatable(context,{
			__index=function(this,key)
				local resolve=funcs[key]
				if resolve then
					return function(_,...)
						return resolve(this,...)
					end
				elseif key=="Value" then
					return mainValue
				elseif key=="Pressed" then
					return mainActive
				elseif key=="Key" then
					return mainKey
				elseif key=="Themes" then
					return mainThemes
				else
					if typeName=="TextLabel" then
						return textLabel[key]
					elseif typeName=="TextBox" then
						return textBox[key]
					elseif typeName=="TextButton" or typeName=="Select" then
						return textButton[key]
					end
				end
				
				return nil
			end,
			__newindex=function(this,key,value)
				if key=="Value" then
					funcs.Set(this,value)
				elseif key=="Themes" and type(value)=="table" then
					mainThemes=value
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
		
		table.insert(Contexts,newMetaTable)
		return newMetaTable
	end

	function Window:SetTitle(text)
		self.Title.Text=text
	end
	
	-- Destroy a window
	function Window:Destroy()
		self.Parent=nil
		for k,v in ipairs(Contexts) do
			v:Destroy()
		end
		self.Frame:Destroy()
		table.clear(self)
	end
	
	local frame=Window.Frame
	GrabUI(Window.Frame)
	Window:Hide()
	Window:ApplyWindowHeight()
	Window.Open.Activated:Connect(function()
		Window:SetVisible(not Window:IsVisible())
	end)
	
	return Window
end

do
	function Library:CreateWindow()
		return CreateWindow()
	end
	
	function Library:Notify(Data)
        local title,description,duration=Data.Title or Data.Name or 'Title',Data.Description or "Description",Data.Duration or 5
        duration=type(duration)=="number" and duration or 5
        StarterGui:SetCore("SendNotification",{
			Title=title,
			Text=description,
			Duration=duration
		})
	end

	function Library:GrabUI(frame)
		GrabUI(frame)
	end
end

Library.Loaded=true
Library.Gui=Gui

return Library
