jit.on()

CULLFRONT = math.sin(0.64278761) -- 150 Degrees forward

num = 1

function init()
    hook.Remove("InitPostEntity", "runonce")
	ply = LocalPlayer()		
	if num >= ents.GetCount() then
		num = 1
	end
	num = num + 1
	e = Entity(num)
	if e:IsValid() then
		e:SetNoDraw(true)
		if e:IsPlayer() or e:GetClass() == "viewmodel" then
			e:SetNoDraw(false)
		end
		if util.IsPointInCone(e:GetPos(), ply:GetPos(), ply:GetAimVector(), CULLFRONT, 100000) then         
			if ply:IsLineOfSightClear(e:GetPos() + Vector(-25,-25,35)) or ply:IsLineOfSightClear(e:GetPos() + Vector(100,100,-10)) then                    
				e:SetNoDraw(false)
			end
		end
		if e:GetPos():Distance(ply:GetPos()) < 100 then
			e:SetNoDraw(false)
		end
	end
end

coroutine.create(init)

hook.Add("Think", "tick", init)
hook.Add("InitPostEntity", "runonce", init)
