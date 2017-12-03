-- enemy = require("enemy.lua")
enemyGenerator = {}

enemyGenerator.enemies = {}
enemyGenerator.enemyAmount = 0

function enemyGenerator.generateEnemy(xPos, yPos)
    local newEnemy = base_enemy:createEnemy(xPos, yPos)
    table.insert(enemyGenerator.enemies, newEnemy)
    enemyGenerator.enemyAmount = enemyGenerator.enemyAmount + 1
end

function enemyGenerator.update(dt)
    enemyGenerator.updateEnemyArray(dt)
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

return enemyGenerator
