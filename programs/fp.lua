--

-- We'll need these
if turtle then
 -- os.loadAPI('')
end

--
function dot(key) return function(t) return t[key] end end

function const(x) return function(_) return x end end