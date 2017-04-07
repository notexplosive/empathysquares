function length(x,y)
  return math.sqrt( x*x + y*y )
end

function normalized(x,y)
  local l = length(x,y)
  return x/l,y/l
end

-- vectors must be NORMALIZED going in
function dotProduct(x1,y1,x2,y2)
  return (x1 * x2) + (y1 * y2)
end

function angleBetweenTwoVectors(x1,y1,x2,y2)
  return math.acos(dotProduct(x1,y1,x2,y2))
end

function angle(x,y)
  local x1,y1 = normalized(x,y)
  local angle1 = angleBetweenTwoVectors( x1,y1 ,1,0 )
  local angle2 = angleBetweenTwoVectors( x1,y1 ,0,1 )
  local angle1_deg = math.floor(math.deg(angle1))
  local angle2_deg = math.floor(math.deg(angle2))

  if angle1_deg < 90 and angle2_deg < 90 then
    return angle1
    --print(angle1_deg)
  end

  if not (angle1_deg < 90) then
    return math.pi/2+angle2
    --print(90+angle2_deg)
  end

  if not (angle2_deg < 90) and (angle1_deg < 90) then
    return math.pi*2-angle1
    --print(360-angle1_deg)
  end

end

function rotate(x,y,a)
  local length = length(x,y)
  local angle  = angle(x,y)
  x = math.cos(a+angle)
  y = math.sin(a+angle)
  x,y = normalized(x,y)
  x = x * length
  y = y * length
  return x,y
end
