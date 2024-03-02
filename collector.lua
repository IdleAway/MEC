local Collector = {}
local Optix = require('optix')
local ldbug = false
local mod = 'Collector'
local refreshTime = 3
local c = 0


function Collector.collect(dbug)
    while true do
        if dbug then
            Optix.printDbug(mod,'info',c .. ' iteration')
        end
        c = c+1
        os.sleep(refreshTime)
    end
end

return Collector