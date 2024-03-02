local Collector = {}

local ldbug = false
local mod = 'Collector'
local Optix = require('optix.lua')
local refreshTime = 120

function collect(dbug)
    ldbug = dbug
    local c = 0
    if ldub then
        Optix.printDbug(mod,'info','Collector startet in dbug mode')
    end
    while true
        if ldbug then
            Optix.printDbug(mod,'info','Collector running its ' .. c .. ' iteration')
        end
        os.sleep(refreshTime)
    end
end

return Collector
