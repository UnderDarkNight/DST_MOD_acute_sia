local assets =
{
    -- Asset("ANIM", "anim/backpack.zip"),
    -- Asset("ANIM", "anim/swap_krampus_sack.zip"),
    -- Asset("ANIM", "anim/chemist_other_beard_container.zip"),
    -- Asset( "IMAGE", "images/widget/chemist_other_beard_container_widget_bg.tex" ), 
    -- Asset( "ATLAS", "images/widget/chemist_other_beard_container_widget_bg.xml" ),
}

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("backpack1")
    inst.AnimState:SetBuild("swap_krampus_sack")
    inst.AnimState:PlayAnimation("anim")
    
    -- inst:AddTag("gestaltprotection")  -- 防止被月岛虚影打。和启迪王冠一样

    inst.entity:SetPristine()
    ----------------------------------------------------------------------------------------------------------------------------------------------
    --
    ----------------------------------------------------------------------------------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end


    inst:AddComponent("lootdropper")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem.keepondeath = true --- 死亡不掉落


    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BEARD
    inst.components.equippable:SetPreventUnequipping(true)  --- 死亡不掉落
    inst.components.equippable.dapperness = 0
    inst.components.equippable:SetOnEquip(function(_,owner)

    end)
    inst.components.equippable:SetOnUnequip(function(_,owner)

    end)
    inst.components.equippable.restrictedtag = "acute_sia"


    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    ---- 被其他MOD打掉落的时候处理
        inst:ListenForEvent("unequipped",function(_,_table)
            inst:Remove()
        end)
    -----------------------------------------------------------------------
    ---- 换角色的时候移除
        inst:ListenForEvent("equipped",function(_,_table)
            inst:ListenForEvent("ms_playerreroll",function()
                inst:Remove()
            end,_table and _table.owner)
            inst:ListenForEvent("ms_becameghost",function()
                inst:Remove()                
            end,_table and _table.owner)
        end)
    -----------------------------------------------------------------------
    ----
        inst:ListenForEvent("on_landed",inst.Remove)
        inst:ListenForEvent("ondropped",inst.Remove)
    -----------------------------------------------------------------------

    return inst
end

return Prefab("acute_sia_other_beard_container", fn, assets)
