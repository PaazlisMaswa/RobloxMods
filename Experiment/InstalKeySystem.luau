-- loadstring(game:HttpGet('https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Experiment/InstalKeySystem.luau'))()

local RunService=game:GetService("RunService")
local UILibrary=if RunService:IsStudio() then require(game.ReplicatedStorage.Packages.PaazlisUI) else loadstring(game:HttpGet('https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/PaazlisUI/init.luau'))()

--! Author: oyb0i
-- KeySystem UI
--[[
	Remove this from 10 line to 17 line, 
	If you just want to create it directly from the window, then use this:
	
local Window=UILibrary:CreateWindow({
	Title="Panel",
	KeySystem=--Same as this
})
]]

local KeySystemUI=UILibrary:CreateKeySystem({
	Title          ="Panel", -- The main title shown at the top of the GUI
	Description    ="Key System", -- The text shown below the title
	UseNonce       =true, -- To prevent replay attacks and request tampering, default: false
	FileName       ="Mykey.txt", -- The name of the file where the valid key will be saved for auto-login

	-- [1] PlatoBoost Settings
	ServiceId      =24751, -- Your PlatoBoost Service ID
	PlatoSecret    ="4ce8695c-5918-4704-a778-786e74424a0e", -- Your PlatoBoost Secret Key

	-- [2] Anti-Bypass / Global Secret Variable
	Secret         ="1234", -- This makes the script ONLY run from the key script. Even if they copy the original obfuscated script to bypass the key,they won't be able to!

	-- [3] Scripts & Links
	NoScriptURL    =false, -- If you don't want to use the script URL, you can set this to true to want to disable the script from running on the client.
	ScriptURL      ="https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Mods/InstalPanel.luau", -- The raw URL of your main script

	-- [4] Social Media Settings (Set to true to show,false to hide)
	ShowDiscord    =false,
	DiscordURL     ="https://discord.gg/kT55J724BK",

	ShowInstagram  =false,
	InstagramURL   ="https://www.instagram.com/oyb0i/",

	ShowYoutube    =false,
	YoutubeURL     ="https://www.youtube.com/channel/UCAlXXV1Hbvf7WbfXARuVtiQ",

	-- [5] GUI Management
	OldGuiName     ="KeyUI-Old", -- Name of the old GUI to destroy if it's already open
	GuiName        ="KeyUI", -- Name of the main script's GUI to check if it's already executing
})
