require "drawable"
require "logic_loop"
require "actor"
require "circle"

function love.load()
  local circle = new_circle(5,200,200)
  new_circle(5,400,300)

  circle.velocity = {x=2,y=3}
end
