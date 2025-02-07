------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

local function OnAttached(inst,target) -- 玩家得到 debuff 的瞬间。 穿越洞穴、重新进存档 也会执行。
    inst.entity:SetParent(target.entity)
    inst.Network:SetClassifiedTarget(target)
    local player = inst.entity:GetParent()
    inst.target = target
    -----------------------------------------------------    

        player.components.locomotor:SetExternalSpeedMultiplier(inst, "acute_sia_debuff_coffee_speed_up", 1.25)
        -----------------------------------------------------
        ---- 死亡
            -- player:ListenForEvent("death",function()
            inst:ListenForEvent("ms_becameghost",function()
                inst.components.debuff:OnDetach()
            end,player)
        -----------------------------------------------------

    -----------------------------------------------------
end

local function OnDetached(inst) -- 被外部命令  inst:RemoveDebuff 移除debuff 的时候 执行
    -- local player = inst.entity:GetParent()
    local player = inst.target
    if player then
        player.components.locomotor:RemovePredictExternalSpeedMultiplier(inst, "acute_sia_debuff_coffee_speed_up")
    end
    inst:Remove()
end

local function OnUpdate(inst)
    -- local player = inst.entity:GetParent()
    local player = inst.target

    local time = player.components.acute_sia_com_data:Add("acute_sia_debuff_coffee_speed_up_time",-1)
    if time <= 0 then
        inst.components.debuff:OnDetach()
    end

end

local function ExtendDebuff(inst)
    -- inst.countdown = 3 + (inst._level:value() < CONTROL_LEVEL and EXTEND_TICKS or math.floor(TUNING.STALKER_MINDCONTROL_DURATION / FRAMES + .5))
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("CLASSIFIED")



    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff.keepondespawn = true -- 是否保持debuff 到下次登陆
    -- inst.components.debuff:SetDetachedFn(inst.Remove)
    inst.components.debuff:SetDetachedFn(OnDetached)
    -- inst.components.debuff:SetExtendedFn(ExtendDebuff)
    -- ExtendDebuff(inst)

    inst:DoPeriodicTask(1, OnUpdate, nil, TheWorld.ismastersim)  -- 定时执行任务


    return inst
end

return Prefab("acute_sia_debuff_coffee_speed_up", fn)
