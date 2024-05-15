--------------------------------------------------------------------------------------------
------ 常用函数放 TUNING 里
--------------------------------------------------------------------------------------------
----- RPC 命名空间
TUNING["acute_sia.RPC_NAMESPACE"] = "acute_sia_RPC"


--------------------------------------------------------------------------------------------

TUNING["acute_sia.fn"] = {}
TUNING["acute_sia.fn"].GetStringsTable = function(prefab_name)
    -------- 读取文本表
    -------- 如果没有当前语言的问题，调取中文的那个过去
    -------- 节省重复调用运算处理
    if TUNING["acute_sia.fn"].GetStringsTable_last_prefab_name == prefab_name then
        return TUNING["acute_sia.fn"].GetStringsTable_last_table or {}
    end


    local LANGUAGE = "ch"
    if type(TUNING["acute_sia.Language"]) == "function" then
        LANGUAGE = TUNING["acute_sia.Language"]()
    elseif type(TUNING["acute_sia.Language"]) == "string" then
        LANGUAGE = TUNING["acute_sia.Language"]
    end
    local ret_table = prefab_name and TUNING["acute_sia.Strings"][LANGUAGE] and TUNING["acute_sia.Strings"][LANGUAGE][tostring(prefab_name)] or nil
    if ret_table == nil and prefab_name ~= nil then
        ret_table = TUNING["acute_sia.Strings"]["ch"][tostring(prefab_name)]
    end

    ret_table = ret_table or {}
    TUNING["acute_sia.fn"].GetStringsTable_last_prefab_name = prefab_name
    TUNING["acute_sia.fn"].GetStringsTable_last_table = ret_table

    return ret_table
end


--------------------------------------------------------------------------------------------
local function GetStringsTable(prefab_name)
    local temp_prefab = nil
    return TUNING["acute_sia.fn"].GetStringsTable(temp_prefab or prefab_name)
end
--------------------------------------------------------------------------------------------