--
local path = 'https://raw.githubusercontent.com/%s/%s/%s/%s'
local settings = { username   = 'swiftsnamesake',
	               branch     = 'master',
	               repository = 'computercraft-scripts' }



local function load(fn)
  --
  local url = path:format(settings.username, settings.repository, settings.branch, fn)
  if http.checkURL(url) then
    local response = http.get(url)
    print(url)
    return response
  else
  	print(('Forbidden url: %s':format(url)))
  	return nil
  end
end


local function save(fn, to)
  local response = load(fn)
  if fn ~= nil then
  	-- TODO: Check pre-existing (?)
  	local f = fs.open(fn, 'w')
  	f.write(response.readAll())
  	f.close()
  else
  	print('Unable to load and save file')
  end
end


-- load('programs/vector.lua')