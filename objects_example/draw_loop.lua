function love.draw()
  for i=1,#actors do
    if actors[i].visible then
      actors[i].draw()
    end
  end
end
