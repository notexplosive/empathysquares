local mouseDownLastFrame = false
local click = false;

DISABLE_CLICK = false

function mouseClick()
  return click and not DISABLE_CLICK
end

function cursorUpdate()
  click = love.mouse.isDown(1) and not mouseDownLastFrame
  mouseDownLastFrame = love.mouse.isDown(1)
end
