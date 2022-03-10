-- @author Hanzoy

--[[Pawn类
    成员变量（属性）
    Stats stats                 棋子的属性表 表中仅含有数据，不包含任何操作
    table<int, Buff> buffs      棋子的buff表，值弱表 对buff的操作必须使用Buff类的函数进行 不允许直接对表进行操作
    table<int, Skill> skills    棋子的skill表，值弱表 对skill的操作必须使用Skill类的函数进行 不允许直接对表进行操作
    string teamBelongsTo        棋子所属的队伍
    object objRef               棋子的引用 这里引用的是场景中的实际物体
    TilePos tilePos             棋子所在的地图坐标 并非场景坐标，而是以Tile为单位保存的坐标
    string AuthID               认证id

    成员函数（方法）
    Pawn initialize()                                               初始化棋子 创建一个新的棋子
    Pawn initialize(object objRef, string teamBelongsTo)            初始化棋子 创建一个新的棋子 如果传入了objRef，则将objRef设置为传入的objRef 如果传入了teamBelongsTo，则将teamBelongsTo设置为传入的teamBelongsTo
    Pawn Clone(Pawn clonedTarget, TilePos targetTilePos)            基于Pawn克隆一个棋子，默认克隆自身(第一个参数为隐含)
    Pawn CopyFrom(Pawn copiedTarget)                                从copiedTarget处拷贝全部的属性（深拷贝） 
    auto GetStats(string statName)                                  获取指定属性的值
    void SetStats(string statName, auto value)                      设置指定属性的值
    void SetTilePos(TilePos tilePos)                                重设棋子的tilePos
    void MoveTo(TilePos targetTilePos)                              移动棋子到指定的地图坐标
    void MoveFromTo(TilePos originTilePos, TilePos targetTilePos)
    void AddBuff(Buff buff)                                         增加buff
    void RemoveBuff(Buff buff)                                      移除buff
]]

local Stats = require('FrameEmblem/BaseClass/Stats')
local TilePos = require('FrameEmablem/Utils/TilePos')
local Pawn = class("Pawn")

-- Pawn的构造函数
function Pawn:initialize(objRef, teamBelongsTo)
    self.stats = Stats:init()
    self.buffs = setmetatable({}, {__mode = 'v'})
    self.skills = setmetatable({}, {__mode = 'v'})

    --暂时默认nil
    self.objRef = objRef or nil
    self.teamBelongsTo = teamBelongsTo or nil
    self.tilePos = nil

    self.AuthID = GenerateID()
end

function Pawn:Clone(targetTilePos)
    local newPawn = Pawn:new()
    newPawn.stats = DeepCopy(self.stats)
    newPawn.buffs = DeepCopy(self.buffs)
    newPawn.skills = DeepCopy(self.skills)
    newPawn.objRef = self.objRef
    newPawn.teamBelongsTo = self.teamBelongsTo
    newPawn.tilePos = targetTilePos or self.tilePos
    newPawn.AuthID = GenerateID()
    return newPawn
end

function Pawn:CopyFrom(copiedTarget)
    self.stats = DeepCopy(copiedTarget.stats)
    self.buffs = DeepCopy(copiedTarget.buffs)
    self.skills = DeepCopy(copiedTarget.skills)
    self.objRef = copiedTarget.objRef
    self.teamBelongsTo = copiedTarget.teamBelongsTo
    self.tilePos = copiedTarget.tilePos
end

function Pawn:GetStats(statName)
    if self.stats[statName] then
        return self.stats[statName]
    else
        Debug.LogWarning('Pawn.GetStats 警告：没有找到指定属性')
    end
end

function Pawn:SetStats(statName, value)
    if self.stats[statName] then
        self.stats[statName] = value
    else
        Debug.LogWarning('Pawn.SetStats 警告：没有找到指定属性')
    end
end

function Pawn:SetTilePos( tilePos )
    if self.isInstanceOf(tilePos, TilePos) then
        if self.tilePos ~= tilePos then
            self.tilePos = tilePos
        end
    else
        Debug.LogWarning('Pawn.SetTilePos 警告：tilePos类型不合法')
    end
end

function Pawn:MoveTo( targetTilePos )
    self:MoveFromTo(self.tilePos, targetTilePos)
end

function Pawn:MoveFromTo(originTilePos, targetTilePos)
    if self.isInstanceOf(originTilePos, TilePos) and self.isInstanceOf(originTilePos, TilePos) then
        if self.tilePos ~= originTilePos then
            self.tilePos = originTilePos
        end
        -- Event OnMove
        self.tilePos = targetTilePos
    else
        Debug.LogWarning('Pawn.MoveTo 警告：参数类型不合法')
    end
end

function Pawn:AddBuff( buff )
    table.insert(self.buffs, buff)
end

function Pawn:RemoveBuff(buff)
    for k,v in ipairs(self.buffs) do
        if v == buff then
            table.remove(self.buffs, k)
            break
        end
    end
end

-- 暂时不清楚AuthID生成规则
function GenerateID()
    return 1
end

function DeepCopy(object)
    local tempTable = {}
    local function _copy(obj)
        if type(obj) ~= 'table' then
            return obj;
        elseif tempTable[obj] then
            return tempTable[obj]
        end
        local newTable = {}
        tempTable[obj] = newTable
        for k, v in ipairs(obj) do
            newTable[_copy(k)] = _copy(v)
        end
        return setmetatable(newTable, getmetatable(obj))
    end
    return _copy(object)
end

return Pawn
