---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 统一注册 【 images\inventoryimages 】 里的所有图标
--- 每个 xml 里面 只有一个 tex

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if Assets == nil then
    Assets = {}
end

local files_name = {

	---------------------------------------------------------------------------------------
	--- 02_items
		"acute_sia_weapon_duster",			---- 特别的扫把
		"acute_sia_item_portable_blender",			---- 磨粉机
	---------------------------------------------------------------------------------------
	--- 03_plants
		"acute_sia_plant_dug_coffeebush",			---- 咖啡树
	---------------------------------------------------------------------------------------
	--- 04_foods
		"acute_sia_food_green_raisins",					---- 青提
		"acute_sia_food_green_raisins_rot",				---- 青提
		"acute_sia_food_green_raisins_cooked",			---- 烤青提
		"acute_sia_food_coffeebeans",					---- 咖啡豆
		"acute_sia_food_coffeebeans_cooked",			---- 烤咖啡豆
		"acute_sia_food_coffee_powder",					---- 咖啡粉

		"acute_sia_food_crystal_raisins",				---- 水晶葡萄
		"acute_sia_food_black_coffee",					---- 黑咖啡
		"acute_sia_food_sweet_coffee",					---- 甜咖啡
	---------------------------------------------------------------------------------------

}

for k, name in pairs(files_name) do
    table.insert(Assets, Asset( "IMAGE", "images/inventoryimages/".. name ..".tex" ))
    table.insert(Assets, Asset( "ATLAS", "images/inventoryimages/".. name ..".xml" ))
	RegisterInventoryItemAtlas("images/inventoryimages/".. name ..".xml", name .. ".tex")
end


