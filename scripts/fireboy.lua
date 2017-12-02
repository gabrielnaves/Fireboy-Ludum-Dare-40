fireboy = {}

-- Movement data
fireboy.x = 180
fireboy.y = 608
fireboy.movSpeed = 10
fireboy.jumpSpeed = 25
fireboy.launchSpeed = 500
fireboy.velX, fireboy.velY = 0, 0
fireboy.accX, fireboy.accY = 0, 0

-- Image data
fireboy.img = love.graphics.newImage('assets/sprites/fireboy.png')
fireboy.num_frames = 5
fireboy.pos_frame = 1
fireboy.frame_width = fireboy.img:getWidth() / fireboy.num_frames
fireboy.frame_height = fireboy.img:getHeight()
fireboy.frames = {
    love.graphics.newQuad(fireboy.frame_width * 0, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 1, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 2, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 3, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight()),
    love.graphics.newQuad(fireboy.frame_width * 4, 0, fireboy.frame_width, fireboy.frame_height, fireboy.img:getWidth(), fireboy.img:getHeight())
}

-- Timers
fireboy.elapsedTime = 0
fireboy.frameTime = 0.3
fireboy.launchTime = 3

function fireboy.draw(dt)
    love.graphics.draw(fireboy.img, fireboy.frames[fireboy.pos_frame],
                       fireboy.x - fireboy.frame_width / 2, fireboy.y - fireboy.frame_height)
end

function fireboy.updatePosition(dt)
    fireboy.x = fireboy.x + fireboy.velX * dt
    fireboy.y = fireboy.y - fireboy.velY * dt
end

function fireboy.updateVelocity(dt)
    fireboy.velX = fireboy.velX + fireboy.accX * dt
    fireboy.velY = fireboy.velY + fireboy.accY * dt
end

function fireboy.updateInitialState(dt, gamestate)
    -- Animation update
    fireboy.elapsedTime = fireboy.elapsedTime + dt
    if fireboy.elapsedTime > fireboy.frameTime then
        if fireboy.pos_frame == 1 then fireboy.pos_frame = 2
        elseif fireboy.pos_frame == 2 then fireboy.pos_frame = 1
        end
        fireboy.elapsedTime = 0
    end
    -- State update
    if love.keyboard.isDown('space') then
        fireboy.state = fireboy.states.launch
        fireboy.updateFunction = fireboy.updateLaunch
        gamestate.state = gamestate.states.ingame
    end
end

function fireboy.updateLaunch(dt, gamestate)
    fireboy.pos_frame = 3
    -- Position update
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

function fireboy.updateFloat(dt, gamestate)
    fireboy.pos_frame = 4
end

function fireboy.updateFall(dt, gamestate)
    fireboy.pos_frame = 5
end

function fireboy.updateReady(dt, gamestate)
    fireboy.pos_frame = 2
end

function fireboy.updateAscend(dt, gamestate)
    fireboy.pos_frame = 3
end

function fireboy.update(dt, gamestate)
    fireboy.updateFunction(dt, gamestate)
end

-- State data
fireboy.states = { initial = "Initial", launch = "Launch", float = "Float", fall = "Fall", ready = "Ready", ascend = "Ascend" }
fireboy.state = fireboy.states.initial
fireboy.updateFunction = fireboy.updateInitialState

return fireboy
