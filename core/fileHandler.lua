local FileHandler = {}
local Util = require('core/util')

function FileHandler.writeDataToFile(filename,data)
    --print('FileHandler writing '..filename)
    local file = fs.open(filename,'w')
    file.write(textutils.serialise(data))
    file.close()
end

function FileHandler.readDataFromFile(filename)
    if fs.exists(filename) then
        local file = fs.open(filename,'r')
        local serialisedData = file.readAll()
        file.close()
        --Util.tprint(textutils.unserialise(serialisedData))
        return textutils.unserialise(serialisedData)
    else
        print('FileHandler failed to find '..filename)
        return nil
    end
end

return FileHandler