input = {}

function input:horizontalAxis()
    local result = 0
    if love.keyboard.isDown('left', 'a') then
        result = result - 1
    end
    if love.keyboard.isDown('right', 'd') then
        result = result + 1
    end
    local joysticks = love.joystick.getJoysticks()
    for i, joystick in ipairs(joysticks) do
        if joystick:getName() == "Android Accelerometer" then
            local x_axis = joystick:getAxes()
            if x_axis < -0.15 then
                result = -1
            elseif x_axis > 0.15 then
                result = 1
            else
                result = x_axis*2
            end
        end
    end
    return result
end

function input.actionButton()
    return mouse.mouseButton
end

function input.actionButtonDown()
    return mouse.mouseButtonDown
end

mouse = {}

-- Mouse input
mouse.mouseX = 0
mouse.mouseY = 0
mouse.mouseButton = false
mouse.mouseButtonDown = false

function mouse:update()
    local mouseDown = love.mouse.isDown(1)
    if mouseDown and not self.mouseButton then
        self.mouseButtonDown = true
    else
        self.mouseButtonDown = false
    end
    self.mouseButton = mouseDown
    self.mouseX = love.mouse.getX()
    self.mouseY = love.mouse.getY()
end
