require "box"
require "cursor"

local haltInputTimer = 0;
local evaluateFlag = false;
local popText = ""

function startGame()
  if not gameStarted then
    for x=0,6 do
      for y=0,5 do
        local b = Box:create(x,y)
        b.color[1] = 20*x + 20
        b.color[2] = 20*y + 20
        b.color[3] = x+y
      end
    end

    Box.list[10]:changeImage("angry.png")
    Box.list[35]:changeImage("angry.png")
    gameStarted = true;
  end
end

function love.draw()
  if not gameStarted then

    love.graphics.print("press space to begin",350,200)
    local img = love.graphics.newImage("happy.png")
    love.graphics.draw(img,200,200)
  end
  for i = 1,#Box.list do
    Box.list[i]:draw()
  end

  love.graphics.print(popText,200,200)
end

function love.update()
  cursorUpdate()

  if haltInputTimer > 0 then
    haltInputTimer = haltInputTimer - 1
    DISABLE_CLICK = true;
  else
    DISABLE_CLICK = false;
  end

  if love.keyboard.isDown('space') then
    startGame()
  end

  local currentlyVisibleImages = {}
  for i = 1,#Box.list do
    Box.list[i]:update()
    if Box.list[i].active and Box.list[i].showImage then
      currentlyVisibleImages[#currentlyVisibleImages+1] = Box.list[i]
    end

    if #currentlyVisibleImages == 2 then
      if haltInputTimer == 0 then
        if not evaluateFlag then
          haltInputTimer = 60
          evaluateFlag = true
        end
      end

      if haltInputTimer == 0 then
        if evaluateFlag then
          local img1 = currentlyVisibleImages[1]
          local img2 = currentlyVisibleImages[2]

          if img1.name == img2.name then
            img1:destroy()
            img2:destroy()
            popText = img1.name;
          else
            img1.showImage = false;
            img2.showImage = false;
          end

          currentlyVisibleImages = {}
          evaluateFlag = false;
        end
      end

    end
  end

  print(evaluateFlag)
  --print(#currentlyVisibleImages .. " currently visible images")
end
