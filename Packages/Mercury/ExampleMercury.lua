-- loadstring(game:HttpGet('https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/Mercury/ExampleMercury.lua'))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/PaazlisMaswa/RobloxProject/refs/heads/main/Packages/Mercury/init.luau"))()

local gui = Library:create({
    Theme = Library.Themes.Serika
})

local Tab = Window:tab({
    Icon = "rbxassetid://6034996695",
    Name = "Aimbot"
}

Tab:button({
    Name = "show prompt",
    Callback = function()
        tab:prompt{
            Title = "baby",
            Text = "nice to meet you",
            Buttons = {
                Ok = function()
                    tab:prompt{
                        Followup = true,
                        Title = "really?",
                        Text = "you sure?=",
                        Buttons = {
                            Yes = function()
                                tab:Prompt{
                                    Followup = true,
                                    Title = "lol",
                                    Text = "Welcome",
                                    Buttons = {
                                        Learn = function()
                                            gui:set_status("money")
                                        end,
                                        Lazy = function()
                                            gui:set_Status("homeless")
                                        end
                                    }
                                }
                            end,
                        }
                    }
                end,
            }
        }
    end
})

Tab:keybind({Callback = function()
    gui:prompt()
end})

Tab:Dropdown({
    Name = "Dropdown",
    Description = "Dropdown Description",
    StartingText = "Bodypart",
    Items = {
        "Head",
        "Torso",
        "Random"
    }
})

Tab:slider({
    Name = "Slider",
    Description = "Slider Description",
    StartingText = "Aimbot Speed",
    Callback = function(v)
       gui:set_status(v)
    end
})

Tab:Textbox({Callback = function(v)
    gui:Prompt{Text = v}
end,})

Tab:color_picker({
    Name = "Color Picker",
    Style = Library.ColorPickerStyles.Legacy,
    Description = "Click to adjust color...",
    Callback = function(color)
        print(color)
    end,
})

Tab:Toggle({})
