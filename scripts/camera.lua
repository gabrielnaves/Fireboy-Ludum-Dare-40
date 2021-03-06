camera = {}

camera.x, camera.realX = 0, 0
camera.y, camera.realY = 0, 0

camera.fireboyOffset = 400
camera.maxReturn = 400
camera.currentTopPosition = 0

camera.shaking = false
camera.shakeTimer = 0
camera.shakeTime = 0.2

function camera.set()
    love.graphics.push()
    love.graphics.translate(-camera.x, -camera.y)
end

function camera.unset()
    love.graphics.pop()
end

function camera.update(dt)
    -- Update actual camera position
    camera.x, camera.y = camera.realX, camera.realY
    if fireboy.y < camera.y + camera.fireboyOffset then
        camera.y = fireboy.y - camera.fireboyOffset
        camera.currentTopPosition = camera.y
    end
    if fireboy.y > camera.y + camera.fireboyOffset and camera.y < -640 then
        camera.y = fireboy.y - camera.fireboyOffset
        if camera.y > camera.currentTopPosition + camera.maxReturn then
            camera.y = camera.currentTopPosition + camera.maxReturn
        end
    end
    camera.realX, camera.realY = camera.x, camera.y
    -- Camera shake
    if camera.shaking then
        camera.x = camera.x + love.math.random(-2, 2)
        camera.y = camera.y + love.math.random(-3, 3)
        camera.shakeTimer = camera.shakeTimer + dt
        if camera.shakeTimer > camera.shakeTime then
            camera.shaking = false
            camera.shakeTimer = 0
        end
    else
        camera.x = 0
    end
    if camera.y > 0 then camera.y = 0 end
end

function camera.shake()
    camera.shaking = true
    camera.shakeTimer = 0
end

function camera.reset()
    camera.x, camera.y = 0, 0
    camera.realX, camera.realY = 0, 0
    camera.currentTopPosition = 0
    camera.shakeTimer = 0
    camera.shaking = false
end

return camera
