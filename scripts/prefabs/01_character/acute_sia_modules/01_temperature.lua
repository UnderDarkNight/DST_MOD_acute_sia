--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

acute_sia_master_postinit


耐寒但怕热

耐寒 ： 低于 35度 的时候，下降速度减半。
怕热 ： 高于 35度 的时候，上升速度加倍。

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end


    inst:ListenForEvent("acute_sia_master_postinit",function()
        


        local over_cold_temp = 0
        local over_heat_temp = inst.components.temperature.overheattemp
        local comfortable_temp = ( over_cold_temp + over_heat_temp ) / 2

        local old_DoDelta = inst.components.temperature.DoDelta
        inst.components.temperature.DoDelta = function(self, num,...)
            local current_temp = self.current
            if current_temp < comfortable_temp and num < 0 then     -- 耐寒
                num = num * 0.5
            elseif current_temp > comfortable_temp and num > 0 then  -- 怕热
                num = num * 2
            end
            return old_DoDelta(self, num,...)
        end



    end)
end