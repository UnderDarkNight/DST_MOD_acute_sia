----------------------------------------------------------------------------------------------------------------------------------------------------
--[[



]]--
----------------------------------------------------------------------------------------------------------------------------------------------------



local assets = {
    Asset("ANIM", "anim/acute_sia_food_crystal_raisins.zip"), 
    Asset( "IMAGE", "images/inventoryimages/acute_sia_food_crystal_raisins.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/acute_sia_food_crystal_raisins.xml" ),
}

local function fn()

    local inst = CreateEntity() -- 创建实体
    inst.entity:AddTransform() -- 添加xyz形变对象
    inst.entity:AddAnimState() -- 添加动画状态
    inst.entity:AddNetwork() -- 添加这一行才能让所有客户端都能看到这个实体

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("acute_sia_food_crystal_raisins") -- 地上动画
    inst.AnimState:SetBuild("acute_sia_food_crystal_raisins") -- 材质包，就是anim里的zip包
    inst.AnimState:PlayAnimation("idle") -- 默认播放哪个动画

    MakeInventoryFloatable(inst)
    inst:AddTag("preparedfood")


    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end
    --------------------------------------------------------------------------
    ------ 物品名 和检查文本
        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        -- inst.components.inventoryitem:ChangeImageName("leafymeatburger")
        inst.components.inventoryitem.imagename = "acute_sia_food_crystal_raisins"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_crystal_raisins.xml"

    -------------------------------------------------------------------
    --  
        inst:AddComponent("edible") -- 可食物组件
        inst.components.edible.foodtype = FOODTYPE.VEGGIE
        inst.components.edible:SetOnEatenFn(function(inst,eater)
            if eater and eater:HasTag("player")  then

            end
        end)
        inst.components.edible.hungervalue = 25
        inst.components.edible.sanityvalue = 25
        inst.components.edible.healthvalue = 5    
    -------------------------------------------------------------------
    --- 
        inst:AddComponent("perishable") -- 可腐烂的组件
        inst.components.perishable:SetPerishTime(TUNING.PERISH_ONE_DAY*15)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food" -- 腐烂后变成腐烂食物
    -------------------------------------------------------------------
    --- 
        inst:AddComponent("stackable") -- 可堆叠
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
        inst:AddComponent("tradable")
        MakeHauntableLaunch(inst)
    -------------------------------------------------------------------
    --- 落水影子
        -- local function shadow_init(inst)
        --     if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
        --         inst.AnimState:Hide("SHADOW")
        --     else                                
        --         inst.AnimState:Show("SHADOW")
        --     end
        -- end
        -- inst:ListenForEvent("on_landed",shadow_init)
        -- shadow_init(inst)
    -------------------------------------------------------------------
    
    return inst
end

return Prefab("acute_sia_food_crystal_raisins", fn, assets)