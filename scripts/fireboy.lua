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
fireboy.elapsedTime = 0
fireboy.frameTime = 0.3
fireboy.launchTime = 3
fireboy.jumpTime = 0.5

-- Some miscellaneous variables
fireboy.previousPositionY = nil
fireboy.flip = false

-- Fire variables
fireboy.fire = 100
fireboy.dashCost = 25
fireboy.waterDamage = 0.6
fireboy.fireBonus = 50

function fireboy.draw(dt)
    local frame_index = fireboy.pos_frame
    if flip then frame_index = frame_index + 5 end
    love.graphics.draw(fireboy.img, fireboy.frames[frame_index],
                       fireboy.x - fireboy.frame_width / 2, fireboy.y - fireboy.frame_height)
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
    fireboy.elapsedTime = fireboy.elapsedTime + dt
    if fireboy.elapsedTime > fireboy.frameTime then
        if fireboy.pos_frame == 1 then fireboy.pos_frame = 2
        elseif fireboy.pos_frame == 2 then fireboy.pos_frame = 1
        end
        fireboy.elapsedTime = 0
    end
    -- State update
    if input:actionButtonDown() then
        fireboy.state = fireboy.states.launch
        fireboy.updateFunction = fireboy.updateLaunch
        gamestate.state = gamestate.states.ingame
    end
end

function fireboy.updateLaunch(dt)
    fireboy.pos_frame = 3
    -- Motion update
    fireboy.velY = fireboy.launchSpeed
    fireboy.updatePosition(dt)
    -- State update
    fireboy.elapsedTime = fireboy.elapsedTime + dt
    if fireboy.elapsedTime > fireboy.launchTime then
        fireboy.state = fireboy.states.float
        fireboy.updateFunction = fireboy.updateFloat
        fireboy.elapsedTime = 0
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
    elseif input:actionButtonDown() then
         fireboy.fire = fireboy.fire - fireboy.dashCost
         fireboy.state = fireboy.states.ascend
         fireboy.updateFunction = fireboy.updateAscend
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
    if input:actionButtonDown() then
        fireboy.fire = fireboy.fire - fireboy.dashCost
        fireboy.state = fireboy.states.ascend
        fireboy.updateFunction = fireboy.updateAscend
    else
        for i, platform in ipairs(platformGenerator.platforms) do
            if platform.y > fireboy.previousPositionY and platform.y < fireboy.y then
                if fireboy.x+4 > platform.x and fireboy.x-4 < platform.x + platform.img:getWidth() then
                    fireboy.accX, fireboy.accY, fireboy.velX, fireboy.velY = 0, 0, 0, 0
                    fireboy.y = platform.y
                    if platform.type == base_platform.water then
                        fireboy.fire = fireboy.fire * fireboy.waterDamage
                        fireboy.state = fireboy.states.ascend
                        fireboy.updateFunction = fireboy.updateAscend
                    elseif platform.type == base_platform.normal then
                        fireboy.state = fireboy.states.ascend
                        fireboy.updateFunction = fireboy.updateAscend
                    else
                        fireboy.fire = fireboy.fire + fireboy.fireBonus
                        fireboy.state = fireboy.states.ready
                        fireboy.updateFunction = fireboy.updateReady
                        fireboy.elapsedTime = 0
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
    fireboy.elapsedTime = fireboy.elapsedTime + dt
    if fireboy.elapsedTime > fireboy.frameTime then
        if fireboy.pos_frame == 1 then fireboy.pos_frame = 2
        elseif fireboy.pos_frame == 2 then fireboy.pos_frame = 1
        end
        fireboy.elapsedTime = 0
    end
    -- State update
    if input:actionButtonDown() then
        fireboy.state = fireboy.states.ascend
        fireboy.updateFunction = fireboy.updateAscend
        fireboy.elapsedTime = 0
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
    fireboy.elapsedTime = fireboy.elapsedTime + dt
    if fireboy.elapsedTime > fireboy.jumpTime then
        fireboy.state = fireboy.states.float
        fireboy.updateFunction = fireboy.updateFloat
        fireboy.elapsedTime = 0
    elseif input:actionButtonDown() then
        fireboy.fire = fireboy.fire - fireboy.dashCost
        fireboy.elapsedTime = 0
    end
end

function fireboy.update(dt)
    fireboy.updateFunction(dt)
    -- update flip
    if fireboy.velX > 0 then flip = false elseif fireboy.velX < 0 then flip = true end
end

-- State data
fireboy.states = { initial = "Initial", launch = "Launch", float = "Float", fall = "Fall", ready = "Ready", ascend = "Ascend" }
fireboy.state = fireboy.states.initial
fireboy.updateFunction = fireboy.updateInitialState

return fireboy
