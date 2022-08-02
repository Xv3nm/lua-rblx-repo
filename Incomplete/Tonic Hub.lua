local Library = loadstring(game:HttpGet("https://pastebin.com/raw/EuTU2Xe3"))()


--        Tabs
local VisualsTab = Library:CreateTab("Visuals")
local AimbotTab = Library:CreateTab("Aimbot")
local SettingsTab = Library:CreateTab("Settings")
_G.Destroyed = false





--        Sections
-- VisualsTab
local MainVisuals = VisualsTab:CreateSection("Main")
local ConfigVisuals = VisualsTab:CreateSection("Config")

-- AimbotTab
local MainAimbot = AimbotTab:CreateSection("Main")
local ConfigAimbot = AimbotTab:CreateSection("Config")

-- SettingsTab
local MainSettings = SettingsTab:CreateSection("Settings")
local CreditsSettings = SettingsTab:CreateSection("Credits")


-- Variables
local BoxESP = false
local HeadESP = false
local fillBox = false
local tracerESP = false
local BoxColor = Color3.new(1,1,1)
local FillColor = Color3.new(0,1,0)
local InvisibleColor = Color3.new(1,0,0)
local VisibleColor = Color3.new(0,1,0)


_G.Aim_Enabled = false -- True
_G.Aim_TeamCheck = false -- False
_G.Aim_AliveCheck = true -- True
_G.Aim_WallCheck = false -- Laggy
_G.Aim_Sensitivity = 0  -- 0
_G.Aim_TriggerKey = "MouseButton2" -- MouseButton2
_G.Aim_Toggle = false -- False
_G.Aim_LockPart = "Head" -- Head


_G.FOV_Enabled = false -- True
_G.FOV_Visible = true -- True
_G.FOV_Size = 100 -- 100
_G.FOV_Color = "255, 255, 255" -- 255,255,255
_G.FOV_LockedColor = "255, 70, 70" -- 255,70,70
_G.FOV_Transparency = 0.5 -- 0.5
_G.FOV_Sides = 60 -- 60
_G.FOV_Thickness = 1 -- 1






--        Buttons etc.
--VisualsTab
MainVisuals:CreateToggle("Box ESP", function(boolean)
    print("Box ESP:", boolean)
    BoxESP = boolean
end)

MainVisuals:CreateToggle("Head ESP", function(boolean)
    print("Head ESP:", boolean)
    HeadESP = boolean
end)

MainVisuals:CreateToggle("Tracer ESP", function(boolean)
    print("Tracer ESP:", boolean)
    tracerESP = boolean
end)

MainVisuals:CreateToggle("Fill Box", function(boolean)
    print("Fill Box:", boolean)
    fillBox = boolean
end)



ConfigVisuals:CreateColorPicker("Box Color", Color3.new(1, 1, 1), function(color)
   print("Box Color:", color)
   BoxColor = color
end)

ConfigVisuals:CreateColorPicker("Fill Color", Color3.new(0, 1, 0), function(color)
   print("Fill Color:", color)
   FillColor = color
end)

ConfigVisuals:CreateColorPicker("Invisible Head Color", Color3.new(1, 0, 0), function(color)
   print("Invis Head Color:", color)
   InvisibleColor = color
end)

ConfigVisuals:CreateColorPicker("Visible Head Color", Color3.new(0, 1, 0), function(color)
   print("Visible Head Color:", color)
   VisibleColor = color
end)

ConfigVisuals:CreateLabel("HeadEspLabel","\nBy default Head ESP is red when\nplayer is behind a wall and green \nwhen a player is visible.")
ConfigVisuals:CreateLabel("Blank","\n")







-- AimbotTab
MainAimbot:CreateToggle("Aimbot", function(boolean)
   print("Aimbot:", boolean)
   _G.Aim_Enabled = boolean
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)

MainAimbot:CreateToggle("FOV Circle", function(boolean)
   print("FOVCircle:", boolean)
   _G.FOV_Enabled = boolean
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)

