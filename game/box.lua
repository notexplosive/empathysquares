Box = {}
Box.__index = Box
Box.list = {}

function Box:create(x,y)
  -- necessary steps to create an object
  -- create a table called "box"
  box = {}

  -- literally magic. Essentially copies the functions from "Box" into "box"
  setmetatable(box,Box)

  box.width  = 130
  box.height = 130
  box.x = 0
  box.y = 0
  box.color = {120,200,120,255}

  -- tracks if mouse is hovering over box
  box.hover = false

  -- if false, the object is not displayed as is effectively "destroyed"
  box.active = true;

  -- flag that designates if we should show the box or the image
  box.showImage = false;

  -- designates which folder to look in for that emotion.
  -- also designates the text that appears when a match is successful.
  box.name = "happy"

  -- image is the actual "image" object. modified with Box:changeImage
  box.image = nil;

  -- flag to keep track if the game has assigned an image yet.
  box.hasBeenAssignedImage = false;

  -- initializes the image fields so nothing weird happens later.
  box:changeImage(box.name);

  -- need to refactor "animTick" is the wrong name for this.
  -- this is used in Box:draw() for the intro animation.
  box.animTick = .1
  box.animTrigger = false

  -- places box at constructor given position if provided
  if x ~= nil then
    box.x = x
  end
  if y ~= nil then
    box.y = y
  end

  -- adds box to the list of all boxes
  -- self-removes if the box if Box:destroy() is called
  Box.list[#Box.list+1] = box

  -- constructor returns the object because LUA
  return box
end

-- assigns name and image
function Box:changeImage(str)
  self.name = str;
  self.image = love.graphics.newImage("images/"..self.name.."/1.png")
end

-- translates the x and y to the actual pixel position in the window
function Box:realPosition()
  local scale = 140;
  return self.x*scale+130,self.y*scale+30
end

-- determines if the mouse is currently hovering
function Box:getHover()
  local x,y = love.mouse.getPosition()
  local px,py = self:realPosition()
  return (x > px and y > py) and (x < px+self.width and y < py+self.height)
end

-- note: x and y do not refer to their world position
-- x and y refer to where they are in the grid (1,1) , (2,3) etc
-- see Box:realPosition
function Box:setPosition(x,y)
  self.x = x
  self.y = y
end

-- runs 60 times per second (see main.lua)
function Box:update()
  if self.active then
    -- update self.hover
    self.hover = self:getHover() and not DISABLE_CLICK

    if self.hover and mouseClick() then
      self.showImage = true;
    end

    -- animTrigger has a 50% chance of being true.
    -- adds variance to the intro animation.
    -- might refactor this out later
    if not self.animTrigger then
      self.animTrigger = (math.random() > .5)
    end
  end
end

-- LUA is garbage collected so we can't remove objects properly.
function Box:destroy()
  self.active = false;
  Box.list[self.x+1][self.y+1] = nil
end

-- called every time love.draw() is called (60ish times per second)
function Box:draw()
  -- save position for later use
  local x,y = self:realPosition()

  -- save current color on the "brush" so we can give it back later
  local r,g,b,a = love.graphics.getColor()

  -- animTick slowly rises to 1 exponentially
  -- creates a nice easing curve for animation
  if self.animTick < 1 then
    if self.animTrigger then
      self.animTick = self.animTick * 1.05
    end
  else
    self.animTick = 1
  end

  -- sets brush to self.color
  if self.color ~= nil then
    love.graphics.setColor(unpack(self.color))
  end

  if self.active then
    if self.showImage then
      love.graphics.setColor(255,255,255,255)
      --love.graphics.draw(self.image,x,y)
      xScale = self.width / self.image:getWidth()
      yScale = self.height / self.image:getHeight()

      love.graphics.push()
      love.graphics.scale(xScale,yScale)
      love.graphics.draw(self.image,x/xScale,y/yScale)
      love.graphics.pop()
    else
      -- display the box, displays differently if box is being hovered over
      if self.hover and self.animTick == 1 then
        love.graphics.setColor(15,160,15,255)
        love.graphics.rectangle('fill',x,y,self.width,self.height)
        love.graphics.setColor(255,255,255,255)
        love.graphics.rectangle('line',x,y,self.width,self.height)
      else
        love.graphics.rectangle('fill',x*self.animTick,y*self.animTick,self.width,self.height)
        love.graphics.setColor(15,15,255,255)
        love.graphics.rectangle('line',x*self.animTick,y*self.animTick,self.width,self.height)
      end
    end
  end

  -- give the brush its old color back
  -- technically not needed, but good convention
  love.graphics.setColor(r,g,b,a)
end
