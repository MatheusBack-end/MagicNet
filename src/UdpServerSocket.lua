-- local modules
local socket = require('socket')
udp = socket:udp()

-- class object
UdpServerSocket = {} -- table

-- object constructor
function UdpServerSocket:new(ip, port) -- string, int
    if port >= 65535 or port <= 0 then
        port = 5000 -- default port
    end
    
    -- object internal filds
    local object = {
        ip = ip,    -- string
        port = port -- int
    }
    
    -- lua metatable
    setmetatable(object, self)
    self.__index = self
    
    -- open server
    self:open_server(ip, port)
    
    return object -- table type UdpServerSocket
end

function UdpServerSocket:open_server(ip, port) -- string, int
    udp:setsockname(ip, port)
    print(ip, port)
end

function UdpServerSocket:send(ip, port, packet) -- string, int, table type Packet
    udp:sendto(packet, ip, port)
end

function UdpServerSocket:receive()
    local ip, port, data = udp:receivefrom()
    return ClientReceiver:new(ip, port, data)
end
