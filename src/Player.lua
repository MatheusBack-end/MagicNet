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
    rotation = rotation,
    last_ping =  0
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function Player:apply_damage(damage)
  self.life = self.life - damage

  if self.life <= 0 then
    Server:die_player(self)
  end
end
