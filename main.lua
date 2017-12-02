background = require("objects.background")
frame = require("objects.frame")
floor = require("objects.floor")

fireboy = require("objects.fireboy")

function love.load(arg)

end

function love.update(dt)

end

function love.draw(dt)
    love.graphics.draw(background.img, background.x, background.y)
    love.graphics.draw(frame.img, frame.x, frame.y)
    love.graphics.draw(floor.img, floor.x, floor.y)

    love.graphics.draw(fireboy.img, fireboy.frames[fireboy.pos_frame], fireboy.drawX(), fireboy.drawY())
end
