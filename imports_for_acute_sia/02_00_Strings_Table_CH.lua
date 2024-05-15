if TUNING["acute_sia.Strings"] == nil then
    TUNING["acute_sia.Strings"] = {}
end

local this_language = "ch"
-- if TUNING["acute_sia.Language"] then
--     if type(TUNING["acute_sia.Language"]) == "function" and TUNING["acute_sia.Language"]() ~= this_language then
--         return
--     elseif type(TUNING["acute_sia.Language"]) == "string" and TUNING["acute_sia.Language"] ~= this_language then
--         return
--     end
-- end

--------- 默认加载中文文本，如果其他语言的文本缺失，直接调取 中文文本。 03_TUNING_Common_Func.lua
--------------------------------------------------------------------------------------------------
--- 默认显示名字:  name
--- 默认显示描述:  inspect_str
--- 默认制作栏描述: recipe_desc
--------------------------------------------------------------------------------------------------
TUNING["acute_sia.Strings"][this_language] = TUNING["acute_sia.Strings"][this_language] or {
        --------------------------------------------------------------------
        --- 正在debug 测试的
            ["acute_sia_skin_test_item"] = {
                ["name"] = "皮肤测试物品",
                ["inspect_str"] = "inspect单纯的测试皮肤",
                ["recipe_desc"] = "测试描述666",
            },
        --------------------------------------------------------------------
        --- 组件动作
            ["acute_sia_com_pet_the_cat"] = {
                ["NONE"] = STRINGS.ACTIONS.PET,
            },
            ["acute_sia_com_pilfer"] = {
                ["NONE"] = "顺手牵羊",
                ["SUCCEED"] = "看我顺手牵羊~",
                ["FAIL"] = "这地方空空如也",
            },
        --------------------------------------------------------------------
}

