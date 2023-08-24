function runonce()

	if CLIENT then

		--Initialize run-once variables

		PROPS_AND_NPCS_ONLY = true
		CULLFRONT = math.sin(0.42261826) -- 150 degrees forward
		ply = LocalPlayer()
		jit.on()

		--Initialize functions
		function main() -- more optimized than think
			tAllEnts = ents.GetAll()		
			for a, e in pairs(tAllEnts) do
				e:SetNoDraw(true)
				if util.IsPointInCone(e:GetPos(), ply:GetPos(), ply:GetAimVector(), CULLFRONT, 100000) then
					e:SetNoDraw(true)
					if ply:IsLineOfSightClear(e:GetPos()) then					
						e:SetNoDraw(false)
					end
					if e:IsPlayer() then
						e:SetNoDraw(false)						
					end
				end
				if e:GetClass() == "viewmodel" and "player" and "weapon" and "info_node" then
					e:SetNoDraw(false)
				end
			end
		end

		timer.Create("pootis", 0.2, 0, main)

	end -- End of if

end -- End of runonce

hook.Add( "InitPostEntity", "init", runonce)
