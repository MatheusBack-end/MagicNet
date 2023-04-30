PingPacket = {}

function PingPacket:new()
    local object = {
        buffer = buffer,
        players_count = 0
    }
    
    setmetatable(object, self)
    self.__index = self
    
    return object
end

function PingPacket:encode()
    local pk = Binary:write_byte(0x00)
    pk = pk .. Binary:write_int(self.players_count)
    self.buffer = pk
end

function PingPacket:decode()
    
end
