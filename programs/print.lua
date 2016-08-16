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
function one(nav, blueprint, x, y, z)
-- function one(blueprint, blockmap, x, y, z)
  -- Prints a single block from a layer in a blueprint

  -- TODO: Increase robustness (fetching materials, unloading, clearing the way, refuelling)
  -- TODO: Returned detailed outcome summary (eg. { succeeded=true, block='minecraft:air' }) (?)
  
  local block = blueprint[y][z][x]
  local slot  = inventory.find(block)
  
  if block == 'minecraft:air' then
    if turtle.detectDown() then turtle.digDown() end
    return false
  elseif slot ~= nil then
    print(('Using block %s from slot %d'):format(block, slot))
    if turtle.detectDown() then
      -- TODO: Don't dig if it's the right block
      turtle.digDown()
    end
    turtle.select(slot)
    turtle.placeDown(slot)
    return true
  else
    print(('Missing block %s'):format(block))
    -- TODO: Take action
    return false
  end
end


function layer(nav, blueprint)
-- function layer(blueprint, blockmap)
  area(nav, #blueprint[1], #blueprint, function(nav, x, y, z, _) one(nav, blueprint, x, y, z) end)
end


-- Printing
-- function noop() end

