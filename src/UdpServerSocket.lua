local socket = require('socket')
local udp = socket:udp()

UdpServerSocket = {}

function UdpServerSocket:new(ip, port)
  if port >= 65535 or port <= 0 then
    port = 5000
  end

  local object =
  {
    ip = ip,
    port = port
  }

  setmetatable(object, self)
  self.__index = self

  self:open_server(ip, port)

  return object
end

function UdpServerSocket:open_server(ip, port)
  udp:setsockname(ip, port)
  udp:settimeout(0)
end

function UdpServerSocket:send(ip, port, packet)
  udp:sendto(packet, ip, port)
end

function UdpServerSocket:receive()
  local data, ip, port = udp:receivefrom()
  return ClientReceiver:new(ip, port, data)
end
