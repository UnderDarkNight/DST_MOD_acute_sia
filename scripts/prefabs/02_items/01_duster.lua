------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[



]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local assets =
    {
        Asset("ANIM", "anim/acute_sia_weapon_duster.zip"),
        Asset("ANIM", "anim/acute_sia_weapon_duster_swap.zip"),
    }
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 穿脱执行
    local function onequip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "acute_sia_weapon_duster_swap", "swap_object")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
        if owner:HasTag("player") then
            inst:PushEvent("equip_by_player",owner)
            owner:PushEvent("sia_equip_duster",inst)
        end
    end

    local function onunequip(inst, owner)
        owner.AnimState:ClearOverrideSymbol("swap_object")
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
        if owner:HasTag("player") then
            inst:PushEvent("unequip_by_player",owner)
            owner:PushEvent("sia_unequip_duster",inst)
        end
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 耐久度
    local function finiteuses_setup(inst)
        inst:AddComponent("finiteuses")
        inst.components.finiteuses:SetMaxUses(450)
        inst.components.finiteuses:SetUses(450)
        inst.components.finiteuses:SetOnFinished(function()
            inst:PushEvent("finiteuses_finished")
        end)
        ------- AOE 期间不算耐久
            local old_Use = inst.components.finiteuses.Use
            inst.components.finiteuses.Use = function(self,num,...)
                if inst:HasTag("aoe_doing") then
                    num = 0
                end
                return old_Use(self,num,...)
            end

        ------- 初始化
            inst:DoTaskInTime(0,function()
                if inst.components.finiteuses:GetPercent() <= 0 then
                    inst:AddTag("finiteuses_empty")
                end
            end)
        ------- 执行事件        
            inst:ListenForEvent("finiteuses_finished",function()
                inst:AddTag("finiteuses_empty")
            end)
            inst:ListenForEvent("finiteuses_fixed",function()
                inst:RemoveTag("finiteuses_empty")
            end)

    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 右键使用
    local function workable_setup(inst)
        inst:ListenForEvent("acute_sia_event.OnEntityReplicated.accute_sia_com_workable", function(inst, replica_com)
            replica_com:SetTestFn(function(inst,doer,right_click)
                if inst.replica.inventoryitem:IsGrandOwner(doer) then
                    return true
                end
                return false
            end)
            replica_com:SetSGAction("dolongaction")
            replica_com:SetText("acute_sia_weapon_duster",STRINGS.ACTIONS.CYCLE.GENERIC)
        end)
        if TheWorld.ismastersim then
            local aoe_task = nil

            inst:AddComponent("accute_sia_com_workable")
            inst.components.accute_sia_com_workable:SetActiveFn(function(inst,doer)
                if not inst:HasTag("aoe") then
                    inst:AddTag("aoe")
                    --------------------------------------------------------
                    --- 检查任务
                        if aoe_task then
                            aoe_task:Cancel()
                        end
                        aoe_task = inst:DoPeriodicTask(1,function()
                            if inst.components.finiteuses:GetPercent() <= 0 then
                                inst:RemoveTag("aoe")
                                aoe_task:Cancel()
                                aoe_task = nil
                            end
                        end)
                    --------------------------------------------------------
                else
                    inst:RemoveTag("aoe")
                    --------------------------------------------------------
                    --- 取消检查任务
                        if aoe_task then
                            aoe_task:Cancel()
                            aoe_task = nil
                        end
                    --------------------------------------------------------
                end
                doer:PushEvent("sia_duster_workable",inst)
                return true
            end)
        end        
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 物品接受
    local function acceptable_setup(inst)
        local ACCEPT_ITEM = {
            ["goldnugget"] = true,
            ["livinglog"] = true,
        }
        inst:ListenForEvent("acute_sia_event.OnEntityReplicated.acute_sia_com_acceptable", function(inst, replica_com)
            replica_com:SetTestFn(function(inst,item,doer,right_click)
                if item and ACCEPT_ITEM[item.prefab] then
                    return true
                end
                return false
            end)
            replica_com:SetSGAction("dolongaction")
            replica_com:SetText("acute_sia_weapon_duster",STRINGS.ACTIONS.OCEAN_TRAWLER_FIX)
        end)
        if TheWorld.ismastersim then
            inst:AddComponent("acute_sia_com_acceptable")
            inst.components.acute_sia_com_acceptable:SetOnAcceptFn(function(inst,item,doer)
                if item.components.stackable then
                    item.components.stackable:Get():Remove()
                else
                    item:Remove()
                end
                inst.components.finiteuses:SetPercent(1)
                inst:PushEvent("finiteuses_fixed")
                return true
            end)
        end
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("acute_sia_weapon_duster")
    inst.AnimState:SetBuild("acute_sia_weapon_duster")
    inst.AnimState:PlayAnimation("idle")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("acute_sia_weapon_duster")
    inst:AddTag("weapon")
    MakeInventoryFloatable(inst, "med", 0.05, {0.85, 0.45, 0.85})

    inst.entity:SetPristine()
    --------------------------------------------------------------------------------------------------------------------------------------
    ---
        if TheWorld.ismastersim then
            inst:AddComponent("acute_sia_com_data")
        end
    --------------------------------------------------------------------------------------------------------------------------------------
    --- 耐久度
        if TheWorld.ismastersim then
            finiteuses_setup(inst)
        end
    --------------------------------------------------------------------------------------------------------------------------------------
    --- 物品接受
        acceptable_setup(inst)
    --------------------------------------------------------------------------------------------------------------------------------------
    --- 通用右键
        workable_setup(inst)
    --------------------------------------------------------------------------------------------------------------------------------------

    if not TheWorld.ismastersim then
        return inst
    end

    -------------------------------------------------------------------
    ---
        inst:AddComponent("weapon")
        inst.components.weapon:SetDamage(42.5)
        inst.components.weapon:SetRange(0.8)
        local old_GetDamage = inst.components.weapon.GetDamage
        inst.components.weapon.GetDamage = function(self,attacker, target,...)
            local dmg, spdmg = old_GetDamage(self,attacker, target,...)
            if inst.components.finiteuses:GetUses() <= 0 then
                dmg = 0
                spdmg = 0
            end
            return dmg, spdmg
        end
        inst.components.weapon:SetOnAttack(function(inst, attacker, target)
            attacker:PushEvent("sia_duster_on_attack", target)
        end)
    -------------------------------------------------------------------
    ---
        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "acute_sia_weapon_duster"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/acute_sia_weapon_duster.xml"

        inst:AddComponent("equippable")
        inst.components.equippable:SetOnEquip(onequip)
        inst.components.equippable:SetOnUnequip(onunequip)
    -------------------------------------------------------------------
    ---
        MakeHauntableLaunch(inst)
    -------------------------------------------------------------------
    --- 落水影子
        local function shadow_init(inst)
            if inst:IsOnOcean(false) then       --- 如果在海里（不包括船）
                -- inst.AnimState:Hide("SHADOW")
                inst.AnimState:PlayAnimation("water")
            else                                
                -- inst.AnimState:Show("SHADOW")
                inst.AnimState:PlayAnimation("idle")
            end
        end
        inst:ListenForEvent("on_landed",shadow_init)
        shadow_init(inst)
    -------------------------------------------------------------------
    ---        
    -------------------------------------------------------------------
    return inst
end

return Prefab("acute_sia_weapon_duster", fn, assets)
