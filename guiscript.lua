seat = script.Parent
function added(child)
	if (child.className=="Weld") then
		local human = child.part1.Parent:FindFirstChild("Humanoid")
		if human ~= nil then
			anim = human:LoadAnimation(seat.SitAnim)
			anim:Play()
		end
	 end
end

function removed(child2)
	if anim ~= nil then
		anim:Stop()
		anim:Remove()
	end
end

seat.ChildAdded:connect(added)
seat.ChildRemoved:connect(removed)
script.Parent.Parent.Parent.Parent.Part.Value.On.Changed:Connect(function()
	if script.Parent.Parent.Parent.Parent.Part.Value.On.Value == true then
		script.Parent.Light.Enabled = true
		script:Destroy()
	end
end)
  
local Flex = script.Parent.WingFlex
local Straight = script.Parent.WingStraight
local WFL = script.Parent.WFL.A
local WFR = script.Parent.WFR.A
local WingFlexing = false

function WingFlex()
	WingFlexing = true
	script.Parent.Fly.Value = true
	script.Parent.Taxi.Value = false
	WFL.Motor.DesiredAngle = 0.04
	WFR.Motor.DesiredAngle = 0.04
end

function WingStraight()
	WingFlexing = false
	script.Parent.Fly.Value = false
	script.Parent.Taxi.Value = true
	WFL.Motor.DesiredAngle = 0
	WFR.Motor.DesiredAngle = 0
end

while (WingFlexing) do
	WFL.Motor.DesiredAngle = 0
	WFR.Motor.DesiredAngle = 0
	WFL.Motor.DesiredAngle = 0.04
	WFR.Motor.DesiredAngle = 0.04
	wait(math.random(1,5))
	WFL.Motor.DesiredAngle = 0
	WFR.Motor.DesiredAngle = 0
	WFL.Motor.DesiredAngle = 0.06
	WFR.Motor.DesiredAngle = 0.06
	wait(math.random(1,5))
end]]

Flex.OnServerEvent:Connect(WingFlex)
Straight.OnServerEvent:Connect(WingStraight)
