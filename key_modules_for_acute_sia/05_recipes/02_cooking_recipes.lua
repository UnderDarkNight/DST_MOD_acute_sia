
local function GetStringsTable(prefab_name)
    local temp_prefab = nil
    return TUNING["acute_sia.fn"].GetStringsTable(temp_prefab or prefab_name)
end

---------------------------------------------------------------------------------------------------------------------
----- 水晶葡萄
    local acute_sia_food_crystal_raisins = {
        test = function(cooker, names, tags)
            return ( names.acute_sia_food_green_raisins or 0)  + ( names.acute_sia_food_green_raisins_cooked or 0) == 4
        end,
        name = "acute_sia_food_crystal_raisins", -- 料理名
        weight = 10, -- 食谱权重
        priority = 10, -- 食谱优先级
        foodtype = GLOBAL.FOODTYPE.VEGGIE, --料理的食物类型，比如这里定义的是素食
        hunger = 25 , --吃后回饥饿值
        sanity = 25 , --吃后回精神值
        health = 5 , --吃后回血值
        stacksize = 1,  --- 每次烹饪得到个数
        -- perishtime = TUNING.PERISH_TWO_DAY*5, --腐烂时间
        cooktime = TUNING.ACUTE_SIA_DEBUGGING_MODE and 1/4 or 30/20, --烹饪时间(单位20s :  数字1 为 20s ,)
        potlevel = "high",  --- 锅里的贴图位置 low high  mid
        cookbook_tex = "acute_sia_food_crystal_raisins.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
        cookbook_atlas = "images/inventoryimages/acute_sia_food_crystal_raisins.xml",  
        overridebuild = "acute_sia_food_crystal_raisins",          ----- build (zip名字)
        overridesymbolname = "idle",     ----- scml 的图层名字（图片所在的文件夹名）
        floater = {"med", nil, 0.55},
        oneat_desc = GetStringsTable("acute_sia_food_crystal_raisins")["oneat_desc"],    --- 副作用一栏显示的文本
        cookbook_category = "cookpot"
    }

    AddCookerRecipe("cookpot", acute_sia_food_crystal_raisins) -- 将食谱添加进普通锅
    AddCookerRecipe("portablecookpot", acute_sia_food_crystal_raisins) -- 将食谱添加进便携锅(大厨锅)
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
----- 黑咖啡
    local acute_sia_food_black_coffee = {
        test = function(cooker, names, tags)
            return ( names.acute_sia_food_coffeebeans or 0)  + ( names.acute_sia_food_coffeebeans_cooked or 0) 
            + ( names.acute_sia_food_coffee_powder or 0) == 4
        end,
        name = "acute_sia_food_black_coffee", -- 料理名
        weight = 30, -- 食谱权重
        priority = 30, -- 食谱优先级
        foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是素食
        hunger = 9.4 , --吃后回饥饿值
        sanity = 10 , --吃后回精神值
        health = -5 , --吃后回血值
        stacksize = 1,  --- 每次烹饪得到个数
        -- perishtime = TUNING.PERISH_TWO_DAY*5, --腐烂时间
        cooktime = TUNING.ACUTE_SIA_DEBUGGING_MODE and 1/4 or 10/20, --烹饪时间(单位20s :  数字1 为 20s ,)
        potlevel = "mid",  --- 锅里的贴图位置 low high  mid
        cookbook_tex = "acute_sia_food_black_coffee.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
        cookbook_atlas = "images/inventoryimages/acute_sia_food_black_coffee.xml",  
        overridebuild = "acute_sia_food_black_coffee",          ----- build (zip名字)
        overridesymbolname = "idle",     ----- scml 的图层名字（图片所在的文件夹名）
        floater = {"med", nil, 0.55},
        oneat_desc = GetStringsTable("acute_sia_food_black_coffee")["oneat_desc"],    --- 副作用一栏显示的文本
        cookbook_category = "cookpot"
    }

    AddCookerRecipe("cookpot", acute_sia_food_black_coffee) -- 将食谱添加进普通锅
    AddCookerRecipe("portablecookpot", acute_sia_food_black_coffee) -- 将食谱添加进便携锅(大厨锅)
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
----- 甜咖啡
    local acute_sia_food_sweet_coffee = {
        test = function(cooker, names, tags)
            return ( names.acute_sia_food_coffeebeans or 0)  + ( names.acute_sia_food_coffeebeans_cooked or 0) 
            + ( names.acute_sia_food_coffee_powder or 0) == 3 and (names.honey or 0) + (tags.dairy or 0) == 1
        end,
        name = "acute_sia_food_sweet_coffee", -- 料理名
        weight = 30, -- 食谱权重
        priority = 30, -- 食谱优先级
        foodtype = GLOBAL.FOODTYPE.GOODIES, --料理的食物类型，比如这里定义的是素食
        hunger = 9.4 , --吃后回饥饿值
        sanity = 10 , --吃后回精神值
        health = -5 , --吃后回血值
        stacksize = 1,  --- 每次烹饪得到个数
        -- perishtime = TUNING.PERISH_TWO_DAY*5, --腐烂时间
        cooktime = TUNING.ACUTE_SIA_DEBUGGING_MODE and 1/4 or 10/20, --烹饪时间(单位20s :  数字1 为 20s ,)
        potlevel = "mid",  --- 锅里的贴图位置 low high  mid
        cookbook_tex = "acute_sia_food_sweet_coffee.tex", -- 在游戏内食谱书里的mod食物那一栏里显示的图标，tex在 atlas的xml里定义了，所以这里只写文件名即可
        cookbook_atlas = "images/inventoryimages/acute_sia_food_sweet_coffee.xml",  
        overridebuild = "acute_sia_food_sweet_coffee",          ----- build (zip名字)
        overridesymbolname = "idle",     ----- scml 的图层名字（图片所在的文件夹名）
        floater = {"med", nil, 0.55},
        oneat_desc = GetStringsTable("acute_sia_food_sweet_coffee")["oneat_desc"],    --- 副作用一栏显示的文本
        cookbook_category = "cookpot"
    }

    AddCookerRecipe("cookpot", acute_sia_food_sweet_coffee) -- 将食谱添加进普通锅
    AddCookerRecipe("portablecookpot", acute_sia_food_sweet_coffee) -- 将食谱添加进便携锅(大厨锅)
---------------------------------------------------------------------------------------------------------------------