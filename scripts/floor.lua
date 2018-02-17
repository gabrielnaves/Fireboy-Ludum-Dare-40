floor = {}
floor.img = love.graphics.newImage('assets/sprites/floor.png')
floor.x = 0
floor.y = 608

function floor.draw(dt)
    graphics.draw(floor.img, floor.x, floor.y)
end

return floor
