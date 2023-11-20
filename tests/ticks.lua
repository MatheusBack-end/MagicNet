require("ioutil")
local tick_per_seconds = arg[1]
local tick_interval = 1000 / tick_per_seconds;
local timer = 0
local previous_timer = 0
local debug = 0
local invert_line = false

local function clamp(value, min, max)
  if value > max then
    invert_line = not invert_line
    return max
  end

  if value < min then
    invert_line = not invert_line
    return min
  end

  return value
end

local function get_milliseconds()
  local seconds = os.time()
  local microseconds = os.clock()

  return seconds * 1000 + math.floor(microseconds * 1000)
end

local function commands()
  input = ioutil.read_nb()

  if input then
    if input == "stop\n" then
      os.exit(1)
    end
  end
end

local function tick()
  local actual_time = get_milliseconds()

  timer = timer + actual_time - previous_timer

  if timer >= tick_interval then
    if invert_line then
      debug = clamp(debug - 1, -10, 0)
    else
      debug = clamp(debug + 1, 0, 10)
    end

    if invert_line then
      print('tick ' .. string.rep("-", -debug))
    else
      print('tick ' .. string.rep("-", debug))
    end
    timer = 0
  end

  previous_timer = actual_time
end

while true do
  pcall(function ()
    tick()
  end)
  --commands()
end
