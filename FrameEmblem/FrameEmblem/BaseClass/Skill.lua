--[[Skill类：
    -- 成员变量（属性） --
    + string name   技能的名称
    + int mpCost    技能的魔法消耗
    + int cd        技能的冷却时间
    + hashtable  prop   技能的特殊属性（如范围，方向，持续回合等等，用户可自定义）
    + function skillEffect  技能的效果
    + table<int,Skill> subSkill     子技能表
    + int subSkill_num 子技能中技能的数量
    -- 成员函数（方法） --
    + Skill initialize(Skill other)
    + Skill initialize(string name, function skillEffect)
    + Skill initialize(string name, function skillEffect, int mpCost, int cd)
]] --

--[[
    定义类Skill
]]
Skill = class('Skill')

Skill.static.LAYER = 8 --技能调用的嵌套层数，实际为该值的-1层！！（eg：LAYER = 8，则嵌套层数为7）

--[[一些局部变量，用于子技能表的使用]]--
local skillTable = {}
local subSkillNumTable = {}
local fSkill = 0
local tSkill = 1

--[[
    Skill类的构造函数
]]
function Skill:initialize(name, skillEffect,prop)
    self.name = name
    self.skillEffect = skillEffect
    self.subSkill = {}
    self.subSkill_num = #self.subSkill
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
    self.subSkill_num = #self.subSkill
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
    self.subSkill_num = #self.subSkill
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
--! TODO
--[[
    增加相关属性，用于显示和确定技能的攻击范围
    （需要考虑设计新的数据结构或新的表结构）
]]
--[[
    Skill类的子技能调用函数
    --变量解释：
        skillTable是存储skill的实例的表，包括当前的主技能及其子技能（但是同一技能的子技能在同一时间只有一个技能
        储存于表中！！这也是为什么需要使用subSkillNumTable的原因）
        subSkillNumTable是用于记录调用skillTable中的技能已使用的子技能数量（int型）的表
        fSkill是一个int型，在数值上可理解为skillTable的长度
        tSkill是一个int型，功能为检测子技能的嵌套层数是否合法
    --逻辑解释：
        一开始将当前的主技能放入skillTable中，正式开始子技能的调用和嵌套
        当skillTable不为空时，进行循环，当层数合法且当前技能的子技能未全部调用时，将当前技能的未使用的子技能中的第一个放入
        skillTable，再把这个刚刚放入表中的技能当做当前技能，重复刚才的循环，如果当前技能的子技能全部用完或嵌套层数已满，则
        去掉skillTable的最后一个技能，把它的父技能当做当前技能重复一开始的循环，直至表为空。
]]
function Skill:subSkill_Use()
    skillTable[tSkill] = self
    subSkillNumTable[tSkill] = 0
    AddSkillNum()
    while(fSkill ~= 0) do --当检测技能表不为空时
        if(tSkill <= self.LAYER and skillTable[fSkill].subSkill_num ~= subSkillNumTable[fSkill]) then --监测技能表中的当前技能的子技能未调用完成时
            subSkillNumTable[fSkill] = subSkillNumTable[fSkill] + 1 --当前技能使用的子技能数量增加1
            skillTable[tSkill] = skillTable[fSkill].subSkill[subSkillNumTable[fSkill]] --将当前技能的子技能放入监测技能表中
            subSkillNumTable[tSkill] = 0 --将当前技能的子技能加入子技能数量监测表
            skillTable[tSkill].skillEffect() --使用当前技能的子技能
            AddSkillNum() --当前技能变为原先当前技能的子技能
        else
            table.remove(skillTable)--去掉检测技能表的最后一位（当前技能无子技能或已达嵌套层数）
            table.remove(subSkillNumTable) --相对应去掉子技能数量检测表中的最后一位
            DelSkillNum()--当前技能变为原先当前技能的父技能
        end
    end   
end
--[[
    Skill类的设置特殊属性的函数
    直接修改Skill类中的prop（哈希表）
    eg：prop['range'] = 5
    建议propName使用string类型
]]
function Skill:SetProp(propName,value)
    self.prop[propName] = value
end
--[[
    Skill类的获得特殊属性的函数
    直接根据属性名获取prop（哈希表）中对应的值
]]
function Skill:GetProp(propName)
    return self.prop[propName]
end

function AddSkillNum()
    fSkill = fSkill + 1
    tSkill = tSkill + 1
end
function DelSkillNum()
    fSkill = fSkill - 1
    tSkill = tSkill - 1
end

return Skill
