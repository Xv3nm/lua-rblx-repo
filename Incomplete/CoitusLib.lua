local Library = {}

function Library:Console(name)
    rconsolename(name)
    
    local Cout = {}
    
    function Cout:Help()
        rconsoleclear()
        rconsoleprint('[*]                     <>  Coitus Terminal Commands  <>               [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*] ~    :Clear()                                                      [*]\n')
        rconsoleprint('[*] $        Clears the console                                        [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*] ~    :Output("Output Text")                                        [*]\n')
        rconsoleprint('[*] $        Prints output in console                                  [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*] ~    :FuncOut("Output Text")                                       [*]\n')
        rconsoleprint('[*] $        Output functions                                          [*]\n')
        rconsoleprint('[*] #             E.g. :GetChildren()                                  [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*] ~    :Warn("Warn Text")                                            [*]\n')
        rconsoleprint('[*] $        Prints warn in console                                    [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*] ~    :Error("Error Text")                                          [*]\n')
        rconsoleprint('[*] $        Prints error in console                                   [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*] ~    :Help()                                                       [*]\n')
        rconsoleprint('[*] $        Displays all Coitus cmds                                  [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*]                                                                    [*]\n')
        rconsoleprint('[*]                     <>  Coitus Terminal Commands  <>               [*]\n')
		wait(0.1)
    end
    
    function Cout:Output(out)
        rconsoleprint('[*]: '..out..'\n')
		wait(0.1)
    end

	function Cout:FuncOut(func)
        for i,v in pairs(func) do
			rconsoleprint('[*]: '..tostring(v)..'\n')
		end
		wait(0.1)
	end

    function Cout:Script(link)
        rconsolewarn("Executing custom script('s). Press LeftShit to execute or RightShift to abort! ")

		local UserInputService = game:GetService("UserInputService")
 
		local shiftKeyL = Enum.KeyCode.LeftShift
		local shiftKeyR = Enum.KeyCode.RightShift
 
		local function IsShiftKeyDown()
			if UserInputService:IsKeyDown(shiftKeyL) then
				return 1
			elseif UserInputService:IsKeyDown(shiftKeyR) then
				return 2
			else
				return 0
			end
		end
 
		local function Input(input, gameProcessedEvent)
			if not IsShiftKeyDown() then
				rconsoleclear()
				rconsolewarn(tostring(IsShiftKeyDown())..'Invalid Answer..')
				wait(0.1)
			else
				wait(0.1)
				rconsoleerr(tostring(IsShiftKeyDown()))
				if IsShiftKeyDown() == 1 then
					rconsoleclear()
					rconsolewarn('Script Executed: '..tostring(link))
					UserInputService:Disconnect()
				elseif IsShiftKeyDown() == 2 then
				    rconsoleclear()
				    rconsolewarn('Script Aborted: '..tostring(link))
					UserInputService:Disconnect()
				end
			end
		end
 
		UserInputService.InputBegan:Connect(Input)

		wait(0.1)
    end
    
    function Cout:Warn(out)
        rconsolewarn(out)
		wait(0.1)
    end
    
    function Cout:Error(out)
        rconsoleerr(out)
		wait(0.1)
    end
    
    function Cout:Clear()
        rconsoleclear()
		wait(0.1)
    end
    
    return Cout;
end

return Library;