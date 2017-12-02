platformSprites = {
    love.graphics.newImage('assets/sprites/normal_platform_1.png'),
    love.graphics.newImage('assets/sprites/normal_platform_2.png'),
    love.graphics.newImage('assets/sprites/normal_platform_3.png')
}

function createPlatform()
    local spriteIndex = love.math.random(3)
    local newPlatform = {
        img = platformSprites[spriteIndex]
    }
    return newPlatform
end
