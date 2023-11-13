local argparse = require("argparse")
local yaml = require("lyaml")

local function create_args()
  parser = argparse("setup", "usa essa linha de comando para configurar o servidor.")
  parser:argument("ip", "Endereço IP do servidor")
  parser:argument("port", "Número da porta do servidor")
end

local function save_configurations(data)
  local file = io.open("conf.yaml", "w")

  if file == nil then
    quit("file not found!")
  end
  
  file:write(data)
  file:close()
end

create_args()

local args = parser:parse()

local yaml_data = yaml.dump({{host = args.ip, port = args.port}})

save_configurations(yaml_data);

print("Configuração salva em conf.yaml")

