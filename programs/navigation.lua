--

local Navigator = { meta = {}, methods = {} }


--
function navigator(position, facing, home)
  local bearings = { pos    = position or vector.new(0, 0, 0),
                     facing = facing   or vector.new(0, 0, 1),
                     home   = home     or vector.new(0, 0, 0)}
  setmetatable(bearings, Navigator.meta)
  return bearings
end


--
function Navigator.meta.__index(self, key) return Navigator.methods[key] end


-- Move
function Navigator.methods.up(self)      self.pos = self.pos + vector.new(0, 1,0) turtle.up()      end
function Navigator.methods.down(self)    self.pos = self.pos + vector.new(0,-1,0) turtle.down()    end
function Navigator.methods.forward(self) self.pos = self.pos + self.facing        turtle.forward() end
function Navigator.methods.back(self)    self.pos = self.pos - self.facing        turtle.back()    end

function Navigator.methods.strafeLeft(self) self:left()  self:forward() self:right() end
function Navigator.methods.strafeRight(self) self:right() self:forward() self:left()  end

-- Turn
function Navigator.methods.left(self)  self.facing = self.facing:rotateY(-1) turtle.turnLeft()  end
function Navigator.methods.right(self) self.facing = self.facing:rotateY( 1) turtle.turnRight() end

-- function Navigator.methods.look(self, v) end

--
function Navigator.methods.detect(nav, direction)
	-- TODO: Allow block to be air (eg. check nil)
	-- TODO: Allow any direction
  return ({ up = turtle.detectUp, down = turtle.detectDown, forward = turtle.detect })[direction]()
end


function Navigator.methods.detectForward(nav) return nav:detect('forward') end
function Navigator.methods.detectUp(nav)      return nav:detect('up')      end
function Navigator.methods.detectDown(nav)    return nav:detect('down')    end


function Navigator.methods.inspect(nav, direction)
	-- TODO: Allow any direction
  local b = ({ up = turtle.inspectUp, down = turtle.inspectDown, forward = turtle.inspect })[direction]()
  return (b == nil) and { name='air' } or b
end


-- Advanced movement
function Navigator.methods.area(nav, dx, dz, f)
  --
  -- TODO: Options (eg. turn-right-first or turn-left-first)
  -- TODO: Smarter callbacks (eg. on-turn, on-new-row, etc.)
  -- TODO: What if the turtle is facing a different direction to begin with (?)
  local start = nav.pos -- TODO: Should coords be relative to start or nav.home (?)

  for x = 1, dx do
    for z = 1, dz-1 do
      -- TODO: Work out coordinates within the 'grid' properly (not the same as indices since turtle changes direction)
      -- TODO: More fine-grained callback data (eg. start, middle, last) (?)
      f(nav, nav.pos.x, nav.pos.y, nav.pos.z, 'middle')
      nav:forward()
    end

    f(nav, nav.pos.x, nav.pos.y, nav.pos.z, 'last')

    if x < dx then
      local turn = (x%2 == 0) and nav.right or nav.left
      turn(nav)
      nav:forward()
      turn(nav)
    end      

  end
end

-- function Navigator.methods.move(self, v) end
-- function Navigator.methods.goto(self, v) end -- Screw you, Dijkstra
-- function Navigator.methods.path(self, ?) end

