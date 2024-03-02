local Collector = require('collector')
local Crafter = require('crafter')
local mod = 'Main'
local dbug

local function init(dbug = true)
    dbug = dbug
    Optix.printDbug(mod,'info','MEC started in dbug mode')
    run()
end

local function run()
    parallel.waitForAny(Collector.collect(true),Crafter.loop())
end

init()