require "angle"
require "polygon"

polygon = Polygon:create()
polygon2 = Polygon:create()

polygon2.center = {220,100}

theta = math.pi / 120

function love.load()
  polygon:rotate(theta)
end

function love.update(dt)
  if love.keyboard.isDown('a') then
    polygon:rotate(theta)
  end
  if love.keyboard.isDown('d') then
    polygon:rotate(-theta)
  end
end

function love.draw()
  polygon:draw()
  polygon2:draw()
end
