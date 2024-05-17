------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    角色基础初始化

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



local function Language_check()
    local language = "en"
    if type(TUNING["acute_sia.Language"]) == "function" then
        language = TUNING["acute_sia.Language"]()
    elseif type(TUNING["acute_sia.Language"]) == "string" then
        language = TUNING["acute_sia.Language"]
    end
    return language
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色立绘大图
    GLOBAL.PREFAB_SKINS["acute_sia"] = {
        "acute_sia_none",
    }
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色选择时候都文本
    if Language_check() == "ch" then
        -- The character select screen lines  --人物选人界面的描述
        STRINGS.CHARACTER_TITLES["acute_sia"] = "急性子 Sia"
        STRINGS.CHARACTER_NAMES["acute_sia"] = "Sia"
        STRINGS.CHARACTER_DESCRIPTIONS["acute_sia"] = "性子很急"
        STRINGS.CHARACTER_QUOTES["acute_sia"] = "性子很急"

        -- Custom speech strings  ----人物语言文件  可以进去自定义
        -- STRINGS.CHARACTERS[string.upper("acute_sia")] = require "speech_acute_sia"

        -- The character's name as appears in-game  --人物在游戏里面的名字
        STRINGS.NAMES[string.upper("acute_sia")] = "Sia"
        STRINGS.SKIN_NAMES["acute_sia_none"] = "Sia"  --检查界面显示的名字

        --生存几率
        STRINGS.CHARACTER_SURVIVABILITY["acute_sia"] = "特别容易"
    else
        -- The character select screen lines  --人物选人界面的描述
        STRINGS.CHARACTER_TITLES["acute_sia"] = "Acute Sia"
        STRINGS.CHARACTER_NAMES["acute_sia"] = "Sia"
        STRINGS.CHARACTER_DESCRIPTIONS["acute_sia"] = "excitable person"
        STRINGS.CHARACTER_QUOTES["acute_sia"] = "excitable person"

        -- Custom speech strings  ----人物语言文件  可以进去自定义
        -- STRINGS.CHARACTERS[string.upper("acute_sia")] = require "speech_acute_sia"

        -- The character's name as appears in-game  --人物在游戏里面的名字
        STRINGS.NAMES[string.upper("acute_sia")] = "Sia"
        STRINGS.SKIN_NAMES["acute_sia_none"] = "Sia"  --检查界面显示的名字

        --生存几率
        STRINGS.CHARACTER_SURVIVABILITY["acute_sia"] = "easy"

    end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
------增加人物到mod人物列表的里面 性别为女性（ MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL）
    AddModCharacter("acute_sia", "MALE")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----选人界面人物三维显示
    TUNING[string.upper("acute_sia").."_HEALTH"] = 200
    TUNING[string.upper("acute_sia").."_HUNGER"] = 125
    TUNING[string.upper("acute_sia").."_SANITY"] = 100
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----选人界面初始物品显示，物品相关的prefab
    TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT[string.upper("acute_sia")] = {"acute_sia_weapon_duster"}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
