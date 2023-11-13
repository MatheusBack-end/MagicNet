SoundPacket = {}

function SoundPacket:new()
  local object = {
    buffer,
    id = 0x03,
    client_id,
    sound_name,
    x, y, z
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function SoundPacket:decode()
  self.sound_name = Binary:read_string(string.sub(self.buffer, 2, 22), 20)
  self.x = Binary:read_float(string.sub(self.buffer, 22, 26))
  self.y = Binary:read_float(string.sub(self.buffer, 26, 30))
  self.z = Binary:read_float(string.sub(self.buffer, 30, 34))
  self.client_id = Binary:read_string(string.sub(self.buffer, 34, 43), 10)
end

function SoundPacket:encode()
end
