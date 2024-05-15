--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local all_reward_list = require("prefabs/01_character/acute_sia_modules/09_pilar_reward_list") or {}
local target_with_reward = all_reward_list.target_with_reward or {}

for prefab, v in pairs(target_with_reward) do
    if type(prefab) == "string" then
        AddPrefabPostInit(
            prefab,
            function(inst)
                if not TheWorld.ismastersim then
                    return
                end

                inst:AddComponent("acute_sia_com_pilfer_flag_for_target")

                local onload_check = function()
                    inst.components.acute_sia_com_pilfer_flag_for_target:OnLoadCheck()
                end

                inst:WatchWorldState("cycles",function()
                    inst:DoTaskInTime(5,onload_check)
                end)


        end)
    end
end