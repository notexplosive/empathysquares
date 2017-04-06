new_actor = function(_x,_y)
  local self = {}
  self.draw = function() end;
  self.update = function() end;
  self.x = _x
  self.y = _y

  self.velocity = {}
  self.velocity.x = 0
  self.velocity.y = 0;

  self.visible = true;

  push_drawable(self)
  push_active(self)
  return self
end
