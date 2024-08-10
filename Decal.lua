function moveJump()
	RightShoulder.MaxVelocity = 0.5
	LeftShoulder.MaxVelocity = 0.5
  RightShoulder.DesiredAngle=3.14
	LeftShoulder.DesiredAngle=-3.14
	RightHip.DesiredAngle=0
	LeftHip.DesiredAngle=0
end

function moveFreeFall()
	RightShoulder.MaxVelocity = 0.5
	LeftShoulder.MaxVelocity =0.5
	RightShoulder.DesiredAngle=3.14
	LeftShoulder.DesiredAngle=-3.14
	RightHip.DesiredAngle=0
	LeftHip.DesiredAngle=0
end

function moveSit()
	RightShoulder.MaxVelocity = 0.15
	LeftShoulder.MaxVelocity = 0.15
	RightShoulder.DesiredAngle=3.14 /2
	LeftShoulder.DesiredAngle=-3.14 /2
	RightHip.DesiredAngle=3.14 /2
	LeftHip.DesiredAngle=-3.14 /2
end

function animate(time)
	local amplitude
	local frequency
	if (pose == "Jumping") then
		moveJump()
		return
	end
	if (pose == "FreeFall") then
		moveFreeFall()
		return
	end
	if (pose == "Seated") then
		moveSit()
		return
	end
	local climbFudge = 0
	if (pose == "Running") then
		RightShoulder.MaxVelocity = 0.15
		LeftShoulder.MaxVelocity = 0.15
		amplitude = 1
		frequency = 9
	elseif (pose == "Climbing") then
		RightShoulder.MaxVelocity = 0.5 
		LeftShoulder.MaxVelocity = 0.5
		amplitude = 1
		frequency = 9
		climbFudge = 3.14
	else
		amplitude = 0.1
		frequency = 1
	end
	desiredAngle = amplitude * math.sin(time*frequency)
	if not chasing and frequency==9 then
		frequency=4
	end
	if chasing then
		[RightShoulder.DesiredAngle=math.pi/2
		LeftShoulder.DesiredAngle=-math.pi/2
		RightHip.DesiredAngle=-desiredAngle*2
		LeftHip.DesiredAngle=-desiredAngle*2]]
	else
		RightShoulder.DesiredAngle=desiredAngle + climbFudge
		LeftShoulder.DesiredAngle=desiredAngle - climbFudge
		RightHip.DesiredAngle=-desiredAngle
		LeftHip.DesiredAngle=-desiredAngle
	end
end


function attack(time,attackpos)
	if time-lastattack>=0.25 then
		local hit,pos=raycast(Torso.Position,(attackpos-Torso.Position).unit,attackrange)
		if hit and hit.Parent~=nil then
			local h=hit.Parent:FindFirstChild("Humanoid")
			local TEAM=hit.Parent:FindFirstChild("TEAM")
			if h and TEAM and TEAM.Value~=sp.TEAM.Value then
				local creator=sp:FindFirstChild("creator")
				if creator then
					if creator.Value~=nil then
						if creator.Value~=game.Players:GetPlayerFromCharacter(h.Parent) then
							for i,oldtag in ipairs(h:GetChildren()) do
								if oldtag.Name=="creator" then
									oldtag:remove()
								end
							end
							creator:clone().Parent=h
						else
							return
						end
					end
				end
				hitsound.Volume=1
				hitsound.Pitch=.75+(math.random()*.5)
				hitsound:Play()
				wait(0.15)
				h:TakeDamage(damage)
					if RightShoulder and LeftShoulder then
					RightShoulder.CurrentAngle=0
					LeftShoulder.CurrentAngle=0
				end]]
			end
		end
		lastattack=time
	end
end


Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)

function tween(obj, dur, cmd)
	game:GetService('TweenService'):Create(obj, dur, cmd):Play()
end

workspace.Camera.CameraType = Enum.CameraType.Scriptable
tween(workspace.Camera, TweenInfo.new(1), {CFrame = workspace.MenuCam.CFrame})
local Settings = {
	canAim = true;
	AimSmooth = .08;
	
	fireAnim = 'rbxassetid://18886287033';
	canSemi = true;
	canFullAuto = true;
	fireMode = "Full Auto";
}

return Settings

local Lobbyarea = script.Parent
local sound = workspace.Assets:FindFirstChild("Elementals Lobby Theme")

Lobbyarea.Touched:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChild("Humanoid")
	sound.Parent = character
	if humanoid then
		print("touched")
		local player = game.Players:GetPlayerFromCharacter(character)

		if sound then
			sound:Play()
		end
	end
end)
Lobbyarea.TouchEnded:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		print("no longer touching")
	end
	if sound then
		sound:Stop()
	end
end)

local Settings = {
	
	canAim = true;
	AimSmooth = .125;
	
	fireAnim = 'rbxassetid://18886287033';
	a
	canSemi = true;
	canFullAuto = false;
	fireMode = "Semi";
}

return Settings

function populatehumanoids(mdl)
	if mdl.ClassName=="Humanoid" then
		if mdl.Parent:FindFirstChild("TEAM") and mdl.Parent:FindFirstChild("TEAM").Value~=sp.TEAM.Value then
			table.insert(humanoids,mdl)
		end
	end
	for i2,mdl2 in ipairs(mdl:GetChildren()) do
		populatehumanoids(mdl2)
	end
end

	function playsound(time)
	nextsound=time+5+(math.random()*5)
	local randomsound=sounds[math.random(1,#sounds)]
	randomsound.Volume=.5+(.5*math.random())
	randomsound.Pitch=.5+(.5*math.random())
	randomsound:Play()
end]]

while sp.Parent~=nil and Humanoid and Humanoid.Parent~=nil and Humanoid.Health>0 and Torso and Head and Torso~=nil and Torso.Parent~=nil do
	local _,time=wait(0.25) wait(1/3)
	humanoids={}
	populatehumanoids(game.Workspace)
	closesttarget=nil
	closestdist=sightrange
	local creator=sp:FindFirstChild("creator")
	for i,h in ipairs(humanoids) do
		if h and h.Parent~=nil then
			if h.Health>0 and h.Parent~=sp then
				local plr=game.Players:GetPlayerFromCharacter(h.Parent)
				if creator==nil or plr==nil or creator.Value~=plr then
					local t=h.Parent:FindFirstChild("Torso")
					if t~=nil then
						local dist=(t.Position-Torso.Position).magnitude
						if dist<closestdist then
							closestdist=dist
							closesttarget=t
						end
					end
				end
			end
		end
	end
	if closesttarget~=nil then	
		if not chasing then
			  playsound(time)
			chasing=true
			Humanoid.WalkSpeed=runspeed
			BARKING:Play()
		end
		Humanoid:MoveTo(closesttarget.Position+(Vector3.new(1,1,1)*(variance*((math.random()*2)-1))),closesttarget)
		if math.random()<.5 then
			attack(time,closesttarget.Position)
		end
	else
		if chasing then
			chasing=false
			Humanoid.WalkSpeed=wonderspeed
			BARKING:Stop()
		end
		if time>nextrandom then
			nextrandom=time+3+(math.random()*5)
			local randompos=Torso.Position+((Vector3.new(1,1,1)*math.random()-Vector3.new(.5,.5,.5))*40)
			Humanoid:MoveTo(randompos,game.Workspace.Terrain)
		end
	end
	if time>nextsound then
		playsound(time)
	end
	if time>nextjump then
		nextjump=time+7+(math.random()*5)
		Humanoid.Jump=true
	end
	animate(time)
end

wait(4)
sp:remove()
