DEBUG_MODE = true

function love.load(arg)
    background = require("scripts.background")
    frame = require("scripts.frame")
    floor = require("scripts.floor")
    fireboy = require("scripts.fireboy")
    gamestate = require("scripts.gamestate")
end

function love.update(dt)
    fireboy.update(dt, gamestate)
end

function love.draw(dt)
    background.draw(dt)
    frame.draw(dt)
    floor.draw(dt)
    fireboy.draw(dt)

    if DEBUG_MODE then
        love.graphics.print('Gamestate state: ' .. tostring(gamestate.state), 5, 10)
        love.graphics.print('Fireboy state: ' .. tostring(fireboy.state), 5, 20)
    end
end