MainAimbot:CreateToggle("Team Check", function(boolean)
   print("TeamCheck:", boolean)
   _G.Aim_TeamCheck = boolean
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)

MainAimbot:CreateToggle("Alive Check", function(boolean)
   print("AliveCheck:", boolean)
   _G.Aim_AliveCheck = boolean
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)

MainAimbot:CreateToggle("Wall Check (Laggyish)", function(boolean)
   print("WallCheck:", boolean)
   _G.Aim_WallCheck = boolean
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)

MainAimbot:CreateSlider("Sensitivity (Seconds)", 0, 2, 0, true, function(value)
   print("Sensitivity: " .. value)
   _G.Aim_Sensitivity = value
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)




ConfigAimbot:CreateDropdown("Aimbot Mode", {"Hold", "Press"}, 1, function(option)
    print("Type: " .. option)
    if option == "Hold" then
	    _G.Aim_Toggle = false
	   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
    elseif option == "Press" then
 	    _G.Aim_Toggle = true
	   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
    end
end)

ConfigAimbot:CreateDropdown("Aim Part", {"Head", "HumanoidRootPart"}, 1, function(option)
   print("AimPart: " .. option)
   _G.Aim_LockPart = option
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)

ConfigAimbot:CreateDropdown("Aim Bind", {"MouseButton1", "MouseButton2"}, 2, function(option)
   print("Aim Bind: " .. option)
   _G.Aim_TriggerKey = option
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)

ConfigAimbot:CreateSlider("FOV Size", 0, 500, 100, false, function(value)
   print("FOVSize: " .. value)
   _G.FOV_Size = value
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)

ConfigAimbot:CreateSlider("FOV Transparency", 0, 1, 0.5, true, function(value)
   print("FOVTransparency: " .. value)
   _G.FOV_Transparency = value
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)

ConfigAimbot:CreateSlider("FOV Sides", 3, 250, 60, false, function(value)
   print("FOVSides: " .. value)
   _G.FOV_Sides = value
   loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()
end)









-- Settings Tab
MainSettings:CreateKeybind("Toggle Gui", Enum.KeyCode.RightControl, true, false, function()
   ToggleUI()
end)

MainSettings:CreateLabel("Blank","\n\n\n\n\n")

MainSettings:CreateButton("Destroy Gui", function()
	for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
		if v:FindFirstChild("Main") then
			if v.Main:FindFirstChild("UITabs") then
				v:Destroy()
				_G.Destroyed = true
				pcall(function()
					getgenv().Aimbot.Functions:Exit()
				end)
			end
		end
	end
end)

CreditsSettings:CreateLabel("Dev","\nDeveloper: Totem")

CreditsSettings:CreateButton("Discord (Click to Copy)", function()
	setclipboard("Totem#7908")
end)

CreditsSettings:CreateButton("Github (Click to Copy)", function()
	setclipboard("https://github.com/Xv3nm")
end)

CreditsSettings:CreateButton("My Website (Click to Copy)", function()
	setclipboard("https://sleepy-totem.ga")
end)























local VEC3 = Vector3.new
local VEC2 = Vector2.new
local COL3 = Color3.new
local RGB = Color3.fromRGB
local CFNEW = CFrame.new
local INSTNEW = Instance.new
local TBLINS = table.insert
local Drawing_new = Drawing.new
local Ray_new = Ray.new
local TweenInfo_new = TweenInfo.new

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = Workspace:FindFirstChildOfClass("Camera")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

_G.PlayerLocation = function()
	--[[
	-- GLOBAL ESP
	local Humanoids = {}
	for i,v in pairs(Workspace:GetDescendants()) do
		if v:IsA("Humanoid") or v.Name == "Humanoid" then
			TBLINS(Humanoids, v.Parent)
		end
	end
	return Humanoids;
	]]--
	return Players:GetChildren();
end

