active_objects = {}

function push_active(obj)
  active_objects[#active_objects+1] = obj
end

function love.update(dt)
  for i=1,#active_objects do
    active_objects[i].update()
    active_objects[i].x = active_objects[i].x + active_objects[i].velocity.x
    active_objects[i].y = active_objects[i].y + active_objects[i].velocity.y
  end
end
