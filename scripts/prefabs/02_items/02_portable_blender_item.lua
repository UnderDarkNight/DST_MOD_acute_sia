--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local assets =
{
    Asset("ANIM", "anim/acute_sia_item_portable_blender.zip"),
    Asset( "IMAGE", "images/inventoryimages/acute_sia_item_portable_blender.tex" ), 
    Asset( "ATLAS", "images/inventoryimages/acute_sia_item_portable_blender.xml" ),
}
---------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    --inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)


    inst.AnimState:SetBank("acute_sia_item_portable_blender")
    inst.AnimState:SetBuild("acute_sia_item_portable_blender")
    inst.AnimState:PlayAnimation("idle_ground")

    inst:AddTag("usedeploystring")

    inst.entity:SetPristine()
    -------------------------------------------------------------------

    -------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end
    -------------------------------------------------------------------
        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "acute_sia_item_portable_blender"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_item_portable_blender.xml"


        MakeMediumBurnable(inst, TUNING.TINY_BURNTIME)

        inst:AddComponent("deployable")                
        inst.components.deployable.ondeploy = function(inst, pt, deployer)
            if pt and pt.x then
                SpawnPrefab("acute_sia_building_portable_blender"):PushEvent("_on_place",pt)
                inst:Remove()
                -- if deployer ~= nil and deployer.SoundEmitter ~= nil then
                --     deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
                -- end
            end
        end
        -- inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
        inst.components.deployable:SetDeployMode(DEPLOYMODE.ANYWHERE)
        inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)   
        -------------------------------------------------------------------
        --- 落水影子
            local function shadow_init(inst)
                if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
                    inst.AnimState:Hide("shadow_ground")
                else                                
                    inst.AnimState:Show("shadow_ground")
                end
            end
            inst:ListenForEvent("on_landed",shadow_init)
            shadow_init(inst)
        -------------------------------------------------------------------
    return inst
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- placer post init
local function placer_postinit_fn(inst)
    -- if inst.components.placer then
    --     inst.components.placer.override_testfn = function(inst)
    --         local x,y,z = inst.Transform:GetWorldPosition()
    --         return CanPlantAtPoint(inst,x,y,z)
    --     end
    -- end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return Prefab("acute_sia_item_portable_blender", fn, assets),
    MakePlacer("acute_sia_item_portable_blender_placer", "acute_sia_item_portable_blender", "acute_sia_item_portable_blender", "idle", nil, false, nil, nil, nil, nil, placer_postinit_fn, nil, nil)

