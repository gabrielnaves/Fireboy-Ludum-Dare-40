base_enemy = {}

-- Motion data
base_enemy.x = 180
base_enemy.y = 608
base_enemy.kp = 0.8

-- Image data
base_enemy.img = love.graphics.newImage('assets/sprites/enemy.png')
base_enemy.num_frames = 8
base_enemy.pos_frame = 1
base_enemy.frame_width = base_enemy.img:getWidth() / base_enemy.num_frames
base_enemy.frame_height = base_enemy.img:getHeight()
base_enemy.frames = {
    love.graphics.newQuad(base_enemy.frame_width * 0, 0, base_enemy.frame_width, base_enemy.frame_height, base_enemy.img:getWidth(), base_enemy.img:getHeight()),
    love.graphics.newQuad(base_enemy.frame_width * 1, 0, base_enemy.frame_width, base_enemy.frame_height, base_enemy.img:getWidth(), base_enemy.img:getHeight()),
    love.graphics.newQuad(base_enemy.frame_width * 2, 0, base_enemy.frame_width, base_enemy.frame_height, base_enemy.img:getWidth(), base_enemy.img:getHeight()),
    love.graphics.newQuad(base_enemy.frame_width * 3, 0, base_enemy.frame_width, base_enemy.frame_height, base_enemy.img:getWidth(), base_enemy.img:getHeight()),
    love.graphics.newQuad(base_enemy.frame_width * 4, 0, base_enemy.frame_width, base_enemy.frame_height, base_enemy.img:getWidth(), base_enemy.img:getHeight()),
    love.graphics.newQuad(base_enemy.frame_width * 5, 0, base_enemy.frame_width, base_enemy.frame_height, base_enemy.img:getWidth(), base_enemy.img:getHeight()),
    love.graphics.newQuad(base_enemy.frame_width * 6, 0, base_enemy.frame_width, base_enemy.frame_height, base_enemy.img:getWidth(), base_enemy.img:getHeight()),
    love.graphics.newQuad(base_enemy.frame_width * 7, 0, base_enemy.frame_width, base_enemy.frame_height, base_enemy.img:getWidth(), base_enemy.img:getHeight()),
}
base_enemy.radius = 20

-- Timers
base_enemy.animationTime = 0.1

function base_enemy:createEnemy(xPos, yPos)
    local newEnemy = {
        x = xPos,
        y = yPos,
        img = base_enemy.img,
        num_frames = base_enemy.num_frames,
        pos_frame = base_enemy.pos_frame,
        frame_width = base_enemy.frame_width,
        frame_height = base_enemy.frame_height,
        frames = base_enemy.frames,
        animationTimer = 0
    }
    return newEnemy
end

function base_enemy.update(dt, enemy, i)
    base_enemy.updateMotion(dt, enemy, i)
    base_enemy.updateAnimation(dt, enemy)
end

function base_enemy.updateMotion(dt, enemy, i)
    local distX, distY = fireboy.x-enemy.x, fireboy.y-enemy.y
    enemy.velX, enemy.velY = distX * base_enemy.kp, distY * base_enemy.kp
    base_enemy.updatePosition(dt, enemy, i)
end

function base_enemy.updatePosition(dt, enemy, i)
    enemy.x = enemy.x + enemy.velX * dt
    enemy.y = enemy.y + enemy.velY * dt
    -- for i2, enemy2 in ipairs(enemyGenerator.enemies) do
    --     if i ~= i2 then
    --         enemyCollision:collide(enemy, enemy2)
    --     end
    -- end
end

function base_enemy.updateAnimation(dt, enemy)
    enemy.animationTimer = enemy.animationTimer + dt
    if enemy.animationTimer >= base_enemy.animationTime then
        enemy.animationTimer = 0
        enemy.pos_frame = enemy.pos_frame + 1
        if (enemy.pos_frame == 9) then enemy.pos_frame = 1 end
    end
end

function base_enemy.draw(dt, enemy)
    love.graphics.draw(enemy.img, enemy.frames[enemy.pos_frame], enemy.x-32, enemy.y-24)
end
