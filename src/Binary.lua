-- local modules
local struct = require('struct')

-- class object
Binary = {}

-- class construct
function Binary:new()
    object = {}
    
    setmetatable(object, self)
    self.__index = self
    
    return object -- table type Binary
end

function Binary:read_int(value) -- bytes[]
    
end

function Binary:write_int(value) -- int
    return struct.pack('<i', value) -- byte[4]
end

function Binary:read_float(value) -- bytes[]
    return struct.unpack('<f', value)
end

function Binary:write_float(value) -- float 
    return struct.pack('<f', value)
end

function Binary:write_byte(value) -- int
    return struct.pack('<b', value) -- byte
end

function Binary:read_byte(value) -- byte
    return struct.unpack('<b', value) -- int
end

function Binary:write_string(value, width)
    for i = string.len(value), width - 1, 1 do
        
        value = value .. " "
    end
    
        
    va = {}
    value:gsub(".",function(c) table.insert(va,c) end)
    
    str = " "
    for i = 1, width, 1 do
        str = str .. struct.pack('<c', va[i])
    end
    
    return str
end

function Binary:read_string(value, width)
    str = ""
    va = {}
    value:gsub(".",function(c) table.insert(va,c) end)
    
    for i = 1, width, 1 do
        str = str .. struct.unpack('<c', va[i])
    end
    
    return str
end
