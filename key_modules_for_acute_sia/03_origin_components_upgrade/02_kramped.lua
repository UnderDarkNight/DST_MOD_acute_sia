--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    淘气值 组件，是挂载到 TheWorld 里的

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddComponentPostInit("kramped", function(self)

    --------------------------------------------------------------------------------
    ---- 
        local function extractActionCount(inputString, playerId)
            -- 构造模式以匹配Player后面跟的数字，直至'-'，然后寻找'Actions: '后的数字
            local pattern = "Player " .. playerId .. " -[^%d]*Actions: (%d+)"
            
            -- 使用string.match进行匹配，找到并返回第一个匹配的数字
            local actions = string.match(inputString, pattern)
            
            -- 如果找到了匹配项，则转换为number类型并返回
            if actions then
                return tonumber(actions)
            else
                return nil -- 如果没有找到匹配项，返回nil
            end
        end
        local function string_split(inputstr, sep)
            local t={}
            local i=1
            for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
            end
            return t
        end
        -- 获取指定Player ID的动作数量
        local function getPlayerActions(data, playerId)
            -- 使用自定义的split函数分割数据为多行
            local lines = string_split(data, "\n")
            
            -- 遍历每一行
            for _, line in ipairs(lines) do
                -- 模式匹配查找并提取动作数量
                local actions = extractActionCount(line, playerId)
                
                -- 如果找到了匹配项，则返回
                if actions then
                    return actions
                end
            end
            
            return nil -- 如果没有找到对应ID的玩家，则返回nil
        end
    --------------------------------------------------------------------------------
    function self:Sia_GetPlayerKramp(player)
        local data = self:GetDebugString()
        return getPlayerActions(data, player.GUID) or 0
    end
end)