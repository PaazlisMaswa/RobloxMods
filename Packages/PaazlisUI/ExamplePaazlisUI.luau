local UI=loadstring(game:HttpGet('https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/PaazlisUI/init.luau'))()

local Window=UI:CreateWindow({
	Title='Panel',
})

local TextLabel=Window:CreateWindow({
	Title='Panel',
})

local Button=Window:AddContext({Type='TextButton',Name='Button',Callback=function() end})

task.delay(10,function()
    Button.BackgroundColor3=Color3FromRGB(255,89,89)
    Button.Template.Visible=false
    warn("Button.Template.Visible=",Button.Template.Visible)
end
