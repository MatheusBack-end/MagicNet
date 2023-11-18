Server = {}

local players_amount = 0

function Server:add_player()
  players_amount = players_amount + 1
end

function Server:remove_player()
  players_amount = players_amount - 1
end

function Server:get_players_amount()
  return players_amount
end
