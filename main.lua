require('src/Binary')
require('src/Node')
require('src/LinkedList')
require('src/ByteBuffer')
require('src/Vector3')
require('src/UdpServerSocket')
require('src/packets/Packet')
require('src/packets/PingPacket')
require('src/packets/CreateSessionPacket')
require('src/packets/CloseSessionPacket')
require('src/packets/StartGamePacket')
require('src/packets/SoundPacket')
require('src/packets/HitPacket')
require('src/packets/UpdatePositionPacket')
require('src/SessionManager')
require('src/Player')

local yaml = require('lyaml')
local conf = io.open("conf.yaml", "r"):read("*all")
local parse = yaml.load(conf, { all = true })

print('server started!')

local ip = parse[1].host
local port = tonumber(parse[1].port)

local tst = SessionManager:new(UdpServerSocket:new(ip, port)):run()
