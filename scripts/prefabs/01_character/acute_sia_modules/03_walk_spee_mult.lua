--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    穴居者 ：在洞穴中的移速倍率为 1.25*。

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end

    local BASE_SPEED = 1.0
    if TheWorld:HasTag("cave") then
        BASE_SPEED = 1.25
    end

    local function onbecamehuman(inst)
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "acute_sia_speed_mod", BASE_SPEED)
    end
    local function onbecameghost(inst)
       inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "acute_sia_speed_mod")
    end

    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)


    inst:DoTaskInTime(0,function()
        if inst:HasTag("playerghost") then
            onbecameghost(inst)
        else
            onbecamehuman(inst)
        end
    end)

end