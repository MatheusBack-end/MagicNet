ThreadsManager = {}

function ThreadsManager:new()
  local object =
  {
    threads = {}
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function ThreadsManager:add(thread)
  table.insert(
    self.threads,
    thread
  )
end

function ThreadsManager:run()
  while true do
    for i in pairs(self.threads) do
      coroutine.resume(self.threads[i])
    end
  end
end
