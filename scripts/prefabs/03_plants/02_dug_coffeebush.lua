--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local assets =
{
    Asset("ANIM", "anim/coffeebush.zip"),
    Asset( "IMAGE", "images/inventoryimages/acute_sia_plant_dug_coffeebush.tex" ), 
    Asset( "ATLAS", "images/inventoryimages/acute_sia_plant_dug_coffeebush.xml" ),
}
---------------------------------------------------------------------------------------------------------------------------
local function CanPlantAtPoint(inst,x,y,z)
    return TheWorld.Map:GetTileAtPoint(x,y,z) == 32
end
---------------------------------------------------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    --inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst:AddTag("deployedplant")

    inst.AnimState:SetBank("coffeebush")
    inst.AnimState:SetBuild("coffeebush")
    inst.AnimState:PlayAnimation("dropped",true)


    inst.entity:SetPristine()
    -------------------------------------------------------------------
    --- hook
        inst:DoTaskInTime(0,function()
            -- local old_CanDeploy_fn = inst.replica.inventoryitem.CanDeploy
            inst.replica.inventoryitem.CanDeploy = function(self,pt,mouseover,deployer,rot)
                -- print("CanPlantAtPoint",CanPlantAtPoint(inst,pt.x,pt.y,pt.z))
                if CanPlantAtPoint(inst,pt.x,pt.y,pt.z) then
                    return true
                end
                return false
            end
            if inst.components.deployable then
                -- local old_CanDeploy_fn
                inst.components.deployable.CanDeploy = function(self,pt,mouseover,deployer,rot)
                    if CanPlantAtPoint(inst,pt.x,pt.y,pt.z) then
                        return true
                    end
                    return false
                end
            end
        end)
    -------------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end
    -------------------------------------------------------------------
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_TINYITEM

        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "acute_sia_plant_dug_coffeebush"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_plant_dug_coffeebush.xml"

        inst:AddComponent("fuel")
        inst.components.fuel.fuelvalue = TUNING.TINY_FUEL
        MakeMediumBurnable(inst, TUNING.TINY_BURNTIME)
        inst:AddComponent("deployable")                
        inst.components.deployable.ondeploy = function(inst, pt, deployer)
            if pt and pt.x then
                SpawnPrefab("acute_sia_plant_coffeebush"):PushEvent("_OnPlanted",pt)
                inst.components.stackable:Get():Remove()
                if deployer ~= nil and deployer.SoundEmitter ~= nil then
                    deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
                end
            end            
        end
        -- inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
        inst.components.deployable:SetDeployMode(DEPLOYMODE.ANYWHERE)
        inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)   
        -------------------------------------------------------------------
        --- 落水影子
            local function shadow_init(inst)
                if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
                    -- inst.AnimState:Hide("SHADOW")
                    -- inst.AnimState:PlayAnimation("dropped_water",true)
                    inst.AnimState:PlayAnimation("dropped",true)

                else                                
                    -- inst.AnimState:Show("SHADOW")
                    inst.AnimState:PlayAnimation("dropped",true)
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

return Prefab("acute_sia_plant_dug_coffeebush", fn, assets),
    MakePlacer("acute_sia_plant_dug_coffeebush_placer", "coffeebush", "coffeebush", "idle", nil, false, nil, nil, nil, nil, placer_postinit_fn, nil, nil)

