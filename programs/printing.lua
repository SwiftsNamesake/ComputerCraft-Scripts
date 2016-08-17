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

  local block   = blueprint[y][z][x]
  local slot    = inventory.find(block)
  local current = nav:inspect('down')

  print('Block: ',   block)
  print('Slot: ',    slot)
  print('Current: ', current.name)

  if block == current.name then
    -- print((''))
    return true
  
  elseif block == 'minecraft:air' then
    turtle.digDown()
    return true

  elseif slot ~= nil then
    print(('Using block %s from slot %d'):format(block, slot))
    turtle.digDown() -- TODO Wrap in if-statement (?)
    turtle.select(slot)
    turtle.placeDown()
    return true

  else
    print(('Missing block %s'):format(block))
    -- TODO: Take action
    return false
  end

end


-- function restock() end
-- function resourceCount() end


function layer(nav, blueprint, which, firstTurn)
-- function layer(nav, blueprint, blockmap)
  -- TODO: Clear the way, refuel, restock and unload (when necessary)
  -- TODO: How to deal with nav w.r.t home
  local thelayer = blueprint[which] --
  print(('Printing a %dx%d layer'):format(#thelayer[1], #thelayer))
  nav:area(#thelayer[1], #thelayer, firstTurn, function(nav, x, y, z, _) print(x+1,y+1,z+1) one(nav, blueprint, x+1, y+1, z+1) end)
end


-- Printing
-- function noop() end

