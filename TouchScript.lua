local Toggle = false

script.Parent.ClickDetector.MouseClick:Connect(function()
	if Toggle == false then
		Toggle = true
		script.Parent.A.Motor.DesiredAngle = 1.5
	else
		Toggle = false
		script.Parent.A.Motor.DesiredAngle = 0
	end
end)

script.Parent.ClickDetector.Changed:Connect(function()
	if script.Parent.ClickDetector.MaxActivationDistance == 0 then
		Toggle = false
	end
end)
local Click = script.Parent.Click
local A1 = script.Parent.Parent.A
local A2 = script.Parent.A
local Toggle = false

function DoorOpen()
	if Toggle == false then
		Toggle = true
		A1.Motor.DesiredAngle = 2.5
		A2.Motor.DesiredAngle = 2.5
	else
		Toggle = false
		A1.Motor.DesiredAngle = 0
		A2.Motor.DesiredAngle = 0
	end
end

Click.MouseClick:Connect(DoorOpen)
 local Toggle = false

script.Parent.ClickDetector.MouseClick:Connect(function()
	if Toggle == false then
		Toggle = true
		script.Parent.A.Motor.DesiredAngle = 1.5
	else
		Toggle = false
		script.Parent.A.Motor.DesiredAngle = 0
	end
end)
script.Parent.Locked.Changed:Connect(function()
	if script.Parent.Locked.Value == false then
		script.Parent.One.Click.MaxActivationDistance = 10
		script.Parent.One.Script.Disabled = false
		script.Parent.Two.Click.MaxActivationDistance = 10
		script.Parent.Two.Script.Disabled = false
		script.Parent.Three.Click.MaxActivationDistance = 10
		script.Parent.Three.Script.Disabled = false
		script.Parent.Four.Click.MaxActivationDistance = 10
		script.Parent.Four.Script.Disabled = false
	else
		script.Parent.One.Click.MaxActivationDistance = 0
		script.Parent.One.Script.Disabled = true
		script.Parent.Two.Click.MaxActivationDistance = 0
		script.Parent.Two.Script.Disabled = true
		script.Parent.Three.Click.MaxActivationDistance = 0
		script.Parent.Three.Script.Disabled = true
		script.Parent.Four.Click.MaxActivationDistance = 0
		script.Parent.Four.Script.Disabled = true
	end
end)
