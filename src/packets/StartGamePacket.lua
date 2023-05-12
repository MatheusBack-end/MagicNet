StartGamePacket = {}

function StartGamePacket:new()
    local object = {
        id = 0x04,
        buffer,
        players
    }
    
    setmetatable(object, self)
    self.__index = self
    
    return object
end

function StartGamePacket:decode()
    
end

function StartGamePacket:encode()
    local buffer = Binary:write_byte(self.id)
    local size = 0
    for _ in pairs(self.players) do size = size + 1 end
    buffer = buffer .. Binary:write_int(size)
    
    for key, player in pairs(self.players) do
        buffer = buffer .. Binary:write_float(player.x)
        buffer = buffer .. Binary:write_float(player.y)
        buffer = buffer .. Binary:write_float(player.z)
        
        buffer = buffer .. Binary:write_float(player.rx)
        buffer = buffer .. Binary:write_float(player.ry)
        buffer = buffer .. Binary:write_float(player.rz)
        buffer = buffer .. Binary:write_string(player.id, 10)
        buffer = buffer .. Binary:write_string(player.name, 20)
    end
    
    self.buffer = buffer
end
