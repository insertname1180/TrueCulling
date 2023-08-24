if CLIENT then

    CULLFRONT = math.sin(0.42261826)
    jit.on()

    hook.Add( "InitPostEntity", "init", init)

    function init()
        ply = LocalPlayer()
    end

    hook.Remove("InitPostEntity", "init")

    function main() -- more optimized than think        
        init()    
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
    end -- End of main

    main()

end
