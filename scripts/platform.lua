base_platform = {}

base_platform.platformSprites = {
    love.graphics.newImage('assets/sprites/normal_platform_1.png'),
    love.graphics.newImage('assets/sprites/normal_platform_2.png'),
    love.graphics.newImage('assets/sprites/normal_platform_3.png'),
    love.graphics.newImage('assets/sprites/fire_platform_1.png'),
    love.graphics.newImage('assets/sprites/fire_platform_2.png'),
    love.graphics.newImage('assets/sprites/fire_platform_3.png'),
    love.graphics.newImage('assets/sprites/water_platform_1.png'),
    love.graphics.newImage('assets/sprites/water_platform_2.png'),
    love.graphics.newImage('assets/sprites/water_platform_3.png')
}

base_platform.normal = "Normal"
base_platform.fire = "Fire"
base_platform.water = "Water"
base_platform.platformTypes = { "Normal", "Fire", "Water" }

base_platform.lastGenerated = 2
function base_platform.createPlatform()
    local spriteIndex = love.math.random(0, 2)
    local platformType = love.math.random(100)

    if platformType <= 50 then platformType = 0
    elseif platformType <= 75 then platformType = 1
    else platformType = 2 end

    if base_platform.lastGenerated == 1 then platformType = 0 end
    if base_platform.lastGenerated == 2 then platformType = 0 end

    local newPlatform = {
        img = base_platform.platformSprites[spriteIndex + 3 * platformType + 1],
        type = base_platform.platformTypes[platformType + 1]
    }
    base_platform.lastGenerated = platformType
    return newPlatform
end
