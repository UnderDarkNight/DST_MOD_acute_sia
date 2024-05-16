local assets =
{
    
}

NAUGHTY_VALUE["acute_sia_naughty_target"] = 100

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()


    inst.AnimState:SetBank("cane")
    inst.AnimState:SetBuild("swap_cane")
    inst.AnimState:PlayAnimation("idle")


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(1)
    inst:AddComponent("combat")
    inst:AddComponent("inspectable")

    inst:ListenForEvent("Set",function(_,_table)
        local num = _table.num or 0
        NAUGHTY_VALUE[inst.prefab] = num
        local player = _table.player 

        if player == nil then
            inst:Remove()
            return
        end
        if player.components.playercontroller == nil then
            inst:Remove()
            return
        end
        inst.components.combat:GetAttacked(player,100)
    end)

    return inst
end

return Prefab("acute_sia_naughty_target", fn, assets)
