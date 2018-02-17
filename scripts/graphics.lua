graphics = {}

-- graphics.original_width = 1
-- graphics.screen_width = love.graphics.getWidth()
graphics.original_height = 640
graphics.screen_height = love.graphics.getHeight()
graphics.scaling = graphics.screen_height / graphics.original_height

function graphics.draw(img, x, y)
    love.graphics.draw(img, x*graphics.scaling, y*graphics.scaling, 0, graphics.scaling, graphics.scaling)
end

function graphics.drawq(img, quad, x, y)
    love.graphics.draw(img, quad, x*graphics.scaling, y*graphics.scaling, 0, graphics.scaling, graphics.scaling)
end

function graphics.draws(img, x, y, th, sx, sy)
    love.graphics.draw(img, x*graphics.scaling, y*graphics.scaling, th, sx*graphics.scaling, sy*graphics.scaling)
end

function graphics.drawqs(img, quad, x, y, th, sx, sy)
    love.graphics.draw(img, quad, x*graphics.scaling, y*graphics.scaling, th, sx*graphics.scaling, sy*graphics.scaling)
end

