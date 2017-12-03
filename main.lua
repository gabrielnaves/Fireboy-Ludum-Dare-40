require("scripts.game_input")
require("scripts.base_platform")
require("scripts.base_enemy")
require("scripts.enemy_collision")
require("scripts.game_math")

DEBUG_MODE = true

function love.load(arg)
    camera = require("scripts.camera")
    platformGenerator = require("scripts.platform_generator")

    background = require("scripts.background")
    frame = require("scripts.frame")
    floor = require("scripts.floor")
    enemyGenerator = require("scripts.enemy_generator")
    fireboy = require("scripts.fireboy")
    gamestate = require("scripts.gamestate")
    firebar = require("scripts.firebar")

    platformGenerator.start()
end

function love.update(dt)
    input:update(dt)
    platformGenerator.update(dt)
    enemyGenerator.update(dt)
    fireboy.update(dt)
    gamestate.update(dt)
    camera.update()
end

function love.draw(dt)
    background.draw(dt)

    -- Camera transformation
    camera.set()

    floor.draw(dt)
    platformGenerator.draw(dt)
    enemyGenerator.draw(dt)
    fireboy.draw(dt)

    camera.unset()
    -- End of camera transformation

    frame.draw(dt)
    firebar.draw(dt)
    gamestate.draw(dt)

    if DEBUG_MODE then
        love.graphics.print('Fire: ' .. tostring(firebar.fire), 5, 40)
        love.graphics.print('Gamestate state: ' .. tostring(gamestate.state), 5, 50)
        love.graphics.print('Fireboy state: ' .. tostring(fireboy.state), 5, 60)
        love.graphics.print('Enemy amount: ' .. tostring(enemyGenerator.enemyAmount), 5, 70)
    end
end
