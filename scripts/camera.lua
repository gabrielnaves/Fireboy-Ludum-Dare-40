camera = {}

camera.x = 0
camera.y = 0

camera.fireboyOffset = 400

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
    end
end

return camera
