-- @ author : Gyss

local _REGISTER = {
    "CONST_FUNCTIONS",
}

local _Null = function()
    Debug.LogWarning("CONST_FUNCTIONS检索失败，未检索到对应的函数，请检查传参是否正确")
end


local _global_functions_cache = {}

Func = {}

Func.Init = function()
    for _,libName in ipairs(_REGISTER) do
        local _functionLib = require("FrameEmblem/CONST_FUNCTIONS/"..libName)
        for k,v in pairs(_functionLib) do
            if _global_functions_cache[k] then
                Debug.LogWarning("CONST_FUNCTIONS 警告：存在重名函数 "..k)
            else
                _global_functions_cache[k] = v
            end
        end
    end
end

local mt = {
    __index = function(_,k)
        local _result = _global_functions_cache[k]
        if _result then
            return _result
        else
            Debug.LogWarning("CONST_FUNCTIONS 警告：未找到对应函数，请检查传参 "..k) 
            return _Null
        end
    end,

    __newindex = function(_,k)
        Debug.LogWarning("CONST_FUNCTIONS 警告：试图向只读的CONST_FUNCTIONS表中添加函数 "..k)
    end,

    __call = function(k)
        local _result = _global_functions_cache[k]
        if _result then
            return _result
        else
            Debug.LogWarning("CONST_FUNCTIONS 警告：未找到对应函数，请检查传参 "..k) 
            return _Null
        end
    end
}

setmetatable(Func, mt)

return Func
