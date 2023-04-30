local socket = require('socket')
local bin = require('struct')
local udp = socket:udp()
PingPacket = {}

function PingPacket:new()
    object = {
        id = 0x00,
        buffer = nil,
        ping_id = nil,
        players_count = nil
    }
    
    setmetatable(object, self)
    self.__index = self
    
    return object
end

function PingPacket:decode()
    local b = string.sub(self.buffer, 2)
    local c = bin.unpack("<i", b)
    self.players_count = c
end

function PingPacket:encode() 
    
    local pk = bin.pack('<b', self.id)
    pk = pk .. bin.pack("d", self.ping_id)
    self.buffer = pk
end

function ping()
    timestamp = socket.gettime()
    local packet = PingPacket:new()
    packet.ping_id = timestamp
    packet:encode()

udp:sendto(packet.buffer, '127.0.0.1', 5000)

local response, err = udp:receive()


local rtt = socket.gettime() - timestamp
local ping = rtt
print(ping)
local pk = PingPacket:new()
pk.buffer = response
pk:decode()

end

ping()
t = os.time() + 1
--[[
while true do
    if os.time() >= t then
        ping()
        t = os.time() + 1
    end
end
]]--



