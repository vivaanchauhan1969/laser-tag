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
local AdvancedRespawnScript=script;
repeat Wait(0)until script and script.Parent and script.Parent.ClassName=="Model";
local Adam=AdvancedRespawnScript.Parent;
local GameDerbis=Game:GetService("Debris");
local AdamHumanoid;
for _,Child in pairs(Adam:GetChildren())do
if Child and Child.ClassName=="Humanoid"and Child.Health>0.001 then
AdamHumanoid=Child;
end;
end;
local Respawndant=Adam:Clone();
coroutine.resume(coroutine.create(function()
if Adam and AdamHumanoid and AdamHumanoid:FindFirstChild("Status")and not AdamHumanoid:FindFirstChild("Status"):FindFirstChild("AvalibleSpawns")then
SpawnModel=Instance.new("Model");
SpawnModel.Parent=AdamHumanoid.Status;
SpawnModel.Name="AvalibleSpawns";
else
SpawnModel=AdamHumanoid:FindFirstChild("Status"):FindFirstChild("AvalibleSpawns");
end;
function FindSpawn(SearchValue)
local PartsArchivable=SearchValue:GetChildren();
for AreaSearch=1,#PartsArchivable do
if PartsArchivable[AreaSearch].className=="SpawnLocation"then
local PositionValue=Instance.new("Vector3Value",SpawnModel);
PositionValue.Value=PartsArchivable[AreaSearch].Position;
PositionValue.Name=PartsArchivable[AreaSearch].Duration;
end;
FindSpawn(PartsArchivable[AreaSearch]);
end;
end;
FindSpawn(Game.Workspace);
local SpawnChilden=SpawnModel:GetChildren();
if#SpawnChilden>0 then
local SpawnItself=SpawnChilden[math.random(1,#SpawnChilden)];
local RespawningForceField=Instance.new("ForceField");
RespawningForceField.Parent=Adam;
RespawningForceField.Name="SpawnForceField";
GameDerbis:AddItem(RespawningForceField,SpawnItself.Name);
Adam:MoveTo(SpawnItself.Value+Vector3.new(0,3.5,0));
else
if Adam:FindFirstChild("SpawnForceField")then
Adam:FindFirstChild("SpawnForceField"):Destroy();
end;
Adam:MoveTo(Vector3.new(0,115,0));
end;
end));
function Respawn()
Wait(5);
Respawndant.Parent=Adam.Parent;
Respawndant:makeJoints();
Respawndant:FindFirstChild("Head"):MakeJoints();
Respawndant:FindFirstChild("Torso"):MakeJoints();
Adam:remove();
end;
AdamHumanoid.Died:connect(Respawn);
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
Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)


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
				
function tween(obj, dur, cmd)
	game:GetService('TweenService'):Create(obj, dur, cmd):Play()
end

workspace.Camera.CameraType = Enum.CameraType.Scriptable
				local One = script.One.Value
local Two = script.Two.Value
local Three = script.Three.Value
local Speed = 200

script.Parent.Parent.Flap.Changed:Connect(function()
	if script.Parent.Parent.Flap.Value == 0 then
		Speed = 200
	elseif script.Parent.Parent.Flap.Value == 1 then
		Speed = 180
	elseif script.Parent.Parent.Flap.Value == 2 then
		Speed = 170
	elseif script.Parent.Parent.Flap.Value == 3 then
		Speed = 160
	elseif script.Parent.Parent.Flap.Value == 4 then
		Speed = 150
	end
end)

function SmokeOne()
	if One.Velocity.Magnitude > Speed then
		One.Smoke:Emit(100)
		One.Touchdown:Play()
	end
end

function SmokeTwo()
	if Two.Velocity.Magnitude > Speed then
		Two.Smoke:Emit(100)
		Two.Touchdown:Play()
	end
end

function SmokeThree()
	if Three.Velocity.Magnitude > Speed then
		Three.Smoke:Emit(100)
		Three.Touchdown:Play()
	end
end


One.Touched:Connect(SmokeOne)
Two.Touched:Connect(SmokeTwo)
Three.Touched:Connect(SmokeThree)
tween(workspace.Camera, TweenInfo.new(1), {CFrame = workspace.MenuCam.CFrame})
