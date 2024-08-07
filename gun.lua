player.PlayerGui.ChildAdded:connect(checkReviving)

if UserInputService.TouchEnabled then
	UserInputService.ModalEnabled = true
	UserInputService.TouchStarted:connect(function(inputObject, gameProcessedEvent) if gameProcessedEvent == false then doJump = true end end)
	UserInputService.TouchEnded:connect(function() doJump = false end)
else
	ContextActionService:BindAction("Jump", function(action, userInputState, inputObject) doJump = (userInputState == Enum.UserInputState.Begin) end, false, Enum.KeyCode.Space, Enum.KeyCode.ButtonA)
end

game:GetService("RunService").RenderStepped:connect(function()
	if player.Character ~= nil then
		if player.Character:FindFirstChild("Humanoid") then
			if doJump == true then
				jump()
			end
			player.Character.Humanoid:Move(Vector3.new(0,0,-1), false)
		end
	end
end)
function   waitForChild(parent, childName)
	local child = parent:findFirstChild(childName)
	if child then return child end
	while true do
		child = parent.ChildAdded:wait()
		if child.Name==childName then return child end
	end
end

local Figure = script.Parent
local Torso = waitForChild(Figure, "Torso")
local RightShoulder = waitForChild(Torso, "Right Shoulder")
local LeftShoulder = waitForChild(Torso, "Left Shoulder")
local RightHip = waitForChild(Torso, "Right Hip")
local LeftHip = waitForChild(Torso, "Left Hip")
local Neck = waitForChild(Torso, "Neck")
local Humanoid = waitForChild(Figure, "Humanoid")
local pose = "Standing"

local currentAnim = ""
local currentAnimTrack = nil
local currentAnimKeyframeHandler = nil
local currentAnimSpeed = 1.0
local animTable = {}
local animNames = {
