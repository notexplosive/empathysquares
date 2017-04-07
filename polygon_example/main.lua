require "angle"
require "polygon"

polygon = Polygon:create()
polygon2 = Polygon:create()

polygon2.center = {200,200}

line = {x=1*200,y=1*200}
theta = math.pi / 120

function love.load()
  polygon:rotate(math.pi / 120)
end

function love.update(dt)
  if love.keyboard.isDown('a') then
    polygon:rotate(math.pi / 120)
  end
  if love.keyboard.isDown('d') then
    polygon:rotate(-math.pi / 120)
  end
end

function love.draw()
  polygon:draw()

  love.graphics.line(200,200,400,200)
  love.graphics.line(200,200,200 + line.x,200 + line.y)
  love.graphics.circle('line',200,200,200)
end
