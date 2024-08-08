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
  
