--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

			health_delta, hunger_delta, sanity_delta = self.custom_stats_mod_fn(self.inst, health_delta, hunger_delta, sanity_delta, food, feeder)


]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end
    inst:ListenForEvent("acute_sia_master_postinit",function()
        



        inst.components.eater.custom_stats_mod_fn = function(inst, health_delta, hunger_delta, sanity_delta, food, feeder)
            -- print("eater  custom:",food)
            -- if food:HasTag("green_raisins") then
            if food and food.prefab == "acute_sia_food_green_raisins" then
                health_delta = health_delta + 10    --- 提子额外回复多
            end
            return health_delta, hunger_delta, sanity_delta
        end



    end)
end