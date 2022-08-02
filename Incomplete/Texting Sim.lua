getgenv().settings = {
    enable = false,
    upgrade = true,
    text = true,
    removetextpopup = true
}

local count = 1; -- Dont change
while settings.enable do
    wait(0.1)
    if settings.upgrade then
        count = count + 1
        game:GetService("ReplicatedStorage").Events.GetItem:FireServer("Buy","Phone",count)
        game:GetService("ReplicatedStorage").Events.GetItem:FireServer("Buy","Emoji",count)
        if count == 75 then
            count = 1
            print("Count Reset")
        end
    end
    
    
    if settings.text then
        game:GetService("ReplicatedStorage").Events.SendTexts:FireServer("Phone")
    end
    
    if settings.removetextpopup then
        game.Players.LocalPlayer.PlayerGui.ScreenGui.ChildAdded:Connect(function(v)
            v:Destroy()
        end)
    else
        game.Players.LocalPlayer.PlayerGui.ScreenGui.ChildAdded:Disconnect()
    end
    
    if not settings.enable then
        break
    end
end
    
    