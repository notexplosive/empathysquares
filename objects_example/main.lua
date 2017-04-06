require "actor"
require "draw_loop"
require "logic_loop"
require "circle"

function love.load()
  for i=0,100 do
    local c = new_circle(8+math.random(4),800*(math.random(100)/100),600*(math.random(100)/100))
    c.velocity = {x=math.random(3)-4,y=math.random(3)-4}
    c.color = {r=math.random(255),g=math.random(255),b=math.random(255)}
  end
end
