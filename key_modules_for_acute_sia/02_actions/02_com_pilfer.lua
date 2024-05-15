------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[



]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
    -- AddComponentPostInit("inspectable", function(self)
    --     if self.inst.components.acute_sia_com_pilfer_flag_for_target == nil then
    --         self.inst:AddComponent("acute_sia_com_pilfer_flag_for_target")
    --     end
    -- end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
    local function GetStringsTable(prefab_name)
        local temp_prefab = "acute_sia_com_pilfer"
        return TUNING["acute_sia.fn"].GetStringsTable(temp_prefab or prefab_name)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local ACUTE_SIA_COM_PILFER = Action({mount_valid = false,priority = 0})
ACUTE_SIA_COM_PILFER.id = "ACUTE_SIA_COM_PILFER"
ACUTE_SIA_COM_PILFER.strfn = function(act)
    return "NONE"
end

ACUTE_SIA_COM_PILFER.fn = function(act)
    -- local item = act.invobject
    local target = act.target
    local doer = act.doer
    local replica_com = doer.replica.acute_sia_com_pilfer or doer.replica._.acute_sia_com_pilfer
    if replica_com and replica_com:Test(target,true) then
       return  doer.components.acute_sia_com_pilfer:CastSpell(target)
    end
    return true
end
AddAction(ACUTE_SIA_COM_PILFER)


local function GetAction()
    local temp_action = ACTIONS.ACUTE_SIA_COM_PILFER
    return temp_action
end

AddComponentAction("SCENE", "acute_sia_com_pilfer_flag_for_target" , function(target, doer, actions, right_click)   ---- 这个会在 client 上执行
    -- print("pet the cat",doer, target)
    if target and target ~= doer then
        local replica_com = doer.replica.acute_sia_com_pilfer or doer.replica._.acute_sia_com_pilfer
        -- print("6666",replica_com,target,doer)
        if replica_com and replica_com:Test(target,right_click) then
            local tempAction = GetAction()
            tempAction.priority = replica_com:GetPriority()
            table.insert(actions, tempAction)
        end
    end
end)


local action_handler_fn = function(inst)
    local crash_flag,crash_reason = pcall(function()
        local bufferaction = inst:GetBufferedAction()
        if bufferaction then
            local target = bufferaction.target
            local doer = inst
            local invobject = bufferaction.invobject
            local replica_com = doer.replica.acute_sia_com_pilfer or doer.replica._.acute_sia_com_pilfer
            if replica_com then
               replica_com:DoPreAction(target)
               return replica_com:GetSGAction()
            end
        end
    end)
    return "give"
end

AddStategraphActionHandler("wilson",ActionHandler(ACUTE_SIA_COM_PILFER,function(inst)
    return action_handler_fn(inst)
    -- return "dojostleaction"
end))
AddStategraphActionHandler("wilson_client",ActionHandler(ACUTE_SIA_COM_PILFER, function(inst)
    return action_handler_fn(inst)
    -- return "dojostleaction"
end))

STRINGS.ACTIONS.ACUTE_SIA_COM_PILFER = {
    ["NONE"] = GetStringsTable()["NONE"] or "顺手牵羊",
}
