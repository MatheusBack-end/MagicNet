StartGamePacket = {}

function StartGamePacket:new()
  local object =
  {
    id = 0x04,
    buffer = nil,
    players = nil
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function StartGamePacket:decode()
end

function StartGamePacket:encode()
  local buffer = ByteBuffer:new()
  buffer:put_byte(self.id)
  buffer:put_int(self:get_size())

  for key, player in pairs(self.players) do
    buffer:put_vec3(player.position)
    buffer:put_vec3(player.rotation)
    buffer:put_string(player.id)
    buffer:put_string(player.name)
  end

  self.buffer = buffer
end

function StartGamePacket:get_size()
  local size = 0

  for _ in ipairs(self.players) do
    size = size + 1
  end

  return size
end
