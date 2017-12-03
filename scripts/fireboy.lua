fireboy = {}

-- Motion data
fireboy.x = 180
fireboy.y = 608
fireboy.movAcc = 1100
fireboy.jumpSpeed = -500
fireboy.launchSpeed = -1000
fireboy.velX, fireboy.velY = 0, 0
fireboy.accX, fireboy.accY = 0, 0
fireboy.gravity = 500
fireboy.maxHorizontalVel = 400
fireboy.offsetBound = 18

-- Image data
fireboy.img = love.graphics.newImage('assets/sprites/fireboy.png')
fireboy.num_frames = 10
fireboy.pos_frame = 1
fireboy.frame_width = fireboy.img:getWidth() / fireboy.num_frames
fireboy.frame_height = fireboy.img:getHeight()
fireboy.frames = {
    love.graphics.newQuad(fireboy.frame_width * 0, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 1, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 2, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 3, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 4, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 5, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 6, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 7, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 8, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 9, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight())
}

-- Timers
fireboy.animationTimer = 0
fireboy.launchTimer = 0
fireboy.jumpTimer = 0
fireboy.frameTime = 0.3
fireboy.launchTime = 3
fireboy.jumpTime = 0.5
fireboy.hitTime = 0.8
fireboy.hitTimer = fireboy.hitTime
fireboy.blinkTimer = 0
fireboy.blinkTime = 0.2
fireboy.dashTimer = 0
fireboy.dashTime = 2
fireboy.dashDamageTimer = 0
fireboy.dashDamageTime = 0.2

-- Some miscellaneous variables
fireboy.previousPositionY = nil
fireboy.flip = false
fireboy.blastZone = 100

-- Fire variables
fireboy.dashCost = 25
fireboy.waterDamage = 0.5
fireboy.fireBonus = 50

-- Collision data
fireboy.boxWidth = 20
fireboy.boxHeight = 36

function fireboy.draw(dt)
    local frame_index = fireboy.pos_frame
    if fireboy.flip then frame_index = frame_index + 5 end
    if fireboy.hitTimer > fireboy.hitTime then
        love.graphics.draw(fireboy.img, fireboy.frames[frame_index],
                           fireboy.x - fireboy.frame_width / 2, fireboy.y - fireboy.frame_height)
    elseif fireboy.blinkTimer > fireboy.blinkTime / 2 then
        love.graphics.draw(fireboy.img, fireboy.frames[frame_index],
                           fireboy.x - fireboy.frame_width / 2, fireboy.y - fireboy.frame_height)
    end
end

function fireboy.updatePosition(dt)
    fireboy.x = fireboy.x + fireboy.velX * dt
    fireboy.y = fireboy.y + fireboy.velY * dt
    if fireboy.x < fireboy.offsetBound then
        fireboy.x = fireboy.offsetBound
        fireboy.velX = 0
    end
    if fireboy.x > 360 - fireboy.offsetBound then
        fireboy.x = 360 - fireboy.offsetBound
        fireboy.velX = 0
    end
end

function fireboy.updateVelocity(dt)
    if (fireboy.accX > 0 and fireboy.velX > 0) or (fireboy.accX < 0 and fireboy.velX < 0) then
        fireboy.velX = fireboy.velX + fireboy.accX * dt
    elseif fireboy.accX ~= 0 then
        fireboy.velX = fireboy.velX * 0.95
        fireboy.velX = fireboy.velX + fireboy.accX * dt
    else
        fireboy.velX = fireboy.velX * 0.95
    end
    fireboy.velY = fireboy.velY + fireboy.accY * dt
    if fireboy.velX > fireboy.maxHorizontalVel then fireboy.velX = fireboy.maxHorizontalVel end
    if fireboy.velX < -fireboy.maxHorizontalVel then fireboy.velX = -fireboy.maxHorizontalVel end
end

function fireboy.updateInitialState(dt)
    -- Animation update
    fireboy.animationTimer = fireboy.animationTimer + dt
    if fireboy.animationTimer > fireboy.frameTime then
        if fireboy.pos_frame == 1 then fireboy.pos_frame = 2
        elseif fireboy.pos_frame == 2 then fireboy.pos_frame = 1
        end
        fireboy.animationTimer = 0
    end
    -- State update
    if input:actionButtonDown() then
        fireboy.state = fireboy.states.launch
        fireboy.updateFunction = fireboy.updateLaunch
        fireboy.animationTimer = 0
    end
