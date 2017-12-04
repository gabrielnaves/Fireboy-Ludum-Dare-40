score = {}

score.text = love.graphics.newImage('assets/sprites/score_text.png')

score.score = 0
score.distance = 0
score.enemiesKilled = 0
score.multiplier = 1

score.fireTimer = 0

function score.update(dt)
    score.updateDistance(dt)
    score.updateMultiplier(dt)
    score.calculateScore(dt)
end

function score.updateDistance(dt)
    local currentDistance = math.floor((608 - fireboy.y) / 100)
    if currentDistance > score.distance then
        score.distance = currentDistance
    end
end

function score.updateMultiplier(dt)
    if firebar.fire == firebar.maxFire then
        score.fireTimer = score.fireTimer + dt
        if score.fireTimer > 1 then
            score.fireTimer = 0
            score.multiplier = score.multiplier + 1
        end
    else
        score.fireTimer = 0
    end
end

function score.calculateScore(dt)
    local enemyMultiplier = math.floor(score.enemiesKilled / 5) + 1
    score.score = score.distance * enemyMultiplier * score.multiplier
end

function score.draw(dt)
    if gamestate.state ~= gamestate.states.begin then
        love.graphics.draw(score.text, 6 + camera.realX, 26 + camera.realY)

        drawInteger(score.distance, 98 + camera.realX, 26 + camera.realY)
        drawInteger(score.enemiesKilled, 58 + camera.realX, 46 + camera.realY)
        drawInteger(score.multiplier - 1, 124 + camera.realX, 66 + camera.realY)
        drawInteger(score.score, 72 + camera.realX, 86 + camera.realY)
    end
end

function score.reset()
    score.score = 0
    score.distance = 0
    score.enemiesKilled = 0
    score.multiplier = 1
    score.fireTimer = 0
end

return score
