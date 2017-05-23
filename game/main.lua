require "box"
require "cursor"

local emotionNames = love.filesystem.getDirectoryItems("images")
print("DETECTED FOLDERS:")
for i=1,#emotionNames do
  local subImages = love.filesystem.getDirectoryItems("images/"..emotionNames[i])
  print(emotionNames[i])
  print(unpack(subImages))
end
print()

-- happy, sad, tired, angy, sick, surprised, confused

local haltInputTimer = 0;
local evaluateFlag = false;
local popText = ""
local gameStarted = false;

function startGame()
  -- destroy all boxes, assuming we've already started the game once this run.
  for i=0,#Box.list do
    if Box.list[i] ~= nil then
      Box.list[i]:destroy()
    end
  end

  Box.list = {}

  if not gameStarted then
    for x=0,3 do
      for y=0,3 do
        local b = Box:create(x,y)
        b.color[1] = 40*x + 40
        b.color[2] = 25*y + 40
        b.color[3] = (x+y)*10
        b.animTick = 1 - (x+y)*.15
      end
    end

    local numberMarked = 0
    for i=1,#Box.list/2 do
      local emotion = emotionNames[ i % (#emotionNames) + 1 ]
      numberMarked = numberMarked + 1

      local t1 = i
      local t2 = 1

      while Box.list[t1].marked do
        t1 = t1 + 1
      end

      while (Box.list[t2].marked or t1 == t2) do
        t2 = math.random(#Box.list)
      end

      Box.list[t1].marked = true
      Box.list[t2].marked = true

      Box.list[t1]:changeImage(emotion)
      Box.list[t2]:changeImage(emotion)

      if(emotion ~= nil) then
        print(t1 .. ", " .. t2 .. " " .. emotion)
      end
    end

    gameStarted = true;
  end
end

function love.draw()
  if not gameStarted then

    love.graphics.print("press space to begin",350,200)
  end
  for i = 1,#Box.list do
    Box.list[i]:draw()
  end

  love.graphics.print(popText,200,200)
end

function love.update()
  -- see cursor.lua
  cursorUpdate()

  -- if clicking is disabled, tick down a timer to re-enable it
  if haltInputTimer > 0 then
    haltInputTimer = haltInputTimer - 1
    DISABLE_CLICK = true;
  else
    DISABLE_CLICK = false;
  end

  -- press space to start
  if love.keyboard.isDown('space') and not gameStarted then
    startGame()
    gameStarted = true;
  end

  -- press r to reset
  if love.keyboard.isDown('r') and gameStarted then
    startGame()
    gameStarted = false;
  end

  -- table to track boxes that are showing their image and not the square
  local currentlyVisibleImages = {}

  -- actual "game" happens here.
  for i = 1,#Box.list do
    -- run the update function for every box (see box.lua)
    Box.list[i]:update()

    -- adds box to the list of shown images
    if Box.list[i].active and Box.list[i].showImage then
      currentlyVisibleImages[#currentlyVisibleImages+1] = Box.list[i]
    end

    -- if there are 2 shown images, determine match
    if #currentlyVisibleImages == 2 then
      if haltInputTimer == 0 then
        if not evaluateFlag then
          -- turn off mouse for 60 seconds
          haltInputTimer = 60
          evaluateFlag = true
        end
      end

      -- yes, this if is repeated, it has to be because of how the logic works
      -- trust me.
      if haltInputTimer == 0 then
        if evaluateFlag then
          local img1 = currentlyVisibleImages[1]
          local img2 = currentlyVisibleImages[2]

          -- if they share the same name (aka: came from the same folder)
          -- then we have a match!
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

  --print(#currentlyVisibleImages .. " currently visible images")
end
