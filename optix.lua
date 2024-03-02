local Optix = {}

local function getColorLvl(lvl)
    cLvl = colors.white
    if lvl == 'crit' then
        cLvl = colors.red
    elseif lvl == 'warn' then
        cLvl = colors.orange
    elseif lvl == 'info' then
        cLvl = colors.yellow
    end
    return cLvl
end

local function getColorModule(mod)
    cMod = colors.gray
    return cMod
end

function Optix.printDbug(mod,lvl,msg)
    local cLvl = getColorLvl(lvl)
    local cMod = getColorModule(mod)
    term.setTextColor(cLvl)
    term.write(string.upper(lvl) .. '\t- ')
    term.setTextColor(cMod)
    term.write(mod .. '\t- ')
    term.setTextColor(colors.white)
    term.write(msg .. '\n')
    term.setCursorPos(1,1)
end

return Optix