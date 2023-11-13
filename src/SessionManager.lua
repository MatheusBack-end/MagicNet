SessionManager = {}

function SessionManager:new(udp_server)
   local object = {
       udp_server = udp_server,
       players = {}
   }

   setmetatable(object, self)
   self.__index = self

   return object
end

function SessionManager:receive_packets()
    while true do
        local buffer = self.udp_server:receive()
        local ip = buffer[2]
        local port = buffer[3]
        buffer = buffer [1]
        local pid = Binary:read_byte(string.sub(buffer, 1, 2))

        if buffer then
            if pid == 0x0 then
                local packet = PingPacket:new()
                packet.players_count = count(self.players)
                packet:encode()
                self.udp_server:send(ip, port, packet.buffer)
            end
            
            if pid == 0x02 then
                local packet = UpdatePositionPacket:new()
                packet.buffer = buffer
                packet:decode();
                self:broadcast_less_sender(buffer, packet.client_id)
            end

            if pid == 0x09 then
              local packet = HitPacket:new()
              packet.buffer = buffer
              packet:decode()

              self:broadcast_less_sender(buffer, packet.damager_id)
              print(packet.damager_id .. " hit caralho!!! " .. packet.client_id)
            end
            
            if pid == 0x03 then
              local packet = SoundPacket:new()
              packet.buffer = buffer;
              packet:decode()
              --io.write(packet.client_id .. "\n");
              self:broadcast_less_sender(buffer, packet.client_id)
            end

            if pid == 0x01 then
                local packet = CreateSessionPacket:new()
                packet.buffer = buffer
                packet:decode()
                
                if self:get_player(packet.client_id) == nil then
                    local pk = StartGamePacket:new()
                    pk.players = self.players
                    pk:encode()
                    
                    self.udp_server:send(ip, port, pk.buffer);
                    self:create_player(packet.client_id, packet.player_name, packet.x, packet.y, packet.z, packet.rx, packet.ry, packet.rz, ip, port)
                    self:broadcast_less_sender(buffer, packet.client_id)
                end
            end
            
            if pid == 0x05 then
                local packet = close_session_packet:new()
                packet.buffer = buffer
                packet:decode()
                
                if self:get_player(packet.client_id) then
                    self:remove_player(packet.client_id)
                    self:broadcast(buffer)
                end
            end
            
        end
       
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

function SessionManager:remove_player(client_id)
    self.players[client_id] = nil
    print("player id " .. client_id .. " disconnected!")
end

function SessionManager:create_player(client_id, name, x, y, z, rx, ry, rz, ip, port)
    self.players[client_id] = Player:new(ip, port, name, client_id, x, y, z, rx, ry, rz)
    print("player id " .. client_id .. " join in server!")
end

function SessionManager:get_player(client_id)
    return self.players[client_id]
end

function SessionManager:run()
    self:receive_packets()
end

function count(table)
    local size = 0
    for _ in pairs(table) do size = size + 1 end
    return size
end
