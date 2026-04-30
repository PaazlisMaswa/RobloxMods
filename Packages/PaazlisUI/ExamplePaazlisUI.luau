local UI=loadstring(game:HttpGet('https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/PaazlisUI/init.luau'))()

local Window=UI:CreateWindow({
	Title='Panel',
})

local Button=Window:AddContext({Type='Button',Name='Button'})

task.delay(10,function()
    Button.BackgroundColor3=Color3.fromRGB(255,89,89)
    Button.Template.Visible=false
    warn("Button.Template.Visible=",Button.Template.Visible)
end

UI:Notify("Panel","Panel Loaded",10)
