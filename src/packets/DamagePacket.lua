DamagePacket = {}

function DamagePacket:new()
  local object = {
    id = 0x06,
    buffer,
    client_id,
    player_name
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function DamagePacket:decode()
  self.client_id = Binary:read_string(string.sub(self.buffer, 2, 12), 10)
  self.player_name = Binary:read_string(string.sub(self.buffer, 12), 20)
end

function DamagePacket:encode()

end
