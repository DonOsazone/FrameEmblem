--- @author Gyss

--[[Buff类

    成员变量(属性)
    string name     buff的名称
    int layer       buff的层数（例如中毒Buff可能有多层，每层都会造成伤害）
    int duration    bfuu的持续时间（单位为回合）    设为-1时，表示无限持续
    Pawn target     buff的目标（即Buff附加在哪个棋子身上）
    Pawn from       buff的来源（即Buff从哪个棋子身上附加）  该属性为私有，仅有Buff类自身可以访问    该属性可以用于处理诸如【吸血】等效果
    function buffEffect  buff的效果（即buff的效果函数）  当Buff触发时，会调用该函数（自定义？）

    成员函数（方法）
    Buff initialize(Buff other)               初始化buff    可以基于其他Buff进行拷贝，也可以自定义buff
    Buff initialize(string name,function buffEffect)
    Buff initialize(string name,function buffEffect,int layer,int duration)
    void SetBuffFrom(Pawn from)                设置buff的来源，将Buff的from属性设置为传入的from     该函数仅能执行一次
]]

--@class Buff

local Buff = {}

local _private = setmetatable({},{__mode = "k"})

--- @function initialize
---
function Buff:initialize(OtherOrName,buffEffect,layer,duration)
    if OtherOrName:isInstanceOf(Buff) then
        self.name = OtherOrName.name
        self.layer = OtherOrName.layer
        self.duration = OtherOrName.duration
        self.target = OtherOrName.target
        self.buffEffect = OtherOrName.buffEffect
    elseif type(OtherOrName) == "string" then
        self.name = OtherOrName.name
        self.buffEffect = buffEffect or function() end
        self.layer = layer or 1
        self.duration = duration or -1
    end
end

function Buff:SetBuffFrom(_from)
    if self:isInstanceOf(Buff) then
        _private[self] = {from = _from}
        self.SetBuffFrom = function() 
            Debug.LogWarning("Buff.SetBuffFrom 警告：不能对Buff的来源进行二次修改") 
        end
    else
        Debug.LogWarning("Buff.SetBuffFrom 警告：该函数仅能作为实例的成员函数调用")
    end
end

function Buff:Spell(...)
    (type(self.buffEffect) == "function" and self.buffEffect or Func(self.buffEffect))(...)
end



