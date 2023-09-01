jit.on()

CULLFRONT = math.sin(0.57357644) -- Degrees forward angle in sine

function main()
	if engine.TickCount()%4 == 0 then
		allEnts = ents.GetAll()
		for a, ents_ in pairs(allEnts) do
			if engine.TickCount()%10 == 0 then
				ents_:SetNoDraw(true)
				if ents_:GetClass() == "10C_BaseFlex" then
					continue
				end
				if util.IsPointInCone(ents_:GetPos(), LocalPlayer():GetPos(), LocalPlayer():GetAimVector(), CULLFRONT, 100000) then
					if LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(-25,-25,-25)) or LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(10,10,10)) then
						ents_:SetNoDraw(false)
					end
				end
				if ents_:IsPlayer() or ents_:GetClass() == "viewmodel" then       
					ents_:SetNoDraw(false)
				end
				if ents_:GetPos():Distance(LocalPlayer():GetPos()) < 100 then			
					ents_:SetNoDraw(false)		
				end
			else
				return
			end
		end
	end
end

hook.Add("Think", "cullLoop", main)
hook.Add("InitPostEntity", "initents", main)
