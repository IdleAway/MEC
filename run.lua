local Collector = require('modules/collector')
local Timer = require('core/timer')

local defaultTimerInterval = 60
local defaultCollectInterval = 60

-- == -- == -- == -- == -- ==
-- MODULE LOOPS
-- == -- == -- == -- == -- ==

local function timerLoop()
    while true do
        Timer.update()
        os.sleep(defaultTimerInterval)
    end
end

local function collectData()
    while true do
        Collector.collect()
        os.sleep(defaultCollectInterval)
    end
end

-- == -- == -- == -- == -- ==
-- MAIN
-- == -- == -- == -- == -- ==

local function run()
    parallel.waitForAny(timerLoop,collectData)
end

-- == -- == -- == -- == -- ==
-- INIT
-- == -- == -- == -- == -- ==

local function init()
    -- move check log file to here?
    --TermX.takeOver()
    --TermX.process(mod,'success','MEC starting...')
    run()
end

if #arg > 0 then
    if arg[1] == 'wipe' then
        fs.delete('MEC/data')
    end
end
init()