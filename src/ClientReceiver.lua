ClientReceiver = {}

function ClientReceiver:new(ip, port, data)
  local object =
  {
    ip = ip,
    port = port,
    data = data
  }

  setmetatable(object, self)
  self.__index = self

  return object
end
