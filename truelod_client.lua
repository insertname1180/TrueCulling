function runonce()

	if CLIENT then

		--Initialize run-once variables
		PROPS_AND_NPCS_ONLY = true
		CULLFRONT = math.sin(0) --180deg   
		sEntClass = ""
		jit.on()

		--Initialize functions

		function mainloop()
			timer.Create("loop", 0.2, 0, main)
		end

		function loadvarinfunc()
			ply = LocalPlayer()
			vPlyDir = ply:GetAimVector()
			vPlyPos = ply:GetPos()
		end
		
		function main() -- more optimized than think
			tAllEnts = ents.GetAll()
			for a, e in ipairs(tAllEnts) do
				loadvarinfunc()
				vEntPos = e:GetPos() -- Get its position...
				e:SetNoDraw(true)
				if e:GetClass() == "viewmodel" and "player" and "weapon" and "info_node" then
					e:SetNoDraw(false)
				end
				if util.IsPointInCone(vEntPos, vPlyPos, vPlyDir, CULLFRONT, 100000) then
					e:SetNoDraw(true)
					if ply:IsLineOfSightClear(vEntPos) then
						e:SetNoDraw(false)
					end
				end
			end
		end

		function threading()
			coroutine.create(loadvarinfunc)
			coroutine.create(main)
			coroutine.create(mainloop)		
		end

		-- threading
		threading()
		mainloop()

	end -- End of if

end -- End of runonce

hook.Add( "InitPostEntity", "MapStartTrigger", runonce)
