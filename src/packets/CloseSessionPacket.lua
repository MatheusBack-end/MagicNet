close_session_packet = {}

function close_session_packet:new()
  local object =
  {
    buffer = nil,
    client_id = nil
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function close_session_packet:decode()
  self.client_id = self.buffer:get_string()
end

function close_session_packet:encode()
end
