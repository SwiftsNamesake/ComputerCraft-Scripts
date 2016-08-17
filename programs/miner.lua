-- miner.lua

-- TODO: Branch mining
-- TODO: Surveying (eg. reporting vein findings)
-- TODO: Modems

-- We'll need these
if turtle then
  os.loadAPI('utils/vector') --
  os.loadAPI('utils/navigation')
  os.loadAPI('utils/inventory')
  os.loadAPI('utils/range')
end


local vec = vector


-- General helpers

-- Navigation helpers

-- Mining helpers
local miner = {}


function miner.digAll()
  --
  while turtle.detectUp()   do turtle.digUp()   end
  while turtle.detectDown() do turtle.digDown() end
  while turtle.detect()     do turtle.dig()     end
end



function miner.refuel(nav)
  -- TODO: Move to navigation (?)
  -- TODO: FINISH
  print('ATTEMTPING TO CALL UNIMPLEMENTED FUNCTION miner.refuel')
  return nil

  local slot     = turtle.getSelectedSlot()
  local fuelSlot = range(1,16):findWith(inventory.isFuel) --
  
  if slot ~= nil then
    turtle.select(fuelSlot) --
    turtle.refuel(_)        -- TODO: How much (?)
    turtle.select(slot)     --
  else
    nav:goto(nav.home) -- Fuel chest is assumed to be right next to the home block
    -- TODO: Take fuel and use it
end


function miner.unload(nav)
  -- TODO: Move to navigation (?)
  -- TODO: IMPLEMENT
  print('ATTEMTPING TO CALL UNIMPLEMENTED FUNCTION miner.unload')


end


function miner.descend()
  -- Dig down so that the turtle is positioned between two
  -- unexcavated layers (and in level with a third one)
  if turtle.detectDown() then turtle.digDown() end -- TODO: Is the turtle faster with this check?
  turtle.down()
  if turtle.detectDown() then turtle.digDown() end
  turtle.down()
end


function miner.toBedrock(dx, dz, rightWhen)
  -- TODO: Rename 'rightWhen' param (?)
end


--
-- function excavateThree(nav, dx, dz, rightWhen)
function excavateThree(nav, dx, dz, firstTurn)
  -- Excavate three vertical layers.
  -- 
  -- The X, Y and Z axes are defined relative to the turtle's original position;
  -- the X axis is 'right', the Y axis is 'up' and the Z axis is 'forward'.

  -- TODO: Rename 'rightWhen' param (or maybe use sign of the 'dx' and 'dy' parameters to determine direction) (?)
  
  miner.descend()

  nav:area(dx, dz, firstTurn, function(nav, rel, where)
    
    if where == 'middle' then
      miner.digAll()
    elseif where == 'last' then
      turtle.digUp()
      turtle.digDown()
    elseif where == 'turning' then
      miner.digAll()
    end

  end)
end



-- for i, n in ipairs(range(5,20):map(function(x) return x*x end)) do
--   print(n)
-- end
