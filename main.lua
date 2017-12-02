require("scripts.platform")

DEBUG_MODE = true

function love.load(arg)
    camera = require("scripts.camera")
    platformGenerator = require("scripts.platform_generator")
    platformGenerator.start()

    background = require("scripts.background")
    frame = require("scripts.frame")
    floor = require("scripts.floor")
    fireboy = require("scripts.fireboy")
    gamestate = require("scripts.gamestate")

end

function love.update(dt)
    platformGenerator.update(dt)
    fireboy.update(dt)
    camera.update()
end

function love.draw(dt)
    background.draw(dt)

    -- Camera transformation
    camera.set()

    floor.draw(dt)
    platformGenerator.draw(dt)
    fireboy.draw(dt)

    camera.unset()
    -- End of camera transformation

    frame.draw(dt)

    if DEBUG_MODE then
        love.graphics.print('Gamestate state: ' .. tostring(gamestate.state), 5, 10)
        love.graphics.print('Fireboy state: ' .. tostring(fireboy.state), 5, 20)
        love.graphics.print('Camera pos: ' .. tostring(camera.y), 5, 30)
    end
end
