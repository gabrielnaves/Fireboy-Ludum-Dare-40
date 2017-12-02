input = {}

function input:horizontalAxis()
    result = 0
    if love.keyboard.isDown('left', 'a') then
        result = result - 1
    end
    if love.keyboard.isDown('right', 'd') then
        result = result + 1
    end
    return result
end
