-- box "constructor", this function returns a table that will behave like a box
function new_selectable_box(x,y,height,width)
  -- basically overloading. If height/width are not provided, they are set to 16
  if height == nil or width == nil then
    width = 16
    height = 16
  end

  -- local fields
  local box = {}
  box.velocity = {}
  box.velocity.y = 0;
  box.x = x
  box.y = y
  box.clicked = false;
  box.mouseover = false;

  -- local methods
  box.render = function()
    if love.mouse.isDown(1) and box.mouseover then
      love.graphics.setColor( 255, 0, 0, 255 )
      love.graphics.rectangle("fill",box.x,box.y,width,height)
    else
      if box.clicked then
        if box.mouseover then
          love.graphics.setColor( 255, 255, 255, 255 )
          love.graphics.rectangle("line",box.x,box.y,width,height)
        else
          love.graphics.setColor( 255, 0, 255, 255 )
          love.graphics.rectangle("line",box.x,box.y,width,height)
        end
      else
        if box.mouseover then
          love.graphics.setColor( 255, 255, 0, 255 )
          love.graphics.rectangle("fill",box.x,box.y,width,height)
        else
          love.graphics.setColor( 0, 255, 255, 255 )
          love.graphics.rectangle("fill",box.x,box.y,width,height)
        end
      end
    end
  end

  -- showing other syntax for functions
  box.update = function()
    local mx = love.mouse.getX()
    local my = love.mouse.getY()

    if mx > box.x and mx < box.x + width and my > box.y and my < box.y + height then
      box.mouseover = true
    else
      box.mouseover = false
    end

    if box.mouseover and mouseclick then
      box.clicked = not box.clicked
    end
  end

  box.fall = function()
    if box.y < 550 then
      box.y = box.y + box.velocity.y
      box.velocity.y = box.velocity.y + love.math.random(3)
    end
  end

  -- return call at end of constructor
  return box;
end
