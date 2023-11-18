Player = {}

function Player:new(ip, port, name, id, position, rotation)
  local object =
  {
    ip = ip,
    port = port,
    name = name,
    id = id,
    life = 100,
    position = position,
    rotation = rotation
  }

  setmetatable(object, self)
  self.__index = self

  return object
end
