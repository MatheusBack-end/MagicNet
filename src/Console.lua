local posix = require("posix")
local socket = require("socket")

Console = {}

function Console:new(threads_manager)
  local object =
  {
    threads_manager = threads_manager,
    buffer = ''
  }

  setmetatable(object, self)
  self.__index = self

  --io.stdin:setvbuf("no")

  return object
end

function Console:read_terminal()
  local input_ready = socket.select({io.stdin}, nil, 0)

  if #input_ready ~= 0 then
    print("hi")
  end
end

function Console:run()
  local co = coroutine.create(function ()
    while true do
      self:read_terminal()
      coroutine.yield()
    end
  end)

  self.threads_manager:add(co)
end
