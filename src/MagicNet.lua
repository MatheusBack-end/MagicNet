require('src/autoload')

Log:info("server started!!")

local ip = "0.0.0.0"
local port = 19132

local thread_manager = ThreadsManager:new()
local session_manager = SessionManager:new(UdpServerSocket:new(ip, port), thread_manager)
session_manager:run()
Console:new(thread_manager, session_manager):run()
thread_manager:run()
