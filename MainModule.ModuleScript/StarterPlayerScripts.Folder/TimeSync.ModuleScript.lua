local TimeSync = {}

TimeSync.GetServerTime = function()
	return tick() + TimeSync.ServerOffset
end

local TimeSync_Event = game:GetService("ReplicatedStorage"):WaitForChild("TimeSync_Event")
local Pings = {}
local function GetOffset()
	local StartTime, ServerTime, ClientTime = tick(), TimeSync_Event:InvokeServer(), tick()
	
	TimeSync.Ping = (ClientTime - StartTime) / 2
	table.insert(Pings, 1, {TimeSync.Ping, ServerTime + TimeSync.Ping - ClientTime})
	Pings[5] = nil
	
	local Lowest
	for _, Data in ipairs(Pings) do
		if not Lowest or Data[1] < Lowest[1] then
			Lowest = Data
		end
	end
	
	TimeSync.ServerOffset = Lowest[2]
end

GetOffset()
coroutine.wrap(function()
	for i = 1, 4 do
		wait(0.25)
		
		GetOffset()
	end
	
	while true do
		wait(0.5)
		
		GetOffset()
	end
end)()

return TimeSync