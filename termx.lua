local TermX = {}
local provider = 'TermX'
local defaultColor = colors.white
local providerColor = colors.grey
local logfile = 'MEC/mec_log.log'

-- == -- == -- == -- == -- ==
-- INTERNALS
-- == -- == -- == -- == -- ==


local function lvlColor(lvl)
    if lvl == 'crit' then
        cLvl = colors.red
    elseif lvl == 'warn' then
        cLvl = colors.orange
    elseif lvl == 'success' then
        cLvl = colors.green
    else
        cLvl = colors.white
    end
    return cLvl
end

local function lvlPrefix(lvl)
    if lvl == 'crit' then
        pref = '[-] '
    elseif lvl == 'warn' then
        pref = '[*] '
    elseif lvl == 'success' then
        pref = '[+] '
    else
        pref = '[#] '
    end
    return pref
end

local function split(str,maxlen)
    local inc = str
    local split = true
    local lines = {}
    while split do
        local line = string.sub(inc,1,maxlen)
        table.insert(lines,line)
        inc = string.sub(inc,maxlen,string.len(inc))
        if string.len(inc) <= maxlen then
            split = false
            if string.len(inc) > 0 then
                table.insert(lines,inc)
            end
        end
    end
    return lines
end

-- == -- == -- == -- == -- ==
-- PRINTING
-- == -- == -- == -- == -- ==

local function tprint(provider,level,message)
    local color = lvlColor(level)
    local pre = lvlPrefix(level)
    local header = pre .. provider .. '\t: '
    if string.len(header) + string.len(message) > 52 then
        max = 52 - string.len(header)
        term.setTextColor(color)
        term.write(header)
        term.setTextColor(defaultColor)
        
        for _,line in ipairs(split(message,max)) do
            term.write(line)
            curX, curY = term.getCursorPos()
            term.setCursorPos(string.len(header)+1,curY+1)
        end
        
    else
        term.setTextColor(color)
        term.write(header)
        term.setTextColor(defaultColor)
        term.write(message)
    end
    curX, curY = term.getCursorPos()
    term.setCursorPos(1,curY+1)
end

-- == -- == -- == -- == -- ==
-- LOGGING (currently csv)
-- == -- == -- == -- == -- ==

-- TODO: Timestamp
local function tlog(statement)
    if fs.exists(logfile) then
        log = io.open(logfile, 'a')
    else
        log = io.open(logfile, 'w')
        --TermX.output(provider,'info','New log created')
    end
    io.output(log)
    io.write(statement..'\n')
    io.close(log)
end

-- == -- == -- == -- == -- ==
-- EXPORTS
-- == -- == -- == -- == -- ==

function TermX.process(provider,level,message)
    tlog(provider..','..level..','..message)
    tprint(provider,level,message)
end

function TermX.takeOver()
    term.clear()
    term.setCursorPos(1,1)
end

return TermX