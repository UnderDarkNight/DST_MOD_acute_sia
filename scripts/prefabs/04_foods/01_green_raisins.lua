----------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    青色提子

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------



local assets = {
    Asset("ANIM", "anim/acute_sia_food_green_raisins.zip"), 
    Asset( "IMAGE", "images/inventoryimages/acute_sia_food_green_raisins.tex" ),
    Asset( "ATLAS", "images/inventoryimages/acute_sia_food_green_raisins.xml" ),
    Asset( "IMAGE", "images/inventoryimages/acute_sia_food_green_raisins_rot.tex" ),
    Asset( "ATLAS", "images/inventoryimages/acute_sia_food_green_raisins_rot.xml" ),
    Asset( "IMAGE", "images/inventoryimages/acute_sia_food_green_raisins_cooked.tex" ),
    Asset( "ATLAS", "images/inventoryimages/acute_sia_food_green_raisins_cooked.xml" ),
}

local function common_fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("acute_sia_food_green_raisins")
    inst.AnimState:SetBuild("acute_sia_food_green_raisins")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst)

    inst:AddTag("cookable")
    inst:AddTag("green_raisins")

    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end
    --------------------------------------------------------------------------
    ------ 物品名 和检查文本
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- -- inst.components.inventoryitem:ChangeImageName("leafymeatburger")
    inst.components.inventoryitem.imagename = "acute_sia_food_green_raisins"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_green_raisins.xml"

    --------------------------------------------------------------------------
    -- 
        inst:AddComponent("cookable")
        inst.components.cookable.product = "acute_sia_food_green_raisins_cooked"
    --------------------------------------------------------------------------


    inst:AddComponent("edible") -- 可食物组件
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible.secondaryfoodtype = FOODTYPE.BERRY
    inst.components.edible:SetOnEatenFn(function(inst,eater)
    end)
    inst.components.edible.hungervalue = 9.4
    inst.components.edible.sanityvalue = 5
    inst.components.edible.healthvalue = 3

    inst:AddComponent("stackable") -- 可堆叠
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("tradable")

    MakeHauntableLaunch(inst)
    -------------------------------------------------------------------
    -- 
        inst:AddComponent("acute_sia_com_data")
    -------------------------------------------------------------------
    --- 
        inst:AddComponent("perishable") -- 可腐烂的组件
        inst.components.perishable:SetPerishTime(TUNING.PERISH_ONE_DAY)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food" -- 腐烂后变成腐烂食物
    -------------------------------------------------------------------
    --- 靠新鲜度 切换图标
        inst:ListenForEvent("perishchange", function(inst)
            if inst:HasTag("spoiled") then
                inst.components.inventoryitem.imagename = "acute_sia_food_green_raisins_rot"
                inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_green_raisins_rot.xml"
                inst.components.acute_sia_com_data:Set("spoiled",true)
                inst.AnimState:PlayAnimation("rot")
                inst:PushEvent("imagechange")
            else
                inst.components.inventoryitem.imagename = "acute_sia_food_green_raisins"
                inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_green_raisins.xml"
                inst.components.acute_sia_com_data:Set("spoiled",false)
                inst.AnimState:PlayAnimation("idle")
                inst:PushEvent("imagechange")
            end
        end)
        inst.components.acute_sia_com_data:AddOnLoadFn(function()
            if inst.components.acute_sia_com_data:Get("spoiled") then
                inst.components.inventoryitem.imagename = "acute_sia_food_green_raisins_rot"
                inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_green_raisins_rot.xml"
                inst.AnimState:PlayAnimation("rot")
                inst:PushEvent("imagechange")
            else
                inst.components.inventoryitem.imagename = "acute_sia_food_green_raisins"
                inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_green_raisins.xml"
                inst.AnimState:PlayAnimation("idle")
                inst:PushEvent("imagechange")
            end
        end)
    -------------------------------------------------------------------
    
    return inst
end
local function common_cooked_fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("acute_sia_food_green_raisins")
    inst.AnimState:SetBuild("acute_sia_food_green_raisins")
    inst.AnimState:PlayAnimation("cooked")
    MakeInventoryFloatable(inst)

    inst:AddTag("green_raisins")

    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end
    --------------------------------------------------------------------------
    ------ 物品名 和检查文本
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- -- inst.components.inventoryitem:ChangeImageName("leafymeatburger")
    inst.components.inventoryitem.imagename = "acute_sia_food_green_raisins_cooked"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_green_raisins_cooked.xml"

    --------------------------------------------------------------------------


    inst:AddComponent("edible") -- 可食物组件
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible.secondaryfoodtype = FOODTYPE.BERRY
    inst.components.edible:SetOnEatenFn(function(inst,eater)
    end)
    inst.components.edible.hungervalue = 12.5
    inst.components.edible.sanityvalue = 0
    inst.components.edible.healthvalue = 5

    inst:AddComponent("stackable") -- 可堆叠
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("tradable")

    MakeHauntableLaunch(inst)
    -------------------------------------------------------------------
    -- 
        inst:AddComponent("acute_sia_com_data")
    -------------------------------------------------------------------
    --- 
        inst:AddComponent("perishable") -- 可腐烂的组件
        inst.components.perishable:SetPerishTime(TUNING.PERISH_ONE_DAY)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food" -- 腐烂后变成腐烂食物
    -------------------------------------------------------------------

    -------------------------------------------------------------------
    
    return inst
end


--- 设置可以放烹饪锅里
AddIngredientValues({"acute_sia_food_green_raisins"}, { 
    fruit = 0.5,
},true)


return Prefab("acute_sia_food_green_raisins", common_fn, assets),
    Prefab("acute_sia_food_green_raisins_cooked", common_cooked_fn, assets)