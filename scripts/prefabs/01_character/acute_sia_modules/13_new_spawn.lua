--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

acute_sia_master_postinit

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end

    inst:DoTaskInTime(0, function()
        if not inst.components.acute_sia_com_data:Get("new_spawn_gift") then            
            inst.components.acute_sia_com_data:Set("new_spawn_gift", true)
            inst.components.inventory:GiveItem(SpawnPrefab("acute_sia_weapon_duster"))
        end

    end)
end