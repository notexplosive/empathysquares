require "box";
boxes = {}
frame = 0
mousedown = false;
mouseclick = false;

function love.load()
  local row = 0
  local col = 0
  for i=0,39 do
    boxes[i+1] = new_selectable_box( col*(64+32) + 32, row*(64+32) + 32 ,64,64)
    col = col + 1;
    if col > 7 then
      row = row + 1
      col = 0
    end
  end
end

function love.update(dt)
  if not love.mouse.isDown(1) and mousedown then
    mouseclick = true;
  end
  for i=1,#boxes do
    if love.keyboard.isDown('a') then
      boxes[i].fall()
    end
    boxes[i].update()
  end

  mousedown = love.mouse.isDown(1);
  mouseclick = false;
end

function love.draw()
  local mouseX = love.mouse.getX()
  local mouseY = love.mouse.getY()

  for i=1,#boxes do
    boxes[i].render()
  end

  love.graphics.setColor(255,255,255,255)
  love.graphics.print('frame: '..frame,0,16)
  love.graphics.print(mouseX..','..mouseY)
  frame = frame + 1
  frame = frame % 30
end
