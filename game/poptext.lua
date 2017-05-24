PopText = {}
PopText.oldContent = ""
PopText.content = ""
PopText.framesSpentAsCurrent = 0

-- this is used to change the text shown by PopText.
-- you should not use .content directly.
function PopText.set(text)
  PopText.framesSpentAsCurrent = 0
  PopText.content = text
end

function PopText.update()
  PopText.framesSpentAsCurrent = PopText.framesSpentAsCurrent + 1
end

-- draws the current content, if a "set" was not issued in the last 60 frames,
-- poptext displays nothing
function PopText.draw()
  if PopText.framesSpentAsCurrent < 60 then
    love.graphics.printf(PopText.content,105,240,600,"center")
  end
end
