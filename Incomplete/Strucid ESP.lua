if not fresh then

getgenv().esp_options = { -- Easy customization for my boy Throit
    enabled = true, -- Im sexy and I know it
    
    teamesp = false, -- Enable esp for your team?
    teamcolors = false, -- Use team colors as esp colors, if false then use colors below.
    
    enemycolor = Color3.fromRGB(255,0,0), -- Enemy esp color
    allycolor = Color3.fromRGB(0,0,255), -- Ally esp color

    autothicc = true, -- True by default; Thickness based off of distance; autothicc is on line 48
    thickness = 1, -- Box thickness; autothicc must be false
    transparency = 1, -- Box transparency
}

local lplr = game:GetService("Players").LocalPlayer
local cam = game:GetService("Workspace").CurrentCamera
local function draw(plr)
    local Box = Drawing.new("Quad")
    Box.Visible = false
    Box.PointA = Vector2.new(0, 0); Box.PointB = Vector2.new(0, 0); Box.PointC = Vector2.new(0, 0);Box.PointD = Vector2.new(0, 0)
    if not esp_options.autothicc then Box.Thickness = esp_options.thickness end
    Box.Transparency = esp_options.transparency
    
    local function Update()
        local steplol = game:GetService("RunService").RenderStepped:Connect(function()
            if not esp_options.enabled then Box:Remove(); steplol:Disconnect() return false end
            
            if plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid") ~= nil and plr.Character.PrimaryPart ~= nil and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                if not teamesp then if plr.Team == lplr.Team then return end end
                
                if not esp_options.teamcolors then
                    Box.Color = esp_options.enemycolor
                else
                    if plr.Team == nil then -- Check if in FFA
                        Box.Color = esp_options.enemycolor
                        --print('Current gamemode is FFA all players are enemies')
                    else
                        Box.Color = plr.TeamColor.Color
                    end
                end
                
                if esp_options.autothicc then
                    local dist = lplr:DistanceFromCharacter(plr.Character.HumanoidRootPart.Position) / 100
                    if dist < 1 then
                        dist = 1
                    elseif dist > 2 then
                        dist = 2
                    end
                    Box.Thickness = dist
                end
                
                local pos, vis = cam:WorldToViewportPoint(plr.Character.PrimaryPart.Position)
                if vis then 
                    local points = {}
                    local steplol = 0
                    for _,v in pairs(plr.Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            steplol = steplol + 1
                            local p, vis = cam:WorldToViewportPoint(v.Position)
                            if v == plr.Character.PrimaryPart then
                                p, vis = cam:WorldToViewportPoint((v.CFrame * CFrame.new(0, 0, -v.Size.Z)).p)
                            elseif v.Name == "Head" then
                                p, vis = cam:WorldToViewportPoint((v.CFrame * CFrame.new(0, v.Size.Y/2, v.Size.Z/1.25)).p)
                            elseif string.match(v.Name, "Left") then
                                p, vis = cam:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2, 0, 0)).p)
                            elseif string.match(v.Name, "Right") then
                                p, vis = cam:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2, 0, 0)).p)
                            end
                            points[steplol] = {p, vis}
                        end
                    end

                    local TopY = math.huge
                    local DownY = -math.huge
                    local LeftX = math.huge
                    local RightX = -math.huge

                    local Left
                    local Right
                    local Top
                    local Bottom

                    local closest = nil
                    for _,v in pairs(points) do
                        if v[2] == true then
                            local p = v[1]
                            if p.Y < TopY then
                                Top = p
                                TopY = p.Y
                            end
                            if p.Y > DownY then
                                Bottom = p
                                DownY = p.Y
                            end
                            if p.X > RightX then
                                Right = p
                                RightX = p.X
                            end
                            if p.X < LeftX then
                                Left = p
                                LeftX = p.X
                            end
                        end
                    end

                    if Left ~= nil and Right ~= nil and Top ~= nil and Bottom ~= nil then
                        Box.PointA = Vector2.new(Right.X, Top.Y)
                        Box.PointB = Vector2.new(Left.X, Top.Y)
                        Box.PointC = Vector2.new(Left.X, Bottom.Y)
                        Box.PointD = Vector2.new(Right.X, Bottom.Y)

                        Box.Visible = true
                    else 
                        Box.Visible = false
                    end
                else 
                    Box.Visible = false
                end
            else
                Box.Visible = false
                if game.Players:FindFirstChild(plr.Name) == nil then
                    steplol:Disconnect()
                elseif not esp_options.enabled then
                    steplol:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end

for _,v in pairs(game:GetService("Players"):GetChildren()) do
    if v.Name ~= lplr.Name then 
        if esp_options.enabled then
            draw(v)
        else
            return false
        end
    end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
    draw(v)
end)