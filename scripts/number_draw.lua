digits_img = {}
digits_img.img = love.graphics.newImage('assets/sprites/digits.png')
digits_img.num_frames = 10
digits_img.frame_width = digits_img.img:getWidth() / digits_img.num_frames
digits_img.frame_height = digits_img.img:getHeight()
digits_img.frames = {
    love.graphics.newQuad(digits_img.frame_width * 0, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
    love.graphics.newQuad(digits_img.frame_width * 1, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
    love.graphics.newQuad(digits_img.frame_width * 2, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
    love.graphics.newQuad(digits_img.frame_width * 3, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
    love.graphics.newQuad(digits_img.frame_width * 4, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
    love.graphics.newQuad(digits_img.frame_width * 5, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
    love.graphics.newQuad(digits_img.frame_width * 6, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
    love.graphics.newQuad(digits_img.frame_width * 7, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
    love.graphics.newQuad(digits_img.frame_width * 8, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
    love.graphics.newQuad(digits_img.frame_width * 9, 0, digits_img.frame_width, digits_img.frame_height, digits_img.img:getWidth(), digits_img.img:getHeight()),
}

function drawInteger(num, x, y)
    local number = math.floor(num)
    local digits = {}
    local digit_amount = 0
    while number ~= 0 do
        digit_amount = digit_amount + 1
        table.insert(digits, number % 10)
        number = math.floor(number / 10)
    end
    if digit_amount > 0 then
        local i = 1
        while digit_amount > 0 do
            graphics.drawq(digits_img.img, digits_img.frames[digits[i] + 1],
                               x + digits_img.frame_width * (digit_amount - 1), y)
            digit_amount = digit_amount - 1
            i = i + 1
        end
    else
        graphics.drawq(digits_img.img, digits_img.frames[1], x, y)
    end
end
