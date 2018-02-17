background = {}
background.img = love.graphics.newImage('assets/sprites/background.png')
background.x = 0
background.y = 0

function background.draw(dt)
    graphics.draw(background.img, background.x, background.y)
end

return background
