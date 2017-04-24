require "box"
require "cursor"

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
end

function love.update()
  cursorUpdate()

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
      -- move the destruction countdown into this loop
      -- this way we can adapt it to re-hide two non-matching cards
      if currentlyVisibleImages[1].name == currentlyVisibleImages[2].name then
        currentlyVisibleImages[1]:destroy();
        currentlyVisibleImages[2]:destroy();
      end
    end
  end

  print(#currentlyVisibleImages .. " currently visible images")
end
