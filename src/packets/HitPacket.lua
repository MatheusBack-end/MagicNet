HitPacket = {}

function HitPacket:new()
  local object = {
    buffer = nil,
    id = 0x9,
    client_id = nil,
    damager_id = nil
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function HitPacket:decode()
  self.damager_id = Binary:read_string(string.sub(self.buffer, 12), 10)
  self.client_id = Binary:read_string(string.sub(self.buffer, 2), 10)
end

function HitPacket:encode()
  --
end
