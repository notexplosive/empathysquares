require "angle"

Polygon = {}
Polygon.__index = Polygon

function Polygon.create(self,center,vertecies)
  local polygon = {}
  setmetatable(polygon,Polygon)
  polygon.center = {300,300}
  polygon.vertecies = {100, 100, 200, 100, 150, 200, 50, 50}
  polygon.angle = 0

  if center ~= nil then
    polygon.center = center
  end

  if vertecies ~= nil then
    polygon.vertecies = {unpack(vertecies)}
  end

  return polygon
end

function Polygon:points()
    local tbl = {unpack(self.vertecies)}
    local avgPoint = self:avgPoint()

    for i=1,#tbl,2 do
      tbl[i] = tbl[i] + self.center[i%2] - avgPoint.x
      tbl[i+1] = tbl[i+1] + self.center[i%2+1] - avgPoint.y
    end
    return tbl
end

function Polygon:avgPoint()
  local tbl = {unpack(self.vertecies)}
  local avgPoint = {x=0,y=0}

  for i=1,#tbl,2 do
    avgPoint.x = avgPoint.x + tbl[i]
    avgPoint.y = avgPoint.y + tbl[i+1]
  end

  avgPoint.x = avgPoint.x / (#tbl/2)
  avgPoint.y = avgPoint.y / (#tbl/2)
  return avgPoint
end

function Polygon:draw()
  local r,g,b,a = love.graphics.getColor()
  love.graphics.setColor(255,255,0,255)
  if self:getHover() then
    love.graphics.polygon('fill', polygon:points())
  else
    love.graphics.polygon('line', polygon:points())
  end
  love.graphics.setColor(r,g,b,a)
end

function Polygon:getHover()
  shape = love.physics.newPolygonShape(self.vertecies)
  local mx,my = love.mouse.getPosition()
  return shape:testPoint(0,0,0,mx,my)
end

function Polygon:rotate(theta)
  local tbl = self:points()--{unpack(self.vertecies)}
  self.angle = self.angle + theta
  for i=1,#tbl,2 do
    tbl[i],tbl[i+1] = rotate(tbl[i],tbl[i+1],theta)
  end
  self.vertecies = tbl;
  return tbl
end
