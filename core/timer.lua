local Timer = {}
local FileHandler = require('core/fileHandler')
local timeFile = 'MEC/data/mec_time_file'

function Timer.getStamp()
    local data = FileHandler.readDataFromFile(timeFile)
    return data.time
end

function Timer.getTimeString()
    local data = FileHandler.readDataFromFile(timeFile)
    if data then
        local days, bufmin, hours, mins

        days = math.floor(data.time / (24 * 60))
        bufmin = data.time % (24 * 60)
        hours = math.floor(bufmin / 60)
        mins = bufmin % 60

        return days..' days '..hours..' hours '..mins..' minutes'
    else
        return 'It is Epoch!'
    end
end

function Timer.update()
    local data = FileHandler.readDataFromFile(timeFile)
    if data then
        data.time = data.time + 1
        FileHandler.writeDataToFile(timeFile, data)
    else
        FileHandler.writeDataToFile(timeFile,{ time = 0 })
    end
end

return Timer