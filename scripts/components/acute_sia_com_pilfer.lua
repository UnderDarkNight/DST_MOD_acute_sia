--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local acute_sia_com_pilfer = Class(function(self, inst)
    self.inst = inst

    self.DataTable = {}
    self.TempTable = {}
    self._onload_fns = {}
    self._onsave_fns = {}

end,
nil,
{

})
---------------------------------------------------------------------------------------------------
----- onload/onsave 函数
    function acute_sia_com_pilfer:AddOnLoadFn(fn)
        if type(fn) == "function" then
            table.insert(self._onload_fns, fn)
        end
    end
    function acute_sia_com_pilfer:ActiveOnLoadFns()
        for k, temp_fn in pairs(self._onload_fns) do
            temp_fn(self)
        end
    end
    function acute_sia_com_pilfer:AddOnSaveFn(fn)
        if type(fn) == "function" then
            table.insert(self._onsave_fns, fn)
        end
    end
    function acute_sia_com_pilfer:ActiveOnSaveFns()
        for k, temp_fn in pairs(self._onsave_fns) do
            temp_fn(self)
        end
    end
---------------------------------------------------------------------------------------------------
----- 数据读取/储存
    function acute_sia_com_pilfer:Get(index)
        if index then
            return self.DataTable[index]
        end
        return nil
    end
    function acute_sia_com_pilfer:Set(index,theData)
        if index then
            self.DataTable[index] = theData
        end
    end

    function acute_sia_com_pilfer:Add(index,num)
        if index then
            self.DataTable[index] = (self.DataTable[index] or 0) + ( num or 0 )
            return self.DataTable[index]
        end
        return 0
    end
------------------------------------------------------------------------------------------------------------------------------
---
    function acute_sia_com_pilfer:OnSave()
        self:ActiveOnSaveFns()
        local data =
        {
            DataTable = self.DataTable
        }
        return next(data) ~= nil and data or nil
    end

    function acute_sia_com_pilfer:OnLoad(data)
        if data.DataTable then
            self.DataTable = data.DataTable
        end
        self:ActiveOnLoadFns()
    end
------------------------------------------------------------------------------------------------------------------------------
---
    function acute_sia_com_pilfer:SetSpellFn(fn)
        if type(fn) == "function" then
            self.spell_fn = fn
        end
    end
    function acute_sia_com_pilfer:CastSpell(target)
        if self.spell_fn then
            return self.spell_fn(self.inst,target)
        end
        return true
    end
------------------------------------------------------------------------------------------------------------------------------
return acute_sia_com_pilfer







