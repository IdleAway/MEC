local Collector = require('collector.lua')

local main()
    parallel.waitForAny(Collector.collect)
end

main()