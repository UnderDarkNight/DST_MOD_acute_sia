--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

     通用数据储存库，用来储存各种 【文本】数据

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local acute_sia_com_pilfer_flag_for_target = Class(function(self, inst)
    self.inst = inst

    self.DataTable = {}
    self.TempTable = {}
    self._onload_fns = {}
    self._onsave_fns = {}



end,
nil,
{

})
------------------------------------------------------------------------------------------------------------------------------
------
    function acute_sia_com_pilfer_flag_for_target:CanBePilarToday(cd_day)
        local last_pilar_day = self:Get("last_pilar_day")
        self:Set("cd_day",cd_day)
        if last_pilar_day == nil then
            return true
        end
        if TheWorld.state.cycles - last_pilar_day >= cd_day then
            return true
        end
        -- self.inst:AddTag("pilar_by_sia")
        return false
    end
    function acute_sia_com_pilfer_flag_for_target:DoPilar()
        self:Set("last_pilar_day",TheWorld.state.cycles)
        -- self.inst:AddTag("pilar_by_sia")
    end
    function acute_sia_com_pilfer_flag_for_target:OnLoadCheck()
        local cd_day = self:Get("cd_day") or 0
        if self:CanBePilarToday(cd_day) then
            -- self.inst:AddTag("pilar_by_sia")
        else
            -- self.inst:RemoveTag("pilar_by_sia")
        end
    end
------------------------------------------------------------------------------------------------------------------------------
----- onload/onsave 函数
    function acute_sia_com_pilfer_flag_for_target:AddOnLoadFn(fn)
        if type(fn) == "function" then
            table.insert(self._onload_fns, fn)
        end
    end
    function acute_sia_com_pilfer_flag_for_target:ActiveOnLoadFns()
        for k, temp_fn in pairs(self._onload_fns) do
            temp_fn(self)
        end
    end
    function acute_sia_com_pilfer_flag_for_target:AddOnSaveFn(fn)
        if type(fn) == "function" then
            table.insert(self._onsave_fns, fn)
        end
    end
    function acute_sia_com_pilfer_flag_for_target:ActiveOnSaveFns()
        for k, temp_fn in pairs(self._onsave_fns) do
            temp_fn(self)
        end
    end
------------------------------------------------------------------------------------------------------------------------------
----- 数据读取/储存

    function acute_sia_com_pilfer_flag_for_target:Get(index)
        if index then
            return self.DataTable[index]
        end
        return nil
    end
    function acute_sia_com_pilfer_flag_for_target:Set(index,theData)
        if index then
            self.DataTable[index] = theData
        end
    end

    function acute_sia_com_pilfer_flag_for_target:Add(index,num)
        if index then
            self.DataTable[index] = (self.DataTable[index] or 0) + ( num or 0 )
            return self.DataTable[index]
        end
        return 0
    end
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------
    function acute_sia_com_pilfer_flag_for_target:OnSave()
        self:ActiveOnSaveFns()
        local data =
        {
            DataTable = self.DataTable
        }
        return next(data) ~= nil and data or nil
    end

    function acute_sia_com_pilfer_flag_for_target:OnLoad(data)
        if data.DataTable then
            self.DataTable = data.DataTable
        end
        self:ActiveOnLoadFns()

        self:OnLoadCheck()
    end
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
return acute_sia_com_pilfer_flag_for_target