end

function fireboy.updateLaunch(dt)
    fireboy.pos_frame = 3
    -- Motion update
    fireboy.velY = fireboy.launchSpeed
    fireboy.updatePosition(dt)
    -- State update
    fireboy.launchTimer = fireboy.launchTimer + dt
    if fireboy.launchTimer > fireboy.launchTime then
        fireboy.state = fireboy.states.float
        fireboy.updateFunction = fireboy.updateFloat
        fireboy.launchTimer = 0
    end
end

function fireboy.updateFloat(dt)
    fireboy.pos_frame = 4
    -- Motion update
    fireboy.accX = fireboy.movAcc * input:horizontalAxis()
    fireboy.accY = fireboy.gravity
    fireboy.updateVelocity(dt)
    fireboy.updatePosition(dt)
    -- State update
    if fireboy.velY > 0 then
        fireboy.state = fireboy.states.fall
        fireboy.updateFunction = fireboy.updateFall
        fireboy.previousPositionY = fireboy.y
    elseif input:actionButtonDown() and fireboy.dashTimer > fireboy.dashTime then -- Dash!
        fireboy.blastEnemies()
        firebar.updateFire(firebar.fire - fireboy.dashCost)
        fireboy.state = fireboy.states.ascend
        fireboy.updateFunction = fireboy.updateAscend
        fireboy.dashTimer = 0
        fireboy.dashDamageTimer = 0
    end
end

function fireboy.updateFall(dt)
    fireboy.pos_frame = 5
    -- Motion update
    fireboy.accX = fireboy.movAcc * input:horizontalAxis()
    fireboy.accY = fireboy.gravity
    fireboy.updateVelocity(dt)
    fireboy.updatePosition(dt)
    -- State update
    if input:actionButtonDown() and fireboy.dashTimer > fireboy.dashTime then -- Dash!
        firebar.updateFire(firebar.fire - fireboy.dashCost)
        fireboy.blastEnemies()
        fireboy.state = fireboy.states.ascend
        fireboy.updateFunction = fireboy.updateAscend
        fireboy.dashTimer = 0
        fireboy.dashDamageTimer = 0
    else
        for i, platform in ipairs(platformGenerator.platforms) do
            if platform.y > fireboy.previousPositionY and platform.y < fireboy.y then
                if fireboy.x+4 > platform.x and fireboy.x-4 < platform.x + platform.img:getWidth() then
                    fireboy.accX, fireboy.accY, fireboy.velX, fireboy.velY = 0, 0, 0, 0
                    fireboy.y = platform.y
                    if platform.type == base_platform.water then -- Landed on a water platform
                        if firebar.fire <= 50 then firebar.updateFire(0) end
                        firebar.updateFire(firebar.fire * fireboy.waterDamage)
                        fireboy.state = fireboy.states.ascend
                        fireboy.updateFunction = fireboy.updateAscend
                    elseif platform.type == base_platform.normal then -- Landed on a normal platform
                        fireboy.state = fireboy.states.ascend
                        fireboy.updateFunction = fireboy.updateAscend
                    else -- Landed on a fire platform
                        firebar.updateFire(firebar.fire + fireboy.fireBonus)
                        fireboy.state = fireboy.states.ready
                        fireboy.updateFunction = fireboy.updateReady
                        fireboy.jumpTimer = 0
                        fireboy.pos_frame = 1
                    end
                    break
                end
            end
        end
    end
    fireboy.previousPositionY = fireboy.y
end

function fireboy.updateReady(dt)
    -- Animation update
    fireboy.animationTimer = fireboy.animationTimer + dt
    if fireboy.animationTimer > fireboy.frameTime then
        if fireboy.pos_frame == 1 then fireboy.pos_frame = 2
        elseif fireboy.pos_frame == 2 then fireboy.pos_frame = 1
        end
        fireboy.animationTimer = 0
    end
    -- State update
    if input:actionButtonDown() then -- Jumping off a fire platform
        fireboy.blastEnemies()
        fireboy.state = fireboy.states.ascend
        fireboy.updateFunction = fireboy.updateAscend
        fireboy.animationTimer = 0
        fireboy.jumpTimer = 0
        fireboy.dashDamageTimer = 0
    end
end

