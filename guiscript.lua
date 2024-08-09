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
player = nil

function onChng()
	if script.Parent.Visible == true then
		player = game.Players.LocalPlayer
		player.Character.Plane.MainParts.Main.Value = true
	else 
		player.Character.Plane.MainParts.Main.Value = false
	end
end

script.Parent.Changed:connect(onChanged)

while true do
	wait(0.1)
	script.Parent.PartBOTTOM.Transparency = 1
		script.Parent.PartMIDDLE.Transparency = 0
		script.Parent.Seat.CanCollide = true
		local human = script.Parent.Seat:findFirstChild("SeatWeld") 
		if (human ~= nil ) then
		script.Parent.PartBOTTOM.Transparency = 0
		script.Parent.PartMIDDLE.Transparency = 1
		script.Parent.Seat.CanCollide = false
		wait(1)
	end

while true do
	wait(0.1)
	script.Parent.Seat.Transparency = 1
		script.Parent.Part.Transparency = 0
		script.Parent.Part.CanCollide = true
		local human = script.Parent.Seat:findFirstChild("SeatWeld") 
		if (human ~= nil ) then
		script.Parent.Seat.Transparency = 0
		script.Parent.Part.Transparency = 1
		script.Parent.Part.CanCollide = false
		wait(1)
	end
end

end
