local zombie = script.Parent

for _, script in pairs(zombie.ModuleScripts:GetChildren()) do
	if not game.ServerStorage:FindFirstChild(script.Name) then
		script:Clone().Parent = game.ServerStorage
	end
end

local AI = require(game.ServerStorage.ROBLOX_ZombieAI).new(zombie)
local DestroyService = require(game.ServerStorage.ROBLOX_DestroyService)


local function clearParts(parent)
	for _, part in pairs(parent:GetChildren()) do
		clearParts(part)
	end
	local delay
	if parent:IsA("Part") then
		delay = math.random(5,10)
	else
		delay = 11
	end
	DestroyService:AddItem(parent, delay)
end

zombie.Humanoid.Died:connect(function()
	AI.Stop()
	math.randomseed(tick())
	clearParts(zombie)
	script.Disabled = true
end)

local lastMoan = os.time()
math.randomseed(os.time())
while true do
	local animationTrack = zombie.Humanoid:LoadAnimation(zombie.Animations.Arms)
	animationTrack:Play()
a	local now = os.time()
	if now - lastMoan > 5 then
		if math.random() > .3 then
			zombie.Moan:Play()
			print("playing moan")
			lastMoan = now
		end
	end
	wait(2)
end

local coin = script.Parent
local coinModel = coin.Parent
local trackModel = coinModel.Parent
local tracksModel = trackModel.Parent

coin.BodyPosition.position = script.Parent.Position
coin.BodyGyro.cframe = CFrame.new(
	0, 0, 0,
	0, -1, 0,
	0, 0, 0,
	0, 0, 0
)
coin.RotVelocity = Vector3.new(0, 5, 0)

if coinModel.Parent ~= game.Workspace then
	if game.Workspace:FindFirstChild("Tracks") then
		if tracksModel:FindFirstChild("Coins") == nil then
			local coinsModel = Instance.new("Model")
			coinsModel.Name = "Coins"
			coinsModel.Parent = tracksModel
		end

		tracksModel.ChildRemoved:connect(function(child) if child == trackModel then coinModel:Destroy() end end)
		coinModel.Parent = tracksModel:FindFirstChild("Coins")
	end
end

wait(1)
coin.RotVelocity = Vector3.new(0, 5, 0)
