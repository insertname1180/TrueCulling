jit.on()

CULLFRONT = math.sin(0.57357644) -- Degrees forward angle in sine

function main()		
	ent_ = 0
	while (ent_ ~= ents.GetCount() * 2) do
		ent_ = ent_ + 1
		if Entity(ent_):IsValid() then
			ents_ = Entity(ent_)
			if engine.TickCount()%45 == 0 then
				ents_:SetNoDraw(true)
			end
			if ents_:GetNoDraw(true) then
				if util.IsPointInCone(ents_:GetPos(), LocalPlayer():GetPos(), LocalPlayer():GetAimVector(), CULLFRONT, 100000) then
					if LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(-25,-25,35)) or LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(100,100,-10)) then                    
						ents_:SetNoDraw(false)
					end
				end
			end
			if ents_:IsPlayer() or ents_:GetClass() == "viewmodel" then                    
				ents_:SetNoDraw(false)
			end
			if ents_:GetPos():Distance(LocalPlayer():GetPos()) < 100 then
				ents_:SetNoDraw(false)
			end
		end
	end
end

hook.Add("Think", "cullLoop", main)
hook.Add("InitPostEntity", "initents", main)
