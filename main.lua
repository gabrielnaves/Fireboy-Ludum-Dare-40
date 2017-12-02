DEBUG_MODE = true

function love.load(arg)
    camera = require("scripts.camera")

    background = require("scripts.background")
    frame = require("scripts.frame")
    floor = require("scripts.floor")
    fireboy = require("scripts.fireboy")
    gamestate = require("scripts.gamestate")
end

function love.update(dt)
    fireboy.update(dt, gamestate)
    camera.update()
end

function love.draw(dt)
    background.draw(dt)
    frame.draw(dt)

    -- Camera transformation
    camera.set()

    floor.draw(dt)
    fireboy.draw(dt)

    camera.unset()

    if DEBUG_MODE then
        love.graphics.print('Gamestate state: ' .. tostring(gamestate.state), 5, 10)
        love.graphics.print('Fireboy state: ' .. tostring(fireboy.state), 5, 20)
        love.graphics.print('Camera pos: ' .. tostring(camera.y), 5, 30)
    end
end
