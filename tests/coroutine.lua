local threads = {}

local co = coroutine.create(function ()
  local final = 10000
  local i = 1

  for i=1, final do
    --print(i)

    if i == final then
      print("end co")
    end

    coroutine.yield()
  end
end)

table.insert(threads, co)

local co2 = coroutine.create(function ()
  local final = 100
  local i = 1

  for i=1, final do
    --print(i)

    if i == final then
      print("end co2")
    end

    coroutine.yield()
  end
end)

table.insert(threads, co2)

local function dispatcher()
  while true do
    local n = table.getn(threads)

    if n == 0 then break end

    for i=1,n do
      coroutine.resume(threads[i])
    end
  end
end

dispatcher()
