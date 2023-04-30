close_session_packet = {}

function close_session_packet:new()
    local object = {
        buffer,
        pid = 0x05,
        client_id
    }
    
    setmetatable(object, self)
    self.__index = self
    
    return object
end

function close_session_packet:decode()
    self.client_id = Binary:read_string(string.sub(self.buffer, 2), 10)
end

function close_session_packet:encode()
    
end