-- miner.lua


-- We'll need these
os.loadAPI('utils/vector') --
os.loadAPI('utils/navigation')
os.loadAPI('utils/inventory')
os.loadAPI('utils/range')

local vec = vector


-- General helpers

-- Navigation helpers
-- local bearings = { pos    = vec(0, 0, 0),
--                    facing = vec(0, 0, 1),
--                    home   = vec(0, 0,0 )}


-- Mining helpers
local miner = {}


function miner.digAll()
  turtle.digUp()
  turtle.digDown()
  turtle.dig()
end


function miner.move(v) end


function miner.left()

end


function miner.right()

end


function miner.up()

end


function miner.down()

end


function miner.forward()

end



function miner.back()

end


function miner.refuel()
  range(1,16):map(function (n)
    turtle.select(n)
  end)
end


function miner.unload()

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
function excavateThree(dx, dz, rightWhen)
  -- Excavate three vertical layers.
  -- 
  -- The X, Y and Z axes are defined relative to the turtle's original position;
  -- the X axis is 'right', the Y axis is 'up' and the Z axis is 'forward'.

  -- TODO: Rename 'rightWhen' param (or maybe use sign of the 'dx' and 'dy' parameters to determine direction) (?)
  
  miner.descend()

  for x=1,dx do
    for z=1,dz-1 do
      miner.digAll()
      miner.forward()
    end
    
    turtle.digUp()
    turtle.digDown()

    if x < dx then
      local turn = (x%2 == rightWhen) and miner.right or miner.left
      turn()
      turtle.dig()
      miner.forward()
      turn()
    end

  end
end



-- for i, n in ipairs(range(5,20):map(function(x) return x*x end)) do
--   print(n)
-- end
