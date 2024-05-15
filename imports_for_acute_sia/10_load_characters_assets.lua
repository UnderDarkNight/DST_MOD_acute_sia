------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色相关的 素材文件
------------------------------------------------------------------------------------------------------------------------------------------------------

if Assets == nil then
    Assets = {}
end

local temp_assets = {


	---------------------------------------------------------------------------
        Asset( "IMAGE", "images/saveslot_portraits/acute_sia.tex" ), --存档图片
        Asset( "ATLAS", "images/saveslot_portraits/acute_sia.xml" ),

        Asset( "IMAGE", "bigportraits/acute_sia.tex" ), --人物大图（方形的那个）
        Asset( "ATLAS", "bigportraits/acute_sia.xml" ),

        Asset( "IMAGE", "bigportraits/acute_sia_none.tex" ),  --人物大图（椭圆的那个）
        Asset( "ATLAS", "bigportraits/acute_sia_none.xml" ),
        
        Asset( "IMAGE", "images/map_icons/acute_sia.tex" ), --小地图
        Asset( "ATLAS", "images/map_icons/acute_sia.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_acute_sia.tex" ), --tab键人物列表显示的头像  --- 直接用小地图那张就行了
        Asset( "ATLAS", "images/avatars/avatar_acute_sia.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_ghost_acute_sia.tex" ),--tab键人物列表显示的头像（死亡）
        Asset( "ATLAS", "images/avatars/avatar_ghost_acute_sia.xml" ),
        
        Asset( "IMAGE", "images/avatars/self_inspect_acute_sia.tex" ), --人物检查按钮的图片
        Asset( "ATLAS", "images/avatars/self_inspect_acute_sia.xml" ),
        
        Asset( "IMAGE", "images/names_acute_sia.tex" ),  --人物名字
        Asset( "ATLAS", "images/names_acute_sia.xml" ),
        
        Asset("ANIM", "anim/acute_sia.zip"),              --- 人物动画文件
        Asset("ANIM", "anim/ghost_acute_sia_build.zip"),  --- 灵魂状态动画文件

        ---- 物品栏独立图标和警示动画
        Asset( "IMAGE", "images/widgets/acute_sia_inventorybar.tex" ),
        Asset( "ATLAS", "images/widgets/acute_sia_inventorybar.xml" ),        
        Asset("ANIM", "anim/acute_sia_inventorybar_warning.zip"),

	---------------------------------------------------------------------------


}
-- for i = 1, 30, 1 do
--     print("fake error ++++++++++++++++++++++++++++++++++++++++")
-- end
for k, v in pairs(temp_assets) do
    table.insert(Assets,v)
end

