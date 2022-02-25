--[[Skill类：
    -- 成员变量（属性） --
    + string name   技能的名称
    + int mpCost    技能的魔法消耗
    + int cd        技能的冷却时间
    + function skillEffect  技能的效果
    + table<int,Skill> subSkill     技能表(树状)
    -- 成员函数（方法） --
    + Skill initialize(Skill other)
    + Skill initialize(string name, function skillEffect)
    + Skill initialize(string name, function skillEffect, int mpCost, int cd)
]] --

--[[
    定义类Skill
]]
Skill = class('Skill')

--[[
    Skill类的构造函数
]]
function Skill:initialize(name, skillEffect)
    self.name = name
    self.skillEffect = skillEffect
    self.subSkill = {}
end

--[[
    Skill类的构造函数
]]
function Skill:initialize(other)
    self.name = other.name
    self.cd = other.cd
    self.mpCost = other.mpCost
    self.skillEffect = other.skillEffect
    self.subSkill = {}
    -- 深拷贝子技能表
    for k, v in ipairs(other.subSkill) do
        self.subSkill[k] = v
    end
end

--[[
    Skill类的构造函数
]]
function Skill:initialize(name, skillEffect, mpCost, cd)
    self.name = name
    self.mpCost = mpCost
    self.cd = cd
    self.skillEffect = skillEffect
    self.subSkill = {}
end

--! TODO
--[[
    增加一个Spell函数，用于发动技能
    函数调用后，首先调用自身的skillEffect函数，然后遍历subSkill依次发动
    需要注意死循环的情况
    （例如，技能本体释放结束后调用了子技能A，子技能A调用了B，B调用了C，C调用了A，这种情况会不可避免地导致死循环
    因此，必须规定最大的技能调用层数，超出最大调用层数的技能不会再调用）
]]

--! TODO
--[[
    增加相关属性，用于显示和确定技能的攻击范围
    （需要考虑设计新的数据结构或新的表结构）
]]



return Skill
