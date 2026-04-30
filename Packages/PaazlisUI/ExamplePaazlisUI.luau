local SeverHopEnd=false

local UI=loadstring(game:HttpGet('https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/PaazlisUI/init.luau'))()

local Window=UI:CreateWindow({
	Title='Panel',
})

local Dropdown=Window:AddContext({Type='Dropdown',Name='Local',Active=false})

local Button=Window:AddContext({Type='Button',Name='Server Hop',Callback=function()
     if not SeverHopEnd then
        SeverHopEnd=true
     end
end})

Button.Template.Visible=false
Button.Parent=Dropdown

UI:Notify({Title='Panel',Description='Panel Loaded',Duration=10})
