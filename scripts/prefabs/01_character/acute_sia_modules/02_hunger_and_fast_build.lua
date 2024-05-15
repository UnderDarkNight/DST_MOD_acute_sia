--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    饥饿值 和 快速制作

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end

    local FAST_BUILD_LINE = 50

    inst:ListenForEvent("hungerdelta",function(inst)
        

        local current_hunger = inst.components.hunger.current

        if current_hunger >= FAST_BUILD_LINE and not inst:HasTag("fastbuilder") then
            inst:AddTag("fastbuilder")
        elseif current_hunger < FAST_BUILD_LINE and inst:HasTag("fastbuilder") then
            inst:RemoveTag("fastbuilder")
        end
                

    end)

end