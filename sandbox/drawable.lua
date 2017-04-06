drawable = {}

function push_drawable(obj)
  drawable[#drawable+1] = obj
end

function love.draw()
  for i=1,#drawable do
    if drawable[i].visible then
      drawable[i].draw()
    end
  end
end
