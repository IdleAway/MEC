local Optix = {}

local function getColorLvl(lvl)
    cLvl = colors.white
    if lvl = 'crit'
        cLvl = colors.red
    elseif lvl = 'warn'
        cLvl = colors.orange
    elseif lvl = 'info'
        cLvl = colors.yellow
    end
    return cLvl
end

local function getColorModule(mod)
    cMod = colors.grey
    return cMod
end

function printDbug(mod,lvl,msg)
    local cMod = getColorModule(mod)
    local cLvl = getColorLvl(lvl)
    term.setTextColor(cMod)
    print(string.upper(lvl) .. '\t- ')
    term.setTextColor(cMod)
    print(mod)
    term.setTextColor(color.white)
    print(msg .. '\n')
end

return Optix