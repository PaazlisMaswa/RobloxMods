local Private={
	["Shirt"]="144076358",
	["Pants"]="144076760",
	["TShirt"]=""
}

Private.UseStudio=game:GetService("RunService"):IsStudio()
local Instancer=nil
if Private.UseStudio then Instancer=require(game.ReplicatedStorage.Mods.InstancerLow) else Instancer=loadstring(game:HttpGet("https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/Instancer/init.luau"))() end
local Strs=nil
if Private.UseStudio then Strs=require(game.ReplicatedStorage.Mods.StrsLow) else Strs=loadstring(game:HttpGet("https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/Strs/init.luau"))() end
local Utility=nil
if Private.UseStudio then Utility=require(game.ReplicatedStorage.Mods.UtilityLow) else Utility=loadstring(game:HttpGet("https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/Utility/init.luau"))() end
local Rayfield=nil
if Private.UseStudio then Rayfield=require(game.ReplicatedStorage.Packages.Rayfield.main) else Rayfield=loadstring(game:HttpGet("http://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/Rayfield/init.luau"))() end

local function ApplyClothing(model,className,id)
	local success, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. tostring(id))
	end)
	if success and type(objects)=="table" and #objects>0 then
		local old,instance=nil,objects[1]
		if instance and instance:IsA(className) then
			old=model:FindFirstChildOfClass(className)
		end
		if old then
			old:Destroy()
			instance.Parent=model
			return instance
		end
	end
end

local Players=game:GetService("Players")
local LocalPlayer=Players.LocalPlayer

local Window=Rayfield:CreateWindow({Name="Maswa",LoadingTitle="Maswa",LoadingSubtitle="Interface Suite"})
local Tab=Window:CreateTab("Avatar")

local ShirtInput=Tab:CreateInput({
	Name="Shirt Id",
	CurrentValue=Private.Shirt,
	Callback=function(Id) 
		if not tonumber(Id) then return end
		warn("Avatar Mods | Shirt:",Id)
		local source=ApplyClothing(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(),"Shirt",Id)
		if source then
			Private.Shirt=Id
		end
	end
})

local PantsInput=Tab:CreateInput({
	Name="Pants Id",
	CurrentValue=Private.Pants,
	Callback=function(Id) 
		if not tonumber(Id) then return end
		warn("Avatar Mods | Pants:",Id)
		local source=ApplyClothing(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(),"Pants",Id)
		if source then
			Private.Pants=Id
		end
	end
})
