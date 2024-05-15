--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

acute_sia_master_postinit

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local function ChangeHUD(inst)
        ------------------------------------------------------------------------------------------------------------------
        --- 修改图标
            local inventorybar = ThePlayer.HUD.controls.inv
            local slots = inventorybar.inv
            local icon_list = {
                [1] = "tool.tex",
                [2] = "tool.tex",
                [3] = "tool.tex",
                [4] = "tool.tex",
                [5] = "tool.tex",

                [6] = "food.tex",
                [7] = "food.tex",
                [8] = "food.tex",
                [9] = "food.tex",
                [10] = "food.tex",

                [11] = "material.tex",
                [12] = "material.tex",
                [13] = "material.tex",
                [14] = "material.tex",
                [15] = "material.tex",
            }
            for k, temp_slot in pairs(slots) do
                temp_slot.bgimage:SetTexture("images/widgets/acute_sia_inventorybar.xml",icon_list[k] or "food.tex")
            end
        ------------------------------------------------------------------------------------------------------------------
        --- 添加警告图标
            for k, v in pairs(slots) do
                slots[k]._warning_icon = slots[k]:AddChild(UIAnim())
                local _warning_icon = slots[k]._warning_icon
                _warning_icon:GetAnimState():SetBank("acute_sia_inventorybar_warning")
                _warning_icon:GetAnimState():SetBuild("acute_sia_inventorybar_warning")
                _warning_icon:GetAnimState():PlayAnimation("idle"..tostring(math.random(3)),true)
                _warning_icon:SetPosition(-5,40)
                _warning_icon:Hide()
            end
        ------------------------------------------------------------------------------------------------------------------
        --- 监听事件
            inst:ListenForEvent("client_side_inventorybar_warning",function(inst,_table)
                _table = _table or {}
                local num = _table.num or 1
                local show = _table.show or false
                pcall(function()
                    local _warning_icon = slots[num]._warning_icon
                    if show then
                        _warning_icon:Show()
                    else
                        _warning_icon:Hide()
                    end
                end)
            end)
        ------------------------------------------------------------------------------------------------------------------
        --- 上传事件
            inst.replica.acute_sia_com_rpc_event:PushEvent("inventorybar_icon_change_finish")
        ------------------------------------------------------------------------------------------------------------------
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    inst:DoTaskInTime(1,function()
        if inst == ThePlayer and inst.HUD then
            pcall(ChangeHUD,inst)
        end
    end)
end