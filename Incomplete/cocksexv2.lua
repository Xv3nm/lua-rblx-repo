-- cocksex

local Highlight = loadstring(game:HttpGet("https://raw.githubusercontent.com/ovicular/Highlight/main/Main.lua"))()
targetee = nil
pleaseshoot = false
mouse = game.Players.LocalPlayer:GetMouse()

local TargetGUI = Instance.new("ScreenGui")
local Target = Instance.new("TextBox")
local Background = Instance.new("ImageLabel")

TargetGUI.Name = "TargetGUI"
TargetGUI.Parent = game.CoreGui

Target.Name = "Target"
Target.Parent = TargetGUI
Target.BackgroundColor3 = Color3.new(0, 0, 50)
Target.BackgroundTransparency = 0.30000001192093
Target.ClipsDescendants = true
Target.Position = UDim2.new(.36, 0, .85, 0)
Target.Size = UDim2.new(.3, .5, .03, 21)
Target.Font = Enum.Font.SourceSans
Target.PlaceholderText = "[CS]: (Made by Poleszx) Best aimbot anyone that uses is godly"
Target.Text = ""
Target.TextColor3 = Color3.new(90, 70, 50)
Target.TextSize = 15
Target.TextWrapped = true
Target.Draggable = true

local highlightTable = {}

local debounce = false
function fireat(target)
    if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
        if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Shoot then
            u = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Shoot
            if target.Character then
                u:FireServer(targetee.Character.Torso.CFrame)
            end
        end
    end
end

Target.FocusLost:Connect(
    function()
        local name = string.lower(Target.Text)
        local player = nil

        names = game.Players:GetChildren()

        for i, x in pairs(names) do
            strlower = string.lower(x.Name)
            sub = string.sub(strlower, 1, #name)

            if name == sub then
                player = x
                if player.Name ~= game.Players.LocalPlayer.Name then
                    targetee = player
                end
            end
        end
    end
)

function ShootGlocks(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.E and gameProcessedEvent == false then
        fireat(targetee)
    end
end
function UnShootGlocks(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.E and gameProcessedEvent == false then
        pleaseshoot = false
    end
end
function CtrlSelect(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.F and gameProcessedEvent == false then
        Selecting = true
    end
end
function UnCtrlSelect(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.F and gameProcessedEvent == false then
        Selecting = false
    end
end

handleHighlighting = {}

function handleHighlighting:Check(char, name)
    
end

game:GetService("UserInputService").InputBegan:connect(ShootGlocks)
game:GetService("UserInputService").InputEnded:connect(UnShootGlocks)
game:GetService("UserInputService").InputBegan:connect(CtrlSelect)
game:GetService("UserInputService").InputEnded:connect(UnCtrlSelect)

game:GetService("RunService").Stepped:connect(
    function()
        if Selecting == true then
            if mouse.Target then
                if mouse.Target.Parent:IsA("Model") and game.Players:FindFirstChild(mouse.Target.Parent.Name) then
                    Target.Text = mouse.Target.Parent.Name
                    targetee = game.Players:FindFirstChild(mouse.Target.Parent.Name)
                    getgenv().curTarget = mouse.Target.Parent.Name
                    
                    local name = mouse.Target.Parent.Name
                    local char = mouse.Target.Parent
                    
                    highlightTable[name] = Highlight.create(char,{
                    	FillColor = Color3.fromRGB(255,0,0),
                    	OutlineColor = Color3.fromRGB(80,80,80),
                    })
                    coroutine.wrap(function()
                        getgenv().prevTarget = name
                        while wait() do
                            if getgenv().curTarget ~= getgenv().prevTarget then
                                highlightTable[getgenv().prevTarget]:Destroy()
                                break
                            end
                        end
                    end)()
                end
            end
        end
    end
)

-- simple reset with a button script (made by Tracy)

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
Mouse.KeyDown:Connect(
    function(key)
        if key == "g" then
            game.Players.LocalPlayer.Character.Torso:Destroy()
            local plr = game.Players.LocalPlayer
            local humanoid = plr.Character.Humanoid
            local position = plr.Character.HumanoidRootPart.CFrame
        end
    end
)
