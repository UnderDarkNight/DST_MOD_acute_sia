local assets =
{
    Asset("ANIM", "anim/acute_sia_item_portable_blender.zip"),
    Asset("ANIM", "anim/acute_sia_item_portable_blender.zip"),
}

local function ChangeToItem(inst)
    local item = SpawnPrefab("acute_sia_item_portable_blender")
    item.Transform:SetPosition(inst.Transform:GetWorldPosition())
    item.AnimState:PlayAnimation("collapse")
    item.SoundEmitter:PlaySound("dontstarve/common/together/portable/blender/collapse")
end

local function onhammered(inst)--, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    if inst:HasTag("burnt") then
        inst.components.lootdropper:SpawnLootPrefab("ash")
        local fx = SpawnPrefab("collapse_small")
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        fx:SetMaterial("metal")
    else
        ChangeToItem(inst)
    end

    inst:Remove()
end

local function onhit(inst)--, worker)
    -- if not inst:HasTag("burnt") then
    --     inst.AnimState:PlayAnimation("hit")
    --     if inst.components.prototyper.on then
    --         inst.AnimState:PushAnimation("proximity_loop", true)
    --     else
    --         inst.AnimState:PushAnimation("idle", false)
    --     end
    --     inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")
    -- end
end
local function OnBurnt(inst)
    DefaultBurntStructureFn(inst)
    RemovePhysicsColliders(inst)
    SpawnPrefab("ash").Transform:SetPosition(inst.Transform:GetWorldPosition())
    if inst.components.workable ~= nil then
        inst:RemoveComponent("workable")
    end
    inst.persists = false
    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    inst:ListenForEvent("animover", ErodeAway)
    inst.AnimState:PlayAnimation("burnt_collapse")
end
---------------------------------------------------------------------------------------------------------------------------
-- 回收
    local function workable_setup(inst)
                inst:ListenForEvent("acute_sia_event.OnEntityReplicated.accute_sia_com_workable", function(inst, replica_com)
                    replica_com:SetTestFn(function(inst,doer,right_click)
                        if not right_click then
                            return false
                        end
                        if inst:HasTag("working") then  --- 正在工作
                            return false
                        end
                        if inst:HasTag("dismantlling") then -- 正在拆除
                            return false
                        end
                        return true
                    end)
                    replica_com:SetSGAction("dolongaction")
                    replica_com:SetText("acute_sia_building_portable_blender",STRINGS.ACTIONS.DISMANTLE)
                end)
                if TheWorld.ismastersim then
                    inst:AddComponent("accute_sia_com_workable")
                    inst.components.accute_sia_com_workable:SetActiveFn(function(inst,doer)
                        if inst:HasTag("working") then
                            return false
                        end
                        if inst:HasTag("burnt") then
                            return false
                        end
                        if inst:HasTag("dismantlling") then
                            return false
                        end
                        inst:AddTag("dismantlling")
                        inst.AnimState:PlayAnimation("collapse",false)
                        inst:ListenForEvent("animover", function()
                            local x,y,z = inst.Transform:GetWorldPosition()
                            inst:Remove()
                            SpawnPrefab("acute_sia_item_portable_blender").Transform:SetPosition(x,y,z)
                        end)
                        return true
                    end)
                end
    end
---------------------------------------------------------------------------------------------------------------------------
-- 物品接受  acute_sia_building_portable_blender
    local function acceptable_setup(inst)
        inst:ListenForEvent("acute_sia_event.OnEntityReplicated.acute_sia_com_acceptable", function(inst, replica_com)
            replica_com:SetSGAction("give")
            replica_com:SetText("acute_sia_building_portable_blender",STRINGS.ACTIONS.GIVEALLTOPLAYER)
            replica_com:SetTestFn(function(inst,item,doer,right_click)
                if inst:HasTag("working") then          -- 已经正在工作
                    return false
                end
                if inst:HasTag("burnt") then            -- 被烧毁
                    return false
                end
                if inst:HasTag("dismantlling") then     -- 回收
                    return false    
                end

                if item.prefab ~= "acute_sia_food_coffeebeans_cooked" then
                    return false
                end
                return true
            end)
        end)
        if TheWorld.ismastersim then
            inst:AddComponent("acute_sia_com_acceptable")
            inst.components.acute_sia_com_acceptable:SetOnAcceptFn(function(inst,item,doer)
                local item_num = item.components.stackable:StackSize() or 0
                item:Remove()
                inst:PushEvent("start_working",item_num)
                return true
            end)
        end
    end
