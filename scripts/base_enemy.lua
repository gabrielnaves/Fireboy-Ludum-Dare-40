base_enemy = {}

-- Motion data
base_enemy.x = 180
base_enemy.y = 608
base_enemy.movAcc = 1100
base_enemy.velX, base_enemy.velY = 0, 0
base_enemy.accX, base_enemy.accY = 0, 0
base_enemy.maxMagnitude = 400

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

function base_enemy.update(dt, enemy)
    base_enemy.updateAnimation(dt, enemy)
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
