platformGenerator = {}

platformGenerator.platforms = {}

platformGenerator.startPosition = -1000
platformGenerator.currentPosition = nil
platformGenerator.distanceToNext = nil

function platformGenerator.start()
    platformGenerator.currentPosition = platformGenerator.startPosition
    platformGenerator.generateDistanceToNext()
    platformGenerator.generatePlatforms()
end

function platformGenerator.generateDistanceToNext()
    if firebar.fire > firebar.maxFire * 4 / 5 then
        platformGenerator.distanceToNext = love.math.random(4) * 100
    else
        platformGenerator.distanceToNext = love.math.random(3) * 100
    end
end

function platformGenerator.generatePlatforms()
    platformGenerator.startPosition = platformGenerator.currentPosition
    while platformGenerator.currentPosition > platformGenerator.startPosition - 640 do
        platformGenerator.generatePlatformAt(platformGenerator.currentPosition)
        platformGenerator.currentPosition = platformGenerator.currentPosition - platformGenerator.distanceToNext
        platformGenerator.generateDistanceToNext()
    end
end

function platformGenerator.generatePlatformAt(currentPos)
    local newPlatform = base_platform.createPlatform()
    newPlatform.x = love.math.random(6, 360 - newPlatform.img:getWidth() - 6)
    newPlatform.y = currentPos
    table.insert(platformGenerator.platforms, newPlatform)
end

function platformGenerator.update(dt)
    -- Generation update
    if camera.y < platformGenerator.currentPosition + 640 then
        platformGenerator.generatePlatforms()
    end
    -- Platform lifetime update
    for i, platform in ipairs(platformGenerator.platforms) do
        if platform.y > camera.y + 640 + camera.maxReturn then
            table.remove(platformGenerator.platforms, i)
        end
    end
end

function platformGenerator.draw(dt)
    for i, platform in ipairs(platformGenerator.platforms) do
        love.graphics.draw(platform.img, platform.x, platform.y)
    end
end

function platformGenerator.reset()
    platformGenerator.platforms = {}
    platformGenerator.startPosition = -1000
    platformGenerator.currentPosition = nil
    platformGenerator.distanceToNext = nil
    base_platform.lastGenerated = 2
    platformGenerator.start()
end

return platformGenerator
