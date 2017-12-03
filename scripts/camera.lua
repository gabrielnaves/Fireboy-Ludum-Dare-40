camera = {}

camera.x = 0
camera.y = 0

camera.fireboyOffset = 400
camera.maxReturn = 400
camera.currentTopPosition = 0

function camera.set()
    love.graphics.push()
    love.graphics.translate(-camera.x, -camera.y)
end

function camera.unset()
    love.graphics.pop()
end

function camera.update()
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
end

return camera