---------------------------------------------------------------------------------------------------------------------------
--- start working event
    local function start_working_event_setup(inst)
        if not TheWorld.ismastersim then
            return
        end
        inst.__working_task = nil
        inst:ListenForEvent("start_working",function(inst,item_num)
            inst:AddTag("working")

            inst.AnimState:PlayAnimation("use",true)
            inst.components.acute_sia_com_data:Set("ret_num",item_num)
            inst.__working_task = inst:DoTaskInTime(TUNING.ACUTE_SIA_DEBUGGING_MODE and 5 or 10,function()
                if inst:HasTag("burnt") then
                    return
                end
                inst.__working_task = nil
                inst.AnimState:PlayAnimation("proximity_loop",true)
                inst:RemoveTag("working")
                local ret_num = inst.components.acute_sia_com_data:Get("ret_num")
                inst.components.acute_sia_com_data:Set("ret_num",nil)
                ---------------------------------------------------------------------------
                ---- DropItem
                    local ret_num = ret_num *2

                    -- local loot = inst.components.lootdropper:SpawnLootPrefab("acute_sia_food_coffee_powder")
                    -- local max_stack_num = loot.replica.stackable:MaxSize()

                    -- if ret_num <= max_stack_num then
                    --     loot.components.stackable:SetStackSize(ret_num)
                    --     return
                    -- end

                    while true do
                        local loot = inst.components.lootdropper:SpawnLootPrefab("acute_sia_food_coffee_powder")
                        local max_stack_num = loot.replica.stackable:MaxSize()
                        if ret_num <= max_stack_num then
                            loot.components.stackable:SetStackSize(ret_num)
                            return
                        else
                            loot.components.stackable:SetStackSize(max_stack_num)
                            ret_num = ret_num - max_stack_num
                        end
                        if ret_num <= 0 then
                            return
                        end                        
                    end

                ---------------------------------------------------------------------------
            end)
        end)
        inst:ListenForEvent("onburnt",function()
            if inst.__working_task then
                inst.__working_task:Cancel()
                inst.__working_task = nil
            end
        end)
        inst:DoTaskInTime(0,function()
            local ret_num = inst.components.acute_sia_com_data:Get("ret_num")
            if ret_num then
                inst:PushEvent("start_working",ret_num)
            end
        end)

    end
---------------------------------------------------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst:SetPhysicsRadiusOverride(.5)
    MakeObstaclePhysics(inst, inst.physicsradiusoverride)

    -- inst.MiniMapEntity:SetIcon("portableblender.png")

    inst:AddTag("structure")
    inst:AddTag("mastercookware")

    inst.AnimState:SetBank("acute_sia_item_portable_blender")
    inst.AnimState:SetBuild("acute_sia_item_portable_blender")
    -- inst.AnimState:PlayAnimation("idle")
    inst.AnimState:PlayAnimation("proximity_loop",true)

    -- inst:SetPrefabNameOverride("portableblender_item")

    inst.entity:SetPristine()
    -------------------------------------------------------------------
    ---
        if TheWorld.ismastersim then
            inst:AddComponent("acute_sia_com_data")
        end
    -------------------------------------------------------------------
    --- 收起来
        workable_setup(inst)
    -------------------------------------------------------------------
    --- 物品接受
        acceptable_setup(inst)
    -------------------------------------------------------------------
    --- 开始工作事件安装
        start_working_event_setup(inst)
    -------------------------------------------------------------------

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnWorkCallback(onhit)
    inst.components.workable:SetOnFinishCallback(onhammered)


    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    MakeMediumBurnable(inst, nil, nil, true)
    MakeSmallPropagator(inst)
    inst.components.burnable:SetFXLevel(2)
    inst.components.burnable:SetOnBurntFn(OnBurnt)


    inst.components.acute_sia_com_data:AddOnSaveFn(function()
        if inst:HasTag("burnt") then
            inst.components.acute_sia_com_data:Set("burnt", true)
        end
    end)
    inst.components.acute_sia_com_data:AddOnLoadFn(function()
        if inst.components.acute_sia_com_data:Get("burnt") then
            inst.components.burnable.onburnt(inst)
        end
    end)

    inst:ListenForEvent("_on_place",function(inst,pt)
        inst.Transform:SetPosition(pt.x,0,pt.z)
        inst.AnimState:PlayAnimation("place")
        inst.AnimState:PushAnimation("proximity_loop",true)
    end)

    return inst
end

return Prefab("acute_sia_building_portable_blender", fn, assets)
