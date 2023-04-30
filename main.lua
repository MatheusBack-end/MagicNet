require('src/Binary')
require('src/UdpServerSocket')
require('src/packets/Packet')
require('src/packets/PingPacket')
require('src/packets/CreateSessionPacket')
require('src/packets/CloseSessionPacket')
require('src/packets/StartGamePacket')
require('src/packets/UpdatePositionPacket')
require('src/SessionManager')
require('src/Player')

print('server started!')

local tst = SessionManager:new(UdpServerSocket:new('*', 6666)):run()