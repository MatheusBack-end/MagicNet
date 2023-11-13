ByteBuffer = {}

function ByteBuffer:new()
  local object =
  {
    buffer = LinkedList:new()
  }

  setmetatable(object, self)
  self.__index = self

  return object
end

function ByteBuffer:get_byte()
  return Binary:read_byte(self:get(1))
end

function ByteBuffer:get_char()
  return Binary:read_char(self:get(1))
end

function ByteBuffer:get_short()
  return Binary:read_short(self:get(2))
end

function ByteBuffer:get_int()
  return Binary:read_int(self:get(4))
end

function ByteBuffer:get_float()
  return Binary:read_float(self:get(4))
end

function ByteBuffer:get_string()
  local string_size = self:get_short()

  local string = ""

  for i = 1, string_size, 1 do
    string = string .. self:get_char()
  end

  return string
end

function ByteBuffer:get_vec3()
  local vec3 = Vector3:new(0, 0, 0)

  vec3.x = self:get_float()
  vec3.y = self:get_float()
  vec3.z = self:get_float()

  return vec3
end

function ByteBuffer:put_byte(value)
  self:put(Binary:write_byte(value))
end

function ByteBuffer:put_char(value)
  self:put(Binary:write_char(value))
end

function ByteBuffer:put_short(value)
  self:put(Binary:write_short(value))
end

function ByteBuffer:put_int(value)
  self:put(Binary:write_int(value))
end

function ByteBuffer:put_float(value)
  self:put(Binary:write_float(value))
end

function ByteBuffer:put_string(value)
  self:put(Binary:write_short(#value))
  self:put(Binary:write_string(value, #value))
end

function ByteBuffer:put_vec3(value)
  self:put_float(value.x)
  self:put_float(value.y)
  self:put_float(value.z)
end

function ByteBuffer:get(amount)
  if amount == nil then
    amount = self.buffer.size
  end

  local data = ""

  for i = 1, amount, 1 do
    local byte = self.buffer:get_last()
    data = data .. byte
  end

  return data
end

function ByteBuffer:put(data)
  if not data then
    return
  end

  for i = 1, #data do
    self.buffer:add(string.sub(data, i, i))
  end
end
