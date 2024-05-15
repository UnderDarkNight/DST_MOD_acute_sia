--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

acute_sia_master_postinit

inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED   -- 使用高礼帽的 恢复光环

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end

    ----------------------------------------------------------------------------------------------------------------------------------
    --- 生成/获取物品挂载物品
        local function Get_Beard_Container()
            local current_item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BEARD)
            if current_item == nil or not current_item:IsValid() then
                current_item = SpawnPrefab("acute_sia_other_beard_container")
                inst.components.inventory:Equip(current_item)
            end
            return current_item
        end
        
    ----------------------------------------------------------------------------------------------------------------------------------
    --- 强迫症
        local function obsessive_active()
            inst.components.inventory.itemslots_warning = inst.components.inventory.itemslots_warning or {}
            local max_slots = inst.components.inventory:GetNumSlots()
            local active_flag = false
            for i = 1,max_slots, 1 do
                if inst.components.inventory.itemslots_warning[i] == true then
                    active_flag = true
                    break
                end
            end
            return active_flag
        end
    ----------------------------------------------------------------------------------------------------------------------------------
    --- 执行刷新
        local DAPPERNESS_DELTA_NUM = TUNING.DAPPERNESS_MED
        if TUNING.ACUTE_SIA_DEBUGGING_MODE then
            DAPPERNESS_DELTA_NUM = 0
        end
        local function refresh_dapperness()
            local item = Get_Beard_Container()
            local tar_dapperness = 0
            -------------------------------------------------------------------------------------
            --- 淘气值部分
                local player_kramp =  TheWorld.components.kramped:Sia_GetPlayerKramp(inst)
                if player_kramp > 0 then
                    tar_dapperness = tar_dapperness + DAPPERNESS_DELTA_NUM
                else
                    tar_dapperness = 0
                end
            -------------------------------------------------------------------------------------
            --- 强迫症检查
                if obsessive_active() then
                    tar_dapperness = tar_dapperness - DAPPERNESS_DELTA_NUM
                end
            -------------------------------------------------------------------------------------
            --- 最终刷新
                if item.components.equippable.dapperness ~= tar_dapperness then
                    item.components.equippable.dapperness = tar_dapperness
                    if tar_dapperness == 0 then
                        print("淘气值光环关闭")
                    else
                        print("淘气值光环开启")
                    end
                end
            -------------------------------------------------------------------------------------
        end
    ----------------------------------------------------------------------------------------------------------------------------------
    inst:DoTaskInTime(0,refresh_dapperness)
    inst:DoPeriodicTask(10,refresh_dapperness)
    inst:ListenForEvent("kramped_and_obsessive_refresh",refresh_dapperness)
    inst:ListenForEvent("killed",refresh_dapperness)

end