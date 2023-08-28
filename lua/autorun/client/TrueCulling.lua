jit.on()

CULLFRONT = math.sin(0.57357644) -- 150 Degrees forward

function init()
    hook.Remove("InitPostEntity", "runonce")
    ply = LocalPlayer()
    tAllEnts = ents.GetAll()
    for a, e in pairs(tAllEnts) do
        e:SetNoDraw(true)
        if engine.TickCount()%2 == 0 then
            if util.IsPointInCone(e:GetPos() + Vector(0,0,-50), ply:GetPos(), ply:GetAimVector(), CULLFRONT, 100000) then
				if engine.TickCount()%4 == 0 then
		            if e:GetClass() == "prop_door_rotating" or "func_door" then
		                e:SetNoDraw(false)
		            end
		        else
	                return
	            end                
				if engine.TickCount()%45 == 0 then
                    if ply:IsLineOfSightClear(e:GetPos() + Vector(0,0,-50)) then                    
                        e:SetNoDraw(false)
                    end
                else
                    return
                end
            end
            if engine.TickCount()%45 == 0 then
                if e:IsPlayer() or e:GetClass() == "viewmodel" then                    
                    e:SetNoDraw(false)
                end
            else
                return
            end
        else
            return
        end
    end
end

coroutine.create(init)

hook.Add("Think", "tick", init)
hook.Add("InitPostEntity", "runonce", init)
