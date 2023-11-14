CreateSessionPacket = {}

function CreateSessionPacket:new()
    local object = {
        buffer = nil,
        id = 0x01,
        client_id = nil,
        player_name = nil,
        position = nil,
        rotation = nil
    }

    setmetatable(object, self)
    self.__index = self

    return object
end

function CreateSessionPacket:decode()
  self.client_id = self.buffer:get_string()
  self.player_name = self.buffer:get_string()
  self.position = self.buffer:get_vec3()
  self.rotation = self.buffer:get_vec3()
end

function CreateSessionPacket:encode()
  local buffer = ByteBuffer:new()

  buffer:put_byte(self.id)
  buffer:put_string(self.client_id)
  buffer:put_string(self.player_name)
  buffer:put_vec3(self.position)
  buffer:put_vec3(self.rotation)

  self.buffer = buffer
end
