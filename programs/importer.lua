-- Importing scripts from GitHub
-- Jonatan H Sundqvist
-- August 11(-ish) 2016

-- TODO: How do you control exports within the ComputerCraft Lua environment?

local path = 'https://raw.githubusercontent.com/%s/%s/%s/%s'
local settings = { username   = 'swiftsnamesake',
	                 branch     = 'master',
	                 repository = 'computercraft-scripts' }



function load(fn)
  --
  local url = path:format(settings.username, settings.repository, settings.branch, fn)
  if http.checkURL(url) then
    local response = http.get(url)
    print(url)
    return response
  else
  	print(('Forbidden url: %s'):format(url))
  	return nil
  end
end


function save(fn, to)
  local response = load(fn)
  if fn ~= nil then
  	-- TODO: Check pre-existing (?)
  	local f = fs.open(to, 'w')
  	f.write(response.readAll())
  	f.close()
  else
  	print('Unable to load and save file')
  end
end


-- load('programs/vector.lua')