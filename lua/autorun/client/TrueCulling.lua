jit.on()

CULLFRONT = math.sin(0.42261826) -- 150 Degrees forward

function init()
    hook.Remove("InitPostEntity", "runonce")
    ply = LocalPlayer()
    entList = ents.GetAll()
    for a, e in ipairs(entList) do
        if engine.TickCount()%2 == 0 then
            if e:IsValid() then
                if engine.TickCount()%33 == 0 then
                    if e:IsPlayer() or e:GetClass() == "viewmodel" then
                        e:SetNoDraw(false)
                    else
                        if engine.TickCount()%33 == 0 then
                            if util.IsPointInCone(e:GetPos(), ply:GetPos(), ply:GetAimVector(), CULLFRONT, 100000) or ply:IsLineOfSightClear(e:GetPos()) then
                                e:SetNoDraw(false)
                            else
                                e:SetNoDraw(true)
                            end
                        else
                            return
                        end
                    end
                else
                    return
                end
            end
        else
            return
        end
    end
end

coroutine.create(init)

hook.Add("Think", "tick", init)
hook.Add("InitPostEntity", "runonce", init)
