-- -- 这个文件是给 modmain.lua 调用的总入口
-- -- 本lua 和 modmain.lua 平级
-- -- 子分类里有各自的入口
-- -- 注意文件路径


modimport("key_modules_for_acute_sia/02_actions/01_com_pet_the_cat.lua")   --- 抚摸猫的组件

modimport("key_modules_for_acute_sia/02_actions/02_com_pilfer.lua")   --- 顺手牵羊 组件

modimport("key_modules_for_acute_sia/02_actions/03_com_item_acceptable.lua")   --- 通用接受 组件
modimport("key_modules_for_acute_sia/02_actions/04_com_action_workable.lua")   --- 通用交互 组件

