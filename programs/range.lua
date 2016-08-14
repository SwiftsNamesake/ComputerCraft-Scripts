--
local Range = { meta    = {},
                methods = {} }


-- Constructors
function lift(r)
  setmetatable(r, Range.meta)
  return r
end


-- function new(r)
--   setmetatable(r)
--   return r
-- end


function range(fr,to,step)
  local r = {}
  for i=fr,to,(step or 1) do r[#r+1] = i end
  return lift(r)
end


-- Meta methods
function Range.meta.__index(r, key)
  return Range.methods[key]
end


function Range.meta.__concat(r, other)
  local new = {}
  for i=1, #r     do new[#new+1] = r[i]     end
  for i=1, #other do new[#new+1] = other[i] end
  return lift(new)
end


function Range.meta.__tostring(r)
  return 'Range(' .. table.concat(r, ', ') .. ')'
end

-- function Range.meta.__call(r, args)

-- end


-- Functions


-- Methods
function Range.methods.map(r, f)
  new = {}
  for i=1, #r do new[i] = f(r[i]) end
  return lift(new)
end


function Range.methods.foldl(r, f, initial)
  local acc = initial
  for i=1, #r do
    acc = f(acc, r[i])
  end
  return acc
end


function Range.methods.foldr(r, f, initial)
  local acc = initial
  for i=1, #r do
    acc = f(r[#r-i+1], acc)
  end
  return acc
end


function Range.methods.find(r, e)
  for i=1, #r do
    if r[i] == e then return i end
  end
  return nil
end


function Range.methods.findWith(r, p)
  for i=1, #r do
    if p(r[i]) then return i end
  end
  return nil
end


function Range.methods.filter(r, p)
  local new = {}
  for i=1,#r do
  	if p(r[i]) then new[#new+1] = r[i] end
  end
  return lift(new)
end


function Range.methods.sum(r)
  return r:foldl(function(a,b) return a+b end, 0)
end
-- function Range.methods.concat() end


print(#range(2,10,2), range(1,5))
print(range(2,10,2) .. range(6,10))
print(table.concat({1,2,3}, ','))
print(range(1,4):sum())