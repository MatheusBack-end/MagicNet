Log = {}

local function get_header(type)
  return '[' .. os.date('%I:%M:%S %p') .. ']' .. '[' .. type .. '] '
end

function Log:info(value)
  io.write(get_header('info') .. value .. "\n")
end

function Log:error(value)
  io.write(get_header('error') .. value .. "\n")
  os.exit(-1)
end

function Log:warn(value)
  io.write(get_header('warn') .. value .. "\n")
end

function Log:debug(value)
  io.write(get_header('debug') .. value .. "\n")
end
