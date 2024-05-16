
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ 界面调试
    local Widget = require "widgets/widget"
    local Image = require "widgets/image" -- 引入image控件
    local UIAnim = require "widgets/uianim"


    local Screen = require "widgets/screen"
    local AnimButton = require "widgets/animbutton"
    local ImageButton = require "widgets/imagebutton"
    local Menu = require "widgets/menu"
    local Text = require "widgets/text"
    local TEMPLATES = require "widgets/redux/templates"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local flg,error_code = pcall(function()
    print("WARNING:PCALL START +++++++++++++++++++++++++++++++++++++++++++++++++")
    local x,y,z =    ThePlayer.Transform:GetWorldPosition()  
    ----------------------------------------------------------------------------------------------------------------
    ----
        -- ThePlayer:ListenForEvent("newstate",function(_,_table)
        --     print("newstate",_table and _table.statename)
        -- end)
        -- ThePlayer:RemoveTag("hungrybuilder")
        -- ThePlayer:AddTag("fastbuilder")
    ----------------------------------------------------------------------------------------------------------------
    ---
        -- local current_item = ThePlayer.components.inventory:GetEquippedItem(EQUIPSLOTS.BEARD)
        -- print("current_item",current_item)

    ----------------------------------------------------------------------------------------------------------------
    --- 淘气值

        -- print(TheWorld.components.kramped:GetDebugString())


        -- -- local infos = TheWorld.components.kramped:GetDebugString()
        -- local infos = 
        -- [[
        --     Player 116693 - acute_sia - Actions: 22 / 31, decay in 60.00
        --     Player 116688 - acute_ska - Actions: 0 / 31, decay in 60.00
        --     Player 117793 - acute_sba - Actions: 0 / 31, decay in 60.00
        -- ]]
        -- print(infos)
        -- print("GUID",ThePlayer.GUID)
        -- local num = GetValue(infos, ThePlayer.GUID)
        -- print("num",num)
    ----------------------------------------------------------------------------------------------------------------    
        -- print(TheWorld.components.kramped:Sia_GetPlayerKramp(ThePlayer))
    ----------------------------------------------------------------------------------------------------------------
    --- 玩家hud
        -- -- print(ThePlayer.HUD.controls.inv)
        -- local inventorybar = ThePlayer.HUD.controls.inv
        -- -- print(inventorybar)
        -- -- for k,v in pairs(inventorybar) do
        -- --     print(k,v)
        -- -- end
        -- local slots = inventorybar.inv
        -- -- print(#slots)

        -- local icon_list = {
        --     [1] = "tool.tex",
        --     [2] = "tool.tex",
        --     [3] = "tool.tex",
        --     [4] = "tool.tex",
        --     [5] = "tool.tex",

        --     [6] = "food.tex",
        --     [7] = "food.tex",
        --     [8] = "food.tex",
        --     [9] = "food.tex",
        --     [10] = "food.tex",

        --     [11] = "material.tex",
        --     [12] = "material.tex",
        --     [13] = "material.tex",
        --     [14] = "material.tex",
        --     [15] = "material.tex",
        -- }



        -- for k, temp_slot in pairs(slots) do
        --     temp_slot.bgimage:SetTexture("images/widgets/acute_sia_inventorybar.xml",icon_list[k] or "food.tex")
        -- end


    ----------------------------------------------------------------------------------------------------------------
    ---
        -- local slots = ThePlayer.__test_slots

        -- for k, v in pairs(slots) do
        --     if slots[k]._warning_icon then
        --         slots[k]._warning_icon:Kill()
        --     end

        --     slots[k]._warning_icon = slots[k]:AddChild(UIAnim())
        --     local _warning_icon = slots[k]._warning_icon
        --     _warning_icon:GetAnimState():SetBank("acute_sia_inventorybar_warning")
        --     _warning_icon:GetAnimState():SetBuild("acute_sia_inventorybar_warning")
        --     _warning_icon:GetAnimState():PlayAnimation("idle"..tostring(math.random(3)),true)
        --     _warning_icon:SetPosition(-5,40)
        -- end
    ----------------------------------------------------------------------------------------------------------------
    --- 淘气值相关
        -- SpawnPrefab("acute_sia_naughty_target"):PushEvent("Set",{
        --     player = ThePlayer,
        --     num = 3,
        -- })
        -- print(TheWorld.components.kramped:Sia_GetPlayerKramp(ThePlayer))
    ----------------------------------------------------------------------------------------------------------------
    --- 浆果
        local item = c_select()
        -- print(item.components.edible.foodtype)
        -- print(item.components.stackable.maxsize)
        print(item.components.pickable.product)
        -- print(item:GetDebugString())
    ----------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))