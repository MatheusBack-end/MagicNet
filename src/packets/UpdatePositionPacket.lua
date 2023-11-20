UpdatePositionPacket = {}

function UpdatePositionPacket:new()
  local object =
  {
    buffer = nil,
    client_id = nil,
    position = nil,
    rotation = nil
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function UpdatePositionPacket:decode()
  self.position = self.buffer:get_vec3()
  self.rotation = self.buffer:get_vec3()
  self.client_id = self.buffer:get_string()
end

function UpdatePositionPacket:encode()
end