function fireboy.updateAscend(dt)
    fireboy.pos_frame = 3
    -- Motion update
    fireboy.accX = fireboy.movAcc * input:horizontalAxis()
    fireboy.velY = fireboy.jumpSpeed
    fireboy.updateVelocity(dt)
    fireboy.updatePosition(dt)
    -- State update
    fireboy.jumpTimer = fireboy.jumpTimer + dt
    if fireboy.jumpTimer > fireboy.jumpTime then
        fireboy.state = fireboy.states.float
        fireboy.updateFunction = fireboy.updateFloat
        fireboy.jumpTimer = 0
    elseif input:actionButtonDown() and fireboy.dashTimer > fireboy.dashTime then -- Dash!
        firebar.updateFire(firebar.fire - fireboy.dashCost)
        fireboy.blastEnemies()
        fireboy.jumpTimer = 0
        fireboy.dashTimer = 0
        fireboy.dashDamageTimer = 0
    end
end

function fireboy.updateDead(dt)
    fireboy.pos_frame = 2
end

function fireboy.update(dt)
    -- Update state
    fireboy.updateFunction(dt)
    -- update flip
    if fireboy.velX > 0 then fireboy.flip = false elseif fireboy.velX < 0 then fireboy.flip = true end
    -- check for death by fall
    if (fireboy.y > camera.y + 640 + 60) or firebar.fire <= 0 then
        fireboy.state = fireboy.states.dead
        fireboy.updateFunction = fireboy.updateDead
    end
    -- Update collision with enemies
    fireboy.hitTimer = fireboy.hitTimer + dt
    if gamestate.state == gamestate.states.ingame and fireboy.hitTimer > fireboy.hitTime then
        for i, enemy in ipairs(enemyGenerator.enemies) do
            if enemyCollision:isCollidingWithFireboy(enemy) then
                if enemy.y-fireboy.y > base_enemy.radius / 2 then -- Jumping on enemy, ascend
                    enemyGenerator.killEnemy(i)
                    firebar.updateFire(firebar.fire + fireboy.fireBonus)
                    fireboy.state = fireboy.states.ascend
                    fireboy.updateFunction = fireboy.updateAscend
                    fireboy.jumpTimer = 0
                    break
                elseif fireboy.dashDamageTimer < fireboy.dashDamageTime then -- Just dashed, kill enemy
                    enemyGenerator.killEnemy(i)
                    firebar.updateFire(firebar.fire + fireboy.fireBonus / 4)
                else -- Damaged by enemy, fall
                    if firebar.fire <= 50 then firebar.updateFire(0) end
                    firebar.updateFire(firebar.fire * fireboy.waterDamage)
                    fireboy.hitTimer = 0
                    fireboy.state = fireboy.states.fall
                    fireboy.updateFunction = fireboy.updateFall
                    fireboy.previousPositionY = fireboy.y
                    fireboy.velX, fireboy.velY = 0, 0
                    fireboy.accX, fireboy.accY = 0, 0
                end
            end
        end
    end
    -- Update blink and dash timers
    fireboy.blinkTimer = fireboy.blinkTimer + dt
    if fireboy.blinkTimer > fireboy.blinkTime then fireboy.blinkTimer = 0 end
    fireboy.dashTimer = fireboy.dashTimer + dt
    fireboy.dashDamageTimer = fireboy.dashDamageTimer + dt
end

function fireboy.blastEnemies()
    for i, enemy in ipairs(enemyGenerator.enemies) do -- Kill enemies around
        if gamemath:distance(fireboy.x, fireboy.y, enemy.x, enemy.y) < fireboy.blastZone then
            if enemy.y-fireboy.y > base_enemy.radius / 2 then
                enemyGenerator.killEnemy(i)
            end
        end
    end
end

-- State data
fireboy.states = { initial = "Initial", launch = "Launch", float = "Float",
                   fall = "Fall", ready = "Ready", ascend = "Ascend", dead = "Dead"}
fireboy.state = fireboy.states.initial
fireboy.updateFunction = fireboy.updateInitialState

function fireboy.reset()
    fireboy.x = 180
    fireboy.y = 608
    fireboy.velX, fireboy.velY = 0, 0
    fireboy.accX, fireboy.accY = 0, 0
    fireboy.jumpTimer = 0
    fireboy.launchTimer = 0
    fireboy.animationTimer = 0
    fireboy.hitTimer = fireboy.hitTime
    firebar.updateFire(100)
    fireboy.previousPositionY = nil
    fireboy.pos_frame = 1
    fireboy.flip = false
    fireboy.state = fireboy.states.initial
    fireboy.updateFunction = fireboy.updateInitialState
end

return fireboy
