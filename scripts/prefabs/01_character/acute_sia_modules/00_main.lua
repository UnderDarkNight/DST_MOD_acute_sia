--------------------------------------------------------------------------------------------------------------------------------------------------
---- 模块总入口，使用 common_postinit 进行嵌入初始化，注意 mastersim 区分
--------------------------------------------------------------------------------------------------------------------------------------------------
return function(inst)

    if TheWorld.ismastersim then
        inst:AddComponent("acute_sia_com_rpc_event")
    end


    local modules = {
        "prefabs/01_character/acute_sia_modules/01_temperature",                             ---- 体温处理
        "prefabs/01_character/acute_sia_modules/02_hunger_and_fast_build",                   ---- 饥饿值和快速制作
        "prefabs/01_character/acute_sia_modules/03_walk_spee_mult",                          ---- 制作速度
        "prefabs/01_character/acute_sia_modules/04_pet_the_cat",                             ---- 抚摸猫相关的组件
        "prefabs/01_character/acute_sia_modules/05_kramped_and_obsessive",                   ---- 淘气值/强迫症和回San光环
        "prefabs/01_character/acute_sia_modules/06_inventorybar_icon_change",                ---- 物品栏图标修改
        "prefabs/01_character/acute_sia_modules/07_inventorybar_checker",                    ---- 物品栏检查器
        "prefabs/01_character/acute_sia_modules/08_pilar_sys",                               ---- 顺手牵羊 系统
        "prefabs/01_character/acute_sia_modules/10_naughty_event",                           ---- 淘气值系统
        "prefabs/01_character/acute_sia_modules/11_duster_event",                            ---- 羽毛扫 相关event

    }
    
    for k, lua_addr in pairs(modules) do
        local temp_fn = require(lua_addr)
        if type(temp_fn) == "function" then
            temp_fn(inst)
        end
    end


    inst:AddTag("acute_sia")


    if not TheWorld.ismastersim then
        return
    end



end