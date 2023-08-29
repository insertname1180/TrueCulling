jit.on()
jit.opt.start(3)

CULLFRONT = math.sin(0.64278761) -- Degrees forward angle in sine
num = 0
ent_ = 0

function main()
	loop = true
	while (loop) do
		if ent_ >= ents.GetCount() * 2 then			
			ent_ = 0
		end
		ent_ = ent_ + 1
		if Entity(ent_):IsValid() then
			ents_ = Entity(ent_)
			ents_:SetNoDraw(true)
			if util.IsPointInCone(ents_:GetPos(), LocalPlayer():GetPos(), LocalPlayer():GetAimVector(), CULLFRONT, 100000) then       
				if LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(-25,-25,35)) or LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(100,100,-10)) then                    
					ents_:SetNoDraw(false)
				end
			end
			if ents_:GetPos():Distance(LocalPlayer():GetPos()) < 100 then
				ents_:SetNoDraw(false)
			end
			if ents_:IsPlayer() or ents_:GetClass() == "viewmodel" then                    
				ents_:SetNoDraw(false)
			end
		end
		if ent_ >= ents.GetCount() * 2 then
			break 
		end
	end
	timer.Simple(0.1, main)
end

main()
hook.Add("InitPostEntity", "initents", main)
