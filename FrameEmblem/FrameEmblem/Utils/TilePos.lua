--- @author Gyss

local TilePos = class('TilePos')

function TilePos:initialize(arg1, arg2, arg3)
    if arg1 then
        if self.isInstanceOf(arg1, TilePos) then
            self.x = arg1.x
            self.y = arg1.y
            self.z = arg1.z
        else
            self.x = type(arg1) == 'number' and arg1 or 0
            self.y = type(arg2) == 'number' and arg2 or 0
            self.z = type(arg3) == 'number' and arg3 or 0
        end
    else
        self.x = 0
        self.y = 0
        self.z = 0
    end
end

function TilePos:__eq(other)
    if self.isInstanceOf(other, TilePos) then
        return self.x == other.x and self.y == other.y and self.z == other.z
    else
        Debug.LogWarning('TilePos 警告：传入参数不合法，非法操作：将TilePos与非TilePos进行运算')
        return false
    end
end

function TilePos:__add(other)
    if self.isInstanceOf(other, TilePos) then
        return TilePos(self.x + other.x, self.y + other.y, self.z + other.z)
    else
        Debug.LogWarning('TilePos 警告：传入参数不合法，非法操作：将TilePos与非TilePos进行运算')
        return self
    end
end

function TilePos:__add(other)
    if self.isInstanceOf(other, TilePos) then
        return TilePos(self.x - other.x, self.y - other.y, self.z - other.z)
    else
        Debug.LogWarning('TilePos 警告：传入参数不合法，非法操作：将TilePos与非TilePos进行运算')
        return self
    end
end

function TilePos:__mul(other)
    if self.isInstanceOf(other, TilePos) then
        return self.x * other.x + self.y * other.y + self.z * other.z
    elseif type(other) == 'number' then
        return TilePos(self.x * other, self.y * other, self.z * other)
    else
        Debug.LogWarning('TilePos 警告：传入参数不合法，非法操作：将TilePos与非TilePos且非number进行运算')
        return self
    end
end

function TilePos:__pow(other)
    if self.isInstanceOf(other, TilePos) then
        return TilePos(
            self.y * other.z - self.z * other.y,
            self.z * other.x - self.x * other.z,
            self.x * other.y - self.y * other.x
        )
    else
        Debug.LogWarning('TilePos 警告：传入参数不合法，非法操作：将TilePos与非TilePos进行运算')
        return self
    end
end

function TilePos:__unm()
    return TilePos(-self.x,-self.y,-self.z)
end

return TilePos

