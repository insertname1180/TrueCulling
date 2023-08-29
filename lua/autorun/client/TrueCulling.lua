jit.on()

CULLFRONT = math.sin(0.57357644) -- Degrees forward angle in sine
ent_ = 0
occur = 0
occur_ = 0
occur__ = 0
tl = occur - CurTime()
tl_ = occur_ - CurTime()
tl__ = occur_ - CurTime()

function main()
	if tl < 0 then
		loop = true
		while (loop) do
			if tl__ < 0 then			
				if ent_ >= ents.GetCount() * 2 then			
					ent_ = 0
				end
				ent_ = ent_ + 1
				occur__ = CurTime() + 0.75
			end
			if tl_ < 0 then
				if Entity(ent_):IsValid() then
					ents_ = Entity(ent_)
					ents_:SetNoDraw(true)
					if util.IsPointInCone(ents_:GetPos(), LocalPlayer():GetPos(), LocalPlayer():GetAimVector(), CULLFRONT, 100000) then
						if LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(-25,-25,35)) or LocalPlayer():IsLineOfSightClear(ents_:GetPos() + Vector(100,100,-10)) then                    
							ents_:SetNoDraw(false)
						end
					end
					if ents_:IsPlayer() or ents_:GetClass() == "viewmodel" then                    
						ents_:SetNoDraw(false)
					end
					if ents_:GetPos():Distance(LocalPlayer():GetPos()) < 100 then
						ents_:SetNoDraw(false)
					end
				end
				occur_ = CurTime() + 0.75
			end
			occur = CurTime() + 0.75
			if ent_ >= ents.GetCount() * 2 then
				timer.Simple(0.2, main)
				break
			end
		end
	end
end

main()
hook.Add("InitPostEntity", "initents", main)
