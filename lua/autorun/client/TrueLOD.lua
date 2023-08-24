function runonce()

	if CLIENT then

		--Initialize run-once variables
		PROPS_AND_NPCS_ONLY = true
		CULLFRONT = math.sin(0) --180deg
		ply = LocalPlayer()		
		jit.on()

		--Initialize functions
		
		function main() -- more optimized than think
			tAllEnts = ents.GetAll()
			for a, e in ipairs(tAllEnts) do
				vEntPos = e:GetPos() -- Get its position...
				vPlyDir = ply:GetAimVector()
				vPlyPos = ply:GetPos()				
				e:SetNoDraw(true)
				if e:GetClass() == "viewmodel" and "player" and "weapon" and "info_node" then
					e:SetNoDraw(false)
				end
				if util.IsPointInCone(vEntPos, vPlyPos, vPlyDir, CULLFRONT, 100000) then
					e:SetNoDraw(true)
					if e:IsPlayer() then
						e:SetNoDraw(false)						
					end	
					if e:GetClass() == "viewmodel" and "player" and "weapon" and "info_node" then
						e:SetNoDraw(false)
					end
					if ply:IsLineOfSightClear(vEntPos) then					
						e:SetNoDraw(false)
					end
				end
			end
		end

		coroutine.create(main)

		timer.Create("loop", 0.2, 0, main)
		
	end -- End of if

end -- End of runonce

hook.Add( "InitPostEntity", "init", runonce)
