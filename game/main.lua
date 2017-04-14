require "box"

count = 0

for x=0,6 do
  for y=0,5 do
    Box:create(x,y)
    count = count + 1
  end
end

Box.list[10].color = {255,0,0,255}
Box.list[35].color = {255,0,0,255}

print(count .. " total boxes")

function love.draw()
  for i = 1,#Box.list do
    Box.list[i]:draw()
  end
end

function love.update()
  for i = 1,#Box.list do
    Box.list[i]:update()
  end
end
