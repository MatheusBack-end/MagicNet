require('autoload')

local conf = io.open("conf.yaml", "r"):read("*all")
local parse = yaml.load(conf, { all = true })

Log:info("server started!!")

local ip = parse[1].host
local port = tonumber(parse[1].port)

local thread_manager = ThreadsManager:new()
local session_manager = SessionManager:new(UdpServerSocket:new(ip, port), thread_manager)
session_manager:run()
Console:new(thread_manager, session_manager):run()
thread_manager:run()
