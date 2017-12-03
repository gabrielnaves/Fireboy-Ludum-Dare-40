enemyCollision = {}

function enemyCollision:isCollidingWithFireboy(enemy)
    local width = fireboy.boxWidth * fireboy.scale
    local height = fireboy.boxHeight * fireboy.scale
    local fireboyPoints = {
        { x=(fireboy.x-width/2), y=(fireboy.y-height) }, -- Upper left
        { x=(fireboy.x+width/2), y=(fireboy.y-height) }, -- Upper right
        { x=(fireboy.x-width/2), y=(fireboy.y) }, -- Bottom left
        { x=(fireboy.x+width/2), y=(fireboy.y) } -- Bottom right
    }
    for i, point in ipairs(fireboyPoints) do
        if gamemath:distance(enemy.x, enemy.y, point.x, point.y) < base_enemy.radius then
            return true
        end
    end
    return false
end

-- function enemyCollision:collide(enemy1, enemy2)
--     local xdist, ydist = enemy2.x - enemy1.x, enemy2.y - enemy1.y
--     local distance = math.sqrt(xdist*xdist + ydist*ydist)
--     if distance <= 2*base_enemy.radius then
--         local midX, midY = enemy1.x + xdist/2, enemy1.y + ydist/2
--         local theta2 = math.atan(ydist, xdist)
--         print(theta2)
--         local theta1 = theta2 + math.pi
--         enemy1.x = midX + base_enemy.radius * math.cos(theta1)
--         enemy1.y = midY + base_enemy.radius * math.sin(theta1)
--         enemy2.x = midX + base_enemy.radius * math.cos(theta2)
--         enemy2.y = midY + base_enemy.radius * math.sin(theta2)
--     end
-- end
