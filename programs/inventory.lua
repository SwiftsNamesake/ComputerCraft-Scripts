--
os.loadAPI('utils/range')


--
function find(block)
  -- Finds the first slot which has the given block
  -- TODO: Block data
  Range(1..16):find(function(i) details(i).name == block end)
end


function details(slot)
  -- Gives the details of the blocks in the given slot
  return turtle.getItemDetail(slot) 
end


function isFuel(slot)
  local selected = turtle.getSelectedSlot()
  turtle.select(slot)
  local answer = turtle.refuel(0)
  turtle.select(selected)
  return answer
end


function fuelSlots()
  return range(1,16):filter(isFuel)
end