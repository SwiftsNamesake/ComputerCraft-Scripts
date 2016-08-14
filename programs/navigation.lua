--
-- local bearings = { pos    = vec(0, 0, 0),
--                    facing = vec(0, 0, 1),
--                    home   = vec(0, 0,0 )}


local Navigator = { meta = {}, methods = {} }


--
function navigator(position, facing, home)
  local bearings = { pos    = position or vector.new(0, 0, 0),
                     facing = facing   or vector.new(0, 0, 1),
                     home   = home     or vector.new(0, 0, 0)}
  setmetatable(bearings, Navigator.meta)
end


--
function Navigator.meta.__index(self, key) return Navigator.methods[key] end


--
function Navigator.methods.move(self, v)  end

function Navigator.methods.up(self)      self.pos = self.pos + vector.new(0, 1,0) turtle.up()      end
function Navigator.methods.down(self)    self.pos = self.pos + vector.new(0,-1,0) turtle.down()    end
function Navigator.methods.forward(self) self.pos = self.pos + self.facing        turtle.forward() end
function Navigator.methods.back(self)    self.pos = self.pos - self.facing        turtle.back()    end

function Navigator.methods.left(self)    self.facing = self.facing:rotateY(-1) turtle.up() end
function Navigator.methods.right(self)   self.facing = self.facing:rotateY( 1) turtle.up() end

function Navigator.methods.strafeLeft(self) self:left()  self:forward() self:right() end
function Navigator.methods.strafeLeft(self) self:right() self:forward() self:left()  end