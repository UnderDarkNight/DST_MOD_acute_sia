
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



    ----------------------------------------------------------------
    --- 装备检查
        local function CheckIsEquipment(item)
            if item.components.equippable then
                return true
            end
            return false
        end
    ----------------------------------------------------------------
    --- 食物组件
        local special_food_list = {
            ["wetgoop"] = true,  -- 潮湿的糊糊
            ["spoiled_food"] = true,  -- 腐烂的食物
        }
        local function CheckIsFood(item)
            if special_food_list[item.prefab] then
                return false
            end
            if item.components.edible then
                return true
            end
            return false
        end
    ----------------------------------------------------------------
    --- 排序检查  1-5 装备， 6-10 食物， 11-15 其他
        local function need_to_warning(slot,item)
            if slot <= 5 then
                if CheckIsEquipment(item) then
                    print("is equipment",slot,item)
                    return false
                else
                    print("is not equipment",slot,item)
                    return true
                end
            elseif slot <= 10 then
                if CheckIsFood(item) then
                    print("is food",slot,item)
                    return false
                else
                    print("is not food",slot,item)
                    return true
                end
            else
                if not CheckIsEquipment(item) and not CheckIsFood(item) then
                    print("is other",slot,item)
                    return false
                else
                    print("is not other",slot,item)
                    return true
                end
            end 
        end
    ----------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------
    ---
        ThePlayer.__test_fn = function(inst)


            --------------------------------------------------------------------------------------------------------------
                local slots = inst.components.inventory.itemslots or {}
                inst.components.inventory.itemslots_warning = inst.components.inventory.itemslots_warning or {}
                local max_slots = inst.components.inventory:GetNumSlots()
            --------------------------------------------------------------------------------------------------------------
                local function check_single_slot(num,item)
                    if need_to_warning(num,item) and inst.components.inventory.itemslots_warning[num] ~= true then
                        inst.components.inventory.itemslots_warning[num] = true
                        ---- PushEvent
                        inst.components.acute_sia_com_rpc_event:PushEvent("client_side_inventorybar_warning",{
                            num = num,
                            show = true,
                        })
                        return
                    end
                    if inst.components.inventory.itemslots_warning[num] and not need_to_warning(num,item) then
                        inst.components.inventory.itemslots_warning[num] = false
                        ---- PushEvent
                        inst.components.acute_sia_com_rpc_event:PushEvent("client_side_inventorybar_warning",{
                            num = num,
                            show = false,
                        })
                        return
                    end
                end
            --------------------------------------------------------------------------------------------------------------
            ---- 
                for i = 1, max_slots, 1 do
                    local item = slots[i]
                    if item and item:IsValid() then
                        --------------------------------------------------------------------------------------------------------------
                        ----
                            check_single_slot(i,item)
                        --------------------------------------------------------------------------------------------------------------
                    else
                        --------------------------------------------------------------------------------------------------------------
                        ---- 空位置清除警告
                            if inst.components.inventory.itemslots_warning[i] then
                                inst.components.inventory.itemslots_warning[i] = false
                                ---- PushEvent
                                inst.components.acute_sia_com_rpc_event:PushEvent("client_side_inventorybar_warning",{
                                    num = i,
                                    show = false,
                                })
                            end
                        --------------------------------------------------------------------------------------------------------------    
                    end
                end
            --------------------------------------------------------------------------------------------------------------
        end
    ----------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))