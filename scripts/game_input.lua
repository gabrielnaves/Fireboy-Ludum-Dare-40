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

function input:actionButton()
    return love.keyboard.isDown('space')
end

input.wasDown = false
function input:actionButtonDown()
    if input:actionButton() and not input.wasDown then
        input.wasDown = true
        return true
    end
    if not input:actionButton() and input.wasDown then
        input.wasDown = false
    end
    return false
end
