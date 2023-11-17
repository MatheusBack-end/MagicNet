PingPacket = {}

function PingPacket:new()
  local object =
  {
    buffer = nil,
    players_amount = 0
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function PingPacket:encode()
  local buffer = ByteBuffer:new()
  buffer:put_byte(0)
  buffer:put_int(self.players_amount)

  self.buffer = buffer
end

function PingPacket:decode()
end
