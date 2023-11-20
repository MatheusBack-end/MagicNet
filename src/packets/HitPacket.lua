HitPacket = {}

function HitPacket:new()
  local object = {
    buffer = nil,
    client_id = nil,
    damager_id = nil
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function HitPacket:decode()
  self.damager_id = self.buffer:get_string()
  self.client_id = self.buffer:get_string()
end

function HitPacket:encode()
end
