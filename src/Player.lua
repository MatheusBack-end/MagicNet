Player = {}

function Player:new(ip, port, name, id, x, y, z, rx, ry, rz)
    local object = {
        ip = ip,
        port = port,
        name = name,
        id = id,
        life = 100,
        x = x, y = y, z = z,
        rx = rx, ry = ry, rz = rz
    }
    
    setmetatable(object, self)
    self.__index = self
    
    return object
end
