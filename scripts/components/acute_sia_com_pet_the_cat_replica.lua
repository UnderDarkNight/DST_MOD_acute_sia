--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    local acute_sia_com_pet_the_cat = Class(function(self, inst)
        self.inst = inst
    end)
------------------------------------------------------------------------------------------------------------------------------
--
    function acute_sia_com_pet_the_cat:SetTestFn(fn)
        if type(fn) == "function" then
            self.test_fn = fn
        end
    end
    function acute_sia_com_pet_the_cat:Test(target,right_click)
        if self.inst.replica.rider and self.inst.replica.rider:IsRiding() then
            return false
        end
        if target.replica.combat then
            local attacking_target = target.replica.combat:GetTarget()
            if attacking_target and attacking_target:IsValid() then
                return false
            end
        end
        if self.test_fn then
            return self.test_fn(self.inst,target,right_click)
        end
        return false
    end
------------------------------------------------------------------------------------------------------------------------------
--
    function acute_sia_com_pet_the_cat:SetPreActionFn(fn)
        if type(fn) == "function" then
            self.pre_action_fn = fn
        end
    end
    function acute_sia_com_pet_the_cat:DoPreAction(target)
        if self.pre_action_fn then
            self.pre_action_fn(self.inst,target)
        end
    end
------------------------------------------------------------------------------------------------------------------------------
-- SG
    function acute_sia_com_pet_the_cat:SetSGAction(sg)
        self.sg = sg
    end
    function acute_sia_com_pet_the_cat:GetSGAction()
        return self.sg or "dolongaction"
    end
------------------------------------------------------------------------------------------------------------------------------

return acute_sia_com_pet_the_cat







