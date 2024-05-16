--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    修改浆果丛

    berrybush   berrybush2  berrybush_juicy

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 普通浆果丛
    AddPrefabPostInit(
        "berrybush",
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
            if inst.components.pickable then
                local old_Pick = inst.components.pickable.Pick
                inst.components.pickable.Pick = function(self,worker,...)
                    if math.random(1,100) <= 50 then
                        self.product = "acute_sia_food_green_raisins"
                    else
                        self.product = "berries"
                    end
                    return old_Pick(self,worker,...)
                end
            end
    end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 三叶浆果丛
    AddPrefabPostInit(
        "berrybush2",
        function(inst)
            if not TheWorld.ismastersim then
                return
            end
            if inst.components.pickable then
                local old_Pick = inst.components.pickable.Pick
                inst.components.pickable.Pick = function(self,worker,...)
                    if math.random(1,100) <= 50 then
                        self.product = "acute_sia_food_green_raisins"
                    else
                        self.product = "berries"
                    end
                    return old_Pick(self,worker,...)
                end
            end
    end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 多汁浆果丛
    AddPrefabPostInit(
        "berrybush_juicy",
        function(inst)
            inst.AnimState:OverrideSymbol("berries","acute_sia_berrybush_juisy","berries")
            if not TheWorld.ismastersim then
                return
            end
            if inst.components.pickable then
                local old_Pick = inst.components.pickable.Pick
                inst.components.pickable.Pick = function(self,worker,...)
                    self.product = "acute_sia_food_green_raisins"
                    return old_Pick(self,worker,...)
                end
            end
    end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------