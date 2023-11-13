Node = {}

function Node:new()
  local object =
  {
    next = nil,
    data = nil
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function Node:get_data()
  return self.data
end

function Node:get_next()
  return self.next
end

function Node:set_data(data)
  self.data = data
end

function Node:set_next(next)
  self.next = next
end
