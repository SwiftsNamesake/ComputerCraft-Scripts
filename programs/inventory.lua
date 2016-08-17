--

--
if turtle then
	os.loadAPI('utils/range')
end


--
function summary()
  return {}
end


--
function find(block)
  -- Finds the first slot which has the given block
  -- TODO: Block data
  return range.range(1,16):findWith(function(i) return hasBlock(i, block) end)
end


function details(slot)
  -- Gives the details of the blocks in the given slot
  return turtle.getItemDetail(slot)
end


function hasBlock(slot, block)
	local d = details(slot)
  return (d ~= nil) and (d.name == block)
end


function isFuel(slot)
  local selected = turtle.getSelectedSlot()
  turtle.select(slot)
  local answer = turtle.refuel(0)
  turtle.select(selected)
  return answer
end


function fuelSlots()
  return range.range(1,16):filter(isFuel)
end