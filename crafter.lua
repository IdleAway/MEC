local Crafter = {}
local Optix = require('optix')
local mod = 'Crafter'
local c = 0
local refreshTime = 1

function Crafter.loop(dbug)
    while true do
        if dbug then
            Optix.printDbug(mod,'info',c .. ' iteration')
        end
        c = c+1
        os.sleep(refreshTime)
    end
end

return Crafter