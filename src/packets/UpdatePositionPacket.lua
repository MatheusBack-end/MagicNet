UpdatePositionPacket = {}

function UpdatePositionPacket:new()
    local object = {
        buffer,
        id = 0x02,
        client_id,
        x, y, z,
        rx, ry, rz
    }
    
    setmetatable(object, self)
    self.__index = self
    
    return object
end

function UpdatePositionPacket:decode()
    self.x = Binary:read_float(string.sub(self.buffer, 2, 6))
    self.y = Binary:read_float(string.sub(self.buffer, 6, 10))
    self.z = Binary:read_float(string.sub(self.buffer, 10, 14))
    
    self.rx = Binary:read_float(string.sub(self.buffer, 14, 18))
    self.ry = Binary:read_float(string.sub(self.buffer, 18, 22))
    self.rz = Binary:read_float(string.sub(self.buffer, 22, 26))
    
    self.client_id = Binary:read_string(string.sub(self.buffer, 26), 10)
end

function UpdatePositionPacket:encode()
        
end