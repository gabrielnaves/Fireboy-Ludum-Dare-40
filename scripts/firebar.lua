firebar = {}

firebar.fire = 100
firebar.maxFire = 500
firebar.backImg = love.graphics.newImage('assets/sprites/fireBar_back.png')
firebar.frontImg = love.graphics.newImage('assets/sprites/fireBar_front.png')

function firebar.updateFire(fireAmount)
    firebar.fire = fireAmount
    if firebar.fire > firebar.maxFire then firebar.fire = firebar.maxFire end
    if firebar.fire < 0 then firebar.fire = 0 end
end

function firebar.draw(dt)
    love.graphics.draw(firebar.backImg, 6, 2)
    love.graphics.draw(firebar.frontImg, 10, 6, 0, firebar.fire / firebar.maxFire, 1)
end

return firebar
