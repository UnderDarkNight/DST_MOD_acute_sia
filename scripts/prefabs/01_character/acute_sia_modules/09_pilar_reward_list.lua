--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    【笔记】 总概率必须加起来为1，否则会 得不到目标列表

    算法：随机一个数 0~100.00%，分别减去列表的概率值，结果小于等于0 的时候，踩中该列表

    如果 对应的 prefab 结果为true，直接调取 default_reward_list 。否则根据概率返回奖励列表


]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local list = {
    target_with_reward = {
        --------------------------------------------------------------------------------------------------------------------------------
        --- 猪人房子
            ["pighouse"] = {
                {
                    probability = 0.4, -- 概率
                    reward_list = {     -- 奖励列表
                        "goldnugget","livinglog","cutstone","boards","pigskin","pigskin","pigskin","pigskin"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "gears","transistor"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "bonestew","baconeggs","perogies","honeyham","talleggs"
                    }
                },
                {
                    probability = 0.09, -- 概率
                    reward_list = {     -- 奖励列表
                        "dug_berrybush"
                    }
                },
                {
                    probability = 0.01, -- 概率
                    reward_list = {     -- 奖励列表
                        "krampus_sack"
                    }
                },
            },
        --------------------------------------------------------------------------------------------------------------------------------
        --- 兔人房子
            ["rabbithouse"] = {
                {
                    probability = 0.4, -- 概率
                    reward_list = {     -- 奖励列表
                        "goldnugget","livinglog","cutstone","boards","manrabbit_tail","manrabbit_tail","manrabbit_tail","manrabbit_tail"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "gears","transistor"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "bonestew","baconeggs","perogies","honeyham","talleggs"
                    }
                },
                {
                    probability = 0.09, -- 概率
                    reward_list = {     -- 奖励列表
                        "dug_berrybush"
                    }
                },
                {
                    probability = 0.01, -- 概率
                    reward_list = {     -- 奖励列表
                        "krampus_sack"
                    }
                },
            },
        --------------------------------------------------------------------------------------------------------------------------------
        --- 坟墓
            ["gravestone"] = true,
        --------------------------------------------------------------------------------------------------------------------------------
        --- 鱼人房子
            ["mermhouse_crafted"] = {
                {
                    probability = 0.4, -- 概率
                    reward_list = {     -- 奖励列表
                        "goldnugget","livinglog","cutstone","boards"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "gears","transistor"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "bonestew","baconeggs","perogies","honeyham","talleggs"
                    }
                },
                {
                    probability = 0.09, -- 概率
                    reward_list = {     -- 奖励列表
                        "dug_berrybush"
                    }
                },
                {
                    probability = 0.01, -- 概率
                    reward_list = {     -- 奖励列表
                        "krampus_sack"
                    }
                },
            },
        --------------------------------------------------------------------------------------------------------------------------------
        --- 鱼人房子
            ["mermwatchtower"] = {
                {
                    probability = 0.4, -- 概率
                    reward_list = {     -- 奖励列表
                        "goldnugget","livinglog","cutstone","boards"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "gears","transistor"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "bonestew","baconeggs","perogies","honeyham","talleggs"
                    }
                },
                {
                    probability = 0.09, -- 概率
                    reward_list = {     -- 奖励列表
                        "dug_berrybush"
                    }
                },
                {
                    probability = 0.01, -- 概率
                    reward_list = {     -- 奖励列表
                        "krampus_sack"
                    }
                },
            },
        --------------------------------------------------------------------------------------------------------------------------------
        --- 鱼人房子
            ["mermhouse"] = {
                {
                    probability = 0.4, -- 概率
                    reward_list = {     -- 奖励列表
                        "goldnugget","livinglog","cutstone","boards"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "gears","transistor"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "bonestew","baconeggs","perogies","honeyham","talleggs"
                    }
                },
                {
                    probability = 0.09, -- 概率
                    reward_list = {     -- 奖励列表
                        "dug_berrybush"
                    }
                },
                {
                    probability = 0.01, -- 概率
                    reward_list = {     -- 奖励列表
                        "krampus_sack"
                    }
                },
            },
        --------------------------------------------------------------------------------------------------------------------------------
        --- 赃物袋
            ["klaus_sack"] = {
                {
                    probability = 0.4, -- 概率
                    reward_list = {     -- 奖励列表
                        "goldnugget","livinglog","cutstone","boards"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "gears","transistor"
                    }
                },
                {
                    probability = 0.25, -- 概率
                    reward_list = {     -- 奖励列表
                        "bonestew","baconeggs","perogies","honeyham","talleggs"
                    }
                },
                {
                    probability = 0.09, -- 概率
                    reward_list = {     -- 奖励列表
                        "dug_berrybush"
                    }
                },
                {
                    probability = 0.01, -- 概率
                    reward_list = {     -- 奖励列表
                        "krampus_sack"
                    }
                },
            },
        --------------------------------------------------------------------------------------------------------------------------------
        ---- 舞台之手
            ["stagehand"] = true,
            ["stageusher"] = true,
        --------------------------------------------------------------------------------------------------------------------------------
    },

    ---- 缺省奖励列表
    default_reward_list = {
        "goldnugget","livinglog","cutstone","boards"
    },

}
return list