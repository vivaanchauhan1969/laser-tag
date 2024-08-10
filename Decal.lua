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
