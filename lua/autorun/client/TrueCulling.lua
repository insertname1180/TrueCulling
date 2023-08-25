function runonce()

	if CLIENT then

		CULLFRONT = math.sin(0.42261826) -- 150 Degrees forward		
		ply = LocalPlayer()
		jit.on()

		hook.Remove("InitPostEntity", "runonce")

		function init()
			tAllEnts = ents.GetAll()
			for a, e in pairs(tAllEnts) do
				e:SetNoDraw(true)	
				if util.IsPointInCone(e:GetPos(), ply:GetPos(), ply:GetAimVector(), CULLFRONT, 100000) then
					if ply:IsLineOfSightClear(e:GetPos()) then					
						e:SetNoDraw(false)
					end
				end
				if e:IsPlayer() or e:GetClass() == "viewmodel" then					
					e:SetNoDraw(false)
				end
			end
			timer.Simple(0.5, init)
		end

		coroutine.create(init)

		init()

	end

end

hook.Add("InitPostEntity", "runonce", runonce)
