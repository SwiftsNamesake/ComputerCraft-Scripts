--
if turtle then
  os.loadAPI('utils/vector')
  os.loadAPI('utils/inventory')
  os.loadAPI('utils/navigation')
  os.loadAPI('utils/range')
end


--
-- TODO: Figure out how to interpret coordinates
local blueprint = {
  {'x', ' ', 'x', ' ', 'x'},
  {' ', 'x', ' ', 'x', ' '},
  {'x', ' ', 'x', ' ', 'x'},
  {' ', 'x', ' ', 'x', ' '},
  {'x', ' ', 'x', ' ', 'x'}
}


-- Helpers
function one(blueprint, x, y, z)
-- function one(blueprint, blockmap, x, y, z)
  -- Prints a single block from a layer in a blueprint

  -- TODO: Increase robustness (fetching materials, unloading, clearing the way, refuelling)
  
  local nav = navigation.navigator()
  local block = blueprint[y][z][x]
  local slot  = inventory.find(block)
  if slot ~= nil then
    print(('Using block %s from slot %d'):format(block, slot))
    if turtle.detectDown() then
      -- TODO: Don't dig if it's the right block
      turtle.digDown()
    end
    turtle.select(slot)
    turtle.placeDown(slot)
  else
    print(('Missing block %s'):format(block))
    -- TODO: Take action
  end
end


function layer(blueprint)
-- function layer(blueprint, blockmap)
  area(nav, #blueprint[1], #blueprint, function(nav, x, y, z, _) one(blueprint, x, y, z) end)
end


-- Printing
-- function noop() end

