function runonce()

	if CLIENT then

		--Initialize run-once variables

		CULLFRONT = math.sin(0.42261826) -- 150 degrees forward
		ply = LocalPlayer()
		jit.on()

		-- Remove hook as we no longer need it

		hook.Remove("InitPostEntity", "init")		
			
		--Initialize functions
	
		function main() -- more optimized than think
			tAllEnts = ents.GetAll()
			for a, e in ipairs(tAllEnts) do
				e:SetNoDraw(true)
				if util.IsPointInCone(e:GetPos(), ply:GetPos(), ply:GetAimVector(), CULLFRONT, 100000) then
					if ply:IsLineOfSightClear(e:GetPos()) then
						e:SetNoDraw(false)
					end
				end
				if e:IsPlayer() then
					e:SetNoDraw(false)
				end
				if e:GetClass() == "viewmodel" and "weapon" and "info_node" then
					e:SetNoDraw(false)
				end
			end
			timer.Simple(0.2, main)
		end

		-- Initialize coroutines
		coroutine.create(main)
		
		main()
		
	end -- End of if

end -- End of runonce

hook.Add( "InitPostEntity", "init", runonce)
