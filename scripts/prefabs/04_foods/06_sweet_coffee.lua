----------------------------------------------------------------------------------------------------------------------------------------------------
--[[



]]--
----------------------------------------------------------------------------------------------------------------------------------------------------



local assets = {
    Asset("ANIM", "anim/acute_sia_food_sweet_coffee.zip"), 
    Asset( "IMAGE", "images/inventoryimages/acute_sia_food_sweet_coffee.tex" ),  -- 背包贴图
    Asset( "ATLAS", "images/inventoryimages/acute_sia_food_sweet_coffee.xml" ),
}

local function fn()

    local inst = CreateEntity() -- 创建实体
    inst.entity:AddTransform() -- 添加xyz形变对象
    inst.entity:AddAnimState() -- 添加动画状态
    inst.entity:AddNetwork() -- 添加这一行才能让所有客户端都能看到这个实体

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("acute_sia_food_sweet_coffee") -- 地上动画
    inst.AnimState:SetBuild("acute_sia_food_sweet_coffee") -- 材质包，就是anim里的zip包
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
        inst.components.inventoryitem.imagename = "acute_sia_food_sweet_coffee"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_sweet_coffee.xml"

    -------------------------------------------------------------------
    --  
        inst:AddComponent("edible") -- 可食物组件
        inst.components.edible.foodtype = FOODTYPE.VEGGIE
        inst.components.edible:SetOnEatenFn(function(inst,eater)
            if eater and eater:HasTag("player")  then
                local buff_time = 360
                local buff_rest_time = eater.components.acute_sia_com_data:Add("acute_sia_debuff_coffee_speed_up_time",0)
                if buff_rest_time < buff_time then
                    eater.components.acute_sia_com_data:Set("acute_sia_debuff_coffee_speed_up_time",buff_time)
                end
                local debuff_prefab = "acute_sia_debuff_coffee_speed_up"
                while true do
                    local debuff_inst = eater:GetDebuff(debuff_prefab)
                    if debuff_inst and debuff_inst:IsValid() then
                        return
                    end
                    eater:AddDebuff(debuff_prefab,debuff_prefab)
                end
            end
        end)
        inst.components.edible.hungervalue = 12.5
        inst.components.edible.sanityvalue = 15
        inst.components.edible.healthvalue = 0    
    -------------------------------------------------------------------
    --- 
        inst:AddComponent("perishable") -- 可腐烂的组件
        inst.components.perishable:SetPerishTime(TUNING.PERISH_ONE_DAY*10)
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
        local function shadow_init(inst)
            if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
                -- inst.AnimState:Hide("SHADOW")
                inst.AnimState:PlayAnimation("water")
            else                                
                -- inst.AnimState:Show("SHADOW")
                inst.AnimState:PlayAnimation("idle")
            end
        end
        inst:ListenForEvent("on_landed",shadow_init)
        shadow_init(inst)
    -------------------------------------------------------------------
    
    return inst
end

return Prefab("acute_sia_food_sweet_coffee", fn, assets)