new_circle = function(_r,_x,_y)
  local self = new_actor(_x,_y)
  self.radius = _r

  self.draw = function()
    love.graphics.circle("line",self.x,self.y,self.radius)
  end

  self.update = function()
    --self.x = self.x + 1
  end

  return self 
end
