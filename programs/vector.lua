-- Integer vectors
-- vector.lua
-- TODO: Scalar operations
-- TODO: Enforce immutability (?)
-- TODO: Polar coords
-- TODO: Integer and right angle optimisations
-- TODO: Coordinate system encoding and transforms


--
local Vector = { meta = {},
                 ops = {}}


-- Construction
function new(x,y,z)
  local v = { x, y, z }
  setmetatable(v, Vector.meta)
  return v
end


-- Higher order functions
-- vfold, vmap, dotmap


-- Conversions
function Vector.ops.unpack(v)
  return unpack(v)
end


-- 
function Vector.meta.__index(v, key)
  if key == 'x' then return v[1] end
  if key == 'y' then return v[2] end
  if key == 'z' then return v[3] end
  return Vector.ops[key]
end


-- function Vector.meta.__hash(v)
--   print('hashing...')
-- end


-- Strings
function Vector.meta.__tostring(v)
  return ('Vector(x=%.02f, y=%.02f, z=%.02f)'):format(v.x, v.y, v.z)
end


-- Numeric unary operators
function Vector.ops.negate(v)
  return new(-v.x, -v.y, -v.y)
end


function Vector.ops.abs(v)
  return new(math.sqrt(v.x*v.x + v.y*v.y + v.z*v.z), 0, 0)
end


function Vector.ops.arg(v)
  -- Angle between the vector and the positive X-axis in the XZ plane in radians (clockwise)
  -- TODO: Optimised integer version (cf. modulus) (?)
  return math.acos(v.x/v:abs().x)
end


-- Numeric binary operators
function Vector.meta.__add(v, other)
  return new(v.x+other.x, v.y+other.y, v.z+other.z)
end


function Vector.meta.__sub(v, other)
  return new(v.x-other.x, v.y-other.y, v.z-other.z)
end


-- function Vector.meta.__mul(v, other)
  -- return new(v.x*other.x - v.y*other.y, v.x*other.y + v.y*other.x)
-- end


-- Other methods
function Vector.ops.rotateY(v, quarters)
  -- Rotate the vector clockwise about the Y-axis
  -- TODO: FINISH THIS
  local radians = -((quarters/4) * 2*math.pi) + v:arg() -- TODO: Simplify
  local size    = v:abs().x
  -- print(size, radians, math.cos(radians), math.sin(radians))
  if size ~= 1 then print('NOOOOOOOO') end
  return new(math.floor(size*math.cos(radians) + 0.5), v.y, math.floor(size*math.sin(radians) + 0.5))
end


-- Comparison
function Vector.meta.__eq(v, other)
  return (v.x == other.x) and (v.y == other.y) and (v.z == other.z)
end


--
-- TODO: Find out what coordinate system Minecraft uses
cardinals = { north = new( 0, 0,  1),
              south = new( 0, 0, -1),
              east  = new( 1, 0,  0),
              west  = new(-1, 0,  0)}


cardinals.tostring = function (v)
  if v == cardinals.north then return 'North' end
  if v == cardinals.south then return 'South' end
  if v == cardinals.east  then return 'East'  end
  if v == cardinals.west  then return 'West'  end
end


function checks()
  print(cardinals.north == cardinals.north)
  print(cardinals.north:rotateY(1) == cardinals.east)
  print(cardinals.north:rotateY(2) == cardinals.south)
  print(cardinals.north:rotateY(3) == cardinals.west)
  print(cardinals.north:rotateY(4) == cardinals.north)
  print(cardinals.north:rotateY(5) == cardinals.east)
  print(cardinals.north:rotateY(6) == cardinals.south)

  print('If we face East and then turn right we will be looking towards the South', cardinals.east:rotateY(1) == cardinals.south)

  print(cardinals.tostring(cardinals.north:rotateY(1)), 'East')
  print(cardinals.tostring(cardinals.north:rotateY(2)), 'South')
  print(cardinals.tostring(cardinals.north:rotateY(3)), 'West')
  print(cardinals.tostring(cardinals.north:rotateY(4)), 'North')
  print(cardinals.tostring(cardinals.north:rotateY(5)), 'East')
  print(cardinals.tostring(cardinals.east:rotateY(1)))

  print(cardinals.north:rotateY(2) == cardinals.south)
end


checks()