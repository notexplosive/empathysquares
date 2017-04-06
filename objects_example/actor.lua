actors = {}

new_actor = function(_x,_y)
  local self = {}
  self.type = ""

  -- placeholder functions
  self.load   = function() end
  self.draw   = function() end
  self.update = function(dt) end

  self.x = _x
  self.y = _y

  self.velocity = {}
  self.velocity.x = 0
  self.velocity.y = 0

  self.color = {r=255,g=255,b=255}

  self.visible = true;

  push_actors(self)
  return self
end

function push_actors(obj)
  actors[#actors+1] = obj
end
