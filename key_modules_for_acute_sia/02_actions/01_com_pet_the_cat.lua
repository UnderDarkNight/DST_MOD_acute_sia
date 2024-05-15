------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[



]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
    local function GetStringsTable(prefab_name)
        local temp_prefab = "acute_sia_com_pet_the_cat"
        return TUNING["acute_sia.fn"].GetStringsTable(temp_prefab or prefab_name)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local PET_THE_CAT_COM_ACTION = Action({mount_valid = false,priority = 10})
PET_THE_CAT_COM_ACTION.id = "PET_THE_CAT_COM_ACTION"
PET_THE_CAT_COM_ACTION.strfn = function(act)
    return "NONE"
end

PET_THE_CAT_COM_ACTION.fn = function(act)
    -- local item = act.invobject
    local target = act.target
    local doer = act.doer
    local replica_com = doer.replica.acute_sia_com_pet_the_cat or doer.replica._.acute_sia_com_pet_the_cat
    if replica_com and replica_com:Test(target,true) then
       return  doer.components.acute_sia_com_pet_the_cat:CastSpell(target)
    end
    return true
end
AddAction(PET_THE_CAT_COM_ACTION)


AddComponentAction("SCENE", "inspectable" , function(target, doer, actions, right_click)   ---- 这个会在 client 上执行
    -- print("pet the cat",doer, target)
    if target and target ~= doer then
        local replica_com = doer.replica.acute_sia_com_pet_the_cat or doer.replica._.acute_sia_com_pet_the_cat
        -- print("6666",replica_com,target,doer)
        if replica_com and replica_com:Test(target,right_click) then
            table.insert(actions, ACTIONS.PET_THE_CAT_COM_ACTION)
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
            local replica_com = doer.replica.acute_sia_com_pet_the_cat or doer.replica._.acute_sia_com_pet_the_cat
            if replica_com then
               replica_com:DoPreAction(target)
               return replica_com:GetSGAction()
            end
        end
    end)
    return "dolongaction"
end

AddStategraphActionHandler("wilson",ActionHandler(PET_THE_CAT_COM_ACTION,function(inst)
    return action_handler_fn(inst)
    -- return "dojostleaction"
end))
AddStategraphActionHandler("wilson_client",ActionHandler(PET_THE_CAT_COM_ACTION, function(inst)
    return action_handler_fn(inst)
    -- return "dojostleaction"
end))

STRINGS.ACTIONS.PET_THE_CAT_COM_ACTION = {
    ["NONE"] = GetStringsTable()["NONE"] or "抚摸",
}
