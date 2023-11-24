Vector3 = {}

function Vector3:new(x, y, z)
  local object =
  {
    x = x,
    y = y,
    z = z
  }

  setmetatable(object, self)
  self.__index = self

  return object
end
