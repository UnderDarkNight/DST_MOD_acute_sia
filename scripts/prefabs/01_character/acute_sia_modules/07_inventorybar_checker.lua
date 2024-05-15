--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

acute_sia_master_postinit

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- item checker
    ----------------------------------------------------------------
    --- 装备检查
        local function CheckIsEquipment(item)
            if item.components.equippable then
                return true
            end
            return false
        end
    ----------------------------------------------------------------
    --- 食物组件
        local special_food_list = {
            ["wetgoop"] = true,  -- 潮湿的糊糊
            ["spoiled_food"] = true,  -- 腐烂的食物
        }
        local function CheckIsFood(item,player)
            if special_food_list[item.prefab] then
                return false
            end
            if player and player.components.eater and not player.components.eater:PrefersToEat(item) then
                return false
            end
            if item.components.edible then
                return true
            end
            return false
        end
    ----------------------------------------------------------------
    --- 排序检查  1-5 装备， 6-10 食物， 11-15 其他
        local function need_to_warning(slot,item,player)
            if slot <= 5 then
                if CheckIsEquipment(item) then
                    -- print("is equipment",slot,item)
                    return false
                else
                    -- print("is not equipment",slot,item)
                    return true
                end
            elseif slot <= 10 then
                if CheckIsFood(item,player) then
                    -- print("is food",slot,item)
                    return false
                else
                    -- print("is not food",slot,item)
                    return true
                end
            else
                if not CheckIsEquipment(item) and not CheckIsFood(item,player) then
                    -- print("is other",slot,item)
                    return false
                else
                    -- print("is not other",slot,item)
                    return true
                end
            end 
        end
    ----------------------------------------------------------------
    --- 检查单个格子

    ----------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 
    -- local check_lock = nil
    local function CheckStart(inst)
        --------------------------------------------------------------------------------------------------------------
        ---- 
            local slots = inst.components.inventory.itemslots or {}
            inst.components.inventory.itemslots_warning = inst.components.inventory.itemslots_warning or {}
            local max_slots = inst.components.inventory:GetNumSlots()
        --------------------------------------------------------------------------------------------------------------
        ---- 
            local function check_single_slot(num,item)
                if need_to_warning(num,item,inst) and inst.components.inventory.itemslots_warning[num] ~= true then
                    inst.components.inventory.itemslots_warning[num] = true
                    ---- PushEvent
                    inst.components.acute_sia_com_rpc_event:PushEvent("client_side_inventorybar_warning",{
                        num = num,
                        show = true,
                    })
                    return
                end
                if inst.components.inventory.itemslots_warning[num] and not need_to_warning(num,item,inst) then
                    inst.components.inventory.itemslots_warning[num] = false
                    ---- PushEvent
                    inst.components.acute_sia_com_rpc_event:PushEvent("client_side_inventorybar_warning",{
                        num = num,
                        show = false,
                    })
                    return
                end
            end
        --------------------------------------------------------------------------------------------------------------
        ---- 
            for i = 1, max_slots, 1 do
                local item = slots[i]
                if item and item:IsValid() then
                    --------------------------------------------------------------------------------------------------------------
                    ----
                        check_single_slot(i,item)
                    --------------------------------------------------------------------------------------------------------------
                else
                    --------------------------------------------------------------------------------------------------------------
                    ---- 空位置清除警告
                        if inst.components.inventory.itemslots_warning[i] then
                            inst.components.inventory.itemslots_warning[i] = false
                            ---- PushEvent
                            inst.components.acute_sia_com_rpc_event:PushEvent("client_side_inventorybar_warning",{
                                num = i,
                                show = false,
                            })
                        end
                    --------------------------------------------------------------------------------------------------------------    
                end
            end
        --------------------------------------------------------------------------------------------------------------
        ----
            inst:PushEvent("kramped_and_obsessive_refresh")
        --------------------------------------------------------------------------------------------------------------
    end

    local function ForceCheckStart(inst)
        inst.components.inventory.itemslots_warning = {}
        CheckStart(inst)
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end
    ------------------------------------------------------------------------------------------------------------------------------------
    --- 添加 监听
        inst:DoTaskInTime(0,function()
            --------------------------------------------------------------------------
            --- 添加 监听
                local need_2_listen_events = {
                    ["itemget"] = true,
                    ["itemlose"] = true,
                    ["dropitem"] = true,
                    ["gotnewitem"] = true,
                    ["newactiveitem"] = true,
                    ["unequip"] = true,
                    ["equip"] = true,
                    -- ["acute_sia_inventorybar_update"] = true,
                }
                for event, v in pairs(need_2_listen_events) do
                    inst:ListenForEvent(event,CheckStart)
                end
                CheckStart(inst)
            --------------------------------------------------------------------------
        end)
    ------------------------------------------------------------------------------------------------------------------------------------
    --- 客户端界面安装完成
        inst:ListenForEvent("inventorybar_icon_change_finish",ForceCheckStart)
    ------------------------------------------------------------------------------------------------------------------------------------
end