jit.on()

CULLFRONT = math.sin(0.42261826) -- 150 Degrees forward

function init()
    hook.Remove("InitPostEntity", "runonce")
    ply = LocalPlayer()
    tAllEnts = ents.GetAll()
    for a, e in pairs(tAllEnts) do
        e:SetNoDraw(true)
        if engine.TickCount()%1 == 0 then
			if engine.TickCount()%16.5 == 0 then
				if e:GetPos():Distance(ply:GetPos()) < 75 then
        	       	e:SetNoDraw(false)
        	    end
			else
				return
			end
            if util.IsPointInCone(e:GetPos(), ply:GetPos(), ply:GetAimVector(), CULLFRONT, 100000) then
                if engine.TickCount()%16.5 == 0 then
                    if ply:IsLineOfSightClear(e:GetPos()) then                    
                        e:SetNoDraw(false)
                    end
                else
                    return
                end
                if e:GetClass() == "prop_door_rotating" or "func_door" then
                    e:SetNoDraw(false)
                end
            end
            if engine.TickCount()%16.5 == 0 then
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
