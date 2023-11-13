LinkedList = {}

function LinkedList:new()
  local object =
  {
    head = nil,
    last_element = nil,
    size = 0
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function LinkedList:add(data)
  local node = Node:new()
  node:set_data(data)

  self.size = self.size + 1

  if(not self.last_element) then
    self.head = node
    self.last_element = node
    return
  end

  self.last_element:set_next(node)
  self.last_element = node
end

function LinkedList:delete()
  self.head = self.head:get_next()
  self.size = self.size - 1
end

function LinkedList:get_last()
  if self.head == nil then
    print("head is nil", self.size)
    return
  end

  local data = self.head:get_data()
  self:delete()

  return data
end

function LinkedList:print_all()
  local current = self.head

  for i = 1, self.size, 1 do
    print(current:get_data())

    current = current:get_next()
  end
end
