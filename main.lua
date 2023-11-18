require('ioutil')
require('src/utils/Log')
require('src/Binary')
require('src/Server')
require('src/Node')
require('src/LinkedList')
require('src/ByteBuffer')
require('src/Vector3')
require('src/ThreadsManager')
require('src/Console')
require('src/ClientReceiver')
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

local log = '[' .. os.date('%I:%M:%S %p') .. ']' .. '[info] '
--print(log .. 'server started!')
Log:info("server started!!")

local ip = parse[1].host
local port = tonumber(parse[1].port)

local thread_manager = ThreadsManager:new()
local session_manager = SessionManager:new(UdpServerSocket:new(ip, port), thread_manager)
session_manager:run()
Console:new(thread_manager, session_manager):run()
thread_manager:run()
