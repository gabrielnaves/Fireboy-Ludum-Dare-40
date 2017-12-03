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

function input:actionButtonDown()
    return input.actionDown
end

input.wasDown = false
input.actionDown = false
function input:update(dt)
    if input:actionButton() and not input.wasDown then
        input.wasDown = true
        input.actionDown = true
    elseif not input:actionButton() and input.wasDown then
        input.wasDown = false
        input.actionDown = false
    else
        input.actionDown = false
    end
end
