if TUNING["acute_sia.Strings"] == nil then
    TUNING["acute_sia.Strings"] = {}
end

local this_language = "en"
if TUNING["acute_sia.Language"] then
    if type(TUNING["acute_sia.Language"]) == "function" and TUNING["acute_sia.Language"]() ~= this_language then
        return
    elseif type(TUNING["acute_sia.Language"]) == "string" and TUNING["acute_sia.Language"] ~= this_language then
        return
    end
end

TUNING["acute_sia.Strings"][this_language] = TUNING["acute_sia.Strings"][this_language] or {
        --------------------------------------------------------------------
        --- 正在debug 测试的
            -- ["acute_sia_skin_test_item"] = {
            --     ["name"] = "en皮肤测试物品",
            --     ["inspect_str"] = "en inspect单纯的测试皮肤",
            --     ["recipe_desc"] = " en 测试描述666",
            -- },        
        --------------------------------------------------------------------        
        --- 组件动作
            ["acute_sia_com_pet_the_cat"] = {
                ["NONE"] = STRINGS.ACTIONS.PET,
            },
            ["acute_sia_com_pilfer"] = {
                ["NONE"] = "Pilfer",
                ["SUCCEED"] = "Succeeded in stealing it.",
                ["FAIL"] = "This place has good security.",
            },
        --------------------------------------------------------------------
        --- 02_items
            ["acute_sia_weapon_duster"] = {
                ["name"] = "Sia's Duster",
                ["inspect_str"] = "A duster that belongs to Sia",
                ["recipe_desc"] = "A duster that belongs to Sia",
            },
        --------------------------------------------------------------------
        --- 04_foods
            ["acute_sia_food_green_raisins"] = {
                ["name"] = "Green Raisins",
                ["inspect_str"] = "Green Raisins",
            },
            ["acute_sia_food_green_raisins_cooked"] = {
                ["name"] = "Cooked Green Raisins",
                ["inspect_str"] = "Cooked Green Raisins",
            },
        --------------------------------------------------------------------

}