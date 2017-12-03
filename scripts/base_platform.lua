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
    local platformType = base_platform.calculatePlatformType()
    local newPlatform = {
        img = base_platform.platformSprites[spriteIndex + 3 * platformType + 1],
        type = base_platform.platformTypes[platformType + 1]
    }
    base_platform.lastGenerated = platformType
    return newPlatform
end

function base_platform.calculatePlatformType()
    local normalChance = nil
    local waterChance = nil

    if firebar.fire <= firebar.maxFire / 5 then
        normalChance = 30
        waterChance = 50
    elseif firebar.fire <= firebar.maxFire * 2 / 5 then
        normalChance = 40
        waterChance = 60
    elseif firebar.fire <= firebar.maxFire * 3 / 5 then
        normalChance = 50
        waterChance = 70
    elseif firebar.fire <= firebar.maxFire * 4 / 5 then
        normalChance = 45
        waterChance = 75
    else
        normalChance = 40
        waterChance = 80
    end

    local platformType = love.math.random(100)
    if platformType <= normalChance then platformType = 0
    elseif platformType <= waterChance then platformType = 2
    else platformType = 1 end
    if base_platform.lastGenerated == 1 then platformType = 0 end
    if base_platform.lastGenerated == 2 then platformType = 0 end
    return platformType
end
