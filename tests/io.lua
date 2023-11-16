require("ioutil")

local function read()
  --@diagnostic disable-next-line
  local input = ioutil.read_nb()

  if input then
    print("input receive " .. input)
  end
end

while true do
  read()
end
