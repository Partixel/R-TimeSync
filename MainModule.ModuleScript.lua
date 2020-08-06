local TimeSync_Event = Instance.new("RemoteFunction")
TimeSync_Event.Name = "TimeSync_Event"
TimeSync_Event.OnServerInvoke = function(Plr)
	return tick()
end
TimeSync_Event.Parent = game:GetService("ReplicatedStorage")

local LoaderModule = require(game:GetService("ServerStorage"):FindFirstChild("LoaderModule") and game:GetService("ServerStorage").LoaderModule:FindFirstChild("MainModule") or 03593768376)("TimeSync")
LoaderModule(script:WaitForChild("StarterPlayerScripts"))

return nil