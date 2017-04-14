Box = {}
Box.__index = Box
Box.list = {}

function Box:create(x,y)
  box = {}
  setmetatable(box,Box)
  box.width = 64
  box.height = 64
  box.x = 0
  box.y = 0
  box.hover = false
  box.color = {120,200,120,255}

  if x ~= nil then
    box.x = x
  end
  if y ~= nil then
    box.y = y
  end

  Box.list[#Box.list+1] = box

  return box
end

function Box:realPosition()
  return self.x*80+46,self.y*80+46
end

function Box:getHover()
  local x,y = love.mouse.getPosition()
  local px,py = self:realPosition()
  return (x > px and y > py) and (x < px+self.width and y < py+self.height)
end

function Box:setPosition(x,y)
  self.x = x
  self.y = y
end

function Box:update()
  self.hover = self:getHover()
end

function Box:draw()
  local x,y = self:realPosition()
  local r,g,b,a = love.graphics.getColor()
  if self.color ~= nil then
    love.graphics.setColor(unpack(self.color))
  end

  if self.hover then
    love.graphics.setColor(15,160,15,255)
    love.graphics.rectangle('fill',x,y,self.width,self.height)
    love.graphics.setColor(255,255,255,255)
    love.graphics.rectangle('line',x,y,self.width,self.height)
  else
    love.graphics.rectangle('fill',x,y,self.width,self.height)
    love.graphics.setColor(15,15,255,255)
    love.graphics.rectangle('line',x,y,self.width,self.height)
  end
  love.graphics.setColor(r,g,b,a)
end
