-- -- -- 这个文件是给 modmain.lua 调用的总入口
-- -- -- 本lua 和 modmain.lua 平级
-- -- -- 子分类里有各自的入口
-- -- -- 注意文件路径


modimport("key_modules_for_acute_sia/00_others/__all_others_modules_init.lua") 
-- 难以归类的杂乱东西

modimport("key_modules_for_acute_sia/01_character/__all_character_modules_init.lua") 
-- 角色模块

modimport("key_modules_for_acute_sia/02_actions/__all_action_modules_init.lua") 
-- 动作模块

modimport("key_modules_for_acute_sia/03_origin_components_upgrade/__all_origin_components_init.lua") 
-- 官方component修改

