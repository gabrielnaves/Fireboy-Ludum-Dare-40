-- enemy = require("enemy.lua")
enemyGenerator = {}

enemyGenerator.enemies = {}
enemyGenerator.enemyAmount = 0

-- Timers
enemyGenerator.enemyGenTimer = 0
enemyGenerator.enemyGenTime = 4

function enemyGenerator.update(dt)
    if gamestate.state == gamestate.states.ingame then
        enemyGenerator.enemyGenTimer = enemyGenerator.enemyGenTimer + dt
        if enemyGenerator.enemyGenTimer > enemyGenerator.enemyGenTime then
            enemyGenerator.enemyGenTimer = 0
            enemyGenerator.generateEnemy(love.math.random(-10, 370), camera.y - 32)
        end
        enemyGenerator.updateEnemyArray(dt)
    end
end

function enemyGenerator.generateEnemy(xPos, yPos)
    local newEnemy = base_enemy:createEnemy(xPos, yPos)
    table.insert(enemyGenerator.enemies, newEnemy)
    enemyGenerator.enemyAmount = enemyGenerator.enemyAmount + 1
end

function enemyGenerator.updateEnemyArray(dt)
    for i, enemy in ipairs(enemyGenerator.enemies) do
        base_enemy.update(dt, enemy)
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
end

return enemyGenerator
