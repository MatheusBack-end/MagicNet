--[[local start = os.clock()
local coroutines = {}
local is_end = false

local function loop_for_test()
  for i = 1, 100000000, 1 do
    timer()
    coroutine.yield()
  end

  print("end loop for tests")
  is_end = true
end

local function timer()
  if os.clock() - start > 10 then
    print("10 secs")
  end
end

local function create_coroutines()
  table.insert(coroutines, coroutine.create(function ()
    loop_for_test()
    timer()
  end))
end

local function coroutine_loop()
  for i=1, 1, 1 do
    coroutine.resume(coroutines[i])
  end
end

create_coroutines()

while true do
  if is_end then
    break
  end

  coroutine_loop()
end--]]

local start = os.clock()
local final = false

local function time()
  if final then
    return
  end

  if os.clock() - start > 10 then
    print("10 secs")
    final = true
  end
end

for i = 1, 100000000, 1 do i = i
  time()
end
