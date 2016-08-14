local blueprint = {
  {'x', ' ', 'x', ' ', 'x'},
  {' ', 'x', ' ', 'x', ' '},
  {'x', ' ', 'x', ' ', 'x'},
  {' ', 'x', ' ', 'x', ' '},
  {'x', ' ', 'x', ' ', 'x'}
}


-- 3D printing
function noop() end


function build(x, z, y, bp)
  print(x,y,z,bp)
  if turtle.detectDown() then
    turtle.digDown()
  end


  if bp[x][z] == 'x' then
    turtle.placeDown()
  end
end


function area(dx, dz, f)
 print('dx is '..dx)
 print('dz is '..dz)
 for x=1,dx do
   for z=1,dz-1 do
     print(x,z)
     f(x, z) --
     turtle.forward()
   end
   f(x, dz)

   if x%2 == 0 then
     turtle.turnLeft()
     turtle.forward()
     turtle.turnLeft()
   else
     turtle.turnRight()
     turtle.forward()
     turtle.turnRight()
   end
 end
end


function b(x,z)
  print('b')
  build(x, z, nil, blueprint)
end


function printone()
  turtle.select(2)
  turtle.refuel()

  turtle.select(1)
  area(#blueprint, #blueprint[1], b)
end


function inspect()
  local b = ({turtle.inspectDown()})[2]-blueprint = {
-  {'x', ' ', 'x', ' ', 'x'},
-  {' ', 'x', ' ', 'x', ' '},
-  {'x', ' ', 'x', ' ', 'x'},
-  {' ', 'x', ' ', 'x', ' '},
-  {'x', ' ', 'x', ' ', 'x'}
+{
+       "folders":
+       [
+               {
+                       "path": "C:\\Users\\Jonatan\\Desktop\\Lua\\ComputerCraft Scripts"
+               }
+       ]
 }
-
-
--- 3D printing
-function noop() end
-
-
-function build(x, z, y, bp)
-  print(x,y,z,bp)
-  if turtle.detectDown() then
-    turtle.digDown()
-  end
-
-
-  if bp[x][z] == 'x' then
-    turtle.placeDown()
-  end
-end
-
-
-function area(dx, dz, f)
- print('dx is '..dx)
- print('dz is '..dz)
- for x=1,dx do
-   for z=1,dz-1 do
-     print(x,z)
-     f(x, z) --
-     turtle.forward()
-   end
-   f(x, dz)
-
-   if x%2 == 0 then
-     turtle.turnLeft()
-     turtle.forward()
-     turtle.turnLeft()
-   else
-     turtle.turnRight()
-     turtle.forward()
-     turtle.turnRight()
-   end
- end
-end
-
-
-function b(x,z)
-  print('b')
-  build(x, z, nil, blueprint)
-end
-
-
-function printone()
-  turtle.select(2)
-  turtle.refuel()
-
-  turtle.select(1)
-  area(#blueprint, #blueprint[1], b)
-end
-
-
-function inspect()
-  local b = ({turtle.inspectDown()})[2]
-  print('Inspecting... ', b.name)
-  turtle.digDown()
-  return b.name
-end
-
-
-function scan()
-  print('Scanning...')
-  turtle.select(2)
-  turtle.refuel()
-
-  area(3, 3, inspect)
-end
-
-scan()

  print('Inspecting... ', b.name)
  turtle.digDown()
  return b.name
end


function scan()
  print('Scanning...')
  turtle.select(2)
  turtle.refuel()

  area(3, 3, inspect)
end

scan()
