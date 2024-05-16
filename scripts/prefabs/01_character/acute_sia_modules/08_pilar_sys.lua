--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

acute_sia_master_postinit

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local PILAR_CD_DAYS = 2     -- 同一个目标冷却天数
    if TUNING.ACUTE_SIA_DEBUGGING_MODE then
        PILAR_CD_DAYS = 1
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 
    local function GetStringsTable(prefab_name)
        local temp_prefab = "acute_sia_com_pilfer"
        return TUNING["acute_sia.fn"].GetStringsTable(temp_prefab or prefab_name)
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 
    local all_reward_list = require("prefabs/01_character/acute_sia_modules/09_pilar_reward_list")
    local target_with_reward = all_reward_list.target_with_reward
    local function target_is_in_the_list(prefab)
        if target_with_reward[prefab] then
            return true
        end
        return false
    end
    local function get_list_by_prefab(prefab)
        local ret_list = target_with_reward[prefab]
        if type(ret_list) ~= "table" then
            return all_reward_list.default_reward_list
        end
        local current_probability = math.random(10000)/10000
        for i, temp_cmd_table in pairs(ret_list) do
            local temp_probability = temp_cmd_table.probability
            local temp_reward_list = temp_cmd_table.reward_list
            if current_probability - temp_probability <= 0 then
                return temp_reward_list
            else
                current_probability = current_probability - temp_probability
            end
        end
        return all_reward_list.default_reward_list
    end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    inst:ListenForEvent("acute_sia_event.OnEntityReplicated.acute_sia_com_pilfer", function(inst,replica_com)
        replica_com:SetTestFn(function(inst,target,right_click)
            if right_click and target_is_in_the_list(target.prefab) then
                return true
            end
            return false
        end)
        replica_com:SetPreActionFn(function(inst,target)
            
        end)
        replica_com:SetPriority(-1)
    end)
    if TheWorld.ismastersim then
        inst:AddComponent("acute_sia_com_pilfer")
        inst.components.acute_sia_com_pilfer:SetSpellFn(function(inst,target)
            -- print("pilfer",target)
            if target.components.acute_sia_com_pilfer_flag_for_target == nil then
                print("error acute_sia_com_pilfer_flag_for_target  lost")
                return false
            end
            local can_pilar_target = target.components.acute_sia_com_pilfer_flag_for_target:CanBePilarToday(PILAR_CD_DAYS)
            if not can_pilar_target then
                inst.components.talker:Say(GetStringsTable()["FAIL"])
                return true
            end
            target.components.acute_sia_com_pilfer_flag_for_target:DoPilar()
            local reward_prefab = get_list_by_prefab(target.prefab) or {}

            local ret_prefab = tostring(reward_prefab[math.random(#reward_prefab)])
            if PrefabExists(ret_prefab) then
                inst.components.talker:Say(GetStringsTable()["SUCCEED"])
                inst.components.inventory:GiveItem(SpawnPrefab(ret_prefab))
                inst:PushEvent("sia_naughty_dodelta",5)
                -- print(" info +++++ sia_naughty",TheWorld.components.kramped:Sia_GetPlayerKramp(inst))
            else
                inst.components.talker:Say(GetStringsTable()["FAIL"])
            end

            return true
        end)
    end
end