CreateDrawing = function(ClassName)
	return function(Props)
		local Create = Drawing_new(ClassName)
		for i,v in pairs(Props) do
			Create[i] = v
		end
		return Create
	end
end;
	
local Drawings = {}
function IsPartVisible(Part1, Part2)
    local CheckPart = INSTNEW("Part")
	CheckPart.Parent = Workspace
	CheckPart.Name = "CheckVisWall"
    CheckPart.Anchored = true
    CheckPart.CanCollide = false
    CheckPart.Transparency = 1
    CheckPart.Size = VEC3(1.5, 1.5, 1.5) * Part2.Size
    CheckPart.CFrame = Part2.CFrame
    
    local Ray = Ray_new(Part1.Position, (Part2.Position - Part1.Position).Unit * 9999)
    local part,position = workspace:FindPartOnRay(Ray, Part1.Parent)
	if part then
	    if part.Name == CheckPart.Name then
	        CheckPart:Destroy()
	        return true
	    end
	end
	CheckPart:Destroy()
	return false
end

function GetLookVectorAndOrigin(PART)
	local Origin = PART.CFrame
	local LookVector = PART.CFrame.lookVector * 100
	--local Direction = (LookVector - Origin.p).Unit * 100
	
	--local Ray = Ray.new(Origin.p, Direction)
	--local _, EndPosition = workspace:FindPartOnRay(Ray)
	
	return {
		Origin = Origin;
		EndPoint = LookVector;--Workspace:Raycast(Origin, Direction.p).Position;
	}
end
function Get8Corners(PART, OFF)
	if not OFF then OFF = VEC3(1, 1, 1) end
	local CornerVertices = {
		{1, 1, -1},  --v1 - top front right
		{1, -1, -1}, --v2 - bottom front right
		{-1, -1, -1},--v3 - bottom front left
		{-1, 1, -1}, --v4 - top front left
		
		{1, 1, 1},  --v5 - top back right
		{1, -1, 1}, --v6 - bottom back right
		{-1, -1, 1},--v7 - bottom back left
		{-1, 1, 1}  --v8 - top back left
	}
	local Vertices = {}
	local Size = PART.Size * OFF
	for _, Vector in pairs(CornerVertices) do
	    TBLINS(Vertices, (PART.CFrame * CFNEW(Size .X/2 * Vector[1], Size .Y/2 * Vector[2], Size .Z/2 * Vector[3])).Position)
	end
	return Vertices
end

function tocam(pos)
    local PosChar, withinScreenBounds = Camera:WorldToViewportPoint(pos)
    return {VEC2(PosChar.X, PosChar.Y), withinScreenBounds}
end
function GetPropPC(inst, prop)
	local func, result = pcall(function()
		return inst[prop]
	end)
	if not func then
		return nil 
	else 
		return result 
	end
end
function Cleanup()
	for i,v in pairs(Drawings) do
		v:Remove()
		--table.remove(Drawings, i)
	end
	Drawings = {}
