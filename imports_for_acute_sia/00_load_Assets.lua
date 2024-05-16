
if Assets == nil then
    Assets = {}
end

local temp_assets = {


	-- Asset("IMAGE", "images/inventoryimages/acute_sia_empty_icon.tex"),
	-- Asset("ATLAS", "images/inventoryimages/acute_sia_empty_icon.xml"),
	
	-- Asset("SHADER", "shaders/mod_test_shader.ksh"),		--- 测试用的

	---------------------------------------------------------------------------

	Asset("ANIM", "anim/acute_sia_berrybush_juisy.zip"), --- 多汁浆果贴图修改




	---------------------------------------------------------------------------
	-- Asset("ANIM", "anim/acute_sia_mutant_frog.zip"),	--- 变异青蛙贴图包
	-- Asset("ANIM", "anim/acute_sia_animal_frog_hound.zip"),	--- 变异青蛙狗贴图包

	---------------------------------------------------------------------------
	-- Asset("SOUNDPACKAGE", "sound/dontstarve_DLC002.fev"),	--- 单机声音集
	---------------------------------------------------------------------------


}

for k, v in pairs(temp_assets) do
    table.insert(Assets,v)
end

