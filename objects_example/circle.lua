new_circle = function(_r,_x,_y)
  local self = new_actor(_x,_y)
  self.type   = "circle"
  self.radius = _r

  self.draw = function()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.color.r,self.color.g,self.color.b,255)
    love.graphics.circle("line",self.x,self.y,self.radius)
    love.graphics.setColor(r,g,b,a)
  end

  self.update = function(dt)
    if self.y < 0 then
      self.velocity.y = -self.velocity.y
      self.y = 0
    end

    if self.x < 0 then
      self.velocity.x = -self.velocity.x
      self.x = 0
    end

    if self.x > 800 then
      self.velocity.x = -self.velocity.x
      self.x = 800
    end

    if self.y > 600 then
      self.velocity.y = -self.velocity.y
      self.y = 600
    end

    for i=1,#actors do
      local other = actors[i]
      if other ~= self then
        local dif = {}
        dif.x = self.x - other.x
        dif.y = self.y - other.y

        local sumRadius = self.radius + other.radius

        if math.abs(dif.x) < sumRadius and math.abs(dif.y) < sumRadius then
          local oldLength = math.sqrt(self.velocity.x*self.velocity.x + self.velocity.y*self.velocity.y)
          local newLength = math.sqrt(dif.x*dif.x + dif.y*dif.y)

          self.velocity.x = dif.x/newLength * oldLength
          self.velocity.y = dif.y/newLength * oldLength
        end
      end
    end
  end

  return self
end
