-- 框架的服务端主循环


local FES, this = Ava.Util.Mod.New('FrameEmblemServer', ServerBase)


function FES:Init(params)
    -- 客户端模块的初始化操作
    print("服务端初始化")
end


return FES