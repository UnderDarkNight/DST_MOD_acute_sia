--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local acute_sia_com_pilfer = Class(function(self, inst)
    self.inst = inst

    self.priority = 0

end)
------------------------------------------------------------------------------------------------------------------------------
--
    function acute_sia_com_pilfer:SetTestFn(fn)
        if type(fn) == "function" then
            self.test_fn = fn
        end
    end
    function acute_sia_com_pilfer:Test(target,right_click)
        if self.inst.replica.rider and self.inst.replica.rider:IsRiding() then
            return false
        end
        if self.test_fn then
            return self.test_fn(self.inst,target,right_click)
        end
        return false
    end
------------------------------------------------------------------------------------------------------------------------------
--
    function acute_sia_com_pilfer:SetPreActionFn(fn)
        if type(fn) == "function" then
            self.pre_action_fn = fn
        end
    end
    function acute_sia_com_pilfer:DoPreAction(target)
        if self.pre_action_fn then
            self.pre_action_fn(self.inst,target)
        end
    end
------------------------------------------------------------------------------------------------------------------------------
-- SG
    function acute_sia_com_pilfer:SetSGAction(sg)
        self.sg = sg
    end
    function acute_sia_com_pilfer:GetSGAction()
        return self.sg or "give"
    end
------------------------------------------------------------------------------------------------------------------------------
-- 优先级
    function acute_sia_com_pilfer:SetPriority(num)
        self.priority = num
    end
    function acute_sia_com_pilfer:GetPriority()
        return self.priority
    end
------------------------------------------------------------------------------------------------------------------------------

return acute_sia_com_pilfer







