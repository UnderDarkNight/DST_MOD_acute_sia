----------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    咖啡豆

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------



local assets = {
    Asset("ANIM", "anim/acute_sia_food_coffeebeans.zip"), 
    Asset( "IMAGE", "images/inventoryimages/acute_sia_food_coffeebeans.tex" ),
    Asset( "ATLAS", "images/inventoryimages/acute_sia_food_coffeebeans.xml" ),
    Asset( "IMAGE", "images/inventoryimages/acute_sia_food_coffeebeans_cooked.tex" ),
    Asset( "ATLAS", "images/inventoryimages/acute_sia_food_coffeebeans_cooked.xml" ),

}

local function common_fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("acute_sia_food_coffeebeans")
    inst.AnimState:SetBuild("acute_sia_food_coffeebeans")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst)

    inst:AddTag("cookable")

    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end
    --------------------------------------------------------------------------
    ------ 物品名 和检查文本
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- -- inst.components.inventoryitem:ChangeImageName("leafymeatburger")
    inst.components.inventoryitem.imagename = "acute_sia_food_coffeebeans"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_coffeebeans.xml"

    --------------------------------------------------------------------------
    -- 
        inst:AddComponent("cookable")
        inst.components.cookable.product = "acute_sia_food_coffeebeans_cooked"
    --------------------------------------------------------------------------


    inst:AddComponent("edible") -- 可食物组件
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible:SetOnEatenFn(function(inst,eater)
    end)
    inst.components.edible.hungervalue = 0
    inst.components.edible.sanityvalue = -5
    inst.components.edible.healthvalue = -5

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
        inst.components.perishable:SetPerishTime(TUNING.PERISH_ONE_DAY*6)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food" -- 腐烂后变成腐烂食物
    -------------------------------------------------------------------
    
    return inst
end
local function common_cooked_fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("acute_sia_food_coffeebeans")
    inst.AnimState:SetBuild("acute_sia_food_coffeebeans")
    inst.AnimState:PlayAnimation("cooked")
    MakeInventoryFloatable(inst)


    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end
    --------------------------------------------------------------------------
    ------ 物品名 和检查文本
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    -- -- inst.components.inventoryitem:ChangeImageName("leafymeatburger")
    inst.components.inventoryitem.imagename = "acute_sia_food_coffeebeans_cooked"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_coffeebeans_cooked.xml"

    --------------------------------------------------------------------------


    inst:AddComponent("edible") -- 可食物组件
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible:SetOnEatenFn(function(inst,eater)
    end)
    inst.components.edible.hungervalue = 0
    inst.components.edible.sanityvalue = -5
    inst.components.edible.healthvalue = -5

    inst:AddComponent("stackable") -- 可堆叠
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("tradable")

    MakeHauntableLaunch(inst)
    -------------------------------------------------------------------
    -- 
        -- inst:AddComponent("acute_sia_com_data")
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


return Prefab("acute_sia_food_coffeebeans", common_fn, assets),
    Prefab("acute_sia_food_coffeebeans_cooked", common_cooked_fn, assets)