frame = {}
frame.img = love.graphics.newImage('assets/sprites/frame.png')
frame.x = -20
frame.y = 0

function frame.draw(dt)
    love.graphics.draw(frame.img, frame.x, frame.y)
end

return frame
