local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local aimCf = CFrame.new()
local camera = workspace.CurrentCamera
local tempAim = CFrame.new()
local ISAiming = false
local framework = {
	inventory = {
		"Electo";
		"The shocker";
		"Knife";
	};

	module = nil;
	viewmodel = nil;
	currentSlot = 1;
}

function loadSlot(Item)
	local viewmodelFolder = game.ReplicatedStorage.Viewmoduls
	local moduleFolder = game.ReplicatedStorage.module

	for i, v in pairs(camera:GetChildren()) do
		if v:IsA("Model") then
			v:Destroy()
		end
	end

	if moduleFolder:FindFirstChild(Item) then
		framework.module = require(moduleFolder:FindFirstChild(Item))
		if viewmodelFolder:FindFirstChild(Item) then
			framework.viewmodel = viewmodelFolder:FindFirstChild(Item):Clone()
			framework.viewmodel.Parent = camera
		end	
	end
end

RunService.RenderStepped:Connect(function()
	for i, v in pairs(camera:GetChildren()) do
		if v:IsA("Model") then
			v:SetPrimaryPartCFrame(camera.CFrame * aimCf)
		end
	end
	
	if ISAiming and framework.viewmodel ~= nil then
		local offset = framework.viewmodel.Aimpart.CFrame:ToObjectSpace(framework.viewmodel.PrimaryPart.CFrame)
		tempAim = aimCf
		aimCf = aimCf:Lerp(offset, .1)
	else
		local offset = CFrame
		tempAim = aimCf
		aimCf = aimCf:Lerp(offset, 0.1)
	end
end)

loadSlot(framework.inventory[1])

UserInputService.InputBegan:Connect(function(key, processed)
	if processed then return end

	if key.KeyCode == Enum.KeyCode.One then
		if framework.currentSlot ~= 1 then
			loadSlot(framework.inventory[1])
			framework.currentSlot = 1
		end
	end

	if key.KeyCode == Enum.KeyCode.Two then
		if framework.currentSlot ~= 2 then
			loadSlot(framework.inventory[2])
			framework.currentSlot = 2
		end
	end
	
	if key.UserInputType == Enum.UserInputType.MouseButton2 then
		if framework.viewmodel then
			ISAiming = true
		end
	end
	
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		aimCf = tempAim
		ISAiming = false
	end

end)
function playAnimation(animName, transitionTime, humanoid)
	local idleFromEmote = (animName == "idle" and emoteNames[currentAnim] ~= nil)
	if (animName ~= currentAnim and not idleFromEmote) then

		if (currentAnimTrack ~= nil) then
			currentAnimTrack:Stop(transitionTime)
			currentAnimTrack:Destroy()
		end

		currentAnimSpeed = 1.0
		local roll = math.random(1, animTable[animName].totalWeight)
		local origRoll = roll
		local idx = 1
		while (roll > animTable[animName][idx].weight) do
			roll = roll - animTable[animName][idx].weight
			idx = idx + 1
		end
		print(animName .. " " .. idx .. " [" .. origRoll .. "]")
		local anim = animTable[animName][idx].anim


		currentAnimTrack = humanoid:LoadAnimation(anim)


		currentAnimTrack:Play(transitionTime)
		currentAnim = animName


		if (currentAnimKeyframeHandler ~= nil) then
			currentAnimKeyframeHandler:disconnect()
		end
		currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)
	end
end


local toolAnimName = ""
local toolAnimTrack = nil
local currentToolAnimKeyframeHandler = nil

function toolKeyFrameReachedFunc(frameName)
	if (frameName == "End") then
		print("Keyframe : ".. frameName)
		local repeatAnim = stopToolAnimations()
		playToolAnimation(repeatAnim, 0.0, Humanoid)
	end
end
