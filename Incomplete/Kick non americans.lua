local LocalizationService = game:GetService("LocalizationService")
local player = game.Players.LocalPlayer
 
local result, code = pcall(function()
	return LocalizationService:GetCountryRegionForPlayerAsync(player)
end)
 
if result and code == "US" then
    print('Cool beans')
else
    player:Kick("Not american")
end