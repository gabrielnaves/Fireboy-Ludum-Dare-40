gamestate = {}

gamestate.states = { begin = "begin", ingame = "ingame", dead = "dead" }
gamestate.titleText = love.graphics.newImage('assets/sprites/title_text.png')
gamestate.creditsText = love.graphics.newImage('assets/sprites/credits_text.png')
gamestate.beginText = love.graphics.newImage('assets/sprites/start_text.png')
gamestate.gameOverText = love.graphics.newImage('assets/sprites/game_over_text.png')
gamestate.endText = love.graphics.newImage('assets/sprites/end_text.png')

function gamestate.updateBegin(dt)
    if input:actionButtonDown() then
        gamestate.state = gamestate.states.ingame
        gamestate.updateState = gamestate.updateInGame
        gamestate.drawState = gamestate.drawInGame
    end
end

function gamestate.updateInGame(dt)
    if fireboy.state == fireboy.states.dead then
        gamestate.state = gamestate.states.dead
        gamestate.updateState = gamestate.updateDead
        gamestate.drawState = gamestate.drawDead
    end
end

function gamestate.updateDead(dt)
    if input:actionButtonDown() then
        fireboy.reset()
        enemyGenerator.reset()
        camera.reset()
        platformGenerator.reset()
        score.reset()
        gamestate.updateState = gamestate.updateBegin
        gamestate.drawState = gamestate.drawBegin
        gamestate.state = gamestate.states.begin
    end
end

function gamestate.update(dt)
    gamestate.updateState(dt)
end

function gamestate.drawBegin(dt)
    love.graphics.draw(gamestate.titleText, 144, 54)
    love.graphics.draw(gamestate.creditsText, 58, 102)
    love.graphics.draw(gamestate.beginText, 68, 422)
end

function gamestate.drawInGame(dt) end

function gamestate.drawDead(dt)
    love.graphics.draw(gamestate.gameOverText, 120, 388)
    love.graphics.draw(gamestate.endText, 60, 422)
end

function gamestate.draw(dt)
    gamestate.drawState(dt)
end

gamestate.updateState = gamestate.updateBegin
gamestate.drawState = gamestate.drawBegin
gamestate.state = gamestate.states.begin

return gamestate
