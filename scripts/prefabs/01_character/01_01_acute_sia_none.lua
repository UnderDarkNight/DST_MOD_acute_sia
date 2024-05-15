local assets =
{
	Asset( "ANIM", "anim/acute_sia.zip" ),
	Asset( "ANIM", "anim/ghost_acute_sia_build.zip" ),
}
local skin_fns = {

	-----------------------------------------------------
		CreatePrefabSkin("acute_sia_none",{
			base_prefab = "acute_sia",			---- 角色prefab
			skins = {
					normal_skin = "acute_sia",					--- 正常外观
					ghost_skin = "ghost_acute_sia_build",			--- 幽灵外观
			}, 								
			assets = assets,
			skin_tags = {"BASE" ,"ACUTE_SIA", "CHARACTER"},		--- 皮肤对应的tag
			
			build_name_override = "acute_sia",
			rarity = "Character",
		}),
	-----------------------------------------------------
	-----------------------------------------------------
		-- CreatePrefabSkin("acute_sia_skin_flame",{
		-- 	base_prefab = "acute_sia",			---- 角色prefab
		-- 	skins = {
		-- 			normal_skin = "acute_sia_skin_flame", 		--- 正常外观
		-- 			ghost_skin = "ghost_acute_sia_build",			--- 幽灵外观
		-- 	}, 								
		-- 	assets = assets,
		-- 	skin_tags = {"BASE" ,"acute_sia_CARL", "CHARACTER"},		--- 皮肤对应的tag
			
		-- 	build_name_override = "acute_sia",
		-- 	rarity = "Character",
		-- }),
	-----------------------------------------------------

}

return unpack(skin_fns)