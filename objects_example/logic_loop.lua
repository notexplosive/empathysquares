function love.update(dt)
  for i=1,#actors do
    actors[i].x = actors[i].x + actors[i].velocity.x
    actors[i].y = actors[i].y + actors[i].velocity.y
    actors[i].update()
  end
end
