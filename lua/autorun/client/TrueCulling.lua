jit.on()

CULLFRONT = math.sin(0.57357644) -- Degrees forward angle in sine

function main()
	allEnts = ents.GetAll()
	if engine.TickCount()%6 == 0 then
		for a, ents_ in pairs(allEnts) do
			if engine.TickCount()%16 == 0 then
				if ents_:GetNoDraw(false) then
					ents_:SetNoDraw(true)
				end
			end
			if engine.TickCount()%22 == 0 then
				if ents_:GetNoDraw(true) then
					if util.IsPointInCone(ents_:GetPos(), LocalPlayer():GetPos(), LocalPlayer():GetAimVector(), CULLFRONT, 100000) then
						if engine.TickCount()%16.5 == 0 then
							if LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(-25,-25,35)) or LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(100,100,-10)) then
								if ents_:GetNoDraw(true) then 
									ents_:SetNoDraw(false)
								end
							end
						end
					end
				end
			else
				return
			end
			if engine.TickCount()%99 == 0 then
				if ents_:IsPlayer() or ents_:GetClass() == "viewmodel" then    
					if ents_:GetNoDraw(true) then                
						ents_:SetNoDraw(false)
					end
				end
			else
				return
			end
			if engine.TickCount()%120 == 0 then
				if ents_:GetPos():Distance(LocalPlayer():GetPos()) < 100 then
					if ents_:GetNoDraw(true) then				
						ents_:SetNoDraw(false)
					end			
				end
			else
				return
			end
		end
	else
		return
	end
end

hook.Add("Think", "cullLoop", main)
hook.Add("InitPostEntity", "initents", main)
