-- miner.lua


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
  turtle.digUp()
  turtle.digDown()
  turtle.dig()
end



function miner.refuel()
  -- TODO: Move to navigation (?)
  -- TODO: FINISH
  print('ATTEMTPING TO CALL UNIMPLEMENTED FUNCTION miner.refuel')
  range(1,16):map(function (n)
    turtle.select(n)
  end)
end


function miner.unload()
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
function excavateThree(nav, dx, dz)
  -- Excavate three vertical layers.
  -- 
  -- The X, Y and Z axes are defined relative to the turtle's original position;
  -- the X axis is 'right', the Y axis is 'up' and the Z axis is 'forward'.

  -- TODO: Rename 'rightWhen' param (or maybe use sign of the 'dx' and 'dy' parameters to determine direction) (?)
  
  miner.descend()

  nav:area(dx, dz, function(nav, x, y, z, where)
    
    if where == 'middle' then
      miner.digAll()
    elseif where == 'last' then
      turtle.digUp()
      turtle.digDown()
    end

  end)
end



-- for i, n in ipairs(range(5,20):map(function(x) return x*x end)) do
--   print(n)
-- end
