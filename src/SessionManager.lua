SessionManager = {}

function SessionManager:new(udp_server, thread_manager)
  local object =
  {
    udp_server = udp_server,
    thread_manager = thread_manager,
    players = {},
    players_amount = 0
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function SessionManager:receive_packets()
  local client = self.udp_server:receive()

  if client.data == nil then
    return
  end

  local buffer = ByteBuffer:new()
  buffer:put(client.data)

  local pid = buffer:get_byte()

  if pid == 0x0 then
    local packet = PingPacket:new()
    packet.players_amount = Server:get_players_amount()
    packet:encode()

    self.udp_server:send(client.ip, client.port, packet.buffer:get())
  end

  if pid == 0x01 then
    local packet = CreateSessionPacket:new()
    packet.buffer = buffer
    packet:decode()

    if self:get_player(packet.client_id) == nil then
      local pk = StartGamePacket:new()
      pk.players = self.players
      pk:encode()

      self.udp_server:send(client.ip, client.port, pk.buffer:get())
      self:create_player(packet.client_id, packet.player_name, packet.position, packet.rotation, client.ip, client.port)
      self:broadcast_less_sender(client.data, packet.client_id)
    end

    self:update_health_ping(packet.client_id)
  end

  if pid == 0x02 then
    local packet = UpdatePositionPacket:new()
    packet.buffer = buffer
    packet:decode()

    self:broadcast_less_sender(client.data, packet.client_id)
    self:update_health_ping(packet.client_id)
  end

  if pid == 0x05 then
    local packet = close_session_packet:new()
    packet.buffer = buffer
    packet:decode()

    if self:get_player(packet.client_id) then
      self:remove_player(packet.client_id, "close")
      self:broadcast(client.data)
    end
  end

  if pid == 0x09 then
    local packet = HitPacket:new()
    packet.buffer = client.data
    packet:decode()

    self:broadcast_less_sender(client.data, packet.damager_id)
    print(packet.damager_id .. " hit caralho!!! " .. packet.client_id)
    self:update_health_ping(packet.damager_id)
  end
end

function SessionManager:broadcast(buffer)
  for key, value in pairs(self.players) do
    self.udp_server:send(self.players[key].ip, self.players[key].port, buffer)
  end
end

function SessionManager:broadcast_less_sender(buffer, sender_id)
  for key, value in pairs(self.players) do
    if key ~= sender_id then
      self.udp_server:send(self.players[key].ip, self.players[key].port, buffer)
    end
  end
end

function SessionManager:remove_player(client_id, reason)
  self.players[client_id] = nil
  Log:info("player id" .. client_id .. " disconnected! " .. "[" .. reason .. "]")
  Server:remove_player()
end

function SessionManager:create_player(client_id, name, position, rotation, ip, port)
  self.players[client_id] = Player:new(ip, port, name, client_id, position, rotation)
  Log:info("player id " .. client_id .. " join in server!")
  Server:add_player()
end

function SessionManager:get_player(client_id)
  return self.players[client_id]
end

function SessionManager:get_diff(last_ping)
  return os.clock() - last_ping
end

function SessionManager:update_health_ping(client_id)
  self:get_player(client_id).last_ping = os.clock()
end

function SessionManager:timeout_players()
  for key, value in pairs(self.players) do
    if self:get_diff(value.last_ping) > 5 then
      --print("player: " .. value.name .. " has ben disconnected! [timeout]")
      self:remove_player(value.id, "timeout")
      return
    end
  end
end

function SessionManager:run()
  local co = coroutine.create(function ()
    while true do
      self:timeout_players()
      self:receive_packets()
      --self:timeout_players()
      coroutine.yield()
    end
  end)

  self.thread_manager:add(co)
end

function count(table)
  local size = 0
  for _ in pairs(table) do size = size + 1 end
  return size
end
