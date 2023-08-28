jit.on()

CULLFRONT = math.sin(0.57357644) -- 150 Degrees forward

function init()
    hook.Remove("InitPostEntity", "runonce")
    ply = LocalPlayer()
    tAllEnts = ents.GetAll()
    for a, e in pairs(tAllEnts) do
        e:SetNoDraw(true)
		if engine.TickCount()%22.5 == 0 then
		    if util.IsPointInCone(e:GetPos(), ply:GetPos(), ply:GetAimVector(), CULLFRONT, 100000) then         
				if ply:IsLineOfSightClear(e:GetPos() + Vector(-25,-25,0)) or ply:IsLineOfSightClear(e:GetPos() + Vector(25,25,0)) then                    
				    e:SetNoDraw(false)
				end
			end
		else
			return
		end
		if engine.TickCount()%22.5 == 0 then
			if e:GetPos():Distance(ply:GetPos()) < 75 then
				e:SetNoDraw(false)
	        end
		else
            return
        end
        if engine.TickCount()%22.5 == 0 then
            if e:IsPlayer() or e:GetClass() == "viewmodel" then                    
                e:SetNoDraw(false)
            end
        else
            return
        end
    end
end

coroutine.create(init)

hook.Add("Think", "tick", init)
hook.Add("InitPostEntity", "runonce", init)
