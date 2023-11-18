Console = {}

function Console:new(threads_manager, session_manager)
  local object =
  {
    threads_manager = threads_manager,
    session_manager = session_manager
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function Console:read_terminal()
  local input = ioutil.read_nb()

  if input then
    input = input:gsub("\n", "")

    if input == "stop" then
      Log:info("server stopped!!")
      os.exit(1)
    end

    if input == "list" then
      Log:info(Server:get_players_amount() .. " players")
    end
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
