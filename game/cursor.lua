local mouseDownLastFrame = false
local click = false;

-- global flag that indicates mouseclicks should not be recieved
DISABLE_CLICK = false

-- returns true if mouse was clicked this frame (but not pressed)
function mouseClick()
  return click and not DISABLE_CLICK
end

-- run 60 times per second (see main.lua)
function cursorUpdate()
  click = love.mouse.isDown(1) and not mouseDownLastFrame
  mouseDownLastFrame = love.mouse.isDown(1)
end
