--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

acute_sia_master_postinit

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local cats = {
        ["catcoon"] = true  ,               ---- 普通浣猫
        -- ["critter_kitten"] = true  ,        ---- 宠物巢穴的猫仔
        -- ["ticoon"] = true  ,                ---- 浣猫活动的大虎

        -- ["kitcoon_marsh"] = true  ,        ---- 浣猫 活动的小猫
    }
    local kill_penalty_list = {
        ["catcoon"] = true  ,                    ---- 普通浣猫
        ["ticoon"] = true  ,                ---- 浣猫活动的大虎
    }
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- 抚摸组件
        inst:ListenForEvent("acute_sia_event.OnEntityReplicated.acute_sia_com_pet_the_cat", function(inst,replica_com)
            replica_com:SetTestFn(function(inst,target,right_click)
                -- print("test pet the cat",target)
                if cats[target.prefab] then
                    return true
                end
                return false
            end)
            replica_com:SetPreActionFn(function(inst,target)
                -- print("pre action pet the cat",target)
            end)

        end)
        if TheWorld.ismastersim then
            inst:AddComponent("acute_sia_com_pet_the_cat")
            inst.components.acute_sia_com_pet_the_cat:SetSpellFn(function(inst,target)
                local cat_prefab = target.prefab
                local last_day = inst.components.acute_sia_com_pet_the_cat:Get(cat_prefab)
                local sanity_delta = 1
                if last_day ~= TheWorld.state.cycles then
                    sanity_delta = 50
                    inst.components.acute_sia_com_pet_the_cat:Set(cat_prefab,TheWorld.state.cycles)
                end
                inst.components.sanity:DoDelta(sanity_delta)
                return true
            end)
        end
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- 官方组件的 回调event
        if TheWorld.ismastersim then            
            inst:ListenForEvent("sia_petted_kitcoon", function(inst,the_cat)
                inst.components.acute_sia_com_pet_the_cat:CastSpell(the_cat)
            end)
        end
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- 击杀浣猫的惩罚
        if TheWorld.ismastersim then
            inst:ListenForEvent("killed", function(inst,_table)
                local target = _table and _table.victim or { prefab = "test"}
                if kill_penalty_list[target.prefab] then
                   inst.components.sanity.current = 0
                   inst.components.sanity:DoDelta(-1)
                end
            end)
        end
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------



end