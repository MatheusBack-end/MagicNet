Player = {}

function Player:new(ip, port, name, id)
    local object = {
        ip = ip,
        port = port,
        name = name,
        id = id,
        x, y, z
    }
    
    setmetatable(object, self)
    self.__index = self
    
    return object
end