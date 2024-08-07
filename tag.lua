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

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local doJump = false
local reviving = false
local characterWalkSpeed = 40

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

player:WaitForChild("PlayerGui")

local function jump()
	if player.Character ~= nil then
		if player.Character.Humanoid.WalkSpeed == 0 then
			doJump = false
			if player.PlayerGui.StartScreen.StartInstructions.Visible == true then
				player.PlayerGui.StartScreen:Destroy()
				player.Character.Humanoid.WalkSpeed = characterWalkSpeed
				game.ReplicatedStorage.RemoteEvents.RunStarting:FireServer()
			end
		else
			player.Character.Humanoid.Jump = true
		end
	end
end

local function characterTouchedBrick(partTouched)
	local behaviours = partTouched:FindFirstChild("Behaviours")
	if behaviours ~= nil then
		behaviours = behaviours:GetChildren()
		for i = 1, #behaviours do
			if behaviours[i].Value == true then
				game.ReplicatedStorage.RemoteEvents.ExecuteBehaviour:FireServer(player.Character, partTouched, behaviours[i].Name)
			end
		end
	end
end

function characterAdded(newCharacter)
	local humanoid = newCharacter:WaitForChild("Humanoid")
	humanoid.WalkSpeed = 0
	humanoid.Touched:connect(characterTouchedBrick)

	local splashScreen = player.PlayerGui:WaitForChild("StartScreen")

	if UserInputService.TouchEnabled == false then
		if UserInputService.GamepadEnabled then
			splashScreen.StartInstructions.StartLabel.Text = "Press Space or Gamepad A Button to Start"
		else
			splashScreen.StartInstructions.StartLabel.Text = "Press Space to Start"
		end

	end
	if reviving == true then
		reviving = false
		splashScreen:Destroy()
		humanoid.WalkSpeed = characterWalkSpeed
	end

	humanoid.WalkSpeed = 0
end
player.CharacterAdded:connect(characterAdded)

if player.Character then
	characterAdded(player.Character)
end

function checkReviving(addedGui)
	if addedGui.Name == "RevivingGUI" then
		reviving = true
local RunService = game:GetService("RunService")

local character = script.Parent
local humanoid = character.Humanoid

local REGEN_DELAY = 5
local REGEN_RATE = 10

local lastHealth = humanoid.Health
local lastDamageTime = 0

local function onHeartbeat(deltaTime: number)
	local elapsed = os.clock() - lastDamageTime
	if elapsed < REGEN_DELAY then
		return
	end
	if humanoid.Health >= humanoid.MaxHealth then
		return
	end

	humanoid.Health = math.min(humanoid.Health + REGEN_RATE * deltaTime, humanoid.MaxHealth)
end

local function onHealthChanged(health: number)
	if health < lastHealth then
		lastDamageTime = os.clock()
	end
	lastHealth = health
end

RunService.Heartbeat:Connect(onHeartbeat)
humanoid.HealthChanged:Connect(onHealthChanged)
	local config = script:FindFirstChild(name)
	if (config ~= nil) then
		print("Loading anims " .. name)
		table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
		table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))
		local idx = 1
		for _, childPart in pairs(config:GetChildren()) do
			if (childPart:IsA("Animation")) then
				table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
				animTable[name][idx] = {}
				animTable[name][idx].anim = childPart
				local weightObject = childPart:FindFirstChild("Weight")
				if (weightObject == nil) then		for idx, anim in pairs(fileList) do
			animTable[name][idx] = {}
			animTable[name][idx].anim = Instance.new("Animation")
			animTable[name][idx].anim.Name = name
			animTable[name][idx].anim.AnimationId = anim.id
			animTable[name][idx].weight = anim.weight
			animTable[name].count = animTable[name].count + 1
			animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
			print(name .. " [" .. idx .. "] " .. anim.id .. " (" .. anim.wei)
end)
function scriptChildModified(child)
	local fileList = animNames[child.Name]
	if (fileList ~= nil) then
		configureAnimationSet(child.Name, fileList)
	end
end

script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)


for name, fileList in pairs(animNames) do
	configureAnimationSet(name, fileList)
end

local toolAnim = "None"
local toolAnimTime = 0

local jumpAnimTime = 0
local jumpAnimDuration = 0.3

local toolTransitionTime = 0.1
local fallTransitionTime = 0.3
local jumpMaxLimbVelocity = 0.75

function stopAllAnimations()
	local oldAnim = currentAnim


	if (emoteNames[oldAnim] ~= nil and emoteNames[oldAnim] == false) then
		oldAnim = "idle"
	end

	currentAnim = ""
	if (currentAnimKeyframeHandler ~= nil) then
		currentAnimKeyframeHandler:disconnect()
	end

	if (currentAnimTrack ~= nil) then
		currentAnimTrack:Stop()
		currentAnimTrack:Destroy()
		currentAnimTrack = nil
	end
	return oldAnim
end
