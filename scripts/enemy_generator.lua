-- enemy = require("enemy.lua")
enemyGenerator = {}

enemyGenerator.enemies = {}
enemyGenerator.enemyAmount = 0

-- Timers
enemyGenerator.initialDelayTimer = 0
enemyGenerator.initialDelay = 5
enemyGenerator.enemyGenTimer = 0
enemyGenerator.startingGenTime = 4
enemyGenerator.enemyGenTime = 4

function enemyGenerator.update(dt)
    if gamestate.state == gamestate.states.ingame then
        enemyGenerator.initialDelayTimer = enemyGenerator.initialDelayTimer + dt
        if enemyGenerator.initialDelayTimer > enemyGenerator.initialDelay then
            enemyGenerator.scaleGenTimeWithFireLevel()
            enemyGenerator.enemyGenTimer = enemyGenerator.enemyGenTimer + dt
            if enemyGenerator.enemyGenTimer > enemyGenerator.enemyGenTime then
                enemyGenerator.enemyGenTimer = 0
                enemyGenerator.generateEnemy(love.math.random(-10, 370), camera.y - 32)
            end
            enemyGenerator.updateEnemyArray(dt)
        end
    end
end

function enemyGenerator.scaleGenTimeWithFireLevel()
    if firebar.fire <= 100 then
        enemyGenerator.enemyGenTime = enemyGenerator.startingGenTime
    else
        enemyGenerator.enemyGenTime = enemyGenerator.startingGenTime *
                                      (1 - firebar.fire / firebar.maxFire) + 0.8
    end
end

function enemyGenerator.generateEnemy(xPos, yPos)
    local newEnemy = base_enemy:createEnemy(xPos, yPos)
    table.insert(enemyGenerator.enemies, newEnemy)
    enemyGenerator.enemyAmount = enemyGenerator.enemyAmount + 1
end

function enemyGenerator.updateEnemyArray(dt)
    for i, enemy in ipairs(enemyGenerator.enemies) do
        if enemy.y - camera.y > 640*3 then
            enemyGenerator.killEnemy(i)
        else
            base_enemy.update(dt, enemy, i)
        end
    end
end

function enemyGenerator.draw(dt)
    for i, enemy in ipairs(enemyGenerator.enemies) do
        base_enemy.draw(dt, enemy)
    end
end

function enemyGenerator.reset()
    enemyGenerator.enemyGenTimer = 0
    enemyGenerator.enemies = {}
    enemyGenerator.enemyAmount = 0
    enemyGenerator.initialDelayTimer = 0
end

function enemyGenerator.killEnemy(i)
    table.remove(enemyGenerator.enemies, i)
    enemyGenerator.enemyAmount = enemyGenerator.enemyAmount - 1
end

return enemyGenerator
