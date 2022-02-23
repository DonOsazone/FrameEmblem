-- 框架的客户端主循环

local FEC, this = Ava.Util.Mod.New('FrameEmblemClient', ClientBase)


function FEC:Init(params)
    -- 客户端模块的初始化操作
    print("客户端初始化")
end


return FEC
