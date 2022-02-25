--@晨明_NUAA

--[[Skill类：
    -- 成员变量（属性） --
    + string name   技能的名称
    + int mpCost    技能的魔法消耗
    + int cd        技能的冷却时间
    + hashtable  prop   技能的特殊属性（如范围，方向，持续回合等等，用户可自定义）
    + function skillEffect  技能的效果
    + table<int,Skill> subSkill     子技能表
    + table<int,table> skillTable   技能在调用它的子技能时记录用的临时表（一个静态成员）
    -- 成员函数（方法） --
    + Skill initialize(Skill other)
    + Skill initialize(string name, function skillEffect)
    + Skill initialize(string name, function skillEffect, int mpCost, int cd)
]] --

--[[
    定义类Skill
]]
Skill = class('Skill')

Skill.static.LAYER = 7 --技能调用的嵌套层数
Skill.static.skillTable = {} --技能在调用它的子技能时记录用的临时表（一个静态成员）

--[[
    Skill类的构造函数
]]
function Skill:initialize(name, skillEffect,prop)
    self.name = name
    self.skillEffect = skillEffect
    self.subSkill = {}
    for _, v in pairs(prop) do
        self.prop[_] = v
    end

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
    for _, v in pairs(other.prop) do
        self.prop[_] = v
    end
end

--[[
    Skill类的构造函数
]]
function Skill:initialize(name, skillEffect, mpCost, cd,prop)
    self.name = name
    self.mpCost = mpCost
    self.cd = cd
    self.skillEffect = skillEffect
    self.subSkill = {}
    for _, v in pairs(prop) do
        self.prop[_] = v
    end
end

--! TODO
--[[
    增加一个Spell函数，用于发动技能
    函数调用后，首先调用自身的skillEffect函数，然后遍历subSkill依次发动
    需要注意死循环的情况
    （例如，技能本体释放结束后调用了子技能A，子技能A调用了B，B调用了C，C调用了A，这种情况会不可避免地导致死循环
    因此，必须规定最大的技能调用层数，超出最大调用层数的技能不会再调用）
]]
function Skill:Spell()
    self.skillEffect()
    if(self.subSkill_num ~= 0) then
        self.subSkill_Use()
    end
end
--[[
    Skill类的subSkill_Use函数
    --功能解释：
        在本技能的Spell函数被调用且子技能存在时自动调用
        将当前层数作为键，子技能作为值存入Skill类的skillTable中
        然后依次对子技能进行调用，使用完子技能后将其从SkillTable中移除
        （使用了递归的方法）
]]
function Skill:subSkill_Use()
    if(#self.skillTable<=self.LAYER) then
        table.insert(self.skillTable,self.subSkill)
        for i=1,#self.subSkill,1 do
            self.subSkill[i].Spell()
        end
        table.remove(self.skillTable)
    end
end


return Skill
