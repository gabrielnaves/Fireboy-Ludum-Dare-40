gamestate = {}

gamestate.states = { begin = "begin", ingame = "ingame", dead = "dead" }
gamestate.begintext = love.graphics.newImage('assets/sprites/start_text.png')
gamestate.endtext = love.graphics.newImage('assets/sprites/end_text.png')

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
    love.graphics.draw(gamestate.begintext, 68, 422)
end

function gamestate.drawInGame(dt) end

function gamestate.drawDead(dt)
    love.graphics.draw(gamestate.endtext, 60, 422)
end

function gamestate.draw(dt)
    gamestate.drawState(dt)
end

gamestate.updateState = gamestate.updateBegin
gamestate.drawState = gamestate.drawBegin
gamestate.state = gamestate.states.begin

return gamestate
