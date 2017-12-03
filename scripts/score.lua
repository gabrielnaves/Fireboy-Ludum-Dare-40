score = {}

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
    if gamestate.state == gamestate.states.ingame then
        love.graphics.print('Distance: ' .. tostring(score.distance), 5, 25)
        love.graphics.print('Enemies killed: ' .. tostring(score.enemiesKilled), 5, 37)
        love.graphics.print('Fire time multiplier: ' .. tostring(score.multiplier), 5, 49)
        love.graphics.print('Score: ' .. tostring(score.score), 5, 61)
    elseif gamestate.state == gamestate.states.dead then
        love.graphics.print('Total score: ' .. tostring(score.score), 5, 25)
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
