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