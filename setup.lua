local argparse = require("argparse")
local yaml = require("lyaml")

-- Cria um objeto ArgumentParser para receber os parâmetros de linha de comando
local parser = argparse("script", "test")
parser:argument("ip", "Endereço IP do servidor")
parser:argument("port", "Número da porta do servidor")

-- Analisa os parâmetros de linha de comando
local args = parser:parse()

-- Cria uma tabela Lua com as informações de configuração
local config = {
    server = {
        host = args.ip,
        port = tonumber(args.port)
    }
}

--print(config.server.host)

-- Converte a tabela Lua em um documento YAML
local yaml_data = yaml.dump({{host = args.ip, port = args.port}})

-- Escreve o documento YAML no arquivo de configuração
local file = io.open("conf.yaml", "w")

file:write(yaml_data)
file:close()

print("Configuração salva em conf.yaml")

