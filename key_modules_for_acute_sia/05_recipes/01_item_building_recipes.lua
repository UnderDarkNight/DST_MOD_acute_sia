



--------------------------------------------------------------------------------------------------------------------------------------------
---- 扫把
--------------------------------------------------------------------------------------------------------------------------------------------
AddRecipeToFilter("acute_sia_weapon_duster","CHARACTER")     ---- 添加物品到目标标签
AddRecipe2(
    "acute_sia_weapon_duster",            --  --  inst.prefab  实体名字
    { Ingredient("reskin_tool", 2) }, 
    TECH.NONE, --- 科技等级
    {
        -- nounlock=true,
        no_deconstruction=false,
        builder_tag = "acute_sia",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
        -- placer = "fwd_in_pdt_item_talisman_that_repels_snakes",                       -------- 建筑放置器        
        atlas = "images/inventoryimages/acute_sia_weapon_duster.xml",
        image = "acute_sia_weapon_duster.tex",
    },
    {"CHARACTER"}
)
RemoveRecipeFromFilter("acute_sia_weapon_duster","MODS")                       -- -- 在【模组物品】标签里移除这个。
--------------------------------------------------------------------------------------------------------------------------------------------