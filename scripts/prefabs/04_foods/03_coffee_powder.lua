local assets =
{
    Asset("ANIM", "anim/acute_sia_food_coffee_powder.zip"),
}
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("acute_sia_food_coffee_powder")
    inst.AnimState:SetBuild("acute_sia_food_coffee_powder")
    inst.AnimState:PlayAnimation("idle")


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "acute_sia_food_coffee_powder"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_food_coffee_powder.xml"
    inst.components.inventoryitem:SetSinks(true)

    inst:AddComponent("stackable") -- 可堆叠
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_TINYITEM
    inst:AddComponent("tradable")

    MakeHauntableLaunch(inst)

    return inst
end

--- 设置可以放烹饪锅里
AddIngredientValues({"acute_sia_food_coffee_powder"}, { 
    inedible = 1,
})

return Prefab("acute_sia_food_coffee_powder", fn, assets)
