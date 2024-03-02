local core = {
    main = 'main.lua',
    optix = 'optix.lua'
}

local mods = {
    collector = 'collector.lua',
    autoCrafter = 'autocrafter.lua'
}

local run = 'run.lua'

-- ordner struktur
local function structure()
    if not fs.exists('MEC') do
        fs.makeDir('MEC')
        fs.makeDir('MEC/core')
        fs.makeDir('MEC/mods')
    end
end

-- Funktion zum Herunterladen von Dateien von einem URL
local function download(url, filename)
    local request = http.get(url)
    if request then
        local file = fs.open(filename, "w")
        file.write(request.readAll())
        file.close()
        request.close()
        print("Datei heruntergeladen: " .. filename)
    else
        print("Fehler beim Herunterladen der Datei von " .. url)
    end
end

-- GitHub-Repository URL und Dateiname
local githubRepoURL = "https://raw.githubusercontent.com/username/repository/main/file.lua"

-- Herunterladen der Datei
for key, value in pairs(core) do
    download(githubRepoURL, 'MEC/core' .. filename)
end

for key, value in pairs(mods) do
    download(githubRepoURL, 'MEC/core' .. filename)
end

download(githubRepoURL, 'MEC/' .. run)