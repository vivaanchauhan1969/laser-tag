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
local character = script.Parent
local humanoid = character.Humanoid
local spawnLocation = character.HumanoidRootPart.Position
local player = game.Players:GetPlayerFromCharacter(character)

local started = false


function findHeight(distanceInFront)
	local torso = character.HumanoidRootPart
	local ray = Ray.new(
    Vector3.new(torso.Position.X, torso.Position.Y + 50, torso.Position.Z - distanceInFront),
    (Vector3.new(0, -1, 0)).unit * 300)	 														 
	local ignore = character
	local hit, position = game.Workspace:FindPartOnRay(ray, ignore)
	return position.Y + 40
end

function highest(tableOfValues)
	local highestSoFar = tableOfValues[1]
	for i = 2, #tableOfValues do
		if tableOfValues[i] > highestSoFar then
			highestSoFar = tableOfValues[i]
		end
	end
	return highestSoFar
end

function fastStart()
	if started == false then
		started = true
		local fastStartPosition = Instance.new("BodyPosition")
		fastStartPosition.Name = "FastStart"
		fastStartPosition.maxForce = Vector3.new(0, 15000, 0)
		fastStartPosition.Parent = character.HumanoidRootPart
		local fastStartVelocity = Instance.new("BodyVelocity")
		fastStartVelocity.maxForce = Vector3.new(0, 0, 15000)
		fastStartVelocity.velocity = Vector3.new(0, 0, -150)
		fastStartVelocity.Parent = character.HumanoidRootPart
		fastStartPosition.position = Vector3.new(0, highest({findHeight(0), findHeight(10), findHeight(20), findHeight(30)}), 0)
		while character.HumanoidRootPart.Position.Z > spawnLocation.Z - 1000 do
			wait(1)
			if character:FindFirstChild("HumanoidRootPart") == nil then
				break
			end
			fastStartPosition.position = Vector3.new(0, highest({findHeight(0), findHeight(10), findHeight(20), findHeight(30)}), 0)
		end
		fastStartVelocity.velocity = Vector3.new(0, 0, 0)
		wait(2)
		if character:FindFirstChild("HumanoidRootPart") then
			fastStartPosition:Destroy()
			fastStartVelocity:Destroy()
			local shield = Instance.new("ForceField")
			shield.Name = "Shield"
			shield.Parent = character
			game:GetService("Debris"):AddItem(shield, 3)
		end
		fastStart:Destroy()
		script:Destroy()
	end
end

fastStart()

local camera = game.Workspace.CurrentCamera
local player = game.Players.LocalPlayer

camera.CameraType = Enum.CameraType.Scriptable

local targetDistance = 30
local cameraDistance = -30
local cameraDirection = Vector3.new(-1,0,0)

local currentTarget = cameraDirection*targetDistance
local currentPosition = cameraDirection*cameraDistance

game:GetService("RunService").RenderStepped:connect(function()
	local character = player.Character
	if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") then
		local torso = character.HumanoidRootPart
		camera.Focus = torso.CFrame
		if torso:FindFirstChild("FastStart") == nil then
			camera.CoordinateFrame = 	CFrame.new(Vector3.new(torso.Position.X, torso.Position.Y + 10, torso.Position.Z - 20) + currentPosition,
										Vector3.new(torso.Position.X,  torso.Position.Y, torso.Position.Z - 20) + currentTarget)
		else
			--Lower camera for fast start
			camera.CoordinateFrame = CFrame.new(Vector3.new(torso.Position.X, torso.Position.Y - 15, torso.Position.Z - 20) + currentPosition,
											    Vector3.new(torso.Position.X,  torso.Position.Y - 15, torso.Position.Z - 20) + currentTarget)
		end
	end
end)