end
function Create3DVertex(PART, SETT)
	local VertexPositions = Get8Corners(PART, SETT.Offset)
	for i,v in pairs(Get8Corners(PART, VEC3(0.01, 0.01, 0.01))) do
		if not tocam(v)[2] then return end
	end
	local Thickness = SETT.Thickness
	local Transparency = SETT.Transparency
	local Visible = SETT.Visible
	local Color = SETT.Color
	local Filled = SETT.Filled
	local Positions = {
		{
			tocam(VertexPositions[5])[1];
			tocam(VertexPositions[6])[1];
			tocam(VertexPositions[2])[1];
			tocam(VertexPositions[1])[1];
		};
		{
			tocam(VertexPositions[7])[1];
			tocam(VertexPositions[8])[1];
			tocam(VertexPositions[4])[1];
			tocam(VertexPositions[3])[1];
		};
		{
			tocam(VertexPositions[1])[1];
			tocam(VertexPositions[2])[1];
			tocam(VertexPositions[3])[1];
			tocam(VertexPositions[4])[1];
		};
		{
			tocam(VertexPositions[5])[1];
			tocam(VertexPositions[6])[1];
			tocam(VertexPositions[7])[1];
			tocam(VertexPositions[8])[1];
		};
	}
	
	for i = 1,#Positions do
		local NewVertex = CreateDrawing("Quad") {
			["Visible"] = Visible;
			["Transparency"] = Transparency;
			["Thickness"] = Thickness;
			["Color"] = Color;
			["Filled"] = Filled;
			["PointA"] = Positions[i][1];
			["PointB"] = Positions[i][2];
			["PointC"] = Positions[i][3];
			["PointD"] = Positions[i][4];
		}
		Drawings[#Drawings + 1] = NewVertex
	end
end


--[[ Initialize ESP ]]--
spawn(function()
	while _G.Destroyed == false do
		Cleanup()
		
		if _G.Destroyed then
			break
		end
		
		local func, ok = pcall(function()
			for i,v in pairs(_G.PlayerLocation()) do
				if v.Name ~= LocalPlayer.Name then
					local Char = GetPropPC(v, "Character") or v or nil
					local TeamCheck = (GetPropPC(v, "Team") ~= LocalPlayer.Team) or (GetPropPC(v, "TeamColor") ~= LocalPlayer.TeamColor) or (LocalPlayer.Team == nil)
					if Char and TeamCheck then
						local Root = Char:FindFirstChild("HumanoidRootPart") or nil
						local Head = Char:FindFirstChild("Head") or nil
						
						if Root and Head and tocam(Head.Position)[2] then
							--[[ Vertex ]]--
							Create3DVertex(Root, {
								["Offset"] = VEC3(1.5, 3, 2);
								["Thickness"] = 1;
								["Transparency"] = 1;
								["Filled"] = false;
								["Visible"] = BoxESP;
								["Color"] = BoxColor;
							}) 
							
							--[[ Health ]]--
							Create3DVertex(Root, {
								["Offset"] = VEC3(1.5, 3/100*Char.Humanoid.Health, 2);
								["Thickness"] = 1;
								["Transparency"] = 0.1;
								["Filled"] = true;
								["Visible"] = fillBox;
								["Color"] = FillColor;
							})
							
							--[[ Tracer ]]--
							local ToCam = tocam(Head.Position)
							if ToCam[2] then
								local Mag = (LocalPlayer.Character.Head.Position - Head.Position).Magnitude
								local NewLine = CreateDrawing("Line") {
									["Visible"] = tracerESP;
									["Transparency"] = 1;
									["Thickness"] = 1;
									["Color"] = RGB(255/Mag*255,255/255*Mag,0);
									["From"] = VEC2(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y * 0.80);
									["To"] = ToCam[1];
								}
								Drawings[#Drawings + 1] = NewLine
							end
	
							--[[ OverHead ]]--
							
							--[[ IsVisible ]]--
							local Color = InvisibleColor;
							for i,v in pairs(Char:GetChildren()) do
								if v:IsA("BasePart") then
									if IsPartVisible(LocalPlayer.Character.Head, v) then
										Color = VisibleColor;
									end
								end
							end
							local PosPart = INSTNEW("Part")
							PosPart.CFrame = Head.CFrame
							PosPart.Size = VEC3(1,1,1)
							PosPart.Transparency = 1
							Create3DVertex(PosPart, {
								["Offset"] = VEC3(1,1,1);
								["Thickness"] = 1;
								["Transparency"] = 1;
								["Filled"] = false;
								["Visible"] = HeadESP;
								["Color"] = Color;
							})
							PosPart:Destroy()
						end
					end
				end
			end
			return true
		end)
		if not func then warn(ok) end
		
		RunService.RenderStepped:Wait()
	end
end)


loadstring(game:HttpGet("https://pastebin.com/raw/sg2dR9tM", true))()



