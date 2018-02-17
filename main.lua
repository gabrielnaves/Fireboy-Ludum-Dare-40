require("scripts.graphics")
require("scripts.game_input")
require("scripts.base_platform")
require("scripts.base_enemy")
require("scripts.still_animation")
require("scripts.enemy_collision")
require("scripts.game_math")
require("scripts.number_draw")

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
    score = require("scripts.score")
    animationManager = require("scripts.animation_manager")

    platformGenerator.start()
end

function love.update(dt)
    mouse:update()
    platformGenerator.update(dt)
    enemyGenerator.update(dt)
    fireboy.update(dt)
    gamestate.update(dt)
    camera.update(dt)
    score.update(dt)
    animationManager.update(dt)
end

function love.draw(dt)
    background.draw(dt)

    -- Camera transformation
    camera.set()

    floor.draw(dt)
    platformGenerator.draw(dt)
    enemyGenerator.draw(dt)
    fireboy.draw(dt)
    animationManager.draw(dt)
    frame.draw(dt)
    firebar.draw(dt)
    score.draw(dt)

    camera.unset()
    -- End of camera transformation

    gamestate.draw(dt)
end
