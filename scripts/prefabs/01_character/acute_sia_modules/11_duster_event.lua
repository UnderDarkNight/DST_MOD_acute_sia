--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

acute_sia_master_postinit

fastpicker

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end


    ----------------------------------------------------------------------------
    --- 
        
    ----------------------------------------------------------------------------
    ---- 
        local duster_equipping_task = nil
        local weapon_duster = nil
        local function on_equip_task_fn(inst,weapon)
            if weapon_duster:HasTag("aoe") then
                inst:AddTag("fastpicker")
                inst.components.hunger.burnratemodifiers:SetModifier(inst,TUNING.ACUTE_SIA_DEBUGGING_MODE and 20 or 2)
            else
                inst:RemoveTag("fastpicker")
                inst.components.hunger.burnratemodifiers:RemoveModifier(inst)
            end
        end
        inst:ListenForEvent("sia_equip_duster",function(inst,weapon)
            weapon_duster = weapon
            on_equip_task_fn(inst,weapon)
            duster_equipping_task = inst:DoPeriodicTask(1,function()
                on_equip_task_fn(inst,weapon)
            end)
        end)
        inst:ListenForEvent("sia_unequip_duster",function(inst)
            if duster_equipping_task then
                duster_equipping_task:Cancel()
                duster_equipping_task = nil
            end
            weapon_duster = nil
            inst:RemoveTag("fastpicker")
        end)
    ----------------------------------------------------------------------------
    --- AOE 事件
        local musthavetags = { "_combat" }
        local canthavetags = {"INLIMBO", "notarget", "noattack", "flight", "invisible", "wall", "player", "companion"}
        local musthaveoneoftags = nil
        local range = 3
        if TUNING.ACUTE_SIA_DEBUGGING_MODE then
            range = 10
        end
        inst:ListenForEvent("sia_duster_on_attack",function(inst,target)
            local weapon = inst.components.combat:GetWeapon() or {}
            if not weapon:HasTag("acute_sia_weapon_duster") then
                return
            end

            if weapon:HasTag("aoe_doing") then
                return
            end            
            weapon:AddTag("aoe_doing")

            local x,y,z = target.Transform:GetWorldPosition()
            local ents = TheSim:FindEntities(x, y, z, range, musthavetags, canthavetags, musthaveoneoftags)
            for _,temp_target in pairs(ents) do
                if temp_target and temp_target:IsValid() and temp_target ~= target and target.components.combat then
                    inst.components.combat:DoAttack(temp_target,weapon)
                end
            end            
            weapon:RemoveTag("aoe_doing")
        end)
    ----------------------------------------------------------------------------








end