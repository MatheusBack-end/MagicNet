CreateSessionPacket = {}

function CreateSessionPacket:new()
    local object = {
        buffer,
        id = 0x01,
        client_id,
        player_name,
        x, y, z,
        rx, ry, rz
    }
    
    setmetatable(object, self)
    self.__index = self
    
    return object
end

function CreateSessionPacket:decode()
    self.client_id = Binary:read_string(string.sub(self.buffer, 2, 12), 10)
    --print(self.client_id)
    self.player_name = Binary:read_string(string.sub(self.buffer, 12, 32), 20)
    --print(self.player_name)
    
    self.x = Binary:read_float(string.sub(self.buffer, 32, 36))
    self.y = Binary:read_float(string.sub(self.buffer, 36, 40))
    self.z = Binary:read_float(string.sub(self.buffer, 40, 44))
    
    self.rx = Binary:read_float(string.sub(self.buffer, 44, 48))
    self.ry = Binary:read_float(string.sub(self.buffer, 48, 52))
    self.rz = Binary:read_float(string.sub(self.buffer, 52, 55))
    
end

function CreateSessionPacket:encode()
    local buffer = Binary:write_byte(self.id)
    buffer = buffer .. Binary:write_float(self.x)
    buffer = buffer .. Binary:write_float(self.y)
    buffer = buffer .. Binary:write_float(self.z)
    buffer = buffer .. Binary:write_string(self.client_id, 20)
    
    self.buffer = buffer
end