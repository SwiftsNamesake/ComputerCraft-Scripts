-- miner.lua

os.loadAPI('vector') --

local vec = vector


-- General helpers
local Range = {}


local function range(fr,to)
  local r = {}
  for i=fr,to do r[#r+1] = i end
  setmetatable(r, Range)
  return r
end


local Range.lift(r)
  setmetatable(r, Range)
  return r
end


function Range.map(r, f)
  local new = {}
  for i=1, #r do new[i] = f(r[i]) end
  setmetatable(new, Range)
  return new
end


local function Range.filter(r, p)
  local new = {}
  for i=1,#r do
  	if p(r[i]) then new[#new+1] = r[i] end
  end
  setmetatable(new, Range)
  return r
end


-- Mining helpers
local miner = {}

local function miner.digAll()
  turtle.digUp()
  turtle.digDown()
  turtle.dig()
end


local function miner.move(v) end


local function miner.left()

end


local function miner.right()

end


local function miner.up()

end


local function miner.down()

end


local function miner.forward()

end



local function miner.back()

end


local function miner.refuel()
  range(1,9):map(function (n)
    turtle.select(n)
  end)
end


local function miner.unload()

end


local function miner.descend()
  -- Dig down so that the turtle is positioned between two
  -- unexcavated layers (and in level with a third one)
  if turtle.detectDown() then turtle.digDown() end -- TODO: Is the turtle faster with this check?
  turtle.down()
  if turtle.detectDown() then turtle.digDown() end
  turtle.down()
end


local function miner.toBedrock(dx, dz, rightWhen)
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
      miner.digAll()
      miner.forward()
      turn()
    end

  end
end
