Log = {}

function Log:info(value)
  local header = '[' .. os.date('%I:%M:%S %p') .. ']' .. '[info] '
  io.write(header .. value .. "\n")
end

function Log:error(value)
  local header = '[' .. os.date('%I:%M:%S %p') .. ']' .. '[error] '
  io.write(header .. value .. "\n")
  os.exit(-1)
end
