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

return Skill
