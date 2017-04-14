require "box"

for x=0,8 do
  for y=0,5 do
    Box:create(x,y)
  end
end

Box.list[10].color = {255,0,0,255}

Box.list[11].color = {255,0,0,255}

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
