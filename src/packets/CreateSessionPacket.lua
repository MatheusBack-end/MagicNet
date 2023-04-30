CreateSessionPacket = {}

function CreateSessionPacket:new()
    local object = {
        buffer,
        id = 0x01,
        client_id,
        x, y, z
    }
    
    setmetatable(object, self)
    self.__index = self
    
    return object
end

function CreateSessionPacket:decode()
    self.x = Binary:read_float(string.sub(self.buffer, 2, 6))
    self.y = Binary:read_float(string.sub(self.buffer, 6, 10))
    self.z = Binary:read_float(string.sub(self.buffer, 10, 14))
    
    self.client_id = Binary:read_string(string.sub(self.buffer, 14), 10)
end

function CreateSessionPacket:encode()
    local buffer = Binary:write_byte(self.id)
    buffer = buffer .. Binary:write_float(self.x)
    buffer = buffer .. Binary:write_float(self.y)
    buffer = buffer .. Binary:write_float(self.z)
    buffer = buffer .. Binary:write_string(self.client_id, 20)
    
    self.buffer = buffer
